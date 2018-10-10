import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVC1405_4_0( grouped dataset(risk_indicators.Layout_Boca_shell) clam, BOOLEAN isCalifornia = FALSE) := FUNCTION

  RVC_DEBUG := False;

	#if(RVC_DEBUG)
		layout_debug := record
			integer	sysdate;
      boolean iv_pots_phone;
      boolean iv_add_apt;
			boolean iv_riskview_222s;
      integer iv_mi001_adlperssn_count;
      integer iv_pl002_addrs_15yr;
      boolean evidence_of_college;
      string iv_ed001_college_ind;
      string iv_input_dob_match_level;
			integer bst_addr_avm_auto_val_4;
      integer bst_addr_avm_auto_val_1;
      real iv_bst_addr_avm_pct_change_3yr;
      integer iv_prv_addr_avm_auto_val;
      integer iv_gong_did_addr_ct;
      string iv_rec_vehx_level;
      string iv_criminal_x_felony;
      integer iv_pb_total_orders;
      integer iv_in001_estimated_income;
      integer prop_adl_p_lseen_pos;
			string prop_adl_lseen_p;
      integer _prop_adl_lseen_p;
      integer _src_prop_adl_lseen;
      integer iv_mos_src_property_adl_lseen;
      string iv_addr_ver_sources;
      string iv_inp_own_prop_x_addr_naprop;
      integer bst_addr_avm_auto_val;
      integer bst_addr_mortgage_amount;
      real iv_bst_addr_mtg_avm_pct_diff;
      integer iv_prv_addr_source_count;
      integer iv_paw_active_phone_count;
      string iv_infutor_nap;
			integer cs_outstanding_liens_ct;
			integer _criminal_last_date;
      integer iv_dc001_mos_since_crim_ls;
      string iv_db001_bankruptcy;
      integer iv_ms001_ssns_per_adl;
      integer bureau_addr_tn_count_pos;
			integer bureau_addr_count_tn;
      integer bureau_addr_ts_count_pos;
      integer bureau_addr_count_ts;
      integer bureau_addr_tu_count_pos;
      integer bureau_addr_count_tu;
			integer bureau_addr_en_count_pos;
      integer bureau_addr_count_en;
			integer bureau_addr_eq_count_pos;
      integer bureau_addr_count_eq;
      integer _src_bureau_addr_count;
      integer iv_src_bureau_addr_count;
			integer iv_addr_non_phn_src_ct;
      string iv_inp_addr_ownership_lvl;
      integer _add2_mortgage_date;
      integer _add2_mortgage_due_date;
      integer _add3_mortgage_date;
      integer _add3_mortgage_due_date;
      integer mortgage_date_diff;
      string iv_prv_addr_mortgage_term;
      integer iv_prop_owned_assessed_count;
      integer iv_avg_num_sources_per_addr;
      integer iv_max_ids_per_addr;
      string iv_paw_dead_bus_x_active_phn;
      boolean ver_phn_inf;
      boolean ver_phn_nap;
      integer inf_phn_ver_lvl;
      integer nap_phn_ver_lvl;
      string iv_nap_phn_ver_x_inf_phn_ver;
      integer iv_eviction_count;
			real ff_phone_subscore0;
      real ff_phone_subscore1;
      real ff_phone_subscore2;
      real ff_phone_subscore3;
      real ff_phone_subscore4;
			real ff_phone_subscore5;
      real ff_phone_subscore6;
      real ff_phone_subscore7;
      real ff_phone_subscore8;
      real ff_phone_subscore9;
      real ff_phone_subscore10;
			real ff_phone_subscore11;
      real ff_phone_subscore12;
      real ff_phone_subscore13;
      real ff_phone_subscore14;
      real ff_phone_subscore15;
      real ff_phone_subscore16;
      real ff_phone_subscore17;
      real ff_phone_subscore18;
      real ff_phone_rawscore;
      real ff_phone_lnoddsscore;
      real ff_phone_probscore;
      real ff_nophone_subscore0;
      real ff_nophone_subscore1;
      real ff_nophone_subscore2;
      real ff_nophone_subscore3;
      real ff_nophone_subscore4;
      real ff_nophone_subscore5;
			real ff_nophone_subscore6;
      real ff_nophone_subscore7;
      real ff_nophone_subscore8;
      real ff_nophone_subscore9;
      real ff_nophone_subscore10;
			real ff_nophone_subscore11;
      real ff_nophone_subscore12;
			real ff_nophone_subscore13;
      real ff_nophone_subscore14;
      real ff_nophone_subscore15;
			real ff_nophone_subscore16;
			real ff_nophone_subscore17;
			real ff_nophone_subscore18;
			real ff_nophone_subscore19;
			real ff_nophone_subscore20;
			real ff_nophone_subscore21;
			real ff_nophone_subscore22;
			real ff_nophone_rawscore;
			real ff_nophone_lnoddsscore;
			real ff_nophone_probscore;
			integer point;
			integer base;
			real odds;
			real _ff_phone_transformed_score;
			real ff_phone_transformed_score;
			real _ff_nophone_transformed_score;
			real ff_nophone_transformed_score;
			integer _rvc1405_4_0;
			boolean ver_src_ds;
			boolean ssn_deceased;
			integer rvc1405_4_0;
			boolean glrc9q;
			string rc4;
			string rc2;
			string rc3;
			string rc5;
			string rc1;
			models.layout_modelout;
			risk_indicators.Layout_Boca_Shell clam;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end
	in_hphnpop                       := le.adl_shell_flags.in_hphnpop;
	truedid                          := le.truedid;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcount                     := le.iid.addrcount;
	rc_phoneaddrcount                := le.iid.phoneaddrcount;
	rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	ver_addr_sources                 := le.header_summary.ver_addr_sources;
	ver_addr_sources_count           := le.header_summary.ver_addr_sources_recordcount;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_automated_valuation_4   := le.avm.input_address_information.avm_automated_valuation4;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
	add1_pop                         := le.addrpop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_count    := le.address_verification.owned.property_owned_assessed_count;
	property_sold_total              := le.address_verification.sold.property_total;
	add2_avm_automated_valuation     := le.avm.address_history_1.avm_automated_valuation;
	add2_avm_automated_valuation_4   := le.avm.address_history_1.avm_automated_valuation4;
	add2_source_count                := le.address_verification.address_history_1.source_count;
	add2_mortgage_amount             := le.address_verification.address_history_1.mortgage_amount;
	add2_mortgage_date               := le.address_verification.address_history_1.mortgage_date;
	add2_mortgage_due_date           := le.address_verification.address_history_1.first_td_due_date;
	add3_avm_automated_valuation     := le.avm.address_history_2.avm_automated_valuation;
	add3_source_count                := le.address_verification.address_history_2.source_count;
	add3_mortgage_date               := le.address_verification.address_history_2.mortgage_date;
	add3_mortgage_due_date           := le.address_verification.address_history_2.first_td_due_date;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	addr_count2                      := le.address_history_summary.addr_count2;
	addr_count_ge3                   := le.address_history_summary.addr_count3;
	addr_count_ge6                   := le.address_history_summary.addr_count6;
	addr_count_ge10                  := le.address_history_summary.addr_count10;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	inq_count12                      := le.acc_logs.inquiries.count12;
	pb_total_orders                  := le.ibehavior.total_number_of_orders;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_recent_released_count      := le.bjl.liens_recent_released_count;
	liens_historical_released_count  := le.bjl.liens_historical_released_count;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_class                        := le.student.class;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_income_level_code            := le.student.income_level_code;
	ams_file_type                    := le.student.file_type2;
	ams_college_tier                 := le.student.college_tier;
	ams_college_major                := le.student.college_major;
	input_dob_match_level            := le.dobmatchlevel;
	estimated_income                 := le.estimated_income;




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

iv_mi001_adlperssn_count := map(
    not((integer)ssnlength > 0)  => NULL,
    adlperssn_count = 0 => 1,
                           adlperssn_count);
													 

iv_pl002_addrs_15yr := if(not(truedid), NULL, addrs_15yr);

evidence_of_college := not(ams_college_code = '') or not(ams_college_type = '');

