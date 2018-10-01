import risk_indicators, ut, riskwise, riskwisefcra, riskview;


export RVR1104_3_0( grouped dataset( risk_indicators.Layout_Boca_Shell ) clam, boolean isCalifornia, boolean xmlPrescreenOptOut ) := FUNCTION

  RVR_DEBUG := false;

  #if(RVR_DEBUG)
    layout_debug := record
      Risk_Indicators.Layout_Boca_Shell clam;
      Boolean truedid;
      String out_unit_desig;
      String out_sec_range;
      String out_addr_type;
      Integer nas_summary;
      Integer nap_summary;
      String rc_hriskaddrflag;
      String rc_decsflag;
      String rc_dwelltype;
      String rc_bansflag;
      String rc_ziptypeflag;
      String rc_zipclass;
      Integer combo_dobscore;
      qstring100 ver_sources;
      String fname_eda_sourced_type;
      String lname_eda_sourced_type;
      Boolean add1_isbestmatch;
      Integer add1_unit_count;
      String add1_advo_address_vacancy;
      String add1_advo_dnd;
      String add1_advo_drop;
      String add1_advo_res_or_business;
      String add1_advo_mixed_address_usage;
      String add1_avm_land_use;
      Integer add1_avm_automated_valuation;
      Integer add1_avm_automated_valuation_2;
      Integer add1_avm_med_fips;
      Integer add1_naprop;
      Integer add1_purchase_amount;
      Integer add1_mortgage_amount;
      String add1_financing_type;
      String add1_building_area;
      String add1_no_of_rooms;
      Integer property_owned_total;
      Integer property_sold_total;
      Integer property_sold_purchase_count;
      Integer property_sold_assessed_count;
      Integer property_ambig_total;
      String add2_advo_address_vacancy;
      String add2_advo_mixed_address_usage;
      String add2_avm_land_use;
      Integer add2_naprop;
      Integer add3_naprop;
      Integer addrs_5yr;
      Integer addrs_10yr;
      Integer addrs_15yr;
      Integer unique_addr_count;
      Integer addr_lres_12mo_count;
      Integer ssns_per_adl;
      Integer addrs_per_adl;
      Integer ssns_per_adl_c6;
      Integer adls_per_addr_c6;
      Integer ssns_per_addr_c6;
      Integer invalid_addrs_per_adl;
      Integer inq_peradl;
      Integer inq_ssnsperadl;
      Integer inq_addrsperadl;
      Integer inq_lnamesperadl;
      Integer inq_phonesperadl;
      Integer inq_dobsperadl;
      Integer inq_perssn;
      Integer paw_business_count;
      Integer paw_source_count;
      Integer infutor_nap;
      Integer impulse_count;
      Integer attr_total_number_derogs;
      Integer attr_eviction_count;
      Boolean bankrupt;
      String disposition;
      Integer filing_count;
      Integer bk_recent_count;
      Integer liens_recent_unreleased_count;
      Integer liens_historical_unreleased_ct;
      Integer criminal_count;
      Integer watercraft_count;
      String ams_class;
      String ams_college_code;
      String ams_college_type;
      String ams_income_level_code;
      String ams_file_type;
      Boolean prof_license_flag;
      String wealth_index;
      Integer attr_num_aircraft;
      String input_dob_match_level;
      Integer estimated_income;
      Boolean ver_src_ba;
      Boolean bk_flag;
      Boolean ver_src_l2;
      Boolean ver_src_li;
      Boolean lien_rec_unrel_flag;
      Boolean lien_hist_unrel_flag;
      Boolean lien_flag;
      Boolean ver_src_ds;
      Boolean ssn_deceased;
      Integer pk_impulse_count;
      Integer bs_attr_derog_flag;
      Integer bs_attr_eviction_flag;
      Integer bs_attr_derog_flag2;
      String bs_own_rent;
      String _segment;
      Boolean segment_s0;
      Boolean segment_s1;
      Boolean ams_flag;
      Integer s0_derog_lvl_v2;
      Real s0_derog_lvl_v2_m;
      Boolean s0_property_sold_purchase_f;
      Integer s0_prop_ownership_lvl_v2;
      Real s0_prop_ownership_lvl_v2_m;
      Integer s0_add1_advo_usage;
      Real s0_add1_advo_usage_m;
      Integer s0_add2_advo;
      Real s0_add2_advo_m;
      Integer s0_wealth_wc_lvl;
      Real s0_wealth_wc_lvl_m;
      Integer s0_estimated_income;
      Real s0_estimated_income_m;
      Integer s0_life_experience;
      Real s0_life_experience_m;
      Integer s0_addrs_15yr;
      Real s0_addrs_15yr_m;
      Integer s0_nap_lvl;
      Integer s0_verx_lvl;
      Real s0_verx_lvl_m;
      Integer s0_ssns_per_adl_lvl;
      Real s0_ssns_per_adl_lvl_m;
      Integer s0_addrs_per_adl;
      Real s0_addrs_per_adl_m;
      Integer s0_new_roommates;
      Real s0_new_roommates_m;
      Integer s0_inq_velo_lvl;
      Real s0_inq_velo_lvl_m;
      Boolean s1_property_sold_f;
      Boolean add_apt;
      Boolean add_pobox;
      Boolean single_family;
      Integer s1_sfd_rms_lvl;
      Real s1_sfd_rms_lvl_m;
      Integer s1_add1_advo;
      Integer s1_add2_advo;
      Integer s1_advo_lvl;
      Real s1_advo_lvl_m;
      Integer s1_wealth_index;
      Real s1_wealth_index_m;
      Integer pct_lres_gt12mo;
      Integer s1_pct_addr_gt12mo_100;
      Integer s1_addr_count_lvl;
      Real s1_addr_count_lvl_m;
      Integer s1_nap_lvl;
      Integer s1_nap_lvl_v2;
      Real s1_nap_lvl_v2_m;
      Integer s1_eda_sourced_type;
      Real s1_eda_sourced_type_m;
      Boolean s1_nas479;
      Integer s1_life_experience_lvl;
      Real s1_life_experience_lvl_m;
      Boolean multi_inq_per_adl;
      Integer s1_inq_per_adl;
      Real s1_inq_per_adl_m;
      Real s1_ssns_per_adl_lvl;
      Real s1_ssns_per_adl_lvl_m;
      Integer s1_invalid_addrs_per_adl_4;
      Real s1_invalid_addrs_per_adl_4_m;
      Boolean s1_new_roommate;
      Integer s1_mtg_lvl;
      Real s1_mtg_lvl_m;
      Integer s1_avm_increase_2y;
      Integer avm_index_fips;
      Integer s1_avm_index_fips;
      Real s1_avm_index_fips_m;
      Real s0_log;
      Real s1_log;
      Integer base;
      Real odds;
      Integer point;
      Real out_estimate;
      Real phat;
      Integer mod;
      Integer rvr1104_3_1;
      Boolean scored_222s;
      Integer rvr1104_3;
      Boolean _rc07;
      Boolean _rc08;
      Boolean _rc15;
      Boolean _rc11;
      Boolean _rc14;
      Boolean _rc03;
      Boolean _rc06;
      Boolean _rc39;
      Boolean _rc9k;
      Boolean _rc9m;
      Boolean _rc9n;
      Boolean _rc9o;
      Boolean _rc9q;
      Boolean _rc9s;
      Boolean _rc9t;
      Boolean _rc9u;
      Boolean _rc9v;
      Boolean _rc9w;

      Boolean _rc35;
      Boolean _rcEV;
      Boolean _rcMS;
      Boolean _rc9H;
      Boolean _rc98;
      Boolean _rc97;
      Boolean _rc22;
      Boolean _rc25;
      Boolean _rc37;
      Boolean _rcPV;
      Boolean _rc9B;
      Boolean _rc73;
      Boolean _rc9A;
      Boolean _rc02;
      Boolean _rc20;
      Boolean _rc74;
      Boolean _rc9C;
      Boolean _rc9D;
      Boolean _rc23;
      Boolean _rc99;
      Boolean _rc51;
      Boolean _rc48;
      Boolean _rc72;
      Boolean _rc19;
      Boolean _rc9E;
      Boolean _rc24;
      Boolean _rc9I;
      Boolean _rc52;
      Boolean _rc71;
      Boolean _rc26;
      Boolean _rc36;
      Boolean _rc9X;

      Models.Layout_ModelOut;
    end;
    layout_debug doModel(clam le) := TRANSFORM
  #else
    Models.Layout_ModelOut doModel(clam le) := TRANSFORM
  #end


    truedid                          := le.truedid;
    out_unit_desig                   := le.shell_input.unit_desig;
    out_sec_range                    := le.shell_input.sec_range;
    out_addr_type                    := le.shell_input.addr_type;
    nas_summary                      := le.iid.nas_summary;
    nap_summary                      := le.iid.nap_summary;
    rc_hriskaddrflag                 := le.iid.hriskaddrflag;
    rc_decsflag                      := le.iid.decsflag;
    rc_dwelltype                     := le.iid.dwelltype;
    rc_bansflag                      := le.iid.bansflag;
    rc_ziptypeflag                   := le.iid.ziptypeflag;
    rc_zipclass                      := le.iid.zipclass;
    combo_dobscore                   := le.iid.combo_dobscore;
    ver_sources                      := le.header_summary.ver_sources;
    fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
    lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
    add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
    add1_unit_count                  := le.address_verification.input_address_information.unit_count;
    add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
    add1_advo_dnd                    := le.advo_input_addr.dnd_indicator;
    add1_advo_drop                   := le.advo_input_addr.drop_indicator;
    add1_advo_res_or_business        := le.advo_input_addr.residential_or_business_ind;
    add1_advo_mixed_address_usage    := le.advo_input_addr.mixed_address_usage;
    add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
    add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
    add1_avm_automated_valuation_2   := le.avm.input_address_information.avm_automated_valuation2;
    add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
    add1_naprop                      := le.address_verification.input_address_information.naprop;
    add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
    add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
    add1_financing_type              := le.address_verification.input_address_information.type_financing;
    add1_building_area               := (string)le.address_verification.input_address_information.building_area;
    add1_no_of_rooms                 := (string)le.address_verification.input_address_information.no_of_rooms;
    property_owned_total             := le.address_verification.owned.property_total;
    property_sold_total              := le.address_verification.sold.property_total;
    property_sold_purchase_count     := le.address_verification.sold.property_owned_purchase_count;
    property_sold_assessed_count     := le.address_verification.sold.property_owned_assessed_count;
    property_ambig_total             := le.address_verification.ambiguous.property_total;
    add2_advo_address_vacancy        := le.advo_addr_hist1.address_vacancy_indicator;
    add2_advo_mixed_address_usage    := le.advo_addr_hist1.mixed_address_usage;
    add2_avm_land_use                := le.avm.address_history_1.avm_land_use_code;
    add2_naprop                      := le.address_verification.address_history_1.naprop;
    add3_naprop                      := le.address_verification.address_history_2.naprop;
    addrs_5yr                        := le.other_address_info.addrs_last_5years;
    addrs_10yr                       := le.other_address_info.addrs_last_10years;
    addrs_15yr                       := le.other_address_info.addrs_last_15years;
    unique_addr_count                := le.address_history_summary.unique_addr_cnt;
    addr_lres_12mo_count             := le.address_history_summary.lres_12mo_count;
    ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
    addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
    ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
    adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
    ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
    invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
    inq_peradl                       := le.acc_logs.inquiryperadl;
    inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
    inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
    inq_lnamesperadl                 := le.acc_logs.inquirylnamesperadl;
    inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
    inq_dobsperadl                   := le.acc_logs.inquirydobsperadl;
    inq_perssn                       := le.acc_logs.inquiryperssn;
    paw_business_count               := le.employment.business_ct;
    paw_source_count                 := le.employment.source_ct;
    infutor_nap                      := le.infutor_phone.infutor_nap;
    impulse_count                    := le.impulse.count;
    attr_total_number_derogs         := le.total_number_derogs;
    attr_eviction_count              := le.bjl.eviction_count;
    bankrupt                         := le.bjl.bankrupt;
    disposition                      := le.bjl.disposition;
    filing_count                     := le.bjl.filing_count;
    bk_recent_count                  := le.bjl.bk_recent_count;
    liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
    liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
    criminal_count                   := le.bjl.criminal_count;
    watercraft_count                 := le.watercraft.watercraft_count;
    ams_class                        := le.student.class;
    ams_college_code                 := le.student.college_code;
    ams_college_type                 := le.student.college_type;
    ams_income_level_code            := le.student.income_level_code;
    ams_file_type                    := le.student.file_type;
    prof_license_flag                := le.professional_license.professional_license_flag;
    wealth_index                     := le.wealth_indicator;
    input_dob_match_level            := le.dobmatchlevel;
    estimated_income                 := le.estimated_income;
    attr_num_aircraft                := le.aircraft.aircraft_count;

    addrs_prison_history             := le.other_address_info.isprison;
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
    inq_count12                      := le.acc_logs.inquiries.count12;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;

    NULL := -999999999;


    BOOLEAN indexw(string source, string target, string delim) :=
      (source = target) OR
      (StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
      (source[1..length(target)+1] = target + delim) OR
      (StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

    ver_src_ba := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',');

    bk_flag := (rc_bansflag in ['1', '2']) or ver_src_ba or bankrupt or filing_count > 0 or bk_recent_count > 0;

    ver_src_l2 := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',');

    ver_src_li := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',');

    lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

    lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

    lien_flag := ver_src_l2 or ver_src_li or lien_rec_unrel_flag or lien_hist_unrel_flag;

    ver_src_ds := indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',');

    ssn_deceased := rc_decsflag = '1' or ver_src_ds;

    pk_impulse_count := min(2, if(impulse_count = NULL, -NULL, impulse_count));

    bs_attr_derog_flag := if(attr_total_number_derogs > 0, 1, 0);

    bs_attr_eviction_flag := if(attr_eviction_count > 0, 1, 0);

    bs_attr_derog_flag2 := if(bs_attr_derog_flag > 0 or lien_flag or bs_attr_eviction_flag > 0 or pk_impulse_count > 0 or bk_flag or ssn_deceased, 1, 0);

    bs_own_rent := map(
        Add1_NaProp = 4 or Property_Owned_Total > 0                                                  => '1 Owner ',
        trim(trim(Out_Addr_Type, LEFT), LEFT, RIGHT) = 'H' or Add1_NAProp = 1 or Add1_Unit_Count > 3 => '2 Renter',
                                                                                                        '3 Other ');

    _segment := if(bs_attr_derog_flag2 = 1, '0 Derog ', bs_own_rent);

    segment_s0 := _segment != '3 Other ';

    segment_s1 := _segment = '3 Other ';

    ams_flag := ams_class != ' ' or ams_college_code != '' or ams_college_type != ' ' or ams_income_level_code != ' ' or ams_file_type != ' ';

    s0_derog_lvl_v2 := map(
        not((trim(disposition, ALL) in [' ', 'Discharged']))                                                       => 3,
        (liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0) and attr_total_number_derogs = 1 => 2,
                                                                                                                      min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 3));

    s0_derog_lvl_v2_m := map(
        s0_derog_lvl_v2 = 0 => 0.1980838944,
        s0_derog_lvl_v2 = 1 => 0.2581818182,
        s0_derog_lvl_v2 = 2 => 0.3333333333,
        s0_derog_lvl_v2 = 3 => 0.534591195,
                               0.2124897673);

    s0_property_sold_purchase_f := property_sold_purchase_count > 0;

    s0_prop_ownership_lvl_v2 := map(
        add1_naprop = 4 and add1_isbestmatch                                                                                                     => 3,
        add1_naprop = 4 or add2_naprop = 4 or add3_naprop = 4 or property_owned_total > 0 or property_sold_total > 0 or property_ambig_total > 0 => 2,
        add1_isbestmatch                                                                                                                         => 1,
                                                                                                                                                    0);

    s0_prop_ownership_lvl_v2_m := map(
        s0_prop_ownership_lvl_v2 = 0 => 0.2586336336,
        s0_prop_ownership_lvl_v2 = 1 => 0.2472952087,
        s0_prop_ownership_lvl_v2 = 2 => 0.1985559567,
        s0_prop_ownership_lvl_v2 = 3 => 0.1112852665,
                                        0.2124897673);

    s0_add1_advo_usage := map(
        add1_advo_mixed_address_usage = ' '           => -1,
        (add1_advo_mixed_address_usage in ['A', 'C']) => 2,
        add1_advo_mixed_address_usage = 'B'           => 1,
                                                         0);

    s0_add1_advo_usage_m := map(
        s0_add1_advo_usage = -1 => 0.2507692308,
        s0_add1_advo_usage = 0  => 0.2722222222,
        s0_add1_advo_usage = 1  => 0.2118518519,
        s0_add1_advo_usage = 2  => 0.1830104923,
                                   0.2124897673);

    s0_add2_advo := map(
        add2_advo_mixed_address_usage = ' '                                     => -2,
        add2_advo_address_vacancy = 'Y'                                         => -1,
        (add2_advo_mixed_address_usage in ['A', 'C']) and add2_avm_land_use='1' => 2,
        (add2_advo_mixed_address_usage in ['A', 'C'])                           => 1,
                                                                                   0);

    s0_add2_advo_m := map(
        s0_add2_advo = -2 => 0.1839200167,
        s0_add2_advo = -1 => 0.3485714286,
        s0_add2_advo = 0  => 0.2750518314,
        s0_add2_advo = 1  => 0.2321007081,
        s0_add2_advo = 2  => 0.2100350058,
                             0.2124897673);

    s0_wealth_wc_lvl := map(
        wealth_index  > '2' and watercraft_count > 0 => 5,
        wealth_index <= '2' and watercraft_count > 0 => 3,
        (wealth_index in ['5', '6'])               => 5,
                                                      (integer1)wealth_index);

    s0_wealth_wc_lvl_m := map(
        s0_wealth_wc_lvl = 0 => 0.2513542795,
        s0_wealth_wc_lvl = 1 => 0.3280977312,
        s0_wealth_wc_lvl = 2 => 0.2405286344,
        s0_wealth_wc_lvl = 3 => 0.1636256622,
        s0_wealth_wc_lvl = 4 => 0.1111111111,
        s0_wealth_wc_lvl = 5 => 0.0870488323,
                                0.2124897673);

    s0_estimated_income := map(
        estimated_income = 0      => 99,
        estimated_income <= 20000 => 20,
        estimated_income <= 30000 => 30,
        estimated_income <= 40000 => 40,
                                     99);

    s0_estimated_income_m := map(
        s0_estimated_income = 20 => 0.2423046567,
        s0_estimated_income = 30 => 0.2228903588,
        s0_estimated_income = 40 => 0.1939736347,
        s0_estimated_income = 99 => 0.1267806268,
                                    0.2124897673);

    s0_life_experience := map(
        not ams_flag and not(prof_license_flag) and PAW_Source_count > 0 => 4,
        not ams_flag and prof_license_flag                               => 1,
        ams_college_code = '4'                                           => 5,
        ams_college_code = '2'                                           => 3,
        ams_flag                                                         => 2,
                                                                            0);

    s0_life_experience_m := map(
        s0_life_experience = 0 => 0.2200374532,
        s0_life_experience = 1 => 0.2053571429,
        s0_life_experience = 2 => 0.1889400922,
        s0_life_experience = 3 => 0.171875,
        s0_life_experience = 4 => 0.1684782609,
        s0_life_experience = 5 => 0.064516129,
                                  0.2124897673);

    s0_addrs_15yr := map(
        addrs_5yr = 0 and addrs_10yr = 0 and addrs_15yr = 0 => -1,
        (addrs_15yr in [6, 7])                              => 6,
        (addrs_15yr in [8, 9, 10])                          => 10,
        addrs_15yr > 10                                     => 99,
                                                               addrs_15yr);

    s0_addrs_15yr_m := map(
        s0_addrs_15yr = -1 => 0.2062305296,
        s0_addrs_15yr = 1  => 0.1285102332,
        s0_addrs_15yr = 2  => 0.1503759398,
        s0_addrs_15yr = 3  => 0.2123893805,
        s0_addrs_15yr = 4  => 0.2517006803,
        s0_addrs_15yr = 5  => 0.2983539095,
        s0_addrs_15yr = 6  => 0.3373134328,
        s0_addrs_15yr = 10 => 0.376498801,
        s0_addrs_15yr = 99 => 0.4578947368,
                              0.2124897673);

    s0_nap_lvl := map(
        nap_summary = 12 and infutor_nap = 0 => 12,
        nap_summary = 11 and infutor_nap = 0 => 11,
        (nap_summary in [11, 12])            => 8,
        (nap_summary in [1, 3, 4])           => 4,
        infutor_nap != 0                     => 9,
                                                10);

    s0_verx_lvl := map(
        (nas_summary in [4, 7, 9]) and (s0_nap_lvl in [11, 12]) => 11,
        (s0_nap_lvl in [11, 12])                                => 12,
                                                                   s0_nap_lvl);

    s0_verx_lvl_m := map(
        s0_verx_lvl = 4  => 0.3452914798,
        s0_verx_lvl = 8  => 0.3118942731,
        s0_verx_lvl = 9  => 0.2671300894,
        s0_verx_lvl = 10 => 0.2067889192,
        s0_verx_lvl = 11 => 0.1774744027,
        s0_verx_lvl = 12 => 0.1145071029,
                            0.2124897673);

    s0_ssns_per_adl_lvl := map(
        ssns_per_adl > 1 and ssns_per_adl_c6 > 0 => 3,
        ssns_per_adl > 1                         => 2,
        ssns_per_adl = 1 and ssns_per_adl_c6 = 0 => 0,
                                                    1);

    s0_ssns_per_adl_lvl_m := map(
        s0_ssns_per_adl_lvl = 0 => 0.1670862177,
        s0_ssns_per_adl_lvl = 1 => 0.1957126949,
        s0_ssns_per_adl_lvl = 2 => 0.2859042553,
        s0_ssns_per_adl_lvl = 3 => 0.3576287658,
                                   0.2124897673);

    s0_addrs_per_adl := map(
        addrs_per_adl > 8 => 9,
        addrs_per_adl > 4 => 5,
                             addrs_per_adl);

    s0_addrs_per_adl_m := map(
        s0_addrs_per_adl = 0 => 0.1931649331,
        s0_addrs_per_adl = 1 => 0.1363057325,
        s0_addrs_per_adl = 2 => 0.1471618781,
        s0_addrs_per_adl = 3 => 0.1606268364,
        s0_addrs_per_adl = 4 => 0.1751633987,
        s0_addrs_per_adl = 5 => 0.2552570093,
        s0_addrs_per_adl = 9 => 0.3817787419,
                                0.2124897673);

    s0_new_roommates := map(
        ssns_per_addr_c6 > 1 or adls_per_addr_c6 > 1 => 2,
        ssns_per_addr_c6 > 0 or adls_per_addr_c6 > 0 => 1,
                                                        0);

    s0_new_roommates_m := map(
        s0_new_roommates = 0 => 0.1916241422,
        s0_new_roommates = 1 => 0.2386425835,
        s0_new_roommates = 2 => 0.2804995197,
                                0.2124897673);

    s0_inq_velo_lvl := map(
        Inq_PerADL > 0 and Inq_PerSSN > 0 => 1,
        Inq_PerADL > 0 or Inq_PerSSN > 0  => 2,
                                             0);

    s0_inq_velo_lvl_m := map(
        s0_inq_velo_lvl = 0 => 0.1990030172,
        s0_inq_velo_lvl = 1 => 0.3129445235,
        s0_inq_velo_lvl = 2 => 0.3555555556,
                               0.2124897673);

    s1_property_sold_f := property_sold_total > 0 or property_sold_purchase_count > 0 or property_sold_assessed_count > 0;

    add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

    add_pobox := rc_hriskaddrflag = '1' or rc_ziptypeflag = '1' or StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P';

    single_family := (rc_dwelltype = ' ' or add1_avm_land_use = '1') and not(add_apt or add_pobox);

    s1_sfd_rms_lvl := map(
        (integer)add1_building_area = 0 and not(single_family)      => -2,
        (integer)add1_building_area = 0 and single_family           => -1,
        (integer)add1_no_of_rooms > 7 and (integer)add1_building_area > 3000 => 9999,
        (integer)add1_no_of_rooms > 7                               => 3001,
        (integer)add1_building_area <= 1000                         => 1000,
        (integer)add1_building_area <= 1500                         => 1500,
        (integer)add1_building_area <= 2000                         => 2000,
        (integer)add1_building_area <= 3000                         => 3000,
                                                              3001);

    s1_sfd_rms_lvl_m := map(
        s1_sfd_rms_lvl = -2   => 0.1662337662,
        s1_sfd_rms_lvl = -1   => 0.1550619393,
        s1_sfd_rms_lvl = 1000 => 0.2658227848,
        s1_sfd_rms_lvl = 1500 => 0.2083333333,
        s1_sfd_rms_lvl = 2000 => 0.1732673267,
        s1_sfd_rms_lvl = 3000 => 0.126173097,
        s1_sfd_rms_lvl = 3001 => 0.0916289593,
        s1_sfd_rms_lvl = 9999 => 0.0512820513,
                                 0.1584433634);

    s1_add1_advo := map(
        add1_advo_mixed_address_usage = ' '                                                                               => -1,
        add1_advo_res_or_business = 'B' or add1_advo_dnd = 'Y' or add1_advo_address_vacancy = 'Y' or add1_advo_drop = 'Y' => 3,
        (add1_advo_mixed_address_usage in ['A', 'C'])                                                                     => 0,
        add1_advo_mixed_address_usage = 'B'                                                                               => 1,
                                                                                                                             2);

    s1_add2_advo := map(
        add2_advo_mixed_address_usage = ' '           => -1,
        add2_advo_address_vacancy = 'Y'               => 2,
        (add2_advo_mixed_address_usage in ['A', 'C']) => 0,
                                                         1);

    s1_advo_lvl := map(
        s1_add1_advo = -1 and (s1_add2_advo in [-1, 0]) => -1,
        s1_add1_advo = 0 and s1_add2_advo = -1          => 0,
        s1_add1_advo = 1 and s1_add2_advo = -1          => 1,
        s1_add1_advo = 2 and s1_add2_advo = -1          => 2,
        s1_add1_advo = 3 and s1_add2_advo = -1          => 3,
        (s1_add1_advo in [0, 1])                        => 4,
        (s1_add1_advo in [2, 3])                        => 5,
                                                           6);

    s1_advo_lvl_m := map(
        s1_advo_lvl = -1 => 0.1640070922,
        s1_advo_lvl = 0  => 0.1197273115,
        s1_advo_lvl = 1  => 0.1391752577,
        s1_advo_lvl = 2  => 0.1739475774,
        s1_advo_lvl = 3  => 0.1875,
        s1_advo_lvl = 4  => 0.1989910314,
        s1_advo_lvl = 5  => 0.2742537313,
        s1_advo_lvl = 6  => 0.3081395349,
                            0.1584433634);

    s1_wealth_index := if((wealth_index in ['4', '5', '6']), 4, (integer1)wealth_index);

    s1_wealth_index_m := map(
        s1_wealth_index = 0 => 0.1546115576,
        s1_wealth_index = 1 => 0.2785714286,
        s1_wealth_index = 2 => 0.2157434402,
        s1_wealth_index = 3 => 0.1560016729,
        s1_wealth_index = 4 => 0.0917355372,
                               0.1584433634);

    pct_lres_gt12mo := if(unique_addr_count = 0, -1, truncate((unique_addr_count - addr_lres_12mo_count) / unique_addr_count * 100));

    s1_pct_addr_gt12mo_100 := map(
        unique_addr_count = 0 => -9999,
        pct_lres_gt12mo = 100 => 1,
                                 0);

    s1_addr_count_lvl := map(
        unique_addr_count = 0 or unique_addr_count = 1 and s1_pct_addr_gt12mo_100 = 1 => 0,
        unique_addr_count = 2 and s1_pct_addr_gt12mo_100 = 1                          => 1,
        (unique_addr_count in [1, 2])                                                 => 2,
        (unique_addr_count in [3, 4])                                                 => 4,
        (unique_addr_count in [5, 6, 7])                                              => 7,
                                                                                         8);

    s1_addr_count_lvl_m := map(
        s1_addr_count_lvl = 0 => 0.130612888,
        s1_addr_count_lvl = 1 => 0.1629746835,
        s1_addr_count_lvl = 2 => 0.191149635,
        s1_addr_count_lvl = 4 => 0.2372881356,
        s1_addr_count_lvl = 7 => 0.2744186047,
        s1_addr_count_lvl = 8 => 0.4742268041,
                                 0.1584433634);

    s1_nap_lvl := map(
        nap_summary = 12              => 12,
        (nap_summary in [11, 10])     => 11,
        (nap_summary in [4, 6, 7, 9]) => 4,
        (nap_summary in [1, 3])       => -1,
                                         0);

    s1_nap_lvl_v2 := map(
        nap_summary = 12 and infutor_nap = 0              => 12,
        (nap_summary in [11, 10]) and infutor_nap = 0     => 11,
        (nap_summary in [4, 6, 7, 9]) and infutor_nap = 0 => 10,
        s1_nap_lvl = 0 and infutor_nap > 0                => 9,
        nap_summary = 12                                  => 8,
        s1_nap_lvl = 0                                    => 7,
        (nap_summary in [11, 10])                         => 6,
        (nap_summary in [4, 6, 7, 9])                     => 5,
                                                             5);

    s1_nap_lvl_v2_m := map(
        s1_nap_lvl_v2 = 5  => 0.3108108108,
        s1_nap_lvl_v2 = 6  => 0.2394034537,
        s1_nap_lvl_v2 = 7  => 0.2210724365,
        s1_nap_lvl_v2 = 8  => 0.2095238095,
        s1_nap_lvl_v2 = 9  => 0.1771281169,
        s1_nap_lvl_v2 = 10 => 0.1284965035,
        s1_nap_lvl_v2 = 11 => 0.1077947706,
        s1_nap_lvl_v2 = 12 => 0.0942812983,
                              0.1584433634);

    s1_eda_sourced_type := map(
        fname_eda_sourced_type = 'P' or lname_eda_sourced_type = 'P'   => 3,
        fname_eda_sourced_type = 'AP' or lname_eda_sourced_type = 'AP' => 2,
        fname_eda_sourced_type = 'A' or lname_eda_sourced_type = 'A'   => 1,
                                                                          0);

    s1_eda_sourced_type_m := map(
        s1_eda_sourced_type = 0 => 0.2267206478,
        s1_eda_sourced_type = 1 => 0.1926677067,
        s1_eda_sourced_type = 2 => 0.1388458226,
        s1_eda_sourced_type = 3 => 0.1201272872,
                                   0.1584433634);

    s1_nas479 := (nas_summary in [4, 7, 9]);

    s1_life_experience_lvl := map(
        prof_license_flag                              => 3,
        ams_flag                                       => 1,
        PAW_Source_count > 0 or PAW_Business_count > 0 => 2,
                                                          0);

    s1_life_experience_lvl_m := map(
        s1_life_experience_lvl = 0 => 0.1697976879,
        s1_life_experience_lvl = 1 => 0.1352418559,
        s1_life_experience_lvl = 2 => 0.1060606061,
        s1_life_experience_lvl = 3 => 0.0625,
                                      0.1584433634);

    multi_inq_per_adl := Inq_SSNsPerADL > 1 or Inq_AddrsPerADL > 1 or Inq_LnamesPerADL > 1 or Inq_PhonesPerADL > 1 or Inq_DOBsPerADL > 1;

    s1_inq_per_adl := map(
        multi_inq_per_adl => 2,
        Inq_PerADL > 0    => 1,
                             0);

    s1_inq_per_adl_m := map(
        s1_inq_per_adl = 0 => 0.1489407233,
        s1_inq_per_adl = 1 => 0.2646153846,
        s1_inq_per_adl = 2 => 0.4155844156,
                              0.1584433634);

    s1_ssns_per_adl_lvl := if(ssns_per_adl_c6 > 0 and ssns_per_adl = 1, 1.5, min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 3));

    s1_ssns_per_adl_lvl_m := map(
        s1_ssns_per_adl_lvl = 0   => 0.1067927171,
        s1_ssns_per_adl_lvl = 1   => 0.1555249253,
        s1_ssns_per_adl_lvl = 1.5 => 0.1894685039,
        s1_ssns_per_adl_lvl = 2   => 0.2481536189,
        s1_ssns_per_adl_lvl = 3   => 0.3935483871,
                                     0.1584433634);

    s1_invalid_addrs_per_adl_4 := min(if(invalid_addrs_per_adl = NULL, -NULL, invalid_addrs_per_adl), 4);

    s1_invalid_addrs_per_adl_4_m := map(
        s1_invalid_addrs_per_adl_4 = 0 => 0.1503466732,
        s1_invalid_addrs_per_adl_4 = 1 => 0.1587608906,
        s1_invalid_addrs_per_adl_4 = 2 => 0.1820512821,
        s1_invalid_addrs_per_adl_4 = 3 => 0.2405660377,
        s1_invalid_addrs_per_adl_4 = 4 => 0.3410138249,
                                          0.1584433634);

    s1_new_roommate := adls_per_addr_c6 > 0 or ssns_per_addr_c6 > 0;

    s1_mtg_lvl := map(
        add1_mortgage_amount <= 150000 and add1_financing_type = 'ADJ'   => 4,
        add1_financing_type = 'ADJ'                                      => 3,
        add1_mortgage_amount <= 150000 and add1_purchase_amount > 175000 => 0,
        add1_mortgage_amount <= 150000                                   => 2,
                                                                            1);

    s1_mtg_lvl_m := map(
        s1_mtg_lvl = 0 => 0.0872483221,
        s1_mtg_lvl = 1 => 0.1134751773,
        s1_mtg_lvl = 2 => 0.1634182909,
        s1_mtg_lvl = 3 => 0.1764705882,
        s1_mtg_lvl = 4 => 0.2022058824,
                          0.1584433634);

    s1_avm_increase_2y := map(
        add1_avm_automated_valuation = 0 or add1_avm_automated_valuation_2 = 0 => -1,
        add1_avm_automated_valuation > add1_avm_automated_valuation_2          => 1,
                                                                                  0);

    avm_index_fips := if(add1_avm_med_fips = 0 or add1_avm_automated_valuation = 0, -1,
      truncate(100*add1_avm_automated_valuation / add1_avm_med_fips));

    s1_avm_index_fips := map(
        avm_index_fips = -1    => -1,
        avm_index_fips <= 60   => 60,
        avm_index_fips <= 100  => 100,
        avm_index_fips <= 140  => 140,
        s1_avm_increase_2y = 1 => 999,
                                  141);

    s1_avm_index_fips_m := map(
        s1_avm_index_fips = -1  => 0.1580558745,
        s1_avm_index_fips = 60  => 0.2991913747,
        s1_avm_index_fips = 100 => 0.1995332555,
        s1_avm_index_fips = 140 => 0.1389878831,
        s1_avm_index_fips = 141 => 0.0977653631,
        s1_avm_index_fips = 999 => 0.0808709176,
                                   0.1584433634);

    s0_log := -10.87383152 +
        s0_derog_lvl_v2_m * 1.9770833107 +
        (integer)s0_property_sold_purchase_f * -0.560544074 +
        s0_prop_ownership_lvl_v2_m * 2.1671653054 +
        s0_add1_advo_usage_m * 4.0593170252 +
        s0_add2_advo_m * 2.701107417 +
        s0_wealth_wc_lvl_m * 3.0348202058 +
        s0_estimated_income_m * 4.2794460338 +
        s0_life_experience_m * 7.1395981628 +
        s0_addrs_15yr_m * 1.5788318768 +
        s0_verx_lvl_m * 4.6790674875 +
        s0_ssns_per_adl_lvl_m * 2.2656125039 +
        s0_addrs_per_adl_m * 2.5561594612 +
        s0_new_roommates_m * 5.6336037881 +
        s0_inq_velo_lvl_m * 2.0670404639;

    s1_log := -8.327938305 +
        (integer)s1_property_sold_f * -1.058177176 +
        s1_sfd_rms_lvl_m * 3.181928246 +
        s1_advo_lvl_m * 3.5019292009 +
        s1_wealth_index_m * 4.0899477426 +
        s1_addr_count_lvl_m * 2.2558898445 +
        s1_nap_lvl_v2_m * 5.539237526 +
        s1_eda_sourced_type_m * 1.8298924984 +
        (integer)s1_nas479 * 0.2081653848 +
        s1_life_experience_lvl_m * 5.050266087 +
        s1_inq_per_adl_m * 3.0805214842 +
        s1_ssns_per_adl_lvl_m * 2.7768976863 +
        s1_invalid_addrs_per_adl_4_m * 2.1133608665 +
        (integer)s1_new_roommate * 0.3604053298 +
        s1_mtg_lvl_m * 3.389888593 +
        s1_avm_index_fips_m * 2.969753917;

    base := 700;

    odds := 0.18 / (1 - 0.18);

    point := -40;

    out_estimate := (integer)segment_s0 * s0_log + (integer)segment_s1 * s1_log;

    phat := exp(out_estimate) / (1 + exp(out_estimate));

    mod := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

    rvr1104_3_1 := max(501, min(900, if(mod = NULL, -NULL, mod)));

    scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (integer1)input_dob_match_level >= 7 or lien_flag or criminal_count > 0 or bk_flag or ssn_deceased or truedid);

    rvr1104_3 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvr1104_3_1);



    PrescreenOptOut := xmlPrescreenOptOut or risk_indicators.iid_constants.CheckFlag( risk_indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags );
    rcs := riskwise.Reasons( le, PrescreenOptOut, isCalifornia );
    _rc07 := rcs.rc07;
    _rc08 := rcs.rc08;
    _rc15 := rcs.rc15;
    _rc11 := rcs.rc11;
    _rc14 := rcs.rc14;
    _rc03 := rcs.rc03;
    _rc06 := rcs.rc06;
    _rc39 := rcs.rc39;


    _rc9k := rc_dwelltype = 'A';
    _rc9m := wealth_index = '1' AND watercraft_count = 0 AND attr_num_aircraft = 0;
    _rc9n := addrs_prison_history;
    _rc9o := not add1_eda_sourced and phones_per_addr = 0;
    _rc9q := Inq_count12 > 0;
    _rc9s := add1_financing_type = 'ADJ';
    _rc9t := _rc07 OR _rc08 OR _rc15;
    _rc9u := _rc11 OR _rc14;
    _rc9v := _rc03 OR _rc06 OR _rc39;
    _rc9w := bankrupt;




    rcs_main := __common__(
      if( rcs.rcEV, rcs.makeRC('EV') ) & //	Eviction record found
      if( _rc9W, rcs.makeRC('9W') ) & //	Bankruptcy record on file
      if( _rc9N, rcs.makeRC('9N') ) & //	Correctional address in address history
      if( rcs.rcMS, rcs.makeRC('MS') ) & //	Multiple SSNs reported with applicant
      if( rcs.rc9H, rcs.makeRC('9H') ) & //	Evidence of sub-prime credit services solicited
      if( rcs.rc98, rcs.makeRC('98') ) & //	Lien / Judgement record found
      if( _rc9Q, rcs.makeRC('9Q') ) & //	Number of inquiries in the last 12 months
      if( rcs.rc97, rcs.makeRC('97') ) & //	Criminal record found
      if( rcs.rc22, rcs.makeRC('22') ) & //	Unable to verify applicant name and address
      if( _rc9O, rcs.makeRC('9O') ) & //	No evidence of phone service at address
      if( _rc9U, rcs.makeRC('9U') ) & //	Input address invalid, non-residential or undeliverable
      if( rcs.rc25, rcs.makeRC('25') ) & //	Unable to verify applicant address
      if( rcs.rc37, rcs.makeRC('37') ) & //	Unable to verify applicant name
      if( rcs.rcPV, rcs.makeRC('PV') ) & //	Insufficient Property Value
      if( _rc9T, rcs.makeRC('9T') ) & //	Input phone is invalid, non-residential or disconnected
      if( rcs.rc9B, rcs.makeRC('9B') ) & //	Evidence of historical property ownership but no current record
      if( rcs.rc73, rcs.makeRC('73') ) & //	The input phone number is not found in the public record
      if( rcs.rc9A, rcs.makeRC('9A') ) & //	No evidence of property ownership
      if( rcs.rc02, rcs.makeRC('02') ) & //	The input SSN is reported as deceased
      if( _rc9V, rcs.makeRC('9V') ) & //	Input SSN is invalid, recently issued, or inconsistent with date of birth
      if( rcs.rc20, rcs.makeRC('20') ) & //	Unable to verify applicant name, address and phone number
      if( rcs.rc74, rcs.makeRC('74') ) & //	The input phone number is associated with a different name and address
      if( rcs.rc9C, rcs.makeRC('9C') ) & //	Length of residence
      if( rcs.rc9D, rcs.makeRC('9D') ) & //	Change of address frequency
      if( rcs.rc23, rcs.makeRC('23') ) & //	Unable to verify applicant name and SSN
      if( rcs.rc99, rcs.makeRC('99') ) & //	The input address is verified but may not be primary residence
      if( _rc9M, rcs.makeRC('9M') ) & //	Insufficient evidence of wealth
      if( _rc9S, rcs.makeRC('9S') ) & //	Type of mortgage
      if( rcs.rc51, rcs.makeRC('51') ) & //	The input last name is not associated with the input SSN
      if( rcs.rc48, rcs.makeRC('48') ) & //	Unable to verify first name
      if( rcs.rc72, rcs.makeRC('72') ) & //	The input SSN is associated with a different name and address
      if( rcs.rc19, rcs.makeRC('19') ) & //	Unable to verify name, address, SSN/TIN and phone
      if( rcs.rc9E, rcs.makeRC('9E') ) & //	Number of sources confirming identity and current address
      if( rcs.rc24, rcs.makeRC('24') ) & //	Unable to verify applicant address and SSN
      if( _rc9K, rcs.makeRC('9K') ) & //	Address dwelling type
      if( rcs.rc9I, rcs.makeRC('9I') ) &
      if( rcs.rc52, rcs.makeRC('52') ) & //	The input first name is not associated with input SSN
      if( rcs.rc71, rcs.makeRC('71') ) & //	The input SSN is not found in the public record
      if( rcs.rc26, rcs.makeRC('26') ) //	Unable to verify SSN / TIN
    );

    rcs_main2 := __common__(choosen(rcs_main,4));
    
    rcs_final := __common__(rcs_main2 &
      if( Inq_count12 > 0 and not exists( rcs_main2( hri='9Q' ) ), rcs.makeRC('9Q') ));


    #if(RVR_DEBUG)
      self.clam := le;
      self.truedid                         := truedid;
      self.out_unit_desig                  := out_unit_desig;
      self.out_sec_range                   := out_sec_range;
      self.out_addr_type                   := out_addr_type;
      self.nas_summary                     := nas_summary;
      self.nap_summary                     := nap_summary;
      self.rc_hriskaddrflag                := rc_hriskaddrflag;
      self.rc_decsflag                     := rc_decsflag;
      self.rc_dwelltype                    := rc_dwelltype;
      self.rc_bansflag                     := rc_bansflag;
      self.rc_ziptypeflag                  := rc_ziptypeflag;
      self.rc_zipclass                     := rc_zipclass;
      self.combo_dobscore                  := combo_dobscore;
      self.ver_sources                     := ver_sources;
      self.fname_eda_sourced_type          := fname_eda_sourced_type;
      self.lname_eda_sourced_type          := lname_eda_sourced_type;
      self.add1_isbestmatch                := add1_isbestmatch;
      self.add1_unit_count                 := add1_unit_count;
      self.add1_advo_address_vacancy       := add1_advo_address_vacancy;
      self.add1_advo_dnd                   := add1_advo_dnd;
      self.add1_advo_drop                  := add1_advo_drop;
      self.add1_advo_res_or_business       := add1_advo_res_or_business;
      self.add1_advo_mixed_address_usage   := add1_advo_mixed_address_usage;
      self.add1_avm_land_use               := add1_avm_land_use;
      self.add1_avm_automated_valuation    := add1_avm_automated_valuation;
      self.add1_avm_automated_valuation_2  := add1_avm_automated_valuation_2;
      self.add1_avm_med_fips               := add1_avm_med_fips;
      self.add1_naprop                     := add1_naprop;
      self.add1_purchase_amount            := add1_purchase_amount;
      self.add1_mortgage_amount            := add1_mortgage_amount;
      self.add1_financing_type             := add1_financing_type;
      self.add1_building_area              := add1_building_area;
      self.add1_no_of_rooms                := add1_no_of_rooms;
      self.property_owned_total            := property_owned_total;
      self.property_sold_total             := property_sold_total;
      self.property_sold_purchase_count    := property_sold_purchase_count;
      self.property_sold_assessed_count    := property_sold_assessed_count;
      self.property_ambig_total            := property_ambig_total;
      self.add2_advo_address_vacancy       := add2_advo_address_vacancy;
      self.add2_advo_mixed_address_usage   := add2_advo_mixed_address_usage;
      self.add2_avm_land_use               := add2_avm_land_use;
      self.add2_naprop                     := add2_naprop;
      self.add3_naprop                     := add3_naprop;
      self.addrs_5yr                       := addrs_5yr;
      self.addrs_10yr                      := addrs_10yr;
      self.addrs_15yr                      := addrs_15yr;
      self.unique_addr_count               := unique_addr_count;
      self.addr_lres_12mo_count            := addr_lres_12mo_count;
      self.ssns_per_adl                    := ssns_per_adl;
      self.addrs_per_adl                   := addrs_per_adl;
      self.ssns_per_adl_c6                 := ssns_per_adl_c6;
      self.adls_per_addr_c6                := adls_per_addr_c6;
      self.ssns_per_addr_c6                := ssns_per_addr_c6;
      self.invalid_addrs_per_adl           := invalid_addrs_per_adl;
      self.inq_peradl                      := inq_peradl;
      self.inq_ssnsperadl                  := inq_ssnsperadl;
      self.inq_addrsperadl                 := inq_addrsperadl;
      self.inq_lnamesperadl                := inq_lnamesperadl;
      self.inq_phonesperadl                := inq_phonesperadl;
      self.inq_dobsperadl                  := inq_dobsperadl;
      self.inq_perssn                      := inq_perssn;
      self.paw_business_count              := paw_business_count;
      self.paw_source_count                := paw_source_count;
      self.infutor_nap                     := infutor_nap;
      self.impulse_count                   := impulse_count;
      self.attr_total_number_derogs        := attr_total_number_derogs;
      self.attr_eviction_count             := attr_eviction_count;
      self.bankrupt                        := bankrupt;
      self.disposition                     := disposition;
      self.filing_count                    := filing_count;
      self.bk_recent_count                 := bk_recent_count;
      self.liens_recent_unreleased_count   := liens_recent_unreleased_count;
      self.liens_historical_unreleased_ct  := liens_historical_unreleased_ct;
      self.criminal_count                  := criminal_count;
      self.watercraft_count                := watercraft_count;
      self.ams_class                       := ams_class;
      self.ams_college_code                := ams_college_code;
      self.ams_college_type                := ams_college_type;
      self.ams_income_level_code           := ams_income_level_code;
      self.ams_file_type                   := ams_file_type;
      self.prof_license_flag               := prof_license_flag;
      self.wealth_index                    := wealth_index;
      self.input_dob_match_level           := input_dob_match_level;
      self.estimated_income                := estimated_income;
      self.attr_num_aircraft               := attr_num_aircraft;
      self.ver_src_ba                      := ver_src_ba;
      self.bk_flag                         := bk_flag;
      self.ver_src_l2                      := ver_src_l2;
      self.ver_src_li                      := ver_src_li;
      self.lien_rec_unrel_flag             := lien_rec_unrel_flag;
      self.lien_hist_unrel_flag            := lien_hist_unrel_flag;
      self.lien_flag                       := lien_flag;
      self.ver_src_ds                      := ver_src_ds;
      self.ssn_deceased                    := ssn_deceased;
      self.pk_impulse_count                := pk_impulse_count;
      self.bs_attr_derog_flag              := bs_attr_derog_flag;
      self.bs_attr_eviction_flag           := bs_attr_eviction_flag;
      self.bs_attr_derog_flag2             := bs_attr_derog_flag2;
      self.bs_own_rent                     := bs_own_rent;
      self._segment                        := _segment;
      self.segment_s0                      := segment_s0;
      self.segment_s1                      := segment_s1;
      self.ams_flag                        := ams_flag;
      self.s0_derog_lvl_v2                 := s0_derog_lvl_v2;
      self.s0_derog_lvl_v2_m               := s0_derog_lvl_v2_m;
      self.s0_property_sold_purchase_f     := s0_property_sold_purchase_f;
      self.s0_prop_ownership_lvl_v2        := s0_prop_ownership_lvl_v2;
      self.s0_prop_ownership_lvl_v2_m      := s0_prop_ownership_lvl_v2_m;
      self.s0_add1_advo_usage              := s0_add1_advo_usage;
      self.s0_add1_advo_usage_m            := s0_add1_advo_usage_m;
      self.s0_add2_advo                    := s0_add2_advo;
      self.s0_add2_advo_m                  := s0_add2_advo_m;
      self.s0_wealth_wc_lvl                := s0_wealth_wc_lvl;
      self.s0_wealth_wc_lvl_m              := s0_wealth_wc_lvl_m;
      self.s0_estimated_income             := s0_estimated_income;
      self.s0_estimated_income_m           := s0_estimated_income_m;
      self.s0_life_experience              := s0_life_experience;
      self.s0_life_experience_m            := s0_life_experience_m;
      self.s0_addrs_15yr                   := s0_addrs_15yr;
      self.s0_addrs_15yr_m                 := s0_addrs_15yr_m;
      self.s0_nap_lvl                      := s0_nap_lvl;
      self.s0_verx_lvl                     := s0_verx_lvl;
      self.s0_verx_lvl_m                   := s0_verx_lvl_m;
      self.s0_ssns_per_adl_lvl             := s0_ssns_per_adl_lvl;
      self.s0_ssns_per_adl_lvl_m           := s0_ssns_per_adl_lvl_m;
      self.s0_addrs_per_adl                := s0_addrs_per_adl;
      self.s0_addrs_per_adl_m              := s0_addrs_per_adl_m;
      self.s0_new_roommates                := s0_new_roommates;
      self.s0_new_roommates_m              := s0_new_roommates_m;
      self.s0_inq_velo_lvl                 := s0_inq_velo_lvl;
      self.s0_inq_velo_lvl_m               := s0_inq_velo_lvl_m;
      self.s1_property_sold_f              := s1_property_sold_f;
      self.add_apt                         := add_apt;
      self.add_pobox                       := add_pobox;
      self.single_family                   := single_family;
      self.s1_sfd_rms_lvl                  := s1_sfd_rms_lvl;
      self.s1_sfd_rms_lvl_m                := s1_sfd_rms_lvl_m;
      self.s1_add1_advo                    := s1_add1_advo;
      self.s1_add2_advo                    := s1_add2_advo;
      self.s1_advo_lvl                     := s1_advo_lvl;
      self.s1_advo_lvl_m                   := s1_advo_lvl_m;
      self.s1_wealth_index                 := s1_wealth_index;
      self.s1_wealth_index_m               := s1_wealth_index_m;
      self.pct_lres_gt12mo                 := pct_lres_gt12mo;
      self.s1_pct_addr_gt12mo_100          := s1_pct_addr_gt12mo_100;
      self.s1_addr_count_lvl               := s1_addr_count_lvl;
      self.s1_addr_count_lvl_m             := s1_addr_count_lvl_m;
      self.s1_nap_lvl                      := s1_nap_lvl;
      self.s1_nap_lvl_v2                   := s1_nap_lvl_v2;
      self.s1_nap_lvl_v2_m                 := s1_nap_lvl_v2_m;
      self.s1_eda_sourced_type             := s1_eda_sourced_type;
      self.s1_eda_sourced_type_m           := s1_eda_sourced_type_m;
      self.s1_nas479                       := s1_nas479;
      self.s1_life_experience_lvl          := s1_life_experience_lvl;
      self.s1_life_experience_lvl_m        := s1_life_experience_lvl_m;
      self.multi_inq_per_adl               := multi_inq_per_adl;
      self.s1_inq_per_adl                  := s1_inq_per_adl;
      self.s1_inq_per_adl_m                := s1_inq_per_adl_m;
      self.s1_ssns_per_adl_lvl             := s1_ssns_per_adl_lvl;
      self.s1_ssns_per_adl_lvl_m           := s1_ssns_per_adl_lvl_m;
      self.s1_invalid_addrs_per_adl_4      := s1_invalid_addrs_per_adl_4;
      self.s1_invalid_addrs_per_adl_4_m    := s1_invalid_addrs_per_adl_4_m;
      self.s1_new_roommate                 := s1_new_roommate;
      self.s1_mtg_lvl                      := s1_mtg_lvl;
      self.s1_mtg_lvl_m                    := s1_mtg_lvl_m;
      self.s1_avm_increase_2y              := s1_avm_increase_2y;
      self.avm_index_fips                  := avm_index_fips;
      self.s1_avm_index_fips               := s1_avm_index_fips;
      self.s1_avm_index_fips_m             := s1_avm_index_fips_m;
      self.s0_log                          := s0_log;
      self.s1_log                          := s1_log;
      self.base                            := base;
      self.odds                            := odds;
      self.point                           := point;
      self.out_estimate                    := out_estimate;
      self.phat                            := phat;
      self.mod                             := mod;
      self.rvr1104_3_1                     := rvr1104_3_1;
      self.scored_222s                     := scored_222s;
      self.rvr1104_3                       := rvr1104_3;

      self._rc07 := _rc07;
      self._rc08 := _rc08;
      self._rc15 := _rc15;
      self._rc11 := _rc11;
      self._rc14 := _rc14;
      self._rc03 := _rc03;
      self._rc06 := _rc06;
      self._rc39 := _rc39;
      self._rc9k := _rc9k;
      self._rc9m := _rc9m;
      self._rc9n := _rc9n;
      self._rc9o := _rc9o;
      self._rc9q := _rc9q;
      self._rc9s := _rc9s;
      self._rc9t := _rc9t;
      self._rc9u := _rc9u;
      self._rc9v := _rc9v;
      self._rc9w := _rc9w;

      self._rc35 := rcs.rc35;
      self._rcEV := rcs.rcEV;
      self._rcMS := rcs.rcMS;
      self._rc9H := rcs.rc9H;
      self._rc98 := rcs.rc98;
      self._rc97 := rcs.rc97;
      self._rc22 := rcs.rc22;
      self._rc25 := rcs.rc25;
      self._rc37 := rcs.rc37;
      self._rcPV := rcs.rcPV;
      self._rc9B := rcs.rc9B;
      self._rc73 := rcs.rc73;
      self._rc9A := rcs.rc9A;
      self._rc02 := rcs.rc02;
      self._rc20 := rcs.rc20;
      self._rc74 := rcs.rc74;
      self._rc9C := rcs.rc9C;
      self._rc9D := rcs.rc9D;
      self._rc23 := rcs.rc23;
      self._rc99 := rcs.rc99;
      self._rc51 := rcs.rc51;
      self._rc48 := rcs.rc48;
      self._rc72 := rcs.rc72;
      self._rc19 := rcs.rc19;
      self._rc9E := rcs.rc9E;
      self._rc24 := rcs.rc24;
      self._rc9I := rcs.rc9I;
      self._rc52 := rcs.rc52;
      self._rc71 := rcs.rc71;
      self._rc26 := rcs.rc26;
      self._rc36 := true;//rcs.rc36;
      self._rc9X := rvr1104_3 = 222;
    #end

    
 
    self.seq := le.seq;

    riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
    ri := __common__(map(
			riTemp[1].hri <> '00' => riTemp,
			rcs.rc95 => rcs.makeRC('95'),
			rcs.rc35 => rcs.makeRC('35'),
			rvr1104_3 = 222 => rcs.makeRC('9X'),
      rcs_final
		));
		zeros := __common__(dataset( [ {'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc));
		self.ri := __common__(choosen( ri & zeros, 5 ));

		self.score := __common__(map(
			riTemp[1].hri in ['91','92','93','94'] => (string3)((integer)riTemp[1].hri + 10),
			rcs.rc95 => '222',
			self.ri[1].hri='35' => '100',
			(string3)rvr1104_3
		));


  END;
  
  model := project( clam, doModel(left) );
  
  return model;
END;

