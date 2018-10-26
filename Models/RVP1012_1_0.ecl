import risk_indicators, riskwise, riskwisefcra, ut, std, riskview;

export RVP1012_1_0( grouped dataset(risk_indicators.Layout_Boca_Shell) clam ) := FUNCTION

  RVP_DEBUG := false;

  #if(RVP_DEBUG)
    layout_debug := record
      risk_indicators.Layout_Boca_Shell clam;
      Integer adl_addr;
      Boolean truedid;
      String out_addr_type;
      String out_addr_status;
      Integer nas_summary;
      Integer nap_summary;
      String rc_hphonevalflag;
      String rc_hriskaddrflag;
      String rc_decsflag;
      String rc_addrvalflag;
      String rc_dwelltype;
      String rc_bansflag;
      String rc_ziptypeflag;
      String rc_zipclass;
      Integer combo_dobscore;
      qstring100 ver_sources;
      qstring200 ver_sources_first_seen;
      qstring100 ver_sources_count;
      Boolean add1_isbestmatch;
      Integer add1_avm_automated_valuation;
      Integer add1_naprop;
      Integer property_owned_total;
      Integer property_sold_total;
      Integer addrs_5yr;
      Integer addrs_10yr;
      Integer addrs_15yr;
      Boolean addrs_prison_history;
      Integer gong_did_first_ct;
      Integer gong_did_last_ct;
      Integer header_first_seen;
      Integer ssns_per_adl;
      Integer addrs_per_adl;
      Integer phones_per_adl;
      Integer phones_per_addr;
      Integer addrs_per_adl_c6;
      Integer infutor_nap;
      Integer impulse_count;
      Integer impulse_count90;
      Integer impulse_count180;
      Integer attr_addrs_last90;
      Integer attr_addrs_last12;
      Integer attr_addrs_last24;
      Integer attr_addrs_last36;
      Integer attr_num_aircraft;
      Integer attr_eviction_count;
      Boolean bankrupt;
      String disposition;
      Integer filing_count;
      Integer bk_recent_count;
      Integer liens_recent_unreleased_count;
      Integer liens_historical_unreleased_ct;
      Integer liens_recent_released_count;
      Integer liens_historical_released_count;
      Integer liens_unrel_sc_ct;
      Integer criminal_count;
      Integer watercraft_count;
      String ams_income_level_code;
      String prof_license_category;
      String wealth_index;
      String input_dob_match_level;
      Integer archive_date;
      qstring100 rc_sources;
      Integer adl_eq_first_seen;
      Integer vo_count;
      Integer credit_first_seen;
      Integer sysdate;
      Integer adl_addr_match_lvl;
      Real adl_addr_match_lvl_m;
      Integer impulse_lvl;
      Real impulse_lvl_m;
      String _disposition;
      Integer bankrupt_lvl;
      Real bankrupt_lvl_m;
      Integer wealth_index_lvl;
      Real wealth_index_lvl_m;
      Boolean verlst_p;
      Boolean veradd_p;
      Integer ver_nap;
      Real ver_nap_m;
      Integer liens_unrel_sc_eviction_lvl;
      Real liens_unrel_sc_eviction_lvl_m;
      Integer property_sold_total_3;
      Real property_sold_total_3_m;
      Real addr_vel_prin2;
      Real addr_vel_log;
      Real addr_velmod;
      Integer addr_velocity;
      Real addr_velocity_m;
      Integer liens_released_lvl;
      Real liens_released_lvl_m;
      Integer ams_income_lvl;
      Real ams_income_lvl_m;
      Integer ssns_per_adl_lvl;
      Real ssns_per_adl_lvl_m;
      Boolean other_prop_flag;
      Integer prop_owned_total_lvl;
      Real prop_owned_total_lvl_m;
      Integer _credit_first_seen;
      Integer mo_credit_first_seen;
      Integer _header_first_seen;
      Integer mo_header_first_seen;
      Integer mo_adl_first_seen;
      Integer adl_first_seen_lvl;
      Real adl_first_seen_lvl_m;
      Integer prof_license_lvl;
      Real prof_license_lvl_m;
      Boolean voter_flag;
      Boolean phones_per_addr_2p;
      Boolean addrs_per_adl_11p;
      Boolean phones_per_adl_2p;
      Boolean velocity_problem;
      Integer add1_avm_automated_valuation_c;
      Real add1_avm_automated_valuation_rt;
      Boolean add_pobox;
      Boolean add_inval;
      String add_ec1;
      Boolean addr_error_flag;
      Boolean addr_problem;
      Boolean addrs_per_adl_c6_f;
      Boolean source_tot_ak;
      Boolean source_tot_am;
      Boolean source_tot_ar;
      Boolean source_tot_ba_1;
      Boolean source_tot_cg;
      Boolean source_tot_co;
      Boolean source_tot_da;
      Boolean source_tot_ds_1;
      Boolean source_tot_eb;
      Boolean source_tot_em;
      Boolean source_tot_vo;
      Boolean source_tot_eq;
      Boolean source_tot_ff;
      Boolean source_tot_l2_1;
      Boolean source_tot_mw;
      Boolean source_tot_pl;
      Boolean source_tot_sl;
      Boolean source_tot_w;
      Boolean source_tot_wp;
      Integer source_tot_count_fcrapos;
      Integer source_tot_count_fcraneg;
      Boolean source_fcradiff_negative;
      Boolean phn_residential;
      Boolean phn_good_counts;
      Boolean phone_prob;
      Boolean na_apt_flag;
      Boolean verlst_inf;
      Boolean veradd_inf;
      Boolean ver_infutor_nap;
      Real axc_log;
      Integer base;
      Integer point;
      Real odds;
      Real phat;
      Integer rvp1012_1_0_2;
      Integer rvp1012_1_0_1;
      Boolean source_tot_ds;
      Boolean source_tot_ba;
      Boolean bk_flag;
      Boolean lien_rec_unrel_flag;
      Boolean lien_hist_unrel_flag;
      Boolean source_tot_l2;
      Boolean source_tot_li;
      Boolean lien_flag;
      Boolean ssn_deceased;
      Boolean scored_222s;
      Integer rvp1012_1_0;
      models.layout_modelout;
    END;
    layout_debug doModel( clam le ) := TRANSFORM
  #else
    models.layout_modelout doModel( clam le ) := TRANSFORM
  #end


    adl_addr                         := le.adl_shell_flags.adl_addr;
    truedid                          := le.truedid;
    out_addr_type                    := le.shell_input.addr_type;
    out_addr_status                  := le.shell_input.addr_status;
    nas_summary                      := le.iid.nas_summary;
    nap_summary                      := le.iid.nap_summary;
    rc_hphonevalflag                 := le.iid.hphonevalflag;
    rc_hriskaddrflag                 := le.iid.hriskaddrflag;
    rc_decsflag                      := le.iid.decsflag;
    rc_addrvalflag                   := le.iid.addrvalflag;
    rc_dwelltype                     := le.iid.dwelltype;
    rc_bansflag                      := le.iid.bansflag;
    rc_ziptypeflag                   := le.iid.ziptypeflag;
    rc_zipclass                      := le.iid.zipclass;
    combo_dobscore                   := le.iid.combo_dobscore;
    ver_sources                      := le.header_summary.ver_sources;
    ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
    ver_sources_count                := le.header_summary.ver_sources_recordcount;
    add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
    add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
    add1_naprop                      := le.address_verification.input_address_information.naprop;
    property_owned_total             := le.address_verification.owned.property_total;
    property_sold_total              := le.address_verification.sold.property_total;
    addrs_5yr                        := le.other_address_info.addrs_last_5years;
    addrs_10yr                       := le.other_address_info.addrs_last_10years;
    addrs_15yr                       := le.other_address_info.addrs_last_15years;
    addrs_prison_history             := le.other_address_info.isprison;
    gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
    gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
    header_first_seen                := le.ssn_verification.header_first_seen;
    ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
    addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
    phones_per_adl                   := le.velocity_counters.phones_per_adl;
    phones_per_addr                  := le.velocity_counters.phones_per_addr;
    addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
    infutor_nap                      := le.infutor_phone.infutor_nap;
    impulse_count                    := le.impulse.count;
    impulse_count90                  := le.impulse.count90;
    impulse_count180                 := le.impulse.count180;
    attr_addrs_last90                := le.other_address_info.addrs_last90;
    attr_addrs_last12                := le.other_address_info.addrs_last12;
    attr_addrs_last24                := le.other_address_info.addrs_last24;
    attr_addrs_last36                := le.other_address_info.addrs_last36;
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
    liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
    criminal_count                   := le.bjl.criminal_count;
    watercraft_count                 := le.watercraft.watercraft_count;
    ams_income_level_code            := le.student.income_level_code;
    prof_license_category            := le.professional_license.plcategory;
    wealth_index                     := le.wealth_indicator;
    input_dob_match_level            := le.dobmatchlevel;
    archive_date                     := if(999999=le.historydate, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);


    NULL := -999999999;

    BOOLEAN indexw(string source, string target, string delim) :=
      (source = target) OR
      (StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
      (source[1..length(target)+1] = target + delim) OR
      (StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

    rc_sources := ver_sources;

    //******************************************************************************************************//
    // Manual implementation of Adam's zip2() function
    // I'm assuming ver_sources contains a given string once at most.  If this isn't true, this code is not correct 
    // I'm not sure if you need to check for the given source in ver_sources when returning values from the zipped dataset
    //******************************************************************************************************//

    eq_first_seen_zipped 	:= Models.common.zip2(ver_sources, ver_sources_first_seen, ' ,');
    // adl_eq_first_seen    	:= if(Models.common.findw_cpp(ver_sources, 'EQ', ' ,', 'I'), (unsigned2)(eq_first_seen_zipped(str1 = 'EQ')[1].str2), 0);
    adl_eq_first_seen    	:= (unsigned3)(eq_first_seen_zipped(str1 = 'EQ')[1].str2);

    vo_count_zipped 		:= Models.common.zip2(ver_sources, ver_sources_count, ' ,');
    // vo_count    			:= if(Models.common.findw_cpp(ver_sources, 'VO', ' ,', 'I'), (unsigned2)(vo_count_zipped(str1 = 'VO')[1].str2), 0);
    vo_count    			:= (unsigned3)(vo_count_zipped(str1 = 'VO')[1].str2);
    //******************************************************************************************************//

    credit_first_seen := adl_eq_first_seen;

    sysdate := models.common.sas_date((string)(archive_date));

    adl_addr_match_lvl := map(
        adl_addr = 2 and add1_isbestmatch => 2,
        adl_addr = 2                      => 1,
                                             0);

    adl_addr_match_lvl_m := map(
        adl_addr_match_lvl = 0 => 0.0027166304,
        adl_addr_match_lvl = 1 => 0.0051997249,
                                  0.0057192571);

    impulse_lvl := map(
        impulse_count > 0 and impulse_count90 > 0  => 3,
        impulse_count > 0 and impulse_count180 > 0 => 2,
                                                      min(if(impulse_count = NULL, -NULL, impulse_count), 3));

    impulse_lvl_m := map(
        impulse_lvl = 0 => 0.0044553496,
        impulse_lvl = 1 => 0.0088281115,
        impulse_lvl = 2 => 0.0104445104,
                           0.0148687604);


    _disposition := map(
        StringLib.StringToUpperCase(disposition) = 'DISMISSED' => 'DISMISSED',
        disposition = ' '                                      => 'NONE',
                                                                  'DISCHARGE');

    bankrupt_lvl := map(
        _disposition = 'DISMISSED'                      => 2,
        _disposition = 'DISCHARGE' and filing_count > 1 => 2,
        _disposition = 'DISCHARGE'                      => 1,
                                                           0);

    bankrupt_lvl_m := map(
        bankrupt_lvl = 0 => 0.004381424,
        bankrupt_lvl = 1 => 0.0059291259,
                            0.0079474382);

    wealth_index_lvl := map(
        wealth_index = '1' or wealth_index = '2' => 1,
        (unsigned1)wealth_index > 0              => (unsigned1)wealth_index - 1,
                                                0);

    wealth_index_lvl_m := map(
        wealth_index_lvl = 0 => 0.0048553844,
        wealth_index_lvl = 1 => 0.0054357755,
        wealth_index_lvl = 2 => 0.0047376781,
        wealth_index_lvl = 3 => 0.0040624505,
        wealth_index_lvl = 4 => 0.0030376619,
                                0.0020083309);

    verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

    veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

    ver_nap := map(
        veradd_p and verlst_p => 2,
        verlst_p              => 1,
                                 0);

    ver_nap_m := map(
        ver_nap = 0 => 0.0038032507,
        ver_nap = 1 => 0.0044106359,
                       0.0056812301);

    liens_unrel_sc_eviction_lvl := if(liens_unrel_sc_ct = 0 and attr_eviction_count > 0, 1, min(if(liens_unrel_sc_ct = NULL, -NULL, liens_unrel_sc_ct), 3));

    liens_unrel_sc_eviction_lvl_m := map(
        liens_unrel_sc_eviction_lvl = 0 => 0.004466311,
        liens_unrel_sc_eviction_lvl = 1 => 0.005582129,
        liens_unrel_sc_eviction_lvl = 2 => 0.0064301822,
                                           0.0083377395);

    property_sold_total_3 := min(if(property_sold_total = NULL, -NULL, property_sold_total), 3);

    property_sold_total_3_m := map(
        property_sold_total_3 = 0 => 0.0048767645,
        property_sold_total_3 = 1 => 0.0038654396,
        property_sold_total_3 = 2 => 0.0027055151,
                                     0.0012017347);

    addr_vel_prin2 := attr_addrs_last90 * 0.043066 +
        attr_addrs_last12 * 0.162197 +
        attr_addrs_last24 * 0.367767 +
        attr_addrs_last36 * 0.488100 +
        addrs_5yr * 0.552018 +
        addrs_10yr * 0.095435 +
        addrs_15yr * -.533395;

    addr_vel_log := -2.9770 + addr_vel_prin2 * -0.0762;

    addr_velmod := round(100 * exp(addr_vel_log) / (1 + exp(addr_vel_log))/.1);

    addr_velocity := map(
        addr_velmod > 56                        => 2,
        45 < addr_velmod AND addr_velmod <= 56 => 1,
        addr_velmod <= 45                       => 0,
                                                    1);

    addr_velocity_m := map(
        addr_velocity = 0 => 0.0037246901,
        addr_velocity = 1 => 0.0047436148,
                             0.0055778587);

    liens_released_lvl := map(
        liens_historical_released_count > 2                                     => 4,
        liens_historical_released_count = 2                                     => 3,
        liens_historical_released_count = 1                                     => 2,
        liens_historical_released_count = 0 and liens_recent_released_count = 0 => 1,
                                                                                   0);

    liens_released_lvl_m := map(
        liens_released_lvl = 0 => 0.0043369499,
        liens_released_lvl = 1 => 0.0045745496,
        liens_released_lvl = 2 => 0.0056604722,
        liens_released_lvl = 3 => 0.0061751904,
                                  0.0068593827);

    ams_income_lvl := map(
        ams_income_level_code = 'J' => 3,
        ams_income_level_code = 'K' => 3,
        ams_income_level_code = 'F' => 3,
        ams_income_level_code = 'G' => 3,
        ams_income_level_code = 'H' => 3,
        ams_income_level_code = 'I' => 3,
        ams_income_level_code = ' ' => 2,
        ams_income_level_code = 'C' => 1,
        ams_income_level_code = 'D' => 1,
        ams_income_level_code = 'E' => 1,
        ams_income_level_code = 'A' => 0,
        ams_income_level_code = 'B' => 0,
                                       2);

    ams_income_lvl_m := map(
        ams_income_lvl = 0 => 0.0055194365,
        ams_income_lvl = 1 => 0.0052085614,
        ams_income_lvl = 2 => 0.0046209595,
                              0.0043438561);

    ssns_per_adl_lvl := map(
        ssns_per_adl > 3 => 3,
        ssns_per_adl = 3 => 2,
        ssns_per_adl = 2 => 1,
        ssns_per_adl = 1 => 0,
                            0);

    ssns_per_adl_lvl_m := map(
        ssns_per_adl_lvl = 0 => 0.0044838577,
        ssns_per_adl_lvl = 1 => 0.0049319222,
        ssns_per_adl_lvl = 2 => 0.0053665676,
                                0.0064486603);

    other_prop_flag := watercraft_count > 0 or attr_num_aircraft > 0;

    prop_owned_total_lvl := min(if(property_owned_total + (integer)other_prop_flag = NULL, -NULL, property_owned_total + (integer)other_prop_flag), 4);

    prop_owned_total_lvl_m := map(
        prop_owned_total_lvl = 0 => 0.0048864506,
        prop_owned_total_lvl = 1 => 0.0047592047,
        prop_owned_total_lvl = 2 => 0.0040640502,
        prop_owned_total_lvl = 3 => 0.003118075,
                                    0.0017114496);

    _credit_first_seen := models.common.sas_date((string)(credit_first_seen));

    mo_credit_first_seen := if(min(sysdate, _credit_first_seen) = NULL, NULL, truncate((sysdate - _credit_first_seen) / (365.25 / 12)));

    _header_first_seen := models.common.sas_date((string)(header_first_seen));

    mo_header_first_seen := if(min(sysdate, _header_first_seen) = NULL, NULL, truncate((sysdate - _header_first_seen) / (365.25 / 12)));

    mo_adl_first_seen := if(max(mo_credit_first_seen, mo_header_first_seen) = NULL, NULL, min(if(mo_credit_first_seen = NULL, -NULL, mo_credit_first_seen), if(mo_header_first_seen = NULL, -NULL, mo_header_first_seen)));

    adl_first_seen_lvl := map(
        mo_adl_first_seen > 192                             => 4,
        96 < mo_adl_first_seen AND mo_adl_first_seen <= 192 => 3,
        48 < mo_adl_first_seen AND mo_adl_first_seen <= 96  => 2,
        24 < mo_adl_first_seen AND mo_adl_first_seen <= 48  => 1,
                                                               0);

    adl_first_seen_lvl_m := map(
        adl_first_seen_lvl = 0 => 0.0036270237,
        adl_first_seen_lvl = 1 => 0.0036122984,
        adl_first_seen_lvl = 2 => 0.0040273374,
        adl_first_seen_lvl = 3 => 0.0048695501,
                                  0.0052496768);

    prof_license_lvl := map(
        (prof_license_category in ['4', '5'])      => 2,
        (prof_license_category in ['3'])           => 1,
        (prof_license_category in ['0', '1', '2']) => 0,
                                                      1);

    prof_license_lvl_m := map(
        prof_license_lvl = 0 => 0.0055685011,
        prof_license_lvl = 1 => 0.0046816166,
                                0.0037047468);

    voter_flag := vo_count > 0;

    phones_per_addr_2p := phones_per_addr >= 2;

    addrs_per_adl_11p := addrs_per_adl >= 11;

    phones_per_adl_2p := phones_per_adl >= 2;

    velocity_problem := phones_per_addr_2p or addrs_per_adl_11p or phones_per_adl_2p;

    add1_avm_automated_valuation_c := if(add1_avm_automated_valuation <= 0, 100000, min(if(max(add1_avm_automated_valuation, 1) = NULL, -NULL, max(add1_avm_automated_valuation, 1)), 1000000));

    add1_avm_automated_valuation_rt := sqrt(add1_avm_automated_valuation_c);

    add_pobox := rc_hriskaddrflag = '1' or rc_ziptypeflag = '1' or StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P';

    add_inval := StringLib.StringToUpperCase(trim(rc_addrvalflag, LEFT, RIGHT)) != 'V';

    add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

    addr_error_flag := add_ec1 = 'E';

    addr_problem := add_pobox or add_inval or addrs_prison_history or addr_error_flag;

    addrs_per_adl_c6_f := addrs_per_adl_c6 > 0;

    source_tot_ak := Models.common.findw_cpp(rc_sources, 'AK' , ' ,', 'I') > 0;
    source_tot_am := Models.common.findw_cpp(rc_sources, 'AM' , ' ,', 'I') > 0;
    source_tot_ar := Models.common.findw_cpp(rc_sources, 'AR' , ' ,', 'I') > 0;
    source_tot_ba_1 := Models.common.findw_cpp(rc_sources, 'BA' , ' ,', 'I') > 0;
    source_tot_cg := Models.common.findw_cpp(rc_sources, 'CG' , ' ,', 'I') > 0;
    source_tot_co := Models.common.findw_cpp(rc_sources, 'CO' , ' ,', 'I') > 0;
    source_tot_da := Models.common.findw_cpp(rc_sources, 'DA' , ' ,', 'I') > 0;
    source_tot_ds_1 := Models.common.findw_cpp(rc_sources, 'DS' , ' ,', 'I') > 0;
    source_tot_eb := Models.common.findw_cpp(rc_sources, 'EB' , ' ,', 'I') > 0;
    source_tot_em := Models.common.findw_cpp(rc_sources, 'EM' , ' ,', 'I') > 0;
    source_tot_vo := Models.common.findw_cpp(rc_sources, 'VO' , ' ,', 'I') > 0;
    source_tot_eq := Models.common.findw_cpp(rc_sources, 'EQ' , ' ,', 'I') > 0;
    source_tot_ff := Models.common.findw_cpp(rc_sources, 'FF' , ' ,', 'I') > 0;
    source_tot_l2_1 := Models.common.findw_cpp(rc_sources, 'L2' , ' ,', 'I') > 0;
    source_tot_mw := Models.common.findw_cpp(rc_sources, 'MW' , ' ,', 'I') > 0;
    source_tot_pl := Models.common.findw_cpp(rc_sources, 'PL' , ' ,', 'I') > 0;
    source_tot_sl := Models.common.findw_cpp(rc_sources, 'SL' , ' ,', 'I') > 0;
    source_tot_w := Models.common.findw_cpp(rc_sources, 'W' , ' ,', 'I') > 0;
    source_tot_wp := Models.common.findw_cpp(rc_sources, 'WP' , ' ,', 'I') > 0;

    source_tot_count_fcrapos := if(max((integer)source_tot_am, (integer)source_tot_ar, (integer)source_tot_eb, (integer)source_tot_em, (integer)source_tot_vo, (integer)source_tot_eq, (integer)source_tot_mw, (integer)source_tot_pl, (integer)source_tot_sl, (integer)source_tot_w, (integer)source_tot_wp) = NULL, NULL, sum((integer)source_tot_am, (integer)source_tot_ar, (integer)source_tot_eb, (integer)source_tot_em, (integer)source_tot_vo, (integer)source_tot_eq, (integer)source_tot_mw, (integer)source_tot_pl, (integer)source_tot_sl, (integer)source_tot_w, (integer)source_tot_wp));

    source_tot_count_fcraneg := if(max((integer)source_tot_ak, (integer)source_tot_ba_1, (integer)source_tot_cg, (integer)source_tot_co, (integer)source_tot_da, (integer)source_tot_ds_1, (integer)source_tot_ff, (integer)source_tot_l2_1) = NULL, NULL, sum((integer)source_tot_ak, (integer)source_tot_ba_1, (integer)source_tot_cg, (integer)source_tot_co, (integer)source_tot_da, (integer)source_tot_ds_1, (integer)source_tot_ff, (integer)source_tot_l2_1));

    source_fcradiff_negative := source_tot_count_fcrapos <= source_tot_count_fcraneg;

    phn_residential := rc_hphonevalflag = '2';

    phn_good_counts := (gong_did_first_ct in [1, 2]) and gong_did_last_ct = 1;

    phone_prob := not phn_residential or not phn_good_counts;

    na_apt_flag := add1_naprop = 0 and rc_dwelltype = 'A';

    verlst_inf := (infutor_nap in [2, 5, 7, 8, 9, 11, 12]);

    veradd_inf := (infutor_nap in [3, 5, 6, 8, 10, 11, 12]);

    ver_infutor_nap := veradd_inf and verlst_inf;

    axc_log := -14.77970396 +
        adl_addr_match_lvl_m * 232.98328676 +
        impulse_lvl_m * 115.79916038 +
        bankrupt_lvl_m * 132.5013477 +
        wealth_index_lvl_m * 99.502926408 +
        ver_nap_m * 121.55974658 +
        liens_unrel_sc_eviction_lvl_m * 129.78445724 +
        property_sold_total_3_m * 228.46108732 +
        addr_velocity_m * 94.264450064 +
        liens_released_lvl_m * 103.61823651 +
        ams_income_lvl_m * 184.0801135 +
        ssns_per_adl_lvl_m * 114.81905361 +
        prop_owned_total_lvl_m * 184.7463311 +
        adl_first_seen_lvl_m * 89.461240579 +
        prof_license_lvl_m * 181.98137967 +
        (integer)voter_flag * 0.3010867543 +
        (integer)velocity_problem * 0.1624106873 +
        add1_avm_automated_valuation_rt * -0.001098519 +
        (integer)addr_problem * -0.165646584 +
        (integer)addrs_per_adl_c6_f * -0.109988895 +
        (integer)source_fcradiff_negative * 0.1329861396 +
        (integer)phone_prob * -0.071175349 +
        (integer)na_apt_flag * 0.1100471685 +
        (integer)ver_infutor_nap * 0.0487655412;

    base := 700;

    point := -50;

    odds := .004685 / (1 - .004685);

    phat := exp(axc_log) / (1 + exp(axc_log));

    rvp1012_1_0_2 := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

    rvp1012_1_0_1 := max(501, min(900, if(rvp1012_1_0_2 = NULL, -NULL, rvp1012_1_0_2)));

    source_tot_ds := indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'DS', ',');

    source_tot_ba := indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'BA', ',');

    bk_flag := (rc_bansflag in ['1', '2']) or source_tot_ba or bankrupt or filing_count > 0 or bk_recent_count > 0;

    lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

    lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

    source_tot_l2 := indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'L2', ',');

    source_tot_li := indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'LI', ',');

    lien_flag := source_tot_l2 or source_tot_li or lien_rec_unrel_flag or lien_hist_unrel_flag;

    ssn_deceased := rc_decsflag = '1' or source_tot_ds;

    // scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= 7 or lien_flag > 0 or criminal_count > 0 or bk_flag > 0 or ssn_deceased or truedid);
    scored_222s := property_owned_total > 0 or property_sold_total > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (unsigned1)input_dob_match_level >= 7 or lien_flag or criminal_count > 0 or bk_flag or ssn_deceased or truedid);

    rvp1012_1_0 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvp1012_1_0_1);

    #if(RVP_DEBUG)
      self.clam := le;
      self.adl_addr                         := adl_addr;
      self.truedid                          := truedid;
      self.out_addr_type                    := out_addr_type;
      self.out_addr_status                  := out_addr_status;
      self.nas_summary                      := nas_summary;
      self.nap_summary                      := nap_summary;
      self.rc_hphonevalflag                 := rc_hphonevalflag;
      self.rc_hriskaddrflag                 := rc_hriskaddrflag;
      self.rc_decsflag                      := rc_decsflag;
      self.rc_addrvalflag                   := rc_addrvalflag;
      self.rc_dwelltype                     := rc_dwelltype;
      self.rc_bansflag                      := rc_bansflag;
      self.rc_ziptypeflag                   := rc_ziptypeflag;
      self.rc_zipclass                      := rc_zipclass;
      self.combo_dobscore                   := combo_dobscore;
      self.ver_sources                      := ver_sources;
      self.ver_sources_first_seen           := ver_sources_first_seen;
      self.ver_sources_count                := ver_sources_count;
      self.add1_isbestmatch                 := add1_isbestmatch;
      self.add1_avm_automated_valuation     := add1_avm_automated_valuation;
      self.add1_naprop                      := add1_naprop;
      self.property_owned_total             := property_owned_total;
      self.property_sold_total              := property_sold_total;
      self.addrs_5yr                        := addrs_5yr;
      self.addrs_10yr                       := addrs_10yr;
      self.addrs_15yr                       := addrs_15yr;
      self.addrs_prison_history             := addrs_prison_history;
      self.gong_did_first_ct                := gong_did_first_ct;
      self.gong_did_last_ct                 := gong_did_last_ct;
      self.header_first_seen                := header_first_seen;
      self.ssns_per_adl                     := ssns_per_adl;
      self.addrs_per_adl                    := addrs_per_adl;
      self.phones_per_adl                   := phones_per_adl;
      self.phones_per_addr                  := phones_per_addr;
      self.addrs_per_adl_c6                 := addrs_per_adl_c6;
      self.infutor_nap                      := infutor_nap;
      self.impulse_count                    := impulse_count;
      self.impulse_count90                  := impulse_count90;
      self.impulse_count180                 := impulse_count180;
      self.attr_addrs_last90                := attr_addrs_last90;
      self.attr_addrs_last12                := attr_addrs_last12;
      self.attr_addrs_last24                := attr_addrs_last24;
      self.attr_addrs_last36                := attr_addrs_last36;
      self.attr_num_aircraft                := attr_num_aircraft;
      self.attr_eviction_count              := attr_eviction_count;
      self.bankrupt                         := bankrupt;
      self.disposition                      := disposition;
      self.filing_count                     := filing_count;
      self.bk_recent_count                  := bk_recent_count;
      self.liens_recent_unreleased_count    := liens_recent_unreleased_count;
      self.liens_historical_unreleased_ct   := liens_historical_unreleased_ct;
      self.liens_recent_released_count      := liens_recent_released_count;
      self.liens_historical_released_count  := liens_historical_released_count;
      self.liens_unrel_sc_ct                := liens_unrel_sc_ct;
      self.criminal_count                   := criminal_count;
      self.watercraft_count                 := watercraft_count;
      self.ams_income_level_code            := ams_income_level_code;
      self.prof_license_category            := prof_license_category;
      self.wealth_index                     := wealth_index;
      self.input_dob_match_level            := input_dob_match_level;
      self.archive_date                     := archive_date;
      self.rc_sources                       := rc_sources;
      self.adl_eq_first_seen                := adl_eq_first_seen;
      self.vo_count                         := vo_count;
      self.credit_first_seen                := credit_first_seen;
      self.sysdate                          := sysdate;
      self.adl_addr_match_lvl               := adl_addr_match_lvl;
      self.adl_addr_match_lvl_m             := adl_addr_match_lvl_m;
      self.impulse_lvl                      := impulse_lvl;
      self.impulse_lvl_m                    := impulse_lvl_m;
      self._disposition                     := _disposition;
      self.bankrupt_lvl                     := bankrupt_lvl;
      self.bankrupt_lvl_m                   := bankrupt_lvl_m;
      self.wealth_index_lvl                 := wealth_index_lvl;
      self.wealth_index_lvl_m               := wealth_index_lvl_m;
      self.verlst_p                         := verlst_p;
      self.veradd_p                         := veradd_p;
      self.ver_nap                          := ver_nap;
      self.ver_nap_m                        := ver_nap_m;
      self.liens_unrel_sc_eviction_lvl      := liens_unrel_sc_eviction_lvl;
      self.liens_unrel_sc_eviction_lvl_m    := liens_unrel_sc_eviction_lvl_m;
      self.property_sold_total_3            := property_sold_total_3;
      self.property_sold_total_3_m          := property_sold_total_3_m;
      self.addr_vel_prin2                   := addr_vel_prin2;
      self.addr_vel_log                     := addr_vel_log;
      self.addr_velmod                      := addr_velmod;
      self.addr_velocity                    := addr_velocity;
      self.addr_velocity_m                  := addr_velocity_m;
      self.liens_released_lvl               := liens_released_lvl;
      self.liens_released_lvl_m             := liens_released_lvl_m;
      self.ams_income_lvl                   := ams_income_lvl;
      self.ams_income_lvl_m                 := ams_income_lvl_m;
      self.ssns_per_adl_lvl                 := ssns_per_adl_lvl;
      self.ssns_per_adl_lvl_m               := ssns_per_adl_lvl_m;
      self.other_prop_flag                  := other_prop_flag;
      self.prop_owned_total_lvl             := prop_owned_total_lvl;
      self.prop_owned_total_lvl_m           := prop_owned_total_lvl_m;
      self._credit_first_seen               := _credit_first_seen;
      self.mo_credit_first_seen             := mo_credit_first_seen;
      self._header_first_seen               := _header_first_seen;
      self.mo_header_first_seen             := mo_header_first_seen;
      self.mo_adl_first_seen                := mo_adl_first_seen;
      self.adl_first_seen_lvl               := adl_first_seen_lvl;
      self.adl_first_seen_lvl_m             := adl_first_seen_lvl_m;
      self.prof_license_lvl                 := prof_license_lvl;
      self.prof_license_lvl_m               := prof_license_lvl_m;
      self.voter_flag                       := voter_flag;
      self.phones_per_addr_2p               := phones_per_addr_2p;
      self.addrs_per_adl_11p                := addrs_per_adl_11p;
      self.phones_per_adl_2p                := phones_per_adl_2p;
      self.velocity_problem                 := velocity_problem;
      self.add1_avm_automated_valuation_c   := add1_avm_automated_valuation_c;
      self.add1_avm_automated_valuation_rt  := add1_avm_automated_valuation_rt;
      self.add_pobox                        := add_pobox;
      self.add_inval                        := add_inval;
      self.add_ec1                          := add_ec1;
      self.addr_error_flag                  := addr_error_flag;
      self.addr_problem                     := addr_problem;
      self.addrs_per_adl_c6_f               := addrs_per_adl_c6_f;
      self.source_tot_ak                    := source_tot_ak;
      self.source_tot_am                    := source_tot_am;
      self.source_tot_ar                    := source_tot_ar;
      self.source_tot_ba_1                  := source_tot_ba_1;
      self.source_tot_cg                    := source_tot_cg;
      self.source_tot_co                    := source_tot_co;
      self.source_tot_da                    := source_tot_da;
      self.source_tot_ds_1                  := source_tot_ds_1;
      self.source_tot_eb                    := source_tot_eb;
      self.source_tot_em                    := source_tot_em;
      self.source_tot_vo                    := source_tot_vo;
      self.source_tot_eq                    := source_tot_eq;
      self.source_tot_ff                    := source_tot_ff;
      self.source_tot_l2_1                  := source_tot_l2_1;
      self.source_tot_mw                    := source_tot_mw;
      self.source_tot_pl                    := source_tot_pl;
      self.source_tot_sl                    := source_tot_sl;
      self.source_tot_w                     := source_tot_w;
      self.source_tot_wp                    := source_tot_wp;
      self.source_tot_count_fcrapos         := source_tot_count_fcrapos;
      self.source_tot_count_fcraneg         := source_tot_count_fcraneg;
      self.source_fcradiff_negative         := source_fcradiff_negative;
      self.phn_residential                  := phn_residential;
      self.phn_good_counts                  := phn_good_counts;
      self.phone_prob                       := phone_prob;
      self.na_apt_flag                      := na_apt_flag;
      self.verlst_inf                       := verlst_inf;
      self.veradd_inf                       := veradd_inf;
      self.ver_infutor_nap                  := ver_infutor_nap;
      self.axc_log                          := axc_log;
      self.base                             := base;
      self.point                            := point;
      self.odds                             := odds;
      self.phat                             := phat;
      self.rvp1012_1_0_2                    := rvp1012_1_0_2;
      self.rvp1012_1_0_1                    := rvp1012_1_0_1;
      self.source_tot_ds                    := source_tot_ds;
      self.source_tot_ba                    := source_tot_ba;
      self.bk_flag                          := bk_flag;
      self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
      self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
      self.source_tot_l2                    := source_tot_l2;
      self.source_tot_li                    := source_tot_li;
      self.lien_flag                        := lien_flag;
      self.ssn_deceased                     := ssn_deceased;
      self.scored_222s                      := scored_222s;
      self.rvp1012_1_0                      := rvp1012_1_0;
    #end

    self.seq := le.seq;
		PrescreenOptOut := risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
		self.score := if( risk_indicators.rcset.isCode95(PreScreenOptOut), '222', (string3)rvp1012_1_0 );
		self.ri := if( risk_indicators.rcset.isCode95(PreScreenOptOut), DATASET([{'95', risk_indicators.getHRIDesc('95')}],risk_indicators.Layout_Desc) );
  END;


  model := project( clam, doModel(left) );
  return model;
END;