iv_ed001_college_ind := map(																																																																																		 
    not(truedid)                                                                                                                                                => ' ',
    not(ams_college_code = '') or not(ams_college_type = '') or not(ams_college_tier = '') or not(ams_college_major = '') or (ams_file_type in ['H', 'C', 'A']) => '1',
    ams_file_type = 'M'                                                                                                                                         => '0',
    not(ams_class = '') or not(ams_income_level_code = '')                                                                                                      => '1',
                                                                                                                                                                   '0');

iv_input_dob_match_level := if(not(truedid and dobpop), ' ', input_dob_match_level);

bst_addr_avm_auto_val_4 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation_4,
                        add2_avm_automated_valuation_4);

bst_addr_avm_auto_val_1 := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

iv_bst_addr_avm_pct_change_3yr := if(bst_addr_avm_auto_val_1 > 0 and bst_addr_avm_auto_val_4 > 0, bst_addr_avm_auto_val_1 / bst_addr_avm_auto_val_4, NULL);

iv_prv_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_avm_automated_valuation,
                        add3_avm_automated_valuation);

iv_gong_did_addr_ct := if(not(truedid), NULL, gong_did_addr_ct);

iv_rec_vehx_level := map(
    not(truedid)                                   => '  ',
    attr_num_aircraft > 0 and watercraft_count > 0 => 'AW',
    attr_num_aircraft > 0                          => 'AO',
    watercraft_count > 0                           => trim('W', LEFT, RIGHT) + trim((string)min(if(watercraft_count = NULL, -NULL, watercraft_count), 3), LEFT, RIGHT),
                                                      'XX');

iv_criminal_x_felony := if(not(truedid), '   ', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

iv_pb_total_orders := map(
    not(truedid)         => NULL,
    pb_total_orders = '' => -1,
                              (integer)pb_total_orders);

iv_in001_estimated_income := if(not(truedid), NULL, estimated_income);

prop_adl_p_lseen_pos := Models.Common.findw_cpp(ver_sources, 'P' , ', ', 'E');

prop_adl_lseen_p := if(prop_adl_p_lseen_pos = 0, '       0', Models.Common.getw(ver_sources_last_seen, prop_adl_p_lseen_pos, ','));

_prop_adl_lseen_p := common.sas_date((string)(prop_adl_lseen_p));

_src_prop_adl_lseen := _prop_adl_lseen_p;

iv_mos_src_property_adl_lseen := map(
    not(truedid)               => NULL,
    _src_prop_adl_lseen = NULL => -1,
                                  if ((sysdate - _src_prop_adl_lseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_prop_adl_lseen) / (365.25 / 12)), roundup((sysdate - _src_prop_adl_lseen) / (365.25 / 12))));

iv_addr_ver_sources := map(
    not(truedid and add1_pop)                                                  => '             ',
    rc_addrcount > 0 and (rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0) => 'Phn & NonPhn ',
    rc_addrcount > 0                                                           => 'NonPhn Only  ',
    rc_phoneaddrcount > 0 or rc_phoneaddr_addrcount > 0                        => 'Phn Only     ',
                                                                                  'Addr not Verd');

iv_inp_own_prop_x_addr_naprop := map(
    not(add1_pop)            => '  ',
    property_owned_total > 0 => (string)(add1_naprop + 10),
                                if(length((string)add1_naprop) < 2, '0' + (string)add1_naprop, (string)add1_naprop));
bst_addr_avm_auto_val := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_avm_automated_valuation,
                        add2_avm_automated_valuation);

bst_addr_mortgage_amount := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add1_mortgage_amount,
                        add2_mortgage_amount);

iv_bst_addr_mtg_avm_pct_diff := if(bst_addr_mortgage_amount <= 0 or bst_addr_avm_auto_val <= 0, NULL, bst_addr_avm_auto_val / bst_addr_mortgage_amount);

iv_prv_addr_source_count := map(
    not(truedid)     => NULL,
    add1_isbestmatch => add2_source_count,
                        add3_source_count);

iv_paw_active_phone_count := if(not(truedid), NULL, paw_active_phone_count);

iv_infutor_nap := if(not(hphnpop), ' ', trim((string)infutor_nap, LEFT));

cs_outstanding_liens_ct := if(not(truedid), NULL, if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct))) - if(max(liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))));

_criminal_last_date := common.sas_date((string)(criminal_last_date));

iv_dc001_mos_since_crim_ls := map(
    not(truedid)               => NULL,
    _criminal_last_date = NULL => -1,
                                  min(if(if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _criminal_last_date) / (365.25 / 12) >= 0, truncate((sysdate - _criminal_last_date) / (365.25 / 12)), roundup((sysdate - _criminal_last_date) / (365.25 / 12)))), 240));

iv_db001_bankruptcy := map(
    not(truedid or (integer)ssnlength > 0)                                                                                      => '                 ',
    (disposition in ['Discharge NA', 'Discharged'])                                                                             => '1 - BK Discharged',
    (disposition in ['Dismissed'])                                                                                              => '2 - BK Dismissed ',
    (rc_bansflag in ['1', '2']) or bankrupt = true or contains_i(ver_sources, 'BA') > 0 or filing_count > 0 or bk_recent_count > 0 => '3 - BK Other     ',
                                                                                                                                   '0 - No BK        ');

iv_ms001_ssns_per_adl := map(
    not(truedid)     => NULL,
    ssns_per_adl = 0 => 1,
                        ssns_per_adl);

bureau_addr_tn_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TN' , ', ', 'E');

bureau_addr_count_tn := if(bureau_addr_tn_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tn_count_pos, ','));

bureau_addr_ts_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TS' , ', ', 'E');

bureau_addr_count_ts := if(bureau_addr_ts_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_ts_count_pos, ','));

bureau_addr_tu_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'TU' , ', ', 'E');

bureau_addr_count_tu := if(bureau_addr_tu_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_tu_count_pos, ','));

bureau_addr_en_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EN' , ', ', 'E');

bureau_addr_count_en := if(bureau_addr_en_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_en_count_pos, ','));

bureau_addr_eq_count_pos := Models.Common.findw_cpp(ver_Addr_sources, 'EQ' , ', ', 'E');

bureau_addr_count_eq := if(bureau_addr_eq_count_pos = 0, NULL, (integer)Models.Common.getw(ver_Addr_sources_count, bureau_addr_eq_count_pos, ','));

_src_bureau_addr_count := max(if(max(bureau_addr_count_tn, bureau_addr_count_ts, bureau_addr_count_tu, bureau_addr_count_en, bureau_addr_count_eq) = NULL, NULL, sum(if(bureau_addr_count_tn = NULL, 0, bureau_addr_count_tn), if(bureau_addr_count_ts = NULL, 0, bureau_addr_count_ts), if(bureau_addr_count_tu = NULL, 0, bureau_addr_count_tu), if(bureau_addr_count_en = NULL, 0, bureau_addr_count_en), if(bureau_addr_count_eq = NULL, 0, bureau_addr_count_eq))), (real)0);

iv_src_bureau_addr_count := map(
    not(truedid)                  => NULL,
    _src_bureau_addr_count = NULL => -1,
                                     _src_bureau_addr_count);

iv_addr_non_phn_src_ct := if(not(truedid) and add1_pop, NULL, rc_addrcount);

iv_inp_addr_ownership_lvl := map(
    not(add1_pop)        => '            ',
    add1_applicant_owned => 'Applicant   ',
    add1_family_owned    => 'Family      ',
    add1_occupant_owned  => 'Occupant    ',
                            'No Ownership');

_add2_mortgage_date := common.sas_date((string)(add2_mortgage_date));

_add2_mortgage_due_date := common.sas_date((string)(add2_mortgage_due_date));

_add3_mortgage_date := common.sas_date((string)(add3_mortgage_date));

_add3_mortgage_due_date := common.sas_date((string)(add3_mortgage_due_date));

iv_prv_addr_mortgage_term_1 := map(
    not(truedid)                                                                                 => '  ',
    add1_isbestmatch and not(_add2_mortgage_date = NULL) and not(_add2_mortgage_due_date = NULL) => (string)NULL,
    add1_isbestmatch                                                                             => (string)NULL,
    not(_add3_mortgage_date = NULL) and not(_add3_mortgage_due_date = NULL)                      => (string)NULL,
                                                                                                    (string)NULL);

mortgage_date_diff := map(
    not(truedid)                                                                                 => NULL,
    add1_isbestmatch and not(_add2_mortgage_date = NULL) and not(_add2_mortgage_due_date = NULL) => round((_add2_mortgage_due_date - _add2_mortgage_date) / 365.25),
    add1_isbestmatch                                                                             => NULL,
    not(_add3_mortgage_date = NULL) and not(_add3_mortgage_due_date = NULL)                      => round((_add3_mortgage_due_date - _add3_mortgage_date) / 365.25),
                                                                                                    NULL);

iv_prv_addr_mortgage_term := map(
    not(truedid)             => '  ',
    mortgage_date_diff >= 40 => '40',
    mortgage_date_diff >= 30 => '30',
    mortgage_date_diff >= 25 => '25',
    mortgage_date_diff >= 20 => '20',
    mortgage_date_diff >= 15 => '15',
    mortgage_date_diff >= 10 => '10',
    mortgage_date_diff >= 5  => '5',
    mortgage_date_diff >= 0  => '0',
                                '-1');

iv_prop_owned_assessed_count := if(not(truedid or add1_pop), NULL, property_owned_assessed_count);

iv_avg_num_sources_per_addr := map(
    not(truedid)          => NULL,
    unique_addr_count = 0 => -1,
                             if (if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))) >= 0, truncate(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10)))), roundup(if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2 * 2, addr_count_ge3 * 3, addr_count_ge6 * 6, addr_count_ge10 * 10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 * 2 = NULL, 0, addr_count2 * 2), if(addr_count_ge3 * 3 = NULL, 0, addr_count_ge3 * 3), if(addr_count_ge6 * 6 = NULL, 0, addr_count_ge6 * 6), if(addr_count_ge10 * 10 = NULL, 0, addr_count_ge10 * 10))) / if(max(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))), addr_count2, addr_count_ge3, addr_count_ge6, addr_count_ge10) = NULL, NULL, sum(if(unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3))) = NULL, 0, unique_addr_count - if(max(addr_count2, addr_count_ge3) = NULL, NULL, sum(if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3)))), if(addr_count2 = NULL, 0, addr_count2), if(addr_count_ge3 = NULL, 0, addr_count_ge3), if(addr_count_ge6 = NULL, 0, addr_count_ge6), if(addr_count_ge10 = NULL, 0, addr_count_ge10))))));

iv_max_ids_per_addr := if(not(add1_pop), NULL, max(adls_per_addr, ssns_per_addr));

iv_paw_dead_bus_x_active_phn := if(not(truedid), '   ', trim((string)min(if(paw_dead_business_count = NULL, -NULL, paw_dead_business_count), 3), LEFT, RIGHT) + trim(' - ', LEFT, RIGHT) + trim((string)min(if(paw_active_phone_count = NULL, -NULL, paw_active_phone_count), 3), LEFT, RIGHT));

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

iv_eviction_count := if(not(truedid), NULL, attr_eviction_count);

ff_phone_subscore0 := map(
    NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 1 => -0.001453,
    1 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 5   => 0.179126,
    5 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 7   => -0.083163,
    7 <= iv_pl002_addrs_15yr                               => -0.260527,
                                                              0.000000);

ff_phone_subscore1 := map(
    (iv_criminal_x_felony in ['   '])                                    => -0.000000,
    (iv_criminal_x_felony in ['0-0'])                                    => 0.096796,
    (iv_criminal_x_felony in ['1-0'])                                    => -0.167513,
    (iv_criminal_x_felony in ['2-0', '3-0'])                             => -0.262492,
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.522587,
                                                                            -0.000000);

ff_phone_subscore2 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 0.89  => -0.375768,
    0.89 <= iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 0.97 => 0.001095,
    0.97 <= iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 1.05 => 0.160413,
    1.05 <= iv_bst_addr_avm_pct_change_3yr                                           => 0.370108,
                                                                                        0.000000);

ff_phone_subscore3 := map(
    NULL < cs_outstanding_liens_ct AND cs_outstanding_liens_ct < 1 => 0.077243,
    1 <= cs_outstanding_liens_ct                                   => -0.339847,
                                                                      0.000000);

ff_phone_subscore4 := map(
    NULL < iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 0 => -0.097586,
    0 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 43  => 0.378803,
    43 <= iv_mos_src_property_adl_lseen AND iv_mos_src_property_adl_lseen < 68 => 0.227409,
    68 <= iv_mos_src_property_adl_lseen                                        => 0.146497,
                                                                                  0.000000);

ff_phone_subscore5 := map(
    NULL < iv_prv_addr_source_count AND iv_prv_addr_source_count < 1 => -0.015161,
    1 <= iv_prv_addr_source_count AND iv_prv_addr_source_count < 2   => -0.090478,
    2 <= iv_prv_addr_source_count AND iv_prv_addr_source_count < 3   => 0.019980,
    3 <= iv_prv_addr_source_count                                    => 0.216664,
                                                                        0.000000);

ff_phone_subscore6 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 5231     => 0.056389,
    5231 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 60207   => -0.273802,
    60207 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 103892 => -0.124729,
    103892 <= iv_prv_addr_avm_auto_val                                      => 0.087050,
                                                                               -0.000000);

ff_phone_subscore7 := map(
		iv_inp_own_prop_x_addr_naprop = '  ' => -0.000000,
    NULL < (integer)iv_inp_own_prop_x_addr_naprop AND (integer)iv_inp_own_prop_x_addr_naprop < 2 => -0.067689,
    2 <= (integer)iv_inp_own_prop_x_addr_naprop AND (integer)iv_inp_own_prop_x_addr_naprop < 10  => 0.206524,
    10 <= (integer)iv_inp_own_prop_x_addr_naprop AND (integer)iv_inp_own_prop_x_addr_naprop < 14 => 0.012856,
    14 <= (integer)iv_inp_own_prop_x_addr_naprop                                   					     => 0.181122,
																																																		-0.000000);

ff_phone_subscore8 := map(
		iv_ed001_college_ind = ' '																								 => -0.000000,
    NULL < (integer)iv_ed001_college_ind AND (integer)iv_ed001_college_ind < 1 => -0.048170,
    1 <= (integer)iv_ed001_college_ind                             					   => 0.215716,
																																									-0.000000);

ff_phone_subscore9 := map(
		iv_input_dob_match_level = ' '																										 => 0.000000,
    NULL < (integer)iv_input_dob_match_level AND (integer)iv_input_dob_match_level < 8 => -0.130555,
    8 <= (integer)iv_input_dob_match_level                                				     => 0.055188,
																																													0.000000);

ff_phone_subscore10 := map(
    NULL < (integer)iv_pb_total_orders AND (integer)iv_pb_total_orders < 1 => -0.059058,
    1 <= (integer)iv_pb_total_orders AND (integer)iv_pb_total_orders < 2   => 0.014319,
    2 <= (integer)iv_pb_total_orders                             					 => 0.167057,
																																							-0.000000);

ff_phone_subscore11 := map(
    NULL < iv_bst_addr_mtg_avm_pct_diff AND iv_bst_addr_mtg_avm_pct_diff < 0.89 => -0.261532,
    0.89 <= iv_bst_addr_mtg_avm_pct_diff                                        => 0.173837,
                                                                                   0.000000);

ff_phone_subscore12 := map(
		iv_infutor_nap = ' ' => 0.000000,
    NULL < (integer)iv_infutor_nap AND (integer)iv_infutor_nap < 1 => 0.118902,
    1 <= (integer)iv_infutor_nap AND (integer)iv_infutor_nap < 4   => -0.093428,
    4 <= (integer)iv_infutor_nap AND (integer)iv_infutor_nap < 12  => -0.033348,
    12 <= (integer)iv_infutor_nap              					           => 0.193798,
																																			0.000000);

ff_phone_subscore13 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => 0.048107,
    2 <= iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 3   => -0.039249,
    3 <= iv_mi001_adlperssn_count                                    => -0.108689,
                                                                        0.000000);

