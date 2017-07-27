import easi, risk_indicators, riskwise, ut;

bs_with_ip := record
	risk_indicators.Layout_Boca_Shell bs;
	riskwise.Layout_IP2O ip;
end;

export FP31203_1_0( dataset(bs_with_ip) clam, string inputfluxgrade ) := FUNCTION

  FP_DEBUG := false;
	
  #if(FP_DEBUG)
    layout_debug := record
      string inputfluxgrade;
      Boolean truedid;
      String adl_category;
      String in_state;
      Integer nas_summary;
      Integer nap_summary;
      String nap_status;
      Integer did_count;
      String rc_hriskphoneflag;
      String rc_hphonetypeflag;
      String rc_wphonetypeflag;
      String rc_phonevalflag;
      String rc_hphonevalflag;
      String rc_wphonevalflag;
      Boolean rc_wphonedissflag;
      String rc_decsflag;
      String rc_ssndobflag;
      String rc_pwssndobflag;
      String rc_ssnvalflag;
      String rc_pwssnvalflag;
      String rc_ssnstate;
      String rc_bansflag;
      String rc_sources;
      String rc_addrcommflag;
      Integer rc_disthphonewphone;
      String rc_phonetype;
      Integer combo_dobscore;
      Boolean dobpop;
      qstring50 util_adl_type_list;
      Integer util_adl_count;
      Boolean add1_isbestmatch;
      Integer add1_naprop;
      Integer property_owned_total;
      Integer property_sold_total;
      Boolean addrs_prison_history;
      String telcordia_type;
      String gong_did_first_seen;
      String gong_did_last_seen;
      Integer gong_did_first_ct;
      Integer gong_did_last_ct;
      Integer ssns_per_adl;
      Integer ssns_per_addr;
      Integer ssns_per_adl_c6;
      Integer addrs_per_ssn_c6;
      Integer ssns_per_addr_c6;
      Integer invalid_ssns_per_adl;
      Integer invalid_ssns_per_adl_c6;
      Integer infutor_nap;
      Integer impulse_count;
      Integer attr_total_number_derogs;
      Integer attr_arrests;
      Integer attr_arrests12;
      Integer attr_eviction_count;
      Integer attr_eviction_count24;
      Integer attr_eviction_count60;
      Integer attr_num_nonderogs;
      Boolean bankrupt;
      Integer filing_count;
      Integer bk_recent_count;
      Integer liens_recent_unreleased_count;
      Integer liens_historical_unreleased_ct;
      Integer liens_unrel_ot_ct;
      Integer liens_unrel_ot_last_seen;
      Integer liens_unrel_sc_ct;
      Integer liens_unrel_sc_last_seen;
      Integer liens_rel_sc_ct;
      Integer criminal_count;
      Integer criminal_last_date;
      Integer felony_count;
      Integer rel_count;
      Integer rel_bankrupt_count;
      Integer rel_criminal_count;
      Integer rel_felony_count;
      Integer crim_rel_within25miles;
      Integer rel_prop_owned_count;
      Integer rel_incomeunder50_count;
      Integer rel_incomeunder75_count;
      Integer rel_incomeunder100_count;
      Integer rel_incomeover100_count;
      Integer rel_homeunder100_count;
      Integer rel_homeunder150_count;
      Integer rel_homeunder200_count;
      Integer rel_homeunder300_count;
      Integer rel_homeunder500_count;
      Integer rel_homeover500_count;
      Integer rel_educationunder12_count;
      Integer rel_educationover12_count;
      Integer rel_ageunder30_count;
      Integer rel_ageunder40_count;
      Integer rel_ageunder50_count;
      Integer rel_ageunder60_count;
      Integer rel_ageunder70_count;
      Integer rel_ageover70_count;
      Integer acc_count;
      String ams_college_code;
      String ams_college_type;
      String prof_license_category;
      String input_dob_match_level;
      String addr_stability;
      Integer estimated_income;
      Integer archive_date;
      String c_child;
      String c_low_ed;
      String c_no_labfor;
      String c_sub_bus;
      Integer sysdate_1;
      Integer sysdate;
      Real r1;
      Real p1;
      Real log_offset;
      Integer nonf_acc_count_lvl;
      Real nonf_acc_count_lvl_m;
      Integer nonf_attr_arrests_lvl;
      Real nonf_attr_arrests_lvl_m;
      Real addr_stability_m;
      Integer fcra_disthphonewphone_lvl;
      Real fcra_disthphonewphone_lvl_m;
      Integer total_source_count_fcrapos;
      Integer total_source_count_fcraneg;
      Integer fcra_pos_neg_source_lvl;
      Real fcra_pos_neg_source_lvl_m;
      Integer fcra_derog_diff;
      Real fcra_derog_diff_m;
      Boolean wphone_type_unknown;
      Boolean wphone_invalid_number;
      Boolean wphone_disconnected;
      Integer fcra_wphone_bad_phn_lvl;
      Real fcra_wphone_bad_phn_lvl_m;
      Integer fcra_college_lvl;
      Real fcra_college_lvl_m;
      Real fcra_prof_lic_lvl;
      Real fcra_prof_lic_lvl_m;
      Integer _liens_unrel_ot_last_seen;
      Integer mos_ot_unrel_last_seen;
      Integer fcra_ot_unrel_lien_lvl;
      Real fcra_ot_unrel_lien_lvl_m;
      Integer _liens_unrel_sc_last_seen;
      Integer mos_sc_unrel_last_seen;
      Integer fcra_sc_lien_lvl;
      Real fcra_sc_lien_lvl_m;
      Integer fcra_addrs_per_ssn_c6_2_1;
      Real fcra_addrs_per_ssn_c6_2_m_1;
      Integer fcra_addrs_per_ssn_c6_2;
      Real fcra_addrs_per_ssn_c6_2_m;
      Integer fcra_invalid_ssns_per_adl_lvl;
      Real fcra_invalid_ssns_per_adl_lvl_m;
      Integer fcra_dob_match_lvl;
      Real fcra_dob_match_lvl_m;
      Integer rel_income_100plus;
      Integer rel_income_75plus;
      Integer rel_income_50plus;
      Integer rel_income_25plus;
      Integer rel_home_500plus;
      Integer rel_home_300plus;
      Integer rel_home_200plus;
      Integer rel_home_150plus;
      Integer rel_home_100plus;
      Integer rel_home_50plus;
      Integer rel_ed_over12;
      Integer rel_ed_over8;
      Integer rel_age_over70;
      Integer rel_age_over60;
      Integer rel_age_over50;
      Integer rel_age_over40;
      Integer rel_age_over30;
      Integer rel_age_over20;
      Integer nonf_rel_bankrupt_ratio_c27;
      Integer nonf_rel_criminal_ratio_c28;
      Integer nonf_rel_felony_ratio_c29;
      Integer nonf_crim_rel_25miles_ratio_c30;
      Integer nonf_rel_prop_owned_ratio_c31;
      Integer nonf_rel_income_100plus_ratio_c33;
      Integer nonf_rel_income_75plus_ratio_c34;
      Integer nonf_rel_home_300plus_ratio_c38;
      Integer nonf_rel_ed_over12_ratio_c43;
      Integer nonf_rel_age_over40_ratio_c48;
      Integer nonf_rel_ed_over12_ratio;
      Integer nonf_crim_rel_25miles_ratio;
      Integer nonf_rel_income_100plus_ratio;
      Integer nonf_rel_felony_ratio;
      Integer nonf_rel_age_over40_ratio;
      Integer nonf_rel_criminal_ratio;
      Integer nonf_rel_home_300plus_ratio;
      Integer nonf_rel_bankrupt_ratio;
      Integer nonf_rel_income_75plus_ratio;
      Integer nonf_rel_prop_owned_ratio;
      Integer nonf_rel_bankrupt_ratio_f;
      Integer nonf_rel_criminal_ratio_f;
      Integer nonf_rel_felony_ratio_f;
      Integer nonf_crim_rel_25miles_ratio_f;
      Real nonf_rel_prop_owned_ratio_c;
      Real nonf_rel_prop_owned_ratio_lg;
      Real nonf_rel_income_100plus_ratio_c;
      Real nonf_rel_income_100plus_ratio_lg;
      Real nonf_rel_income_75plus_ratio_c;
      Real nonf_rel_income_75plus_ratio_lg;
      Real nonf_rel_age_over40_ratio_c;
      Real nonf_rel_age_over40_ratio_lg;
      Boolean nonf_rel_prop_owned_ratio_f;
      Boolean nonf_rel_income_100plus_ratio_f;
      Boolean nonf_rel_home_300plus_ratio_f;
      Boolean nonf_rel_ed_over12_ratio_f;
      Boolean nonf_rel_age_over40_ratio_f;
      Real relmod_log;
      Real relmod;
      Boolean nonf_util_cell_f;
      Integer nonf_util_adl_count_c;
      Real nonf_util_adl_count_lg;
      Real c_child_2;
      Real _c_child;
      Real _c_child_lg;
      Real c_low_ed_2;
      Real _c_low_ed;
      Real _c_low_ed_lg;
      Real c_no_labfor_2;
      Real _c_no_labfor;
      Real _c_no_labfor_lg;
      Real c_sub_bus_2;
      Real _c_sub_bus;
      Real _c_sub_bus_lg;
      Boolean contrary_phn;
      Boolean verfst_p;
      Boolean verlst_p;
      Boolean veradd_p;
      Boolean verphn_p;
      Boolean contrary_inf;
      Boolean verfst_i;
      Boolean verlst_i;
      Boolean veradd_i;
      Boolean verphn_i;
      Boolean contrary_ssn;
      Boolean verfst_s;
      Boolean verlst_s;
      Boolean veradd_s;
      Boolean verssn_s;
      Boolean nas_479;
      Boolean phn_dcd;
      Real vermod_log;
      Real vermod;
      Integer _gong_did_first_seen;
      Integer _gong_did_last_seen;
      Integer mos_since_gong_first_seen;
      Integer mos_since_gong_last_seen;
      Boolean phn_last_seen_rec;
      Boolean phn_first_seen_rec;
      Boolean phn_pots;
      Boolean phn_disconnected;
      Boolean phn_inval;
      Boolean phn_nonus;
      Boolean phn_highrisk;
      Boolean phn_notpots;
      Boolean phn_cellpager;
      Boolean phn_business;
      Boolean phn_residential;
      Boolean phn_good_counts;
      Real phonemod_log;
      Real phonemod;
      Boolean ssn_priordob;
      Boolean ssn_inval;
      Boolean ssn_deceased_1;
      Boolean ssn_issued18;
      Boolean ssn_statediff;
      Boolean ssn_adl_prob;
      Boolean ssn_prob;
      Real ssnprob_log;
      Real ssnprobmod;
      Integer fcra_estimated_income_c;
      Real fcra_estimated_income_lg;
      Integer _criminal_last_date;
      Integer mos_criminal_last_seen;
      Integer fcra_criminal_lvl;
      Real fcra_criminal_lvl_m;
      Integer fcra_eviction_lvl;
      Real fcra_eviction_lvl_m;
      Integer fcra_ssns_per_addr_lvl;
      Real fcra_ssns_per_addr_lvl_m;
      Boolean core_adl;
      Boolean single_did;
      Integer fcra_adl_lvl;
      Real fcra_adl_lvl_m;
      Real nonfcra_log;
      Integer base;
      Integer point;
      Real odds;
      Real phat;
      Integer scaled_score;
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
      Integer fp31203_1_0;
      Integer fp31203_1_1;
			risk_indicators.Layout_Boca_Shell clam;
      models.layout_modelout;
    end;
    layout_debug doModel(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
  #else
    models.layout_modelout doModel(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
  #end

    truedid                          := le.bs.truedid;
    adl_category                     := le.bs.adlcategory;
    in_state                         := le.bs.shell_input.in_state;
    nas_summary                      := le.bs.iid.nas_summary;
    nap_summary                      := le.bs.iid.nap_summary;
    nap_status                       := le.bs.iid.nap_status;
    did_count                        := le.bs.iid.didcount;
    rc_hriskphoneflag                := le.bs.iid.hriskphoneflag;
    rc_hphonetypeflag                := le.bs.iid.hphonetypeflag;
    rc_wphonetypeflag                := le.bs.iid.wphonetypeflag;
    rc_phonevalflag                  := le.bs.iid.phonevalflag;
    rc_hphonevalflag                 := le.bs.iid.hphonevalflag;
    rc_wphonevalflag                 := le.bs.iid.wphonevalflag;
    rc_wphonedissflag                := le.bs.iid.wphonedissflag;
    rc_decsflag                      := le.bs.iid.decsflag;
    rc_ssndobflag                    := le.bs.iid.socsdobflag;
    rc_pwssndobflag                  := le.bs.iid.pwsocsdobflag;
    rc_ssnvalflag                    := le.bs.iid.socsvalflag;
    rc_pwssnvalflag                  := le.bs.iid.pwsocsvalflag;
    rc_ssnstate                      := le.bs.iid.soclstate;
    rc_bansflag                      := le.bs.iid.bansflag;
    rc_sources                       := le.bs.iid.sources;
    rc_addrcommflag                  := le.bs.iid.addrcommflag;
    rc_disthphonewphone              := le.bs.iid.disthphonewphone;
    rc_phonetype                     := le.bs.iid.phonetype;
    combo_dobscore                   := le.bs.iid.combo_dobscore;
    dobpop                           := le.bs.input_validation.dateofbirth;
    util_adl_type_list               := le.bs.utility.utili_adl_type;
		util_adl_first_seen_list         := le.bs.utility.utili_adl_dt_first_seen;
		util_add1_type_list              := le.bs.utility.utili_addr1_type;
		util_add2_type_list              := le.bs.utility.utili_addr2_type;		
    util_adl_count                   := le.bs.utility.utili_adl_count;
    add1_isbestmatch                 := le.bs.address_verification.input_address_information.isbestmatch;
    add1_naprop                      := le.bs.address_verification.input_address_information.naprop;
    property_owned_total             := le.bs.address_verification.owned.property_total;
    property_sold_total              := le.bs.address_verification.sold.property_total;
    addrs_prison_history             := le.bs.other_address_info.isprison;
    telcordia_type                   := le.bs.phone_verification.telcordia_type;
    gong_did_first_seen              := le.bs.phone_verification.gong_did.gong_adl_dt_first_seen_full;
    gong_did_last_seen               := le.bs.phone_verification.gong_did.gong_adl_dt_last_seen_full;
    gong_did_first_ct                := le.bs.phone_verification.gong_did.gong_did_first_ct;
    gong_did_last_ct                 := le.bs.phone_verification.gong_did.gong_did_last_ct;
    ssns_per_adl                     := le.bs.velocity_counters.ssns_per_adl;
    ssns_per_addr                    := le.bs.velocity_counters.ssns_per_addr;
    ssns_per_adl_c6                  := le.bs.velocity_counters.ssns_per_adl_created_6months;
    addrs_per_ssn_c6                 := le.bs.velocity_counters.addrs_per_ssn_created_6months;
    ssns_per_addr_c6                 := le.bs.velocity_counters.ssns_per_addr_created_6months;
    invalid_ssns_per_adl             := le.bs.velocity_counters.invalid_ssns_per_adl;
    invalid_ssns_per_adl_c6          := le.bs.velocity_counters.invalid_ssns_per_adl_created_6months;
    infutor_nap                      := le.bs.infutor_phone.infutor_nap;
    impulse_count                    := le.bs.impulse.count;
    attr_total_number_derogs         := le.bs.total_number_derogs;
    attr_arrests                     := le.bs.bjl.arrests_count;
    attr_arrests12                   := le.bs.bjl.arrests_count12;
    attr_eviction_count              := le.bs.bjl.eviction_count;
    attr_eviction_count24            := le.bs.bjl.eviction_count24;
    attr_eviction_count60            := le.bs.bjl.eviction_count60;
    attr_num_nonderogs               := le.bs.source_verification.num_nonderogs;
    bankrupt                         := le.bs.bjl.bankrupt;
    filing_count                     := le.bs.bjl.filing_count;
    bk_recent_count                  := le.bs.bjl.bk_recent_count;
    liens_recent_unreleased_count    := le.bs.bjl.liens_recent_unreleased_count;
    liens_historical_unreleased_ct   := le.bs.bjl.liens_historical_unreleased_count;
    liens_unrel_ot_ct                := le.bs.liens.liens_unreleased_other_tax.count;
    liens_unrel_ot_last_seen         := le.bs.liens.liens_unreleased_other_tax.most_recent_filing_date;
    liens_unrel_sc_ct                := le.bs.liens.liens_unreleased_small_claims.count;
    liens_unrel_sc_last_seen         := le.bs.liens.liens_unreleased_small_claims.most_recent_filing_date;
    liens_rel_sc_ct                  := le.bs.liens.liens_released_small_claims.count;
    criminal_count                   := le.bs.bjl.criminal_count;
    criminal_last_date               := le.bs.bjl.last_criminal_date;
    felony_count                     := le.bs.bjl.felony_count;
    rel_count                        := le.bs.relatives.relative_count;
    rel_bankrupt_count               := le.bs.relatives.relative_bankrupt_count;
    rel_criminal_count               := le.bs.relatives.relative_criminal_count;
    rel_felony_count                 := le.bs.relatives.relative_felony_count;
    crim_rel_within25miles           := le.bs.relatives.criminal_relative_within25miles;
    rel_prop_owned_count             := le.bs.relatives.owned.relatives_property_count;
    rel_incomeunder50_count          := le.bs.relatives.relative_incomeunder50_count;
    rel_incomeunder75_count          := le.bs.relatives.relative_incomeunder75_count;
    rel_incomeunder100_count         := le.bs.relatives.relative_incomeunder100_count;
    rel_incomeover100_count          := le.bs.relatives.relative_incomeover100_count;
    rel_homeunder100_count           := le.bs.relatives.relative_homeunder100_count;
    rel_homeunder150_count           := le.bs.relatives.relative_homeunder150_count;
    rel_homeunder200_count           := le.bs.relatives.relative_homeunder200_count;
    rel_homeunder300_count           := le.bs.relatives.relative_homeunder300_count;
    rel_homeunder500_count           := le.bs.relatives.relative_homeunder500_count;
    rel_homeover500_count            := le.bs.relatives.relative_homeover500_count;
    rel_educationunder12_count       := le.bs.relatives.relative_educationunder12_count;
    rel_educationover12_count        := le.bs.relatives.relative_educationover12_count;
    rel_ageunder30_count             := le.bs.relatives.relative_ageunder30_count;
    rel_ageunder40_count             := le.bs.relatives.relative_ageunder40_count;
    rel_ageunder50_count             := le.bs.relatives.relative_ageunder50_count;
    rel_ageunder60_count             := le.bs.relatives.relative_ageunder60_count;
    rel_ageunder70_count             := le.bs.relatives.relative_ageunder70_count;
    rel_ageover70_count              := le.bs.relatives.relative_ageover70_count;
    acc_count                        := le.bs.accident_data.acc.num_accidents;
    ams_college_code                 := le.bs.student.college_code;
    ams_college_type                 := le.bs.student.college_type;
    prof_license_category            := le.bs.professional_license.plcategory;
    input_dob_match_level            := le.bs.dobmatchlevel;
    addr_stability                   := le.bs.mobility_indicator;
    estimated_income                 := le.bs.estimated_income;
    archive_date                     := le.bs.historydate;
    C_CHILD                          := trim(ri.child);
    C_LOW_ED                         := trim(ri.low_ed);
    C_NO_LABFOR                      := trim(ri.no_labfor);
    C_SUB_BUS                        := trim(ri.sub_bus);

    NULL := -999999999;


    BOOLEAN indexw(string source, string target, string delim) :=
      (source = target) OR
      (StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
      (source[1..length(target)+1] = target + delim) OR
      (StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

    sysdate_1 := models.common.sas_date(if(le.bs.historydate=999999, (string)ut.getdate, (string6)le.bs.historydate+'01'));
    sysdate   := models.common.sas_date(if(le.bs.historydate=999999, (string)ut.getdate, (string6)le.bs.historydate+'01'));

    r1 := .1371;

    p1 := .0318;

    // log_offset := ln(r1 * (1 - p1) / (1 - r1) * p1);
    log_offset := ln((r1*(1-p1))/((1-r1)*p1));


    nonf_acc_count_lvl := min(if(acc_count = NULL, -NULL, acc_count), 2);

    nonf_acc_count_lvl_m := map(
        nonf_acc_count_lvl = 0 => 0.1359946538,
        nonf_acc_count_lvl = 1 => 0.1500547645,
                                  0.2125603865);

    nonf_attr_arrests_lvl := map(
        attr_arrests12 > 0 => 2,
        attr_arrests > 0   => 1,
                              0);

    nonf_attr_arrests_lvl_m := map(
        nonf_attr_arrests_lvl = 0 => 0.1355902911,
        nonf_attr_arrests_lvl = 1 => 0.3209302326,
                                     0.4833333333);

    addr_stability_m := map(
        (real)addr_stability = 0 => 0.205655527,
        (real)addr_stability = 1 => 0.2132210373,
        (real)addr_stability = 2 => 0.1224865477,
        (real)addr_stability = 3 => 0.1222520107,
        (real)addr_stability = 4 => 0.0970114943,
        (real)addr_stability = 5 => 0.074259614,
                                    0.0469341408);

    fcra_disthphonewphone_lvl := map(
        10 < rc_disthphonewphone AND rc_disthphonewphone <= 25 => 0,
        0 < rc_disthphonewphone AND rc_disthphonewphone <= 10  => 1,
        rc_disthphonewphone <= 50                              => 2,
                                                                  3);

    fcra_disthphonewphone_lvl_m := map(
        fcra_disthphonewphone_lvl = 0 => 0.0778175313,
        fcra_disthphonewphone_lvl = 1 => 0.0964876033,
        fcra_disthphonewphone_lvl = 2 => 0.118707483,
                                         0.1461964854);

    total_source_count_fcrapos := sum((integer)(Models.common.findw_cpp(rc_sources, 'AM' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'AR' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'EB' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'EM' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'VO' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'EQ' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'MW' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'PL' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'SL' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'W' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'WP' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'E1' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'E2' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'E3' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'E4' , ' ,', 'I') > 0));

    total_source_count_fcraneg := sum((integer)(Models.common.findw_cpp(rc_sources, 'AK' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'BA' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'CG' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'CO' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'DA' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'DS' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'FF' , ' ,', 'I') > 0), (integer)(Models.common.findw_cpp(rc_sources, 'L2' , ' ,', 'I') > 0));


    fcra_pos_neg_source_lvl := map(
        total_source_count_fcrapos > 3 and total_source_count_fcraneg = 0 => 8,
        total_source_count_fcrapos = 3 and total_source_count_fcraneg = 0 => 7,
        total_source_count_fcrapos = 2 and total_source_count_fcraneg = 0 => 6,
        total_source_count_fcrapos > 2 and total_source_count_fcraneg = 1 => 5,
        total_source_count_fcrapos > 2                                    => 4,
        total_source_count_fcrapos = 2 and total_source_count_fcraneg = 1 => 3,
        total_source_count_fcrapos = 2                                    => 2,
        total_source_count_fcrapos = 1 and total_source_count_fcraneg = 0 => 1,
                                                                             0);

    fcra_pos_neg_source_lvl_m := map(
        fcra_pos_neg_source_lvl = 0 => 0.2037513792,
        fcra_pos_neg_source_lvl = 1 => 0.1740607308,
        fcra_pos_neg_source_lvl = 2 => 0.1684813754,
        fcra_pos_neg_source_lvl = 3 => 0.1567931891,
        fcra_pos_neg_source_lvl = 4 => 0.1429487179,
        fcra_pos_neg_source_lvl = 5 => 0.1287562189,
        fcra_pos_neg_source_lvl = 6 => 0.1143112121,
        fcra_pos_neg_source_lvl = 7 => 0.0880982634,
                                       0.0793609894);

    fcra_derog_diff := min(if(max(attr_num_nonderogs - attr_total_number_derogs, -1) = NULL, -NULL, max(attr_num_nonderogs - attr_total_number_derogs, -1)), 6);

    fcra_derog_diff_m := map(
        fcra_derog_diff = -1 => 0.2545454545,
        fcra_derog_diff = 0  => 0.2267759563,
        fcra_derog_diff = 1  => 0.225300575,
        fcra_derog_diff = 2  => 0.1855869818,
        fcra_derog_diff = 3  => 0.1570020296,
        fcra_derog_diff = 4  => 0.1252273003,
        fcra_derog_diff = 5  => 0.10505689,
                                0.0865675325);

    wphone_type_unknown := rc_wphonetypeflag = 'U';

    wphone_invalid_number := (real)rc_wphonevalflag = 0;

    wphone_disconnected := rc_wphonedissflag;

    fcra_wphone_bad_phn_lvl := map(
        wphone_disconnected and wphone_invalid_number and wphone_type_unknown => 3,
        wphone_type_unknown and wphone_invalid_number                         => 2,
        wphone_invalid_number                                                 => 1,
                                                                                 0);

    fcra_wphone_bad_phn_lvl_m := map(
        fcra_wphone_bad_phn_lvl = 0 => 0.1356190924,
        fcra_wphone_bad_phn_lvl = 1 => 0.1399132321,
        fcra_wphone_bad_phn_lvl = 2 => 0.2566666667,
                                       0.5777777778);

    fcra_college_lvl := map(
        ams_college_type = 'P'     => 3,
        (real)ams_college_code = 4 => 2,
        (real)ams_college_code > 0 => 1,
                                      0);

    fcra_college_lvl_m := map(
        fcra_college_lvl = 0 => 0.1422606192,
        fcra_college_lvl = 1 => 0.0912124583,
        fcra_college_lvl = 2 => 0.0673974827,
                                0.0552995392);

    fcra_prof_lic_lvl := if(prof_license_category = '', 0, (real)prof_license_category);

    fcra_prof_lic_lvl_m := map(
        fcra_prof_lic_lvl = 0 => 0.1401126945,
        fcra_prof_lic_lvl = 1 => 0.1450939457,
        fcra_prof_lic_lvl = 2 => 0.0921985816,
        fcra_prof_lic_lvl = 3 => 0.0902896082,
        fcra_prof_lic_lvl = 4 => 0.066439523,
                                 0.0557491289);

    _liens_unrel_ot_last_seen := models.common.sas_date((string)(liens_unrel_OT_last_seen));

    mos_ot_unrel_last_seen := if(min(sysdate_1, _liens_unrel_ot_last_seen) = NULL, NULL, truncate((sysdate_1 - _liens_unrel_ot_last_seen) / (365.25 / 12)));

    fcra_ot_unrel_lien_lvl := map(
        0 <= mos_ot_unrel_last_seen AND mos_ot_unrel_last_seen <= 6 => 3,
        liens_unrel_OT_ct > 1                                       => 2,
        liens_unrel_OT_ct > 0                                       => 1,
                                                                       0);

    fcra_ot_unrel_lien_lvl_m := map(
        fcra_ot_unrel_lien_lvl = 0 => 0.1346293899,
        fcra_ot_unrel_lien_lvl = 1 => 0.1735211268,
        fcra_ot_unrel_lien_lvl = 2 => 0.1651376147,
                                      0.2825112108);

    _liens_unrel_sc_last_seen := models.common.sas_date((string)(liens_unrel_SC_last_seen));

    mos_sc_unrel_last_seen := if(min(sysdate_1, _liens_unrel_sc_last_seen) = NULL, NULL, truncate((sysdate_1 - _liens_unrel_sc_last_seen) / (365.25 / 12)));

    fcra_sc_lien_lvl := map(
        0 <= mos_sc_unrel_last_seen AND mos_sc_unrel_last_seen <= 12 => 4,
        12 < mos_sc_unrel_last_seen AND mos_sc_unrel_last_seen <= 36 => 3,
        liens_unrel_SC_ct > 0                                        => 2,
        liens_rel_SC_ct > 0                                          => 1,
                                                                        0);

    fcra_sc_lien_lvl_m := map(
        fcra_sc_lien_lvl = 0 => 0.1334329503,
        fcra_sc_lien_lvl = 1 => 0.144278607,
        fcra_sc_lien_lvl = 2 => 0.1899050475,
        fcra_sc_lien_lvl = 3 => 0.2184684685,
                                0.305785124);

    fcra_addrs_per_ssn_c6_2_1 := min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 2);

    fcra_addrs_per_ssn_c6_2_m_1 := map(
        fcra_addrs_per_ssn_c6_2_1 = 0 => 0.1273409837,
        fcra_addrs_per_ssn_c6_2_1 = 1 => 0.2180946675,
                                         0.2413793103);

    fcra_addrs_per_ssn_c6_2 := min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 2);

    fcra_addrs_per_ssn_c6_2_m := map(
        fcra_addrs_per_ssn_c6_2 = 0 => 0.1273409837,
        fcra_addrs_per_ssn_c6_2 = 1 => 0.2180946675,
                                       0.2413793103);

    fcra_invalid_ssns_per_adl_lvl := map(
        invalid_ssns_per_adl_c6 > 0 => 2,
        invalid_ssns_per_adl > 0    => 1,
                                       0);

    fcra_invalid_ssns_per_adl_lvl_m := map(
        fcra_invalid_ssns_per_adl_lvl = 0 => 0.1362214153,
        fcra_invalid_ssns_per_adl_lvl = 1 => 0.1943521595,
                                             0.5454545455);

    fcra_dob_match_lvl := map(
        dobpop and (real)input_dob_match_level = 0      => 0,
        (input_dob_match_level in ['1', '2', '3', '4']) => 1,
        (input_dob_match_level in ['5', '6', '7'])      => 2,
                                                           3);

    fcra_dob_match_lvl_m := map(
        fcra_dob_match_lvl = 0 => 0.2340695608,
        fcra_dob_match_lvl = 1 => 0.2144821265,
        fcra_dob_match_lvl = 2 => 0.1696615127,
                                  0.1250555704);

    rel_income_100plus := sum(0, if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count));

    rel_income_75plus := sum(0, if(rel_income_100plus = NULL, 0, rel_income_100plus), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count));

    rel_income_50plus := sum(0, if(rel_income_75plus = NULL, 0, rel_income_75plus), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count));

    rel_income_25plus := sum(0, if(rel_income_50plus = NULL, 0, rel_income_50plus), if(rel_incomeunder50_count = NULL, 0, rel_incomeunder50_count));

    rel_home_500plus := sum(0, if(rel_homeover500_count = NULL, 0, rel_homeover500_count));

    rel_home_300plus := sum(0, if(rel_home_500plus = NULL, 0, rel_home_500plus), if(rel_homeunder500_count = NULL, 0, rel_homeunder500_count));

    rel_home_200plus := sum(0, if(rel_home_300plus = NULL, 0, rel_home_300plus), if(rel_homeunder300_count = NULL, 0, rel_homeunder300_count));

    rel_home_150plus := sum(0, if(rel_home_200plus = NULL, 0, rel_home_200plus), if(rel_homeunder200_count = NULL, 0, rel_homeunder200_count));

    rel_home_100plus := sum(0, if(rel_home_150plus = NULL, 0, rel_home_150plus), if(rel_homeunder150_count = NULL, 0, rel_homeunder150_count));

    rel_home_50plus := sum(0, if(rel_home_100plus = NULL, 0, rel_home_100plus), if(rel_homeunder100_count = NULL, 0, rel_homeunder100_count));

    rel_ed_over12 := sum(0, if(rel_educationover12_count = NULL, 0, rel_educationover12_count));

    rel_ed_over8 := sum(0, if(rel_ed_over12 = NULL, 0, rel_ed_over12), if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count));

    rel_age_over70 := sum(0, if(rel_ageover70_count = NULL, 0, rel_ageover70_count));

    rel_age_over60 := sum(0, if(rel_age_over70 = NULL, 0, rel_age_over70), if(rel_ageunder70_count = NULL, 0, rel_ageunder70_count));

    rel_age_over50 := sum(0, if(rel_age_over60 = NULL, 0, rel_age_over60), if(rel_ageunder60_count = NULL, 0, rel_ageunder60_count));

    rel_age_over40 := sum(0, if(rel_age_over50 = NULL, 0, rel_age_over50), if(rel_ageunder50_count = NULL, 0, rel_ageunder50_count));

    rel_age_over30 := sum(0, if(rel_age_over40 = NULL, 0, rel_age_over40), if(rel_ageunder40_count = NULL, 0, rel_ageunder40_count));

    rel_age_over20 := sum(0, if(rel_age_over30 = NULL, 0, rel_age_over30), if(rel_ageunder30_count = NULL, 0, rel_ageunder30_count));

    nonf_rel_bankrupt_ratio_c27 := if(rel_bankrupt_count > 0, round(100 * rel_bankrupt_count / rel_count), -1);

    nonf_rel_criminal_ratio_c28 := if(rel_criminal_count > 0, round(100 * rel_criminal_count / rel_count), -1);

    nonf_rel_felony_ratio_c29 := if(rel_felony_count > 0, round(100 * rel_felony_count / rel_count), -1);

    nonf_crim_rel_25miles_ratio_c30 := if(crim_rel_within25miles > 0, round(100 * crim_rel_within25miles / rel_count), -1);

    nonf_rel_prop_owned_ratio_c31 := if(rel_prop_owned_count > 0, round(100 * rel_prop_owned_count / rel_count), -1);

    nonf_rel_income_100plus_ratio_c33 := if(rel_income_100plus > 0, round(100 * rel_income_100plus / rel_count), -1);

    nonf_rel_income_75plus_ratio_c34 := if(rel_income_75plus > 0, round(75 * rel_income_75plus / rel_count), -1);

    nonf_rel_home_300plus_ratio_c38 := if(rel_home_300plus > 0, round(25 * rel_home_300plus / rel_count), -1);

    nonf_rel_ed_over12_ratio_c43 := if(rel_ed_over12 > 0, round(25 * rel_ed_over12 / rel_count), -1);

    nonf_rel_age_over40_ratio_c48 := if(rel_age_over40 > 0, round(25 * rel_age_over40 / rel_count), -1);

    nonf_rel_ed_over12_ratio := if(rel_count > 0, nonf_rel_ed_over12_ratio_c43, -2);

    nonf_crim_rel_25miles_ratio := if(rel_count > 0, nonf_crim_rel_25miles_ratio_c30, -2);

    nonf_rel_income_100plus_ratio := if(rel_count > 0, nonf_rel_income_100plus_ratio_c33, -2);

    nonf_rel_felony_ratio := if(rel_count > 0, nonf_rel_felony_ratio_c29, -2);

    nonf_rel_age_over40_ratio := if(rel_count > 0, nonf_rel_age_over40_ratio_c48, -2);

    nonf_rel_criminal_ratio := if(rel_count > 0, nonf_rel_criminal_ratio_c28, -2);

    nonf_rel_home_300plus_ratio := if(rel_count > 0, nonf_rel_home_300plus_ratio_c38, -2);

    nonf_rel_bankrupt_ratio := if(rel_count > 0, nonf_rel_bankrupt_ratio_c27, -2);

    nonf_rel_income_75plus_ratio := if(rel_count > 0, nonf_rel_income_75plus_ratio_c34, -2);

    nonf_rel_prop_owned_ratio := if(rel_count > 0, nonf_rel_prop_owned_ratio_c31, -2);

    nonf_rel_bankrupt_ratio_f := if(nonf_rel_bankrupt_ratio = -1, 0, 1);

    nonf_rel_criminal_ratio_f := if(nonf_rel_criminal_ratio = -1, 0, 1);

    nonf_rel_felony_ratio_f := if(nonf_rel_felony_ratio = -1, 0, 1);

    nonf_crim_rel_25miles_ratio_f := if(nonf_crim_rel_25miles_ratio = -1, 0, 1);

    nonf_rel_prop_owned_ratio_c := max(nonf_rel_prop_owned_ratio, (real)0);

    nonf_rel_prop_owned_ratio_lg := ln(nonf_rel_prop_owned_ratio_c + 1);

    nonf_rel_income_100plus_ratio_c := max(nonf_rel_income_100plus_ratio, (real)0);

    nonf_rel_income_100plus_ratio_lg := ln(nonf_rel_income_100plus_ratio_c + 1);

    nonf_rel_income_75plus_ratio_c := max(nonf_rel_income_75plus_ratio, (real)0);

    nonf_rel_income_75plus_ratio_lg := ln(nonf_rel_income_75plus_ratio_c + 1);

    nonf_rel_age_over40_ratio_c := max(nonf_rel_age_over40_ratio, (real)0);

    nonf_rel_age_over40_ratio_lg := ln(nonf_rel_age_over40_ratio_c + 1);

    nonf_rel_prop_owned_ratio_f := nonf_rel_prop_owned_ratio > 40;

    nonf_rel_income_100plus_ratio_f := nonf_rel_income_100plus_ratio > 30;

    nonf_rel_home_300plus_ratio_f := nonf_rel_home_300plus_ratio > 10;

    nonf_rel_ed_over12_ratio_f := nonf_rel_ed_over12_ratio > 25;

    nonf_rel_age_over40_ratio_f := nonf_rel_age_over40_ratio > 20;

    relmod_log := -2.0511 +
        (integer)nonf_rel_prop_owned_ratio_f * -0.5551 +
        (integer)nonf_rel_income_100plus_ratio_f * -0.7795 +
        (integer)nonf_rel_age_over40_ratio_f * -0.3242 +
        nonf_rel_bankrupt_ratio_f * 0.1551 +
        nonf_rel_criminal_ratio_f * 0.1036 +
        nonf_rel_felony_ratio_f * 0.2452 +
        nonf_crim_rel_25miles_ratio_f * 0.1367;

    relmod := round(100 * exp(relmod_log) / (1 + exp(relmod_log))/.1)*.1;

    nonf_util_cell_f := Models.common.findw_cpp(util_adl_type_list, 'I' , ' ,', 'I') > 0;

    nonf_util_adl_count_c := min(if(max(util_adl_count, 0) = NULL, -NULL, max(util_adl_count, 0)), 25);

    nonf_util_adl_count_lg := ln(nonf_util_adl_count_c + 1);

    c_child_2 := if(C_CHILD = '', 23.5329485298427, (real)c_child);

    _c_child := max(min(if(c_child_2 = NULL, -NULL, c_child_2), 41.7), 0);

    _c_child_lg := ln(_c_child + 1);

    c_low_ed_2 := if(C_LOW_ED = '', 38.79237202753, (real)c_low_ed);

    _c_low_ed := max(min(if(c_low_ed_2 = NULL, -NULL, c_low_ed_2), 80.9), 0);

    _c_low_ed_lg := ln(_c_low_ed + 1);

    c_no_labfor_2 := if(C_NO_LABFOR = '', 59.0022061680208, (real)c_no_labfor);

    _c_no_labfor := max(min(if(c_no_labfor_2 = NULL, -NULL, c_no_labfor_2), 192), 0);

    _c_no_labfor_lg := ln(_c_no_labfor + 1);

    c_sub_bus_2 := if(C_SUB_BUS = '', 42.6667137850206, (real)c_sub_bus);

    _c_sub_bus := max(min(if(c_sub_bus_2 = NULL, -NULL, c_sub_bus_2), 192), 0);

    _c_sub_bus_lg := ln(_c_sub_bus + 1);

    contrary_phn := (nap_summary in [1]);

    verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

    verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

    veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

    verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

    contrary_inf := (infutor_nap in [1]);

    verfst_i := (infutor_nap in [2, 3, 4, 8, 9, 10, 12]);

    verlst_i := (infutor_nap in [2, 5, 7, 8, 9, 11, 12]);

    veradd_i := (infutor_nap in [3, 5, 6, 8, 10, 11, 12]);

    verphn_i := (infutor_nap in [4, 6, 7, 9, 10, 11, 12]);

    contrary_ssn := (nas_summary in [1]);

    verfst_s := (nas_summary in [2, 3, 4, 8, 9, 10, 12]);

    verlst_s := (nas_summary in [2, 5, 7, 8, 9, 11, 12]);

    veradd_s := (nas_summary in [3, 5, 6, 8, 10, 11, 12]);

    verssn_s := (nas_summary in [4, 6, 7, 9, 10, 11, 12]);

    nas_479 := (nas_summary in [4, 7, 9]);

    phn_dcd := nap_status = 'D';

    vermod_log := -0.9790 +
        (integer)add1_isbestmatch * -0.1334 +
        (integer)verlst_p * -0.0210 +
        (integer)verphn_p * -0.2579 +
        (integer)verlst_p * (integer)verphn_p * -0.6695 +
        (integer)contrary_inf * 0.00500 +
        (integer)verphn_p * (integer)contrary_inf * 0.8061 +
        (integer)verlst_i * -0.4714 +
        (integer)verphn_p * (integer)verlst_i * 0.9911 +
        (integer)veradd_i * 0.1293 +
        (integer)verphn_p * (integer)veradd_i * 0.3170 +
        (integer)verlst_i * (integer)veradd_i * -0.4316 +
        (integer)veradd_s * -0.6221 +
        (integer)verlst_i * (integer)veradd_s * 0.2806;

    vermod := round(100 * exp(vermod_log) / (1 + exp(vermod_log))/.1)*.1;

    _gong_did_first_seen := models.common.sas_date((string)(gong_did_first_seen));

    _gong_did_last_seen := models.common.sas_date((string)(gong_did_last_seen));

    mos_since_gong_first_seen := if(min(sysdate, _gong_did_first_seen) = NULL, NULL, truncate((sysdate - _gong_did_first_seen) / (365.25 / 12)));

    mos_since_gong_last_seen := if(min(sysdate, _gong_did_last_seen) = NULL, NULL, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)));

    phn_last_seen_rec := mos_since_gong_last_seen = 0;

    phn_first_seen_rec := 0 <= mos_since_gong_first_seen AND mos_since_gong_first_seen <= 6;

    phn_pots := (telcordia_type in ['00', '50', '51', '52', '54']);

    phn_disconnected := (real)rc_hriskphoneflag = 5;

    phn_inval := (real)rc_phonevalflag = 0 or (real)rc_hphonevalflag = 0 or (rc_phonetype in ['5']);

    phn_nonus := (rc_phonetype in ['3', '4']);

    phn_highrisk := (real)rc_hriskphoneflag = 6 or rc_hphonetypeflag = '5' or (real)rc_hphonevalflag = 3 or (real)rc_addrcommflag = 1;

    phn_notpots := not((telcordia_type in ['00', '50', '51', '52', '54']));

    phn_cellpager := (rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']);

    phn_business := (real)rc_hphonevalflag = 1;

    phn_residential := (real)rc_hphonevalflag = 2;

    phn_good_counts := (gong_did_first_ct in [1, 2]) and gong_did_last_ct = 1;

    phonemod_log := -1.8325 +
        (integer)phn_last_seen_rec * -0.3815 +
        (integer)phn_first_seen_rec * 0.7866 +
        (integer)phn_disconnected * 0.3015 +
        (integer)phn_notpots * 0.3912 +
        (integer)phn_good_counts * -0.0973;

    phonemod := round(100 * exp(phonemod_log) / (1 + exp(phonemod_log))/.1)*.1;

    ssn_priordob := (real)rc_ssndobflag = 1 or (real)rc_pwssndobflag = 1;

    ssn_inval := (real)rc_ssnvalflag = 1 or (rc_pwssnvalflag in ['1', '2', '3']);

    ssn_deceased_1 := (real)rc_decsflag = 1;

    ssn_issued18 := (real)rc_pwssnvalflag = 5;

    ssn_statediff := StringLib.StringToUpperCase(trim(rc_ssnstate, LEFT, RIGHT)) != StringLib.StringToUpperCase(trim(in_state, LEFT, RIGHT));

    ssn_adl_prob := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2;

    ssn_prob := ssn_deceased_1 or ssn_priordob or ssn_inval;

    ssnprob_log := -1.9039 +
        (integer)ssn_issued18 * 0.2258 +
        (integer)ssn_statediff * -0.0710 +
        (integer)ssn_adl_prob * 0.4773 +
        (integer)ssn_prob * 0.7366;

    ssnprobmod := round(100 * exp(ssnprob_log) / (1 + exp(ssnprob_log))/.1)*.1;

    fcra_estimated_income_c := min(if(max(estimated_income, 20000) = NULL, -NULL, max(estimated_income, 20000)), 100000);

    fcra_estimated_income_lg := ln(fcra_estimated_income_c);

    _criminal_last_date := models.common.sas_date((string)(criminal_last_date));

    mos_criminal_last_seen := if(min(sysdate, _criminal_last_date) = NULL, NULL, truncate((sysdate - _criminal_last_date) / (365.25 / 12)));

    fcra_criminal_lvl := map(
        0 <= mos_criminal_last_seen AND mos_criminal_last_seen <= 6 => 3,
        criminal_count > 2                                          => 3,
        (integer)addrs_prison_history > 0                           => 2,
        criminal_count > 1 or felony_count > 0                      => 2,
        criminal_count > 0 or impulse_count > 0                     => 1,
                                                                       0);

    fcra_criminal_lvl_m := map(
        fcra_criminal_lvl = 0 => 0.1257525244,
        fcra_criminal_lvl = 1 => 0.1525530574,
        fcra_criminal_lvl = 2 => 0.1861377507,
                                 0.2160982265);

    fcra_eviction_lvl := map(
        attr_eviction_count24 > 0 or attr_eviction_count60 > 2 => 3,
        attr_eviction_count60 > 0                              => 2,
        attr_eviction_count > 0                                => 1,
                                                                  0);

    fcra_eviction_lvl_m := map(
        fcra_eviction_lvl = 0 => 0.1317482128,
        fcra_eviction_lvl = 1 => 0.2119377163,
        fcra_eviction_lvl = 2 => 0.2683397683,
                                 0.3615384615);

    fcra_ssns_per_addr_lvl := map(
        0 < ssns_per_addr AND ssns_per_addr <= 10 and ssns_per_addr_c6 = 0  => 5,
        0 < ssns_per_addr AND ssns_per_addr <= 10 and ssns_per_addr_c6 = 1  => 4,
        10 < ssns_per_addr AND ssns_per_addr <= 20 and ssns_per_addr_c6 = 0 => 4,
        0 < ssns_per_addr AND ssns_per_addr <= 10 and ssns_per_addr_c6 = 2  => 3,
        20 < ssns_per_addr AND ssns_per_addr <= 40 and ssns_per_addr_c6 = 0 => 3,
        0 <= ssns_per_addr AND ssns_per_addr <= 10                          => 2,
        10 < ssns_per_addr AND ssns_per_addr <= 20 and ssns_per_addr_c6 < 3 => 2,
        20 < ssns_per_addr AND ssns_per_addr <= 30 and ssns_per_addr_c6 = 1 => 2,
        10 < ssns_per_addr AND ssns_per_addr <= 20 and ssns_per_addr_c6 < 5 => 1,
        20 < ssns_per_addr AND ssns_per_addr <= 30 and ssns_per_addr_c6 = 2 => 1,
        30 < ssns_per_addr AND ssns_per_addr <= 40 and ssns_per_addr_c6 < 3 => 1,
        40 < ssns_per_addr and ssns_per_addr_c6 < 2                         => 1,
                                                                               0);

    fcra_ssns_per_addr_lvl_m := map(
        fcra_ssns_per_addr_lvl = 0 => 0.2883379247,
        fcra_ssns_per_addr_lvl = 1 => 0.2015655577,
        fcra_ssns_per_addr_lvl = 2 => 0.1773463632,
        fcra_ssns_per_addr_lvl = 3 => 0.1435288849,
        fcra_ssns_per_addr_lvl = 4 => 0.1226531114,
                                      0.0900516106);

    core_adl := (adl_category)[1..1] = '8';

    single_did := did_count = 1;

    fcra_adl_lvl := map(
        core_adl and single_did => 0,
        not(single_did)         => 1,
                                   2);

    fcra_adl_lvl_m := map(
        fcra_adl_lvl = 0 => 0.1328378009,
        fcra_adl_lvl = 1 => 0.2023217247,
                            0.4672727273);

    nonfcra_log := -12.75380735 +
        nonf_acc_count_lvl_m * 6.8712467889 +
        nonf_attr_arrests_lvl_m * 2.7514121523 +
        addr_stability_m * 4.3829544228 +
        fcra_disthphonewphone_lvl_m * 3.0422197366 +
        fcra_pos_neg_source_lvl_m * 1.8740894722 +
        fcra_derog_diff_m * 2.1289712775 +
        fcra_criminal_lvl_m * 2.7580581582 +
        fcra_eviction_lvl_m * 2.3515552848 +
        fcra_wphone_bad_phn_lvl_m * 4.7501597229 +
        fcra_college_lvl_m * 7.1219418846 +
        fcra_prof_lic_lvl_m * 4.4114219092 +
        fcra_ot_unrel_lien_lvl_m * 3.3272982985 +
        fcra_sc_lien_lvl_m * 2.6840735494 +
        fcra_ssns_per_addr_lvl_m * 2.7658276198 +
        fcra_addrs_per_ssn_c6_2_m * 2.668789995 +
        fcra_invalid_ssns_per_adl_lvl_m * 3.338247875 +
        fcra_dob_match_lvl_m * 2.4129541117 +
        fcra_adl_lvl_m * 4.7577979907 +
        relmod * 0.0350469015 +
        nonf_rel_age_over40_ratio_c * -0.011765365 +
        (integer)nonf_util_cell_f * 0 +
        nonf_util_adl_count_lg * 0 +
        _c_child * 0.0119612997 +
        _c_low_ed * 0.0087848085 +
        _c_no_labfor * 0.0015557599 +
        _c_sub_bus_lg * -0.078911547 +
        vermod * 0.0330633024 +
        phonemod * 0.0226027403 +
        ssnprobmod * 0.0202211748 +
        fcra_estimated_income_lg * -0.176918966 +
        log_offset;

    base := 700;
    point := -40;
    odds := .13 / .87;
    phat := exp(nonfcra_log) / (1 + exp(nonfcra_log));

    scaled_score := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

    source_tot_ds := (integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'DS', ',') > 0;

    source_tot_ba := (integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'BA', ',') > 0;

    bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

    lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

    lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

    source_tot_l2 := (integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'L2', ',') > 0;

    source_tot_li := (integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'LI', ',') > 0;

    lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

    ssn_deceased := (integer1)rc_decsflag = 1 or (integer)source_tot_ds = 1;

    scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or (integer1)input_dob_match_level >= 7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid;

    FP31203_1_0 := map(
        (integer1)rc_ssnvalflag = 3                                                                                    => 201,
        (integer1)rc_decsflag = 1 or (integer1)rc_ssndobflag = 1 or 1 <= (integer1)rc_ssnvalflag AND (integer1)rc_ssnvalflag <= 2  => 200,
        TRIM(StringLib.StringToUpperCase(inputfluxgrade)) not in ['C1', 'B3', 'B1', 'A2', 'A1', 'A0']                    => 203,
        nas_summary <= 4 and nap_summary <= 4 and add1_naprop <= 2 and not(scored_222s)                            => 222,
        max(501, min(900, if(scaled_score = NULL, -NULL, scaled_score))));
				
/* ********************
* UTILITY CORRECTION *
******************** */

     util_adl_2  := (integer)( Models.common.findw_cpp(util_adl_type_list, '2' , ' ,', 'I') > 0 );
     util_adl_Z  := (integer)( Models.common.findw_cpp(util_adl_type_list, 'Z' , ' ,', 'I') > 0 );
     		 
		 util_add1_1  := (integer)( Models.common.findw_cpp(util_add1_type_list, '1' , ' ,', 'I') > 0 );
		 util_add1_Z  := (integer)( Models.common.findw_cpp(util_add1_type_list, 'Z' , ' ,', 'I') > 0 );
		 
		 util_add2_1  := (integer)( Models.common.findw_cpp(util_add2_type_list, '1' , ' ,', 'I') > 0 );
		 util_add2_Z  := (integer)( Models.common.findw_cpp(util_add2_type_list, 'Z' , ' ,', 'I') > 0 );
     
		mk_min_date( string type_list, string FS_list, string picker ) := FUNCTION
			z := models.common.zip2( type_list, fs_list )( (StringLib.StringFind(str1, picker, 1) > 0) );
			as_sas := project( z, transform( {integer8 dt}, self.dt := models.common.sas_date( left.str2 )));
			good_dates := as_sas( dt != models.common.NULL );
			months_since := (sysdate-min(good_dates,dt))/(365.25/12);
			// this function only used within this model for getting months, so do the sysdate diff and division here
			return if( exists(good_dates), months_since, 0 );
		end;		 
		 
     mos_util_adl_2_fseen := mk_min_date(util_add1_type_list, util_adl_first_seen_list, '2'); 
     
     mos_util_adl_Z_fseen := mk_min_date(util_add1_type_list, util_adl_first_seen_list, 'Z');

     ADJUSTED_SCORE       :=  -58.72808 +
					FP31203_1_0          *    1.07840 +
					util_adl_2           *  -21.52561 +
					util_adl_Z           *    3.59667 +
					util_add1_1          *   -2.19398 +
					util_add1_Z          *    4.10021 +
					util_add2_1          *   -2.72122 +
					util_add2_Z          *    1.15914 +
					mos_util_adl_2_fseen *    0.00533 +
					mos_util_adl_Z_fseen *   -0.06308 ;

		 
		 FP31203_1_1 := if(FP31203_1_0 IN [200, 201, 203, 222], FP31203_1_0, 
												max(501,min(900,round(ADJUSTED_SCORE)))
											);
		 
		 
		 

    #if(FP_DEBUG)
      self.clam := le;
      self.inputfluxgrade                     := inputfluxgrade;
      self.truedid                            := truedid;
      self.adl_category                       := adl_category;
      self.in_state                           := in_state;
      self.nas_summary                        := nas_summary;
      self.nap_summary                        := nap_summary;
      self.nap_status                         := nap_status;
      self.did_count                          := did_count;
      self.rc_hriskphoneflag                  := rc_hriskphoneflag;
      self.rc_hphonetypeflag                  := rc_hphonetypeflag;
      self.rc_wphonetypeflag                  := rc_wphonetypeflag;
      self.rc_phonevalflag                    := rc_phonevalflag;
      self.rc_hphonevalflag                   := rc_hphonevalflag;
      self.rc_wphonevalflag                   := rc_wphonevalflag;
      self.rc_wphonedissflag                  := rc_wphonedissflag;
      self.rc_decsflag                        := rc_decsflag;
      self.rc_ssndobflag                      := rc_ssndobflag;
      self.rc_pwssndobflag                    := rc_pwssndobflag;
      self.rc_ssnvalflag                      := rc_ssnvalflag;
      self.rc_pwssnvalflag                    := rc_pwssnvalflag;
      self.rc_ssnstate                        := rc_ssnstate;
      self.rc_bansflag                        := rc_bansflag;
      self.rc_sources                         := rc_sources;
      self.rc_addrcommflag                    := rc_addrcommflag;
      self.rc_disthphonewphone                := rc_disthphonewphone;
      self.rc_phonetype                       := rc_phonetype;
      self.combo_dobscore                     := combo_dobscore;
      self.dobpop                             := dobpop;
      self.util_adl_type_list                 := util_adl_type_list;
      self.util_adl_count                     := util_adl_count;
      self.add1_isbestmatch                   := add1_isbestmatch;
      self.add1_naprop                        := add1_naprop;
      self.property_owned_total               := property_owned_total;
      self.property_sold_total                := property_sold_total;
      self.addrs_prison_history               := addrs_prison_history;
      self.telcordia_type                     := telcordia_type;
      self.gong_did_first_seen                := gong_did_first_seen;
      self.gong_did_last_seen                 := gong_did_last_seen;
      self.gong_did_first_ct                  := gong_did_first_ct;
      self.gong_did_last_ct                   := gong_did_last_ct;
      self.ssns_per_adl                       := ssns_per_adl;
      self.ssns_per_addr                      := ssns_per_addr;
      self.ssns_per_adl_c6                    := ssns_per_adl_c6;
      self.addrs_per_ssn_c6                   := addrs_per_ssn_c6;
      self.ssns_per_addr_c6                   := ssns_per_addr_c6;
      self.invalid_ssns_per_adl               := invalid_ssns_per_adl;
      self.invalid_ssns_per_adl_c6            := invalid_ssns_per_adl_c6;
      self.infutor_nap                        := infutor_nap;
      self.impulse_count                      := impulse_count;
      self.attr_total_number_derogs           := attr_total_number_derogs;
      self.attr_arrests                       := attr_arrests;
      self.attr_arrests12                     := attr_arrests12;
      self.attr_eviction_count                := attr_eviction_count;
      self.attr_eviction_count24              := attr_eviction_count24;
      self.attr_eviction_count60              := attr_eviction_count60;
      self.attr_num_nonderogs                 := attr_num_nonderogs;
      self.bankrupt                           := bankrupt;
      self.filing_count                       := filing_count;
      self.bk_recent_count                    := bk_recent_count;
      self.liens_recent_unreleased_count      := liens_recent_unreleased_count;
      self.liens_historical_unreleased_ct     := liens_historical_unreleased_ct;
      self.liens_unrel_ot_ct                  := liens_unrel_ot_ct;
      self.liens_unrel_ot_last_seen           := liens_unrel_ot_last_seen;
      self.liens_unrel_sc_ct                  := liens_unrel_sc_ct;
      self.liens_unrel_sc_last_seen           := liens_unrel_sc_last_seen;
      self.liens_rel_sc_ct                    := liens_rel_sc_ct;
      self.criminal_count                     := criminal_count;
      self.criminal_last_date                 := criminal_last_date;
      self.felony_count                       := felony_count;
      self.rel_count                          := rel_count;
      self.rel_bankrupt_count                 := rel_bankrupt_count;
      self.rel_criminal_count                 := rel_criminal_count;
      self.rel_felony_count                   := rel_felony_count;
      self.crim_rel_within25miles             := crim_rel_within25miles;
      self.rel_prop_owned_count               := rel_prop_owned_count;
      self.rel_incomeunder50_count            := rel_incomeunder50_count;
      self.rel_incomeunder75_count            := rel_incomeunder75_count;
      self.rel_incomeunder100_count           := rel_incomeunder100_count;
      self.rel_incomeover100_count            := rel_incomeover100_count;
      self.rel_homeunder100_count             := rel_homeunder100_count;
      self.rel_homeunder150_count             := rel_homeunder150_count;
      self.rel_homeunder200_count             := rel_homeunder200_count;
      self.rel_homeunder300_count             := rel_homeunder300_count;
      self.rel_homeunder500_count             := rel_homeunder500_count;
      self.rel_homeover500_count              := rel_homeover500_count;
      self.rel_educationunder12_count         := rel_educationunder12_count;
      self.rel_educationover12_count          := rel_educationover12_count;
      self.rel_ageunder30_count               := rel_ageunder30_count;
      self.rel_ageunder40_count               := rel_ageunder40_count;
      self.rel_ageunder50_count               := rel_ageunder50_count;
      self.rel_ageunder60_count               := rel_ageunder60_count;
      self.rel_ageunder70_count               := rel_ageunder70_count;
      self.rel_ageover70_count                := rel_ageover70_count;
      self.acc_count                          := acc_count;
      self.ams_college_code                   := ams_college_code;
      self.ams_college_type                   := ams_college_type;
      self.prof_license_category              := prof_license_category;
      self.input_dob_match_level              := input_dob_match_level;
      self.addr_stability                     := addr_stability;
      self.estimated_income                   := estimated_income;
      self.archive_date                       := archive_date;
      self.C_CHILD                            := C_CHILD;
      self.C_LOW_ED                           := C_LOW_ED;
      self.C_NO_LABFOR                        := C_NO_LABFOR;
      self.C_SUB_BUS                          := C_SUB_BUS;
      self.sysdate_1                          := sysdate_1;
      self.sysdate                            := sysdate;
      self.r1                                 := r1;
      self.p1                                 := p1;
      self.log_offset                         := log_offset;
      self.nonf_acc_count_lvl                 := nonf_acc_count_lvl;
      self.nonf_acc_count_lvl_m               := nonf_acc_count_lvl_m;
      self.nonf_attr_arrests_lvl              := nonf_attr_arrests_lvl;
      self.nonf_attr_arrests_lvl_m            := nonf_attr_arrests_lvl_m;
      self.addr_stability_m                   := addr_stability_m;
      self.fcra_disthphonewphone_lvl          := fcra_disthphonewphone_lvl;
      self.fcra_disthphonewphone_lvl_m        := fcra_disthphonewphone_lvl_m;
      self.total_source_count_fcrapos         := total_source_count_fcrapos;
      self.total_source_count_fcraneg         := total_source_count_fcraneg;
      self.fcra_pos_neg_source_lvl            := fcra_pos_neg_source_lvl;
      self.fcra_pos_neg_source_lvl_m          := fcra_pos_neg_source_lvl_m;
      self.fcra_derog_diff                    := fcra_derog_diff;
      self.fcra_derog_diff_m                  := fcra_derog_diff_m;
      self.wphone_type_unknown                := wphone_type_unknown;
      self.wphone_invalid_number              := wphone_invalid_number;
      self.wphone_disconnected                := wphone_disconnected;
      self.fcra_wphone_bad_phn_lvl            := fcra_wphone_bad_phn_lvl;
      self.fcra_wphone_bad_phn_lvl_m          := fcra_wphone_bad_phn_lvl_m;
      self.fcra_college_lvl                   := fcra_college_lvl;
      self.fcra_college_lvl_m                 := fcra_college_lvl_m;
      self.fcra_prof_lic_lvl                  := fcra_prof_lic_lvl;
      self.fcra_prof_lic_lvl_m                := fcra_prof_lic_lvl_m;
      self._liens_unrel_ot_last_seen          := _liens_unrel_ot_last_seen;
      self.mos_ot_unrel_last_seen             := mos_ot_unrel_last_seen;
      self.fcra_ot_unrel_lien_lvl             := fcra_ot_unrel_lien_lvl;
      self.fcra_ot_unrel_lien_lvl_m           := fcra_ot_unrel_lien_lvl_m;
      self._liens_unrel_sc_last_seen          := _liens_unrel_sc_last_seen;
      self.mos_sc_unrel_last_seen             := mos_sc_unrel_last_seen;
      self.fcra_sc_lien_lvl                   := fcra_sc_lien_lvl;
      self.fcra_sc_lien_lvl_m                 := fcra_sc_lien_lvl_m;
      self.fcra_addrs_per_ssn_c6_2_1          := fcra_addrs_per_ssn_c6_2_1;
      self.fcra_addrs_per_ssn_c6_2_m_1        := fcra_addrs_per_ssn_c6_2_m_1;
      self.fcra_addrs_per_ssn_c6_2            := fcra_addrs_per_ssn_c6_2;
      self.fcra_addrs_per_ssn_c6_2_m          := fcra_addrs_per_ssn_c6_2_m;
      self.fcra_invalid_ssns_per_adl_lvl      := fcra_invalid_ssns_per_adl_lvl;
      self.fcra_invalid_ssns_per_adl_lvl_m    := fcra_invalid_ssns_per_adl_lvl_m;
      self.fcra_dob_match_lvl                 := fcra_dob_match_lvl;
      self.fcra_dob_match_lvl_m               := fcra_dob_match_lvl_m;
      self.rel_income_100plus                 := rel_income_100plus;
      self.rel_income_75plus                  := rel_income_75plus;
      self.rel_income_50plus                  := rel_income_50plus;
      self.rel_income_25plus                  := rel_income_25plus;
      self.rel_home_500plus                   := rel_home_500plus;
      self.rel_home_300plus                   := rel_home_300plus;
      self.rel_home_200plus                   := rel_home_200plus;
      self.rel_home_150plus                   := rel_home_150plus;
      self.rel_home_100plus                   := rel_home_100plus;
      self.rel_home_50plus                    := rel_home_50plus;
      self.rel_ed_over12                      := rel_ed_over12;
      self.rel_ed_over8                       := rel_ed_over8;
      self.rel_age_over70                     := rel_age_over70;
      self.rel_age_over60                     := rel_age_over60;
      self.rel_age_over50                     := rel_age_over50;
      self.rel_age_over40                     := rel_age_over40;
      self.rel_age_over30                     := rel_age_over30;
      self.rel_age_over20                     := rel_age_over20;
      self.nonf_rel_bankrupt_ratio_c27        := nonf_rel_bankrupt_ratio_c27;
      self.nonf_rel_criminal_ratio_c28        := nonf_rel_criminal_ratio_c28;
      self.nonf_rel_felony_ratio_c29          := nonf_rel_felony_ratio_c29;
      self.nonf_crim_rel_25miles_ratio_c30    := nonf_crim_rel_25miles_ratio_c30;
      self.nonf_rel_prop_owned_ratio_c31      := nonf_rel_prop_owned_ratio_c31;
      self.nonf_rel_income_100plus_ratio_c33  := nonf_rel_income_100plus_ratio_c33;
      self.nonf_rel_income_75plus_ratio_c34   := nonf_rel_income_75plus_ratio_c34;
      self.nonf_rel_home_300plus_ratio_c38    := nonf_rel_home_300plus_ratio_c38;
      self.nonf_rel_ed_over12_ratio_c43       := nonf_rel_ed_over12_ratio_c43;
      self.nonf_rel_age_over40_ratio_c48      := nonf_rel_age_over40_ratio_c48;
      self.nonf_rel_ed_over12_ratio           := nonf_rel_ed_over12_ratio;
      self.nonf_crim_rel_25miles_ratio        := nonf_crim_rel_25miles_ratio;
      self.nonf_rel_income_100plus_ratio      := nonf_rel_income_100plus_ratio;
      self.nonf_rel_felony_ratio              := nonf_rel_felony_ratio;
      self.nonf_rel_age_over40_ratio          := nonf_rel_age_over40_ratio;
      self.nonf_rel_criminal_ratio            := nonf_rel_criminal_ratio;
      self.nonf_rel_home_300plus_ratio        := nonf_rel_home_300plus_ratio;
      self.nonf_rel_bankrupt_ratio            := nonf_rel_bankrupt_ratio;
      self.nonf_rel_income_75plus_ratio       := nonf_rel_income_75plus_ratio;
      self.nonf_rel_prop_owned_ratio          := nonf_rel_prop_owned_ratio;
      self.nonf_rel_bankrupt_ratio_f          := nonf_rel_bankrupt_ratio_f;
      self.nonf_rel_criminal_ratio_f          := nonf_rel_criminal_ratio_f;
      self.nonf_rel_felony_ratio_f            := nonf_rel_felony_ratio_f;
      self.nonf_crim_rel_25miles_ratio_f      := nonf_crim_rel_25miles_ratio_f;
      self.nonf_rel_prop_owned_ratio_c        := nonf_rel_prop_owned_ratio_c;
      self.nonf_rel_prop_owned_ratio_lg       := nonf_rel_prop_owned_ratio_lg;
      self.nonf_rel_income_100plus_ratio_c    := nonf_rel_income_100plus_ratio_c;
      self.nonf_rel_income_100plus_ratio_lg   := nonf_rel_income_100plus_ratio_lg;
      self.nonf_rel_income_75plus_ratio_c     := nonf_rel_income_75plus_ratio_c;
      self.nonf_rel_income_75plus_ratio_lg    := nonf_rel_income_75plus_ratio_lg;
      self.nonf_rel_age_over40_ratio_c        := nonf_rel_age_over40_ratio_c;
      self.nonf_rel_age_over40_ratio_lg       := nonf_rel_age_over40_ratio_lg;
      self.nonf_rel_prop_owned_ratio_f        := nonf_rel_prop_owned_ratio_f;
      self.nonf_rel_income_100plus_ratio_f    := nonf_rel_income_100plus_ratio_f;
      self.nonf_rel_home_300plus_ratio_f      := nonf_rel_home_300plus_ratio_f;
      self.nonf_rel_ed_over12_ratio_f         := nonf_rel_ed_over12_ratio_f;
      self.nonf_rel_age_over40_ratio_f        := nonf_rel_age_over40_ratio_f;
      self.relmod_log                         := relmod_log;
      self.relmod                             := relmod;
      self.nonf_util_cell_f                   := nonf_util_cell_f;
      self.nonf_util_adl_count_c              := nonf_util_adl_count_c;
      self.nonf_util_adl_count_lg             := nonf_util_adl_count_lg;
      self.c_child_2                          := c_child_2;
      self._c_child                           := _c_child;
      self._c_child_lg                        := _c_child_lg;
      self.c_low_ed_2                         := c_low_ed_2;
      self._c_low_ed                          := _c_low_ed;
      self._c_low_ed_lg                       := _c_low_ed_lg;
      self.c_no_labfor_2                      := c_no_labfor_2;
      self._c_no_labfor                       := _c_no_labfor;
      self._c_no_labfor_lg                    := _c_no_labfor_lg;
      self.c_sub_bus_2                        := c_sub_bus_2;
      self._c_sub_bus                         := _c_sub_bus;
      self._c_sub_bus_lg                      := _c_sub_bus_lg;
      self.contrary_phn                       := contrary_phn;
      self.verfst_p                           := verfst_p;
      self.verlst_p                           := verlst_p;
      self.veradd_p                           := veradd_p;
      self.verphn_p                           := verphn_p;
      self.contrary_inf                       := contrary_inf;
      self.verfst_i                           := verfst_i;
      self.verlst_i                           := verlst_i;
      self.veradd_i                           := veradd_i;
      self.verphn_i                           := verphn_i;
      self.contrary_ssn                       := contrary_ssn;
      self.verfst_s                           := verfst_s;
      self.verlst_s                           := verlst_s;
      self.veradd_s                           := veradd_s;
      self.verssn_s                           := verssn_s;
      self.nas_479                            := nas_479;
      self.phn_dcd                            := phn_dcd;
      self.vermod_log                         := vermod_log;
      self.vermod                             := vermod;
      self._gong_did_first_seen               := _gong_did_first_seen;
      self._gong_did_last_seen                := _gong_did_last_seen;
      self.mos_since_gong_first_seen          := mos_since_gong_first_seen;
      self.mos_since_gong_last_seen           := mos_since_gong_last_seen;
      self.phn_last_seen_rec                  := phn_last_seen_rec;
      self.phn_first_seen_rec                 := phn_first_seen_rec;
      self.phn_pots                           := phn_pots;
      self.phn_disconnected                   := phn_disconnected;
      self.phn_inval                          := phn_inval;
      self.phn_nonus                          := phn_nonus;
      self.phn_highrisk                       := phn_highrisk;
      self.phn_notpots                        := phn_notpots;
      self.phn_cellpager                      := phn_cellpager;
      self.phn_business                       := phn_business;
      self.phn_residential                    := phn_residential;
      self.phn_good_counts                    := phn_good_counts;
      self.phonemod_log                       := phonemod_log;
      self.phonemod                           := phonemod;
      self.ssn_priordob                       := ssn_priordob;
      self.ssn_inval                          := ssn_inval;
      self.ssn_deceased_1                     := ssn_deceased_1;
      self.ssn_issued18                       := ssn_issued18;
      self.ssn_statediff                      := ssn_statediff;
      self.ssn_adl_prob                       := ssn_adl_prob;
      self.ssn_prob                           := ssn_prob;
      self.ssnprob_log                        := ssnprob_log;
      self.ssnprobmod                         := ssnprobmod;
      self.fcra_estimated_income_c            := fcra_estimated_income_c;
      self.fcra_estimated_income_lg           := fcra_estimated_income_lg;
      self._criminal_last_date                := _criminal_last_date;
      self.mos_criminal_last_seen             := mos_criminal_last_seen;
      self.fcra_criminal_lvl                  := fcra_criminal_lvl;
      self.fcra_criminal_lvl_m                := fcra_criminal_lvl_m;
      self.fcra_eviction_lvl                  := fcra_eviction_lvl;
      self.fcra_eviction_lvl_m                := fcra_eviction_lvl_m;
      self.fcra_ssns_per_addr_lvl             := fcra_ssns_per_addr_lvl;
      self.fcra_ssns_per_addr_lvl_m           := fcra_ssns_per_addr_lvl_m;
      self.core_adl                           := core_adl;
      self.single_did                         := single_did;
      self.fcra_adl_lvl                       := fcra_adl_lvl;
      self.fcra_adl_lvl_m                     := fcra_adl_lvl_m;
      self.nonfcra_log                        := nonfcra_log;
      self.base                               := base;
      self.point                              := point;
      self.odds                               := odds;
      self.phat                               := phat;
      self.scaled_score                       := scaled_score;
      self.source_tot_ds                      := source_tot_ds;
      self.source_tot_ba                      := source_tot_ba;
      self.bk_flag                            := bk_flag;
      self.lien_rec_unrel_flag                := lien_rec_unrel_flag;
      self.lien_hist_unrel_flag               := lien_hist_unrel_flag;
      self.source_tot_l2                      := source_tot_l2;
      self.source_tot_li                      := source_tot_li;
      self.lien_flag                          := lien_flag;
      self.ssn_deceased                       := ssn_deceased;
      self.scored_222s                        := scored_222s;
      self.fp31203_1_0                        := fp31203_1_0;
			self.FP31203_1_1												:= FP31203_1_1;
			self.clam := le.bs;
    #end

    self.seq := le.bs.seq;
    self.score := (string3)FP31203_1_1;

    num_reasons := 6;
    nugen := true;
    criminal := false;
    ritmp := Models.fraudpoint_reasons( le.bs, le.ip, num_reasons, criminal );
    reasons := Models.Common.checkFraudPointRC34(FP31203_1_1, ritmp, num_reasons);
    self.ri := reasons;


  END;
  
	model := join(clam, Easi.Key_Easi_Census,
		left.bs.shell_input.st<>''
			and left.bs.shell_input.county <>''
			and left.bs.shell_input.geo_blk <> ''
			and keyed(right.geolink=left.bs.shell_input.st+left.bs.shell_input.county+left.bs.shell_input.geo_blk),
		doModel(left, right), left outer,
		atmost(RiskWise.max_atmost)
		,keep(1)
	);
	
  return model;
end;