ff_phone_subscore14 := map(
    (iv_addr_ver_sources in ['             '])         				   => 0.000000,
    (iv_addr_ver_sources in ['Addr not Verd'])      				     => -0.359347,
    (iv_addr_ver_sources in ['NonPhn Only  '])    			         => -0.006090,
    (iv_addr_ver_sources in ['Phn & NonPhn ', 'Phn Only     '])  => 0.025803,
                                                             0.000000);
																														 
																														 


ff_phone_subscore15 := map(
    NULL < iv_in001_estimated_income AND iv_in001_estimated_income < 30000 => -0.030003,
    30000 <= iv_in001_estimated_income                                     => 0.056004,
                                                                              0.000000);

ff_phone_subscore16 := map(
    (iv_rec_vehx_level in ['  '])             => 0.000000,
    (iv_rec_vehx_level in ['W1', 'W2', 'W3']) => 0.266052,
    (iv_rec_vehx_level in ['XX'])             => -0.006585,
                                                 0.000000);

ff_phone_subscore17 := map(
    NULL < iv_paw_active_phone_count AND iv_paw_active_phone_count < 1 => -0.006346,
    1 <= iv_paw_active_phone_count                                     => 0.230173,
                                                                          -0.000000);

ff_phone_subscore18 := map(
    NULL < iv_gong_did_addr_ct AND iv_gong_did_addr_ct < 1 => 0.031115,
    1 <= iv_gong_did_addr_ct                               => -0.041863,
                                                              0.000000);

ff_phone_rawscore := ff_phone_subscore0 +
    ff_phone_subscore1 +
    ff_phone_subscore2 +
    ff_phone_subscore3 +
    ff_phone_subscore4 +
    ff_phone_subscore5 +
    ff_phone_subscore6 +
    ff_phone_subscore7 +
    ff_phone_subscore8 +
    ff_phone_subscore9 +
    ff_phone_subscore10 +
    ff_phone_subscore11 +
    ff_phone_subscore12 +
    ff_phone_subscore13 +
    ff_phone_subscore14 +
    ff_phone_subscore15 +
    ff_phone_subscore16 +
    ff_phone_subscore17 +
    ff_phone_subscore18;

ff_phone_lnoddsscore := ff_phone_rawscore + -1.786059;

ff_phone_probscore := exp(ff_phone_lnoddsscore) / (1 + exp(ff_phone_lnoddsscore));

ff_nophone_subscore0 := map(
    NULL < (integer)iv_pb_total_orders AND (integer)iv_pb_total_orders < 1 => -0.110915,
    1 <= (integer)iv_pb_total_orders AND (integer)iv_pb_total_orders < 2   => 0.198693,
    2 <= (integer)iv_pb_total_orders                           					   => 0.210645,
																																							-0.000000);

ff_nophone_subscore1 := map(
    NULL < iv_max_ids_per_addr AND iv_max_ids_per_addr < 1 => -0.170760,
    1 <= iv_max_ids_per_addr AND iv_max_ids_per_addr < 28  => 0.093223,
    28 <= iv_max_ids_per_addr                              => -0.253448,
                                                              0.000000);

ff_nophone_subscore2 := map(
    NULL < iv_prop_owned_assessed_count AND iv_prop_owned_assessed_count < 1 => -0.056471,
    1 <= iv_prop_owned_assessed_count AND iv_prop_owned_assessed_count < 2   => 0.266908,
    2 <= iv_prop_owned_assessed_count                                        => 0.537122,
                                                                                0.000000);

ff_nophone_subscore3 := map(
    NULL < iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 4920     => 0.030255,
    4920 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 70329   => -0.274129,
    70329 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 95757  => -0.116281,
    95757 <= iv_prv_addr_avm_auto_val AND iv_prv_addr_avm_auto_val < 173195 => 0.122833,
    173195 <= iv_prv_addr_avm_auto_val                                      => 0.433176,
                                                                               0.000000);

ff_nophone_subscore4 := map(
		iv_prv_addr_mortgage_term = '  '																										 => 0.000000,
    NULL < (integer)iv_prv_addr_mortgage_term AND (integer)iv_prv_addr_mortgage_term < 0 => -0.026399,
    0 <= (integer)iv_prv_addr_mortgage_term AND (integer)iv_prv_addr_mortgage_term < 15  => 0.827787,
    15 <= (integer)iv_prv_addr_mortgage_term AND (integer)iv_prv_addr_mortgage_term < 25 => 0.040833,
    25 <= (integer)iv_prv_addr_mortgage_term                              				       => -0.030839,
																																														0.000000);

ff_nophone_subscore5 := map(
    (iv_criminal_x_felony in ['   '])                                    => -0.000000,
    (iv_criminal_x_felony in ['0-0'])                                    => 0.061512,
    (iv_criminal_x_felony in ['1-0'])                                    => 0.056606,
    (iv_criminal_x_felony in ['2-0', '3-0'])                             => -0.157843,
    (iv_criminal_x_felony in ['1-1', '2-1', '2-2', '3-1', '3-2', '3-3']) => -0.362721,
                                                                            -0.000000);

ff_nophone_subscore6 := map(
    NULL < iv_dc001_mos_since_crim_ls AND iv_dc001_mos_since_crim_ls < 0 => 0.062470,
    0 <= iv_dc001_mos_since_crim_ls AND iv_dc001_mos_since_crim_ls < 21  => -0.303436,
    21 <= iv_dc001_mos_since_crim_ls                                     => -0.071211,
                                                                            0.000000);

ff_nophone_subscore7 := map(
    (iv_inp_addr_ownership_lvl in ['            '])    => -0.000000,
    (iv_inp_addr_ownership_lvl in ['Applicant   '])    => 0.022693,
    (iv_inp_addr_ownership_lvl in ['Family      '])    => 0.252239,
    (iv_inp_addr_ownership_lvl in ['No Ownership'])		 => 0.006041,
    (iv_inp_addr_ownership_lvl in ['Occupant    '])    => -0.124412,
                                                          -0.000000);

ff_nophone_subscore8 := map(
    NULL < iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 0.82  => -0.260895,
    0.82 <= iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 0.89 => -0.128636,
    0.89 <= iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 0.97 => 0.007813,
    0.97 <= iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 1.01 => 0.147351,
    1.01 <= iv_bst_addr_avm_pct_change_3yr AND iv_bst_addr_avm_pct_change_3yr < 1.05 => 0.163740,
    1.05 <= iv_bst_addr_avm_pct_change_3yr                                           => 0.196588,
                                                                                        0.000000);

ff_nophone_subscore9 := map(
    NULL < iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 1 => -0.025941,
    1 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 3   => -0.021781,
    3 <= iv_src_bureau_addr_count AND iv_src_bureau_addr_count < 4   => 0.023792,
    4 <= iv_src_bureau_addr_count                                    => 0.579394,
                                                                        -0.000000);

ff_nophone_subscore10 := map(
    NULL < iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 1 => -0.053357,
    1 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 3   => 0.122511,
    3 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 6   => 0.021450,
    6 <= iv_pl002_addrs_15yr AND iv_pl002_addrs_15yr < 12  => -0.097045,
    12 <= iv_pl002_addrs_15yr                              => -0.247699,
                                                              -0.000000);

ff_nophone_subscore11 := map(
    (iv_db001_bankruptcy in ['                 '])                      => 0.000000,
    (iv_db001_bankruptcy in ['2 - BK Dismissed '])             		      => -0.382006,
    (iv_db001_bankruptcy in ['0 - No BK        '])                   	  => -0.002180,
    (iv_db001_bankruptcy in ['1 - BK Discharged', '3 - BK Other     ']) => 0.399995,
                                                                           0.000000);

ff_nophone_subscore12 := map(
    NULL < iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 1 => -0.249005,
    1 <= iv_addr_non_phn_src_ct AND iv_addr_non_phn_src_ct < 2   => -0.015292,
    2 <= iv_addr_non_phn_src_ct                                  => 0.132448,
                                                                    0.000000);

ff_nophone_subscore13 := map(
    NULL < iv_mi001_adlperssn_count AND iv_mi001_adlperssn_count < 2 => 0.069925,
    2 <= iv_mi001_adlperssn_count                                    => -0.091176,
                                                                        0.000000);

ff_nophone_subscore14 := map(
		iv_ed001_college_ind = ' '																								 => -0.000000,
    NULL < (integer)iv_ed001_college_ind AND (integer)iv_ed001_college_ind < 1 => -0.033096,
    1 <= (integer)iv_ed001_college_ind                            				     => 0.184625,
																																									-0.000000);

ff_nophone_subscore15 := map(
    NULL < iv_gong_did_addr_ct AND iv_gong_did_addr_ct < 2 => 0.029924,
    2 <= iv_gong_did_addr_ct AND iv_gong_did_addr_ct < 3   => -0.127596,
    3 <= iv_gong_did_addr_ct                               => -0.273199,
                                                              0.000000);

ff_nophone_subscore16 := map(
    NULL < iv_ms001_ssns_per_adl AND iv_ms001_ssns_per_adl < 3 => 0.018094,
    3 <= iv_ms001_ssns_per_adl                                 => -0.274956,
                                                                  0.000000);

ff_nophone_subscore17 := map(
    NULL < iv_eviction_count AND iv_eviction_count < 1 => 0.019954,
    1 <= iv_eviction_count AND iv_eviction_count < 2   => 0.019495,
    2 <= iv_eviction_count                             => -0.209090,
                                                          0.000000);

ff_nophone_subscore18 := map(
    NULL < iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 2 => -0.158354,
    2 <= iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 3   => -0.002360,
    3 <= iv_avg_num_sources_per_addr AND iv_avg_num_sources_per_addr < 4   => 0.044800,
    4 <= iv_avg_num_sources_per_addr                                       => 0.201493,
                                                                              -0.000000);

ff_nophone_subscore19 := map(
    (iv_nap_phn_ver_x_inf_phn_ver in ['   '])                                                                       => -0.000000,
    (iv_nap_phn_ver_x_inf_phn_ver in [' -1'])                                                                       => 0.048488,
    (iv_nap_phn_ver_x_inf_phn_ver in ['0-0', '0-1', '0-3', '1-0', '1-1', '1-3', '2-0', '2-1', '2-3', '3-1', '3-3']) => -0.047483,
    (iv_nap_phn_ver_x_inf_phn_ver in ['3-0'])                                                                       => 0.137538,
                                                                                                                       -0.000000);

ff_nophone_subscore20 := map(
    (iv_rec_vehx_level in ['  '])                   => -0.000000,
    (iv_rec_vehx_level in ['AO', 'W1', 'W2', 'W3']) => 0.349687,
    (iv_rec_vehx_level in ['XX'])                   => -0.008143,
                                                       -0.000000);

ff_nophone_subscore21 := map(
		iv_input_dob_match_level = ' ' => 0.000000,
    NULL < (integer)iv_input_dob_match_level AND (integer)iv_input_dob_match_level < 8 => -0.068981,
    8 <= (integer)iv_input_dob_match_level                        				             => 0.033564,
																																													0.000000);

ff_nophone_subscore22 := map(
    (iv_paw_dead_bus_x_active_phn in ['   '])                                                                => -0.000000,
    (iv_paw_dead_bus_x_active_phn in ['0-0', '1-0', '1-1', '1-2', '2-0', '2-1', '2-3', '3-0', '3-1', '3-2']) => -0.006034,
    (iv_paw_dead_bus_x_active_phn in ['0-1', '0-2', '0-3'])                                                  => 0.300076,
                                                                                                                -0.000000);

ff_nophone_rawscore := ff_nophone_subscore0 +
    ff_nophone_subscore1 +
    ff_nophone_subscore2 +
    ff_nophone_subscore3 +
    ff_nophone_subscore4 +
    ff_nophone_subscore5 +
    ff_nophone_subscore6 +
    ff_nophone_subscore7 +
    ff_nophone_subscore8 +
    ff_nophone_subscore9 +
    ff_nophone_subscore10 +
    ff_nophone_subscore11 +
    ff_nophone_subscore12 +
    ff_nophone_subscore13 +
    ff_nophone_subscore14 +
    ff_nophone_subscore15 +
    ff_nophone_subscore16 +
    ff_nophone_subscore17 +
    ff_nophone_subscore18 +
    ff_nophone_subscore19 +
    ff_nophone_subscore20 +
    ff_nophone_subscore21 +
    ff_nophone_subscore22;

ff_nophone_lnoddsscore := ff_nophone_rawscore + -2.242987;

ff_nophone_probscore := exp(ff_nophone_lnoddsscore) / (1 + exp(ff_nophone_lnoddsscore));

point := 40;

base := 700;

odds := .10 / .90;

_ff_phone_transformed_score := round(point * (ff_phone_lnoddsscore - ln(odds)) / ln(2) + base);

ff_phone_transformed_score := min(if(max(round(_ff_phone_transformed_score), 501) = NULL, -NULL, max(round(_ff_phone_transformed_score), 501)), 900);

_ff_nophone_transformed_score := round(point * (ff_nophone_lnoddsscore - ln(odds)) / ln(2) + base);

ff_nophone_transformed_score := min(if(max(round(_ff_nophone_transformed_score), 501) = NULL, -NULL, max(round(_ff_nophone_transformed_score), 501)), 900);

_rvc1405_4_0 := if(in_hphnpop = 1, ff_phone_transformed_score, ff_nophone_transformed_score);

ver_src_ds := Models.Common.findw_cpp(ver_sources, 'DS' , ', ', 'E') > 0;

ssn_deceased := rc_decsflag = '1' or ver_src_ds = true;

rvc1405_4_0 := map(
    ssn_deceased = true     => 200,
    iv_riskview_222s = true => 222,
                            _rvc1405_4_0);

glrc9q := inq_count12 > 0;

glrc28_c89_b1 := truedid and dobpop and (integer)iv_input_dob_match_level < 8;

glrc36_c89_b1 := addrpop and hphnpop;

glrc97_c89_b1 := criminal_count > 0;

glrc98_c89_b1 := if(max(liens_recent_unreleased_count, liens_historical_unreleased_ct, liens_recent_released_count, liens_historical_released_count) = NULL, NULL, sum(if(liens_recent_unreleased_count = NULL, 0, liens_recent_unreleased_count), if(liens_historical_unreleased_ct = NULL, 0, liens_historical_unreleased_ct), if(liens_recent_released_count = NULL, 0, liens_recent_released_count), if(liens_historical_released_count = NULL, 0, liens_historical_released_count))) > 0;

glrc9a_c89_b1 := property_owned_total = 0;

glrc9d_c89_b1 := iv_pl002_addrs_15yr >= 5;

glrc9e_c89_b1 := truedid and add1_pop and rc_addrcount = 0 and rc_phoneaddrcount = 0 and rc_phoneaddr_addrcount = 0;

glrc9i_c89_b1 := age < 30 and not(evidence_of_college);

glrc9y_c89_b1 := truedid and (integer)iv_pb_total_orders < 1;

glrcbl_c89_b1 := 0;

glrcmi_c89_b1 := adlperssn_count > 1;

glrcpv_c89_b1 := truedid and addrpop and add1_avm_automated_valuation < 150000;

rcvalue9d_1_c89_b1 := 0.179126 - ff_phone_subscore0;

rcvalue97_1_c89_b1 := 0.096796 - ff_phone_subscore1;

rcvaluebl_1_c89_b1 := 0.370108 - ff_phone_subscore2;

rcvaluebl_2_c89_b1 := 0.378803 - ff_phone_subscore4;

rcvaluebl_3_c89_b1 := 0.216664 - ff_phone_subscore5;

rcvaluebl_4_c89_b1 := 0.173837 - ff_phone_subscore11;

rcvaluebl_5_c89_b1 := 0.056004 - ff_phone_subscore15;

rcvaluebl_6_c89_b1 := 0.266052 - ff_phone_subscore16;

rcvaluebl_7_c89_b1 := 0.230173 - ff_phone_subscore17;

rcvaluebl_8_c89_b1 := 0.031115 - ff_phone_subscore18;

rcvalue98_1_c89_b1 := 0.077243 - ff_phone_subscore3;

rcvaluepv_1_c89_b1 := 0.087050 - ff_phone_subscore6;

rcvalue9a_1_c89_b1 := 0.181122 - ff_phone_subscore7;

rcvalue9i_1_c89_b1 := 0.215716 - ff_phone_subscore8;

rcvalue28_1_c89_b1 := 0.055188 - ff_phone_subscore9;

rcvalue9y_1_c89_b1 := 0.167057 - ff_phone_subscore10;

rcvalue36_1_c89_b1 := 0.193798 - ff_phone_subscore12;

rcvaluemi_1_c89_b1 := 0.048107 - ff_phone_subscore13;

rcvalue9e_1_c89_b1 := 0.025803 - ff_phone_subscore14;

glrc28_c89_b2 := truedid and dobpop and (integer)iv_input_dob_match_level < 8;

glrc36_c89_b2 := addrpop and hphnpop and nap_phn_ver_lvl != 3 and inf_phn_ver_lvl != 3;

glrc97_c89_b2 := criminal_count > 0;

glrc9d_c89_b2 := iv_pl002_addrs_15yr >= 5;

glrc9e_c89_b2 := truedid and add1_pop;

glrc9i_c89_b2 := age < 30 and not(evidence_of_college);

glrc9w_c89_b2 := bankrupt = true;

glrc9y_c89_b2 := truedid and (integer)iv_pb_total_orders < 1;

glrcev_c89_b2 := attr_eviction_count > 0;

glrcmi_c89_b2 := adlperssn_count > 1;

glrcms_c89_b2 := ssns_per_adl > 1;

glrcpv_c89_b2 := truedid and addrpop and add1_avm_automated_valuation < 150000;

glrcbl_c89_b2 := 0;

rcvalue9y_1_c89_b2 := 0.210645 - ff_nophone_subscore0;

rcvaluebl_1_c89_b2 := 0.093223 - ff_nophone_subscore1;

rcvaluebl_2_c89_b2 := 0.537122 - ff_nophone_subscore2;

rcvaluebl_3_c89_b2 := 0.827787 - ff_nophone_subscore4;

rcvaluebl_4_c89_b2 := 0.252239 - ff_nophone_subscore7;

rcvaluebl_5_c89_b2 := 0.196588 - ff_nophone_subscore8;

rcvaluebl_6_c89_b2 := 0.029924 - ff_nophone_subscore15;

rcvaluebl_7_c89_b2 := 0.349687 - ff_nophone_subscore20;

rcvaluebl_8_c89_b2 := 0.300076 - ff_nophone_subscore22;

rcvaluepv_1_c89_b2 := 0.433176 - ff_nophone_subscore3;

rcvalue97_1_c89_b2 := 0.061512 - ff_nophone_subscore5;

rcvalue97_2_c89_b2 := 0.062470 - ff_nophone_subscore6;

rcvalue9e_1_c89_b2 := 0.579394 - ff_nophone_subscore9;

rcvalue9e_2_c89_b2 := 0.132448 - ff_nophone_subscore12;

rcvalue9e_3_c89_b2 := 0.201493 - ff_nophone_subscore18;

rcvalue9d_1_c89_b2 := 0.122511 - ff_nophone_subscore10;

rcvalue9w_1_c89_b2 := 0.399995 - ff_nophone_subscore11;

rcvaluemi_1_c89_b2 := 0.069925 - ff_nophone_subscore13;

rcvalue9i_1_c89_b2 := 0.184625 - ff_nophone_subscore14;

rcvaluems_1_c89_b2 := 0.018094 - ff_nophone_subscore16;

rcvalueev_1_c89_b2 := 0.019954 - ff_nophone_subscore17;

rcvalue36_1_c89_b2 := 0.137538 - ff_nophone_subscore19;

rcvalue28_1_c89_b2 := 0.033564 - ff_nophone_subscore21;

rcvalue9i := if(in_hphnpop = 1, (integer)glrc9i_c89_b1 * if(max(rcvalue9i_1_c89_b1) = NULL, NULL, sum(if(rcvalue9i_1_c89_b1 = NULL, 0, rcvalue9i_1_c89_b1))), (integer)glrc9i_c89_b2 * if(max(rcvalue9i_1_c89_b2) = NULL, NULL, sum(if(rcvalue9i_1_c89_b2 = NULL, 0, rcvalue9i_1_c89_b2))));

rcvaluemi := if(in_hphnpop = 1, (integer)glrcmi_c89_b1 * if(max(rcvaluemi_1_c89_b1) = NULL, NULL, sum(if(rcvaluemi_1_c89_b1 = NULL, 0, rcvaluemi_1_c89_b1))), (integer)glrcmi_c89_b2 * if(max(rcvaluemi_1_c89_b2) = NULL, NULL, sum(if(rcvaluemi_1_c89_b2 = NULL, 0, rcvaluemi_1_c89_b2))));

rcvalue28 := if(in_hphnpop = 1, (integer)glrc28_c89_b1 * if(max(rcvalue28_1_c89_b1) = NULL, NULL, sum(if(rcvalue28_1_c89_b1 = NULL, 0, rcvalue28_1_c89_b1))), (integer)glrc28_c89_b2 * if(max(rcvalue28_1_c89_b2) = NULL, NULL, sum(if(rcvalue28_1_c89_b2 = NULL, 0, rcvalue28_1_c89_b2))));

rcvalue9d := if(in_hphnpop = 1, (integer)glrc9d_c89_b1 * if(max(rcvalue9d_1_c89_b1) = NULL, NULL, sum(if(rcvalue9d_1_c89_b1 = NULL, 0, rcvalue9d_1_c89_b1))), (integer)glrc9d_c89_b2 * if(max(rcvalue9d_1_c89_b2) = NULL, NULL, sum(if(rcvalue9d_1_c89_b2 = NULL, 0, rcvalue9d_1_c89_b2))));

rcvalue98 := if(in_hphnpop = 1, (integer)glrc98_c89_b1 * if(max(rcvalue98_1_c89_b1) = NULL, 0, sum(if(rcvalue98_1_c89_b1 = NULL, 0, rcvalue98_1_c89_b1))), 0);

rcvaluepv := if(in_hphnpop = 1, (integer)glrcpv_c89_b1 * if(max(rcvaluepv_1_c89_b1) = NULL, NULL, sum(if(rcvaluepv_1_c89_b1 = NULL, 0, rcvaluepv_1_c89_b1))), (integer)glrcpv_c89_b2 * if(max(rcvaluepv_1_c89_b2) = NULL, NULL, sum(if(rcvaluepv_1_c89_b2 = NULL, 0, rcvaluepv_1_c89_b2))));

rcvalue97 := if(in_hphnpop = 1, (integer)glrc97_c89_b1 * if(max(rcvalue97_1_c89_b1) = NULL, NULL, sum(if(rcvalue97_1_c89_b1 = NULL, 0, rcvalue97_1_c89_b1))), (integer)glrc97_c89_b2 * if(max(rcvalue97_1_c89_b2, rcvalue97_2_c89_b2) = NULL, NULL, sum(if(rcvalue97_1_c89_b2 = NULL, 0, rcvalue97_1_c89_b2), if(rcvalue97_2_c89_b2 = NULL, 0, rcvalue97_2_c89_b2))));

rcvalue9w := if(in_hphnpop = 1, NULL, (integer)glrc9w_c89_b2 * if(max(rcvalue9w_1_c89_b2) = NULL, NULL, sum(if(rcvalue9w_1_c89_b2 = NULL, 0, rcvalue9w_1_c89_b2))));

rcvalueev := if(in_hphnpop = 1, NULL, (integer)glrcev_c89_b2 * if(max(rcvalueev_1_c89_b2) = NULL, NULL, sum(if(rcvalueev_1_c89_b2 = NULL, 0, rcvalueev_1_c89_b2))));

rcvaluems := if(in_hphnpop = 1, NULL, (integer)glrcms_c89_b2 * if(max(rcvaluems_1_c89_b2) = NULL, NULL, sum(if(rcvaluems_1_c89_b2 = NULL, 0, rcvaluems_1_c89_b2))));

// rcvalue9y := if(in_hphnpop = 1, (integer)glrc9y_c89_b1 * if(max(rcvalue9y_1_c89_b1) = NULL, NULL, sum(if(rcvalue9y_1_c89_b1 = NULL, 0, rcvalue9y_1_c89_b1))), (integer)glrc9y_c89_b2 * if(max(rcvalue9y_1_c89_b2) = NULL, NULL, sum(if(rcvalue9y_1_c89_b2 = NULL, 0, rcvalue9y_1_c89_b2))));
rcvalue9y := 0;

rcvalue36 := if(in_hphnpop = 1, (integer)glrc36_c89_b1 * if(max(rcvalue36_1_c89_b1) = NULL, NULL, sum(if(rcvalue36_1_c89_b1 = NULL, 0, rcvalue36_1_c89_b1))), (integer)glrc36_c89_b2 * if(max(rcvalue36_1_c89_b2) = NULL, NULL, sum(if(rcvalue36_1_c89_b2 = NULL, 0, rcvalue36_1_c89_b2))));

rcvalue9e := if(in_hphnpop = 1, (integer)glrc9e_c89_b1 * if(max(rcvalue9e_1_c89_b1) = NULL, NULL, sum(if(rcvalue9e_1_c89_b1 = NULL, 0, rcvalue9e_1_c89_b1))), (integer)glrc9e_c89_b2 * if(max(rcvalue9e_1_c89_b2, rcvalue9e_2_c89_b2, rcvalue9e_3_c89_b2) = NULL, NULL, sum(if(rcvalue9e_1_c89_b2 = NULL, 0, rcvalue9e_1_c89_b2), if(rcvalue9e_2_c89_b2 = NULL, 0, rcvalue9e_2_c89_b2), if(rcvalue9e_3_c89_b2 = NULL, 0, rcvalue9e_3_c89_b2))));

rcvalue9a := if(in_hphnpop = 1, (integer)glrc9a_c89_b1 * if(max(rcvalue9a_1_c89_b1) = NULL, NULL, sum(if(rcvalue9a_1_c89_b1 = NULL, 0, rcvalue9a_1_c89_b1))), NULL);

rcvaluebl := if(in_hphnpop = 1, glrcbl_c89_b1 * if(max(rcvaluebl_1_c89_b1, rcvaluebl_2_c89_b1, rcvaluebl_3_c89_b1, rcvaluebl_4_c89_b1, rcvaluebl_5_c89_b1, rcvaluebl_6_c89_b1, rcvaluebl_7_c89_b1, rcvaluebl_8_c89_b1) = NULL, NULL, sum(if(rcvaluebl_1_c89_b1 = NULL, 0, rcvaluebl_1_c89_b1), if(rcvaluebl_2_c89_b1 = NULL, 0, rcvaluebl_2_c89_b1), if(rcvaluebl_3_c89_b1 = NULL, 0, rcvaluebl_3_c89_b1), if(rcvaluebl_4_c89_b1 = NULL, 0, rcvaluebl_4_c89_b1), if(rcvaluebl_5_c89_b1 = NULL, 0, rcvaluebl_5_c89_b1), if(rcvaluebl_6_c89_b1 = NULL, 0, rcvaluebl_6_c89_b1), if(rcvaluebl_7_c89_b1 = NULL, 0, rcvaluebl_7_c89_b1), if(rcvaluebl_8_c89_b1 = NULL, 0, rcvaluebl_8_c89_b1))), glrcbl_c89_b2 * if(max(rcvaluebl_1_c89_b2, rcvaluebl_2_c89_b2, rcvaluebl_3_c89_b2, rcvaluebl_4_c89_b2, rcvaluebl_5_c89_b2, rcvaluebl_6_c89_b2, rcvaluebl_7_c89_b2, rcvaluebl_8_c89_b2) = NULL, NULL, sum(if(rcvaluebl_1_c89_b2 = NULL, 0, rcvaluebl_1_c89_b2), if(rcvaluebl_2_c89_b2 = NULL, 0, rcvaluebl_2_c89_b2), if(rcvaluebl_3_c89_b2 = NULL, 0, rcvaluebl_3_c89_b2), if(rcvaluebl_4_c89_b2 = NULL, 0, rcvaluebl_4_c89_b2), if(rcvaluebl_5_c89_b2 = NULL, 0, rcvaluebl_5_c89_b2), if(rcvaluebl_6_c89_b2 = NULL, 0, rcvaluebl_6_c89_b2), if(rcvaluebl_7_c89_b2 = NULL, 0, rcvaluebl_7_c89_b2), if(rcvaluebl_8_c89_b2 = NULL, 0, rcvaluebl_8_c89_b2))));

//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

rc_dataset := DATASET([
    {'28', RCValue28}, 
    {'36', RCValue36}, 
    {'97', RCValue97}, 
    {'98', RCValue98}, 
    {'9A', RCValue9A}, 
    {'9D', RCValue9D}, 
    {'9E', RCValue9E}, 
    {'9I', RCValue9I}, 
    {'9W', RCValue9W}, 
    {'9Y', RCValue9Y}, 
    {'EV', RCValueEV}, 
    {'MI', RCValueMI},
    {'MS', RCValueMS}, 
    {'PV', RCValuePV}, 
    {'BL', RCValueBL}
    ], ds_layout)(value > 0);


rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

rcs_9p1 := if(rcs_top4[1].rc = '' and rvc1405_4_0 != 900, ROW({'36', NULL}, ds_layout), rcs_top4[1]);
rcs_9p2 := rcs_top4[2];
rcs_9p3 := rcs_top4[3];
rcs_9p4 := rcs_top4[4];
rcs_9p5 := IF(GLRC9Q AND NOT EXISTS(rcs_top4(rc = '9Q')) AND  // Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
									inq_count12 > 0,
										DATASET([{'9Q', NULL}], ds_layout)); // If so - make it the 5th reason code.
	
rcs_9p := rcs_9p1 & rcs_9p2 & rcs_9p3 & rcs_9p4 & rcs_9p5;

rcs_override := MAP( rvc1405_4_0 = 200 => DATASET([{'02', NULL}], ds_layout),
                     rvc1405_4_0 = 222 => DATASET([{'9X', NULL}], ds_layout),
                     rvc1405_4_0 = 900 => DATASET([{'  ', NULL}], ds_layout),
                     NOT EXISTS(rcs_9p(rc != '')) => DATASET([{'36', NULL}], ds_layout),
                     rcs_9p);
										 
riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	
rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
                                             SELF.hri := LEFT.rc,
                                             SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)));

inCalif := isCalifornia AND (
           (integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
           +(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
           +(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
		
ri := MAP( riTemp[1].hri <> '00' => riTemp,
           inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
           rcs_final
           );
				
zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);

reasons := CHOOSEN(ri & zeros, 5); // Keep up to 4 reason codes

// rc1 := if(rc1_1 = '' and rvc1405_3_0 != 900, '36', rc1_1);

//Intermediate variables

	#if(RVC_DEBUG)
		self.clam															:= le;
		self.sysdate                          := sysdate;
		self.iv_pots_phone                    := iv_pots_phone;
		self.iv_add_apt                       := iv_add_apt;
		self.iv_riskview_222s                 := iv_riskview_222s;
		self.iv_mi001_adlperssn_count         := iv_mi001_adlperssn_count;
		self.iv_pl002_addrs_15yr              := iv_pl002_addrs_15yr;
		self.evidence_of_college              := evidence_of_college;
		self.iv_ed001_college_ind             := iv_ed001_college_ind;
		self.iv_input_dob_match_level         := iv_input_dob_match_level;
		self.bst_addr_avm_auto_val_4          := bst_addr_avm_auto_val_4;
		self.bst_addr_avm_auto_val_1          := bst_addr_avm_auto_val_1;
		self.iv_bst_addr_avm_pct_change_3yr   := iv_bst_addr_avm_pct_change_3yr;
		self.iv_prv_addr_avm_auto_val         := iv_prv_addr_avm_auto_val;
		self.iv_gong_did_addr_ct              := iv_gong_did_addr_ct;
		self.iv_rec_vehx_level                := iv_rec_vehx_level;
		self.iv_criminal_x_felony             := iv_criminal_x_felony;
		self.iv_pb_total_orders               := iv_pb_total_orders;
		self.iv_in001_estimated_income        := iv_in001_estimated_income;
		self.prop_adl_p_lseen_pos             := prop_adl_p_lseen_pos;
		self.prop_adl_lseen_p                 := prop_adl_lseen_p;
		self._prop_adl_lseen_p                := _prop_adl_lseen_p;
		self._src_prop_adl_lseen              := _src_prop_adl_lseen;
		self.iv_mos_src_property_adl_lseen    := iv_mos_src_property_adl_lseen;
		self.iv_addr_ver_sources              := iv_addr_ver_sources;
		self.iv_inp_own_prop_x_addr_naprop    := iv_inp_own_prop_x_addr_naprop;
		self.bst_addr_avm_auto_val            := bst_addr_avm_auto_val;
		self.bst_addr_mortgage_amount         := bst_addr_mortgage_amount;
		self.iv_bst_addr_mtg_avm_pct_diff     := iv_bst_addr_mtg_avm_pct_diff;
		self.iv_prv_addr_source_count         := iv_prv_addr_source_count;
		self.iv_paw_active_phone_count        := iv_paw_active_phone_count;
		self.iv_infutor_nap                   := iv_infutor_nap;
		self.cs_outstanding_liens_ct          := cs_outstanding_liens_ct;
		self._criminal_last_date              := _criminal_last_date;
		self.iv_dc001_mos_since_crim_ls       := iv_dc001_mos_since_crim_ls;
		self.iv_db001_bankruptcy              := iv_db001_bankruptcy;
		self.iv_ms001_ssns_per_adl            := iv_ms001_ssns_per_adl;
		self.bureau_addr_tn_count_pos         := bureau_addr_tn_count_pos;
		self.bureau_addr_count_tn             := bureau_addr_count_tn;
		self.bureau_addr_ts_count_pos         := bureau_addr_ts_count_pos;
		self.bureau_addr_count_ts             := bureau_addr_count_ts;
		self.bureau_addr_tu_count_pos         := bureau_addr_tu_count_pos;
		self.bureau_addr_count_tu             := bureau_addr_count_tu;
		self.bureau_addr_en_count_pos         := bureau_addr_en_count_pos;
		self.bureau_addr_count_en             := bureau_addr_count_en;
		self.bureau_addr_eq_count_pos         := bureau_addr_eq_count_pos;
		self.bureau_addr_count_eq             := bureau_addr_count_eq;
		self._src_bureau_addr_count           := _src_bureau_addr_count;
		self.iv_src_bureau_addr_count         := iv_src_bureau_addr_count;
		self.iv_addr_non_phn_src_ct           := iv_addr_non_phn_src_ct;
		self.iv_inp_addr_ownership_lvl        := iv_inp_addr_ownership_lvl;
		self._add2_mortgage_date              := _add2_mortgage_date;
		self._add2_mortgage_due_date          := _add2_mortgage_due_date;
		self._add3_mortgage_date              := _add3_mortgage_date;
		self._add3_mortgage_due_date          := _add3_mortgage_due_date;
		self.mortgage_date_diff               := mortgage_date_diff;
		self.iv_prv_addr_mortgage_term        := iv_prv_addr_mortgage_term;
		self.iv_prop_owned_assessed_count     := iv_prop_owned_assessed_count;
		self.iv_avg_num_sources_per_addr      := iv_avg_num_sources_per_addr;
		self.iv_max_ids_per_addr              := iv_max_ids_per_addr;
		self.iv_paw_dead_bus_x_active_phn     := iv_paw_dead_bus_x_active_phn;
		self.ver_phn_inf                      := ver_phn_inf;
		self.ver_phn_nap                      := ver_phn_nap;
		self.inf_phn_ver_lvl                  := inf_phn_ver_lvl;
		self.nap_phn_ver_lvl                  := nap_phn_ver_lvl;
		self.iv_nap_phn_ver_x_inf_phn_ver     := iv_nap_phn_ver_x_inf_phn_ver;
		self.iv_eviction_count                := iv_eviction_count;
		self.ff_phone_subscore0               := ff_phone_subscore0;
		self.ff_phone_subscore1               := ff_phone_subscore1;
		self.ff_phone_subscore2               := ff_phone_subscore2;
		self.ff_phone_subscore3               := ff_phone_subscore3;
		self.ff_phone_subscore4               := ff_phone_subscore4;
		self.ff_phone_subscore5               := ff_phone_subscore5;
		self.ff_phone_subscore6               := ff_phone_subscore6;
		self.ff_phone_subscore7               := ff_phone_subscore7;
		self.ff_phone_subscore8               := ff_phone_subscore8;
		self.ff_phone_subscore9               := ff_phone_subscore9;
		self.ff_phone_subscore10              := ff_phone_subscore10;
		self.ff_phone_subscore11              := ff_phone_subscore11;
		self.ff_phone_subscore12              := ff_phone_subscore12;
		self.ff_phone_subscore13              := ff_phone_subscore13;
		self.ff_phone_subscore14              := ff_phone_subscore14;
		self.ff_phone_subscore15              := ff_phone_subscore15;
		self.ff_phone_subscore16              := ff_phone_subscore16;
		self.ff_phone_subscore17              := ff_phone_subscore17;
		self.ff_phone_subscore18              := ff_phone_subscore18;
		self.ff_phone_rawscore                := ff_phone_rawscore;
		self.ff_phone_lnoddsscore             := ff_phone_lnoddsscore;
		self.ff_phone_probscore               := ff_phone_probscore;
		self.ff_nophone_subscore0             := ff_nophone_subscore0;
		self.ff_nophone_subscore1             := ff_nophone_subscore1;
		self.ff_nophone_subscore2             := ff_nophone_subscore2;
		self.ff_nophone_subscore3             := ff_nophone_subscore3;
		self.ff_nophone_subscore4             := ff_nophone_subscore4;
		self.ff_nophone_subscore5             := ff_nophone_subscore5;
		self.ff_nophone_subscore6             := ff_nophone_subscore6;
		self.ff_nophone_subscore7             := ff_nophone_subscore7;
		self.ff_nophone_subscore8             := ff_nophone_subscore8;
		self.ff_nophone_subscore9             := ff_nophone_subscore9;
		self.ff_nophone_subscore10            := ff_nophone_subscore10;
		self.ff_nophone_subscore11            := ff_nophone_subscore11;
		self.ff_nophone_subscore12            := ff_nophone_subscore12;
		self.ff_nophone_subscore13            := ff_nophone_subscore13;
		self.ff_nophone_subscore14            := ff_nophone_subscore14;
		self.ff_nophone_subscore15            := ff_nophone_subscore15;
		self.ff_nophone_subscore16            := ff_nophone_subscore16;
		self.ff_nophone_subscore17            := ff_nophone_subscore17;
		self.ff_nophone_subscore18            := ff_nophone_subscore18;
		self.ff_nophone_subscore19            := ff_nophone_subscore19;
		self.ff_nophone_subscore20            := ff_nophone_subscore20;
		self.ff_nophone_subscore21            := ff_nophone_subscore21;
		self.ff_nophone_subscore22            := ff_nophone_subscore22;
		self.ff_nophone_rawscore              := ff_nophone_rawscore;
		self.ff_nophone_lnoddsscore           := ff_nophone_lnoddsscore;
		self.ff_nophone_probscore             := ff_nophone_probscore;
		self.point                            := point;
		self.base                             := base;
		self.odds                             := odds;
		self._ff_phone_transformed_score      := _ff_phone_transformed_score;
		self.ff_phone_transformed_score       := ff_phone_transformed_score;
		self._ff_nophone_transformed_score    := _ff_nophone_transformed_score;
		self.ff_nophone_transformed_score     := ff_nophone_transformed_score;
		self._rvc1405_4_0                     := _rvc1405_4_0;
		self.ver_src_ds                       := ver_src_ds;
		self.ssn_deceased                     := ssn_deceased;
		self.rvc1405_4_0                      := rvc1405_4_0;
		self.glrc9q                           := glrc9q;
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
		self.score := if(reasons[1].hri IN ['91','92','93','94'],(STRING3)((INTEGER)reasons[1].hri + 10),(string3)rvc1405_4_0);
END;

		model := project( clam, doModel(left) );

		return model;

END;