IMPORT Models, Risk_Indicators, RiskWise, RiskWiseFCRA, RiskView, UT, Std, riskview;

EXPORT RVG1610_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG        := False;

	#if(MODEL_DEBUG)
Layout_Debug := RECORD
			
			
																				unsigned4 seq;
                    Integer sysdate;                          // := sysdate;
                    boolean iv_add_apt;                       // := iv_add_apt;
                    //string iv_add_apt;                       // := iv_add_apt;
                    integer rv_p88_phn_dst_to_inp_add;        // := rv_p88_phn_dst_to_inp_add;
                    string rv_p85_phn_not_issued;            // := rv_p85_phn_not_issued;
                    string rv_l71_add_business;              // := rv_l71_add_business;
                    //string add_ec1;                          // := add_ec1;
                    //string add_ec3;                          // := add_ec3;
                   // string add_ec4;                          // := add_ec4;
                    string rv_l70_add_standardized;          // := rv_l70_add_standardized;
                    string rv_l72_add_curr_vacant;           // := rv_l72_add_curr_vacant;
                    INTEGER rv_f03_input_add_not_most_rec;    // := rv_f03_input_add_not_most_rec;
                    Integer rv_c19_add_prison_hist;           // := rv_c19_add_prison_hist;
                    Integer rv_f00_ssn_score;                 // := rv_f00_ssn_score;
                    integer rv_f01_inp_addr_address_score;    // := rv_f01_inp_addr_address_score;
                    string rv_d32_criminal_x_felony;         // := rv_d32_criminal_x_felony;
                    integer rv_c21_stl_inq_count;             // := rv_c21_stl_inq_count;
                    string rv_d33_eviction_recency;          // := rv_d33_eviction_recency;
                    Integer bureau_adl_eq_fseen_pos;          // := bureau_adl_eq_fseen_pos;
                    string bureau_adl_fseen_eq;              // := bureau_adl_fseen_eq;
                    integer _bureau_adl_fseen_eq;             // := _bureau_adl_fseen_eq;
                    integer _src_bureau_adl_fseen;            // := _src_bureau_adl_fseen;
                    integer rv_c20_m_bureau_adl_fs;           // := rv_c20_m_bureau_adl_fs;
                    integer rv_c12_num_nonderogs;             // := rv_c12_num_nonderogs;
                    string rv_f03_address_match;             // := rv_f03_address_match;
                    integer rv_l80_inp_avm_autoval;           // := rv_l80_inp_avm_autoval;
                    integer rv_c14_addrs_15yr;                // := rv_c14_addrs_15yr;
                    integer rv_c22_inp_addr_occ_index;        // := rv_c22_inp_addr_occ_index;
                    Integer rv_c22_inp_addr_owned_not_occ;    // := rv_c22_inp_addr_owned_not_occ;
                    string rv_ever_asset_owner;              // := rv_ever_asset_owner;
                    string rv_e55_college_ind;               // := rv_e55_college_ind;
                    integer rv_e57_prof_license_br_flag;      // := rv_e57_prof_license_br_flag;
                    integer rv_i61_inq_collection_count12;    // := rv_i61_inq_collection_count12;
                    integer rv_i60_inq_hiriskcred_recency;    // := rv_i60_inq_hiriskcred_recency;
                    integer rv_i60_inq_comm_count12;          // := rv_i60_inq_comm_count12;
                    integer rv_l79_adls_per_apt_addr;         // := rv_l79_adls_per_apt_addr;
                    integer rv_l79_adls_per_sfd_addr;         // := rv_l79_adls_per_sfd_addr;
                    Integer rv_l79_adls_per_addr_c6;          // := rv_l79_adls_per_addr_c6;
                    Integer rv_f01_inp_add_house_num_match;   // := rv_f01_inp_add_house_num_match;
                    Integer rv_c12_inp_addr_source_count;     // := rv_c12_inp_addr_source_count;
                    integer rv_i60_inq_other_recency;         // := rv_i60_inq_other_recency;
                    Integer rv_i62_inq_ssns_per_adl;          // := rv_i62_inq_ssns_per_adl;
                    integer rv_i62_inq_addrs_per_adl;         // := rv_i62_inq_addrs_per_adl;
                    Integer rv_i62_inq_phones_per_adl;        // := rv_i62_inq_phones_per_adl;
                    Real r_subscore0;                      // := r_subscore0;
                    Real r_subscore1;                      // := r_subscore1;
                    Real r_subscore2;                      // := r_subscore2;
                    Real r_subscore3;                      // := r_subscore3;
                    Real r_subscore4;                      // := r_subscore4;
                    Real r_subscore5;                      // := r_subscore5;
                    Real r_subscore6;                      // := r_subscore6;
                    Real r_subscore7;                      // := r_subscore7;
                    Real r_subscore8;                      // := r_subscore8;
                    Real r_subscore9;                      // := r_subscore9;
                    REAL r_subscore10;                     // := r_subscore10;
                    Real r_subscore11;                     // := r_subscore11;
                    Real r_subscore12;                     // := r_subscore12;
                    Real r_subscore13;                     // := r_subscore13;
                    Real r_subscore14;                     // := r_subscore14;
                    Real r_subscore15;                     // := r_subscore15;
                    Real r_subscore16;                     // := r_subscore16;
                    Real r_subscore17;                     // := r_subscore17;
                    Real r_subscore18;                     // := r_subscore18;
                    Real r_subscore19;                     // := r_subscore19;
                    Real r_subscore20;                     // := r_subscore20;
                    Real r_subscore21;                     // := r_subscore21;
                    Real r_subscore22;                     // := r_subscore22;
                    Real r_subscore23;                     // := r_subscore23;
                    Real r_subscore24;                     // := r_subscore24;
                    Real r_subscore25;                     // := r_subscore25;
                    Real r_subscore26;                     // := r_subscore26;
                    Real r_subscore27;                     // := r_subscore27;
                    Real r_subscore28;                     // := r_subscore28;
                    Real r_subscore29;                     // := r_subscore29;
                    Real r_subscore30;                     // := r_subscore30;
                    Real r_subscore31;                     // := r_subscore31;
                    Real r_subscore32;                     // := r_subscore32;
                    Real r_subscore33;                     // := r_subscore33;
                    Real r_rawscore;                       // := r_rawscore;
                    Real r_lnoddsscore;                    // := r_lnoddsscore;
                    Real r_probscore;                      // := r_probscore;
                    string r_aacd_0;                         // := r_aacd_0;
                    Real r_dist_0;                         // := r_dist_0;
                    string r_aacd_1;                         // := r_aacd_1;
                    Real r_dist_1;                         // := r_dist_1;
                    string r_aacd_2;                         // := r_aacd_2;
                    Real r_dist_2;                         // := r_dist_2;
                    string r_aacd_3;                         // := r_aacd_3;
                    Real r_dist_3;                         // := r_dist_3;
                    string r_aacd_4;                         // := r_aacd_4;
                    Real r_dist_4;                         // := r_dist_4;
                    string r_aacd_5;                         // := r_aacd_5;
                    Real r_dist_5;                        // := r_dist_5;
                    string r_aacd_6;                         // := r_aacd_6;
                    Real r_dist_6;                         // := r_dist_6;
                    string r_aacd_7;                         // := r_aacd_7;
                    Real r_dist_7;                         // := r_dist_7;
                    string r_aacd_8;                         // := r_aacd_8;
                    Real r_dist_8;                         // := r_dist_8;
                    string r_aacd_9;                         // := r_aacd_9;
                    Real r_dist_9;                         // := r_dist_9;
                    string r_aacd_10;                        // := r_aacd_10;
                    Real r_dist_10;                        // := r_dist_10;
                    string r_aacd_11;                        // := r_aacd_11;
                    Real r_dist_11;                        // := r_dist_11;
                    string r_aacd_12;                        // := r_aacd_12;
                    Real r_dist_12;                        // := r_dist_12;
                    string r_aacd_13;                        // := r_aacd_13;
                    Real r_dist_13;                        // := r_dist_13;
                    string r_aacd_14;                        // := r_aacd_14;
                    Real r_dist_14;                        // := r_dist_14;
                    string r_aacd_15;                        // := r_aacd_15;
                    Real r_dist_15;                        // := r_dist_15;
                    string r_aacd_16;                        // := r_aacd_16;
                    Real r_dist_16;                        // := r_dist_16;
                    string r_aacd_17;                        // := r_aacd_17;
                    Real r_dist_17;                        // := r_dist_17;
                    string r_aacd_18;                        // := r_aacd_18;
                    Real r_dist_18;                        // := r_dist_18;
                    string r_aacd_19;                        // := r_aacd_19;
                    Real r_dist_19;                        // := r_dist_19;
                    string r_aacd_20;                        // := r_aacd_20;
                    Real r_dist_20;                        // := r_dist_20;
                    string r_aacd_21;                        // := r_aacd_21;
                    Real r_dist_21;                        // := r_dist_21;
                    string r_aacd_22;                        // := r_aacd_22;
                    Real r_dist_22;                        // := r_dist_22;
                    string r_aacd_23;                        // := r_aacd_23;
                    Real r_dist_23;                        // := r_dist_23;
                    string r_aacd_24;                        // := r_aacd_24;
                    Real r_dist_24;                        // := r_dist_24;
                    string r_aacd_25;                        // := r_aacd_25;
                    Real r_dist_25;                        // := r_dist_25;
                    string r_aacd_26;                        // := r_aacd_26;
                    Real r_dist_26;                        // := r_dist_26;
                    string r_aacd_27;                        // := r_aacd_27;
                    Real r_dist_27;                        // := r_dist_27;
                    string r_aacd_28;                        // := r_aacd_28;
                    Real r_dist_28;                        // := r_dist_28;
                    string r_aacd_29;                        // := r_aacd_29;
                    Real r_dist_29;                        // := r_dist_29;
                    string r_aacd_30;                        // := r_aacd_30;
                    Real r_dist_30;                        // := r_dist_30;
                    string r_aacd_31;                        // := r_aacd_31;
                    Real r_dist_31;                        // := r_dist_31;
                    string r_aacd_32;                        // := r_aacd_32;
                    Real r_dist_32;                        // := r_dist_32;
                    string r_aacd_33;                        // := r_aacd_33;
                    Real r_dist_33;                        // := r_dist_33;
                    Real r_rcvaluel79;                     // := r_rcvaluel79;
                    Real r_rcvaluel72;                     // := r_rcvaluel72;
                    Real r_rcvaluel70;                     // := r_rcvaluel70;
                    Real r_rcvaluel71;                     // := r_rcvaluel71;
                    Real r_rcvalued32;                     // := r_rcvalued32;
                    Real r_rcvalued33;                     // := r_rcvalued33;
                    Real r_rcvaluec19;                     // := r_rcvaluec19;
                    Real r_rcvaluef01;                     // := r_rcvaluef01;
                    Real r_rcvaluef00;                     // := r_rcvaluef00;
                    Real r_rcvaluef03;                     // := r_rcvaluef03;
                    Real r_rcvaluee55;                     // := r_rcvaluee55;
                    Real r_rcvaluec12;                     // := r_rcvaluec12;
                    Real r_rcvaluee57;                     // := r_rcvaluee57;
                    Real r_rcvaluec14;                     // := r_rcvaluec14;
                    Real r_rcvaluel80;                     // := r_rcvaluel80;
                    Real r_rcvaluec22;                     // := r_rcvaluec22;
                    Real r_rcvaluec20;                     // := r_rcvaluec20;
                    Real r_rcvaluec21;                     // := r_rcvaluec21;
                    Real r_rcvaluea40;                     // := r_rcvaluea40;
                    Real r_rcvaluep88;                     // := r_rcvaluep88;
                    Real r_rcvaluep85;                     // := r_rcvaluep85;
                    Real r_rcvaluei60;                     // := r_rcvaluei60;
                    Real r_rcvaluei61;                     // := r_rcvaluei61;
                    Real r_rcvaluei62;                     // := r_rcvaluei62;
                    Boolean iv_rv5_deceased;                  // := iv_rv5_deceased;
                    string iv_rv5_unscorable;              // := iv_rv5_unscorable;
                    integer base;                             // := base;
                    integer pts;                              // := pts;
                    Real odds;                             // := odds;
                    integer rvg1610_1_0;                      // := rvg1610_1_0;
                    string r_rc1;                            // := r_rc1;
                    string r_rc2;                            // := r_rc2;
                    string r_rc3;                            // := r_rc3;
                    string r_rc4;                            // := r_rc4;
                    Real r_vl1;                            // := r_vl1;
                    Real r_vl2;                            // := r_vl2;
                    Real r_vl3;                            // := r_vl3;
                    Real r_vl4;                            // := r_vl4;
                    string _rc_inq;                          // := _rc_inq;
                    string rc2;                              // := rc2;
                    string rc3;                              // := rc3;
                    string rc5;                              // := rc5;
                    string rc4;                              // := rc4;
                    string rc1;                              // := rc1;


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
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_ssndod                        := le.ssn_verification.validation.deceasedDate;
	rc_input_addr_not_most_recent    := (integer)le.iid.inputaddrnotmostrecent;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_disthphoneaddr                := le.iid.disthphoneaddr;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	add_input_address_score          := le.address_verification.input_address_information.address_score;
	add_input_house_number_match     := le.address_verification.input_address_information.house_number_match;
	add_input_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add_input_owned_not_occ          := le.address_verification.inputaddr_owned_not_occupied;
	add_input_occ_index              := le.address_verification.inputaddr_occupancy_index;
	add_input_advo_res_or_bus        := le.advo_input_addr.Residential_or_Business_Ind;
	add_input_avm_auto_val           := le.avm.input_address_information.avm_automated_valuation;
	add_input_source_count           := le.address_verification.input_address_information.source_count;
	add_input_naprop                 := le.address_verification.input_address_information.naprop;
	add_input_pop                    := le.addrPop;
	property_owned_total             := le.address_verification.owned.property_total;
	add_curr_isbestmatch             := le.address_verification.address_history_1.isbestmatch;
	add_curr_advo_vacancy            := le.advo_addr_hist1.Address_Vacancy_Indicator;
	add_curr_naprop                  := le.address_verification.address_history_1.naprop;
	add_curr_pop                     := le.addrPop2;
	add_prev_naprop                  := le.address_verification.address_history_2.naprop;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	adls_per_addr_curr               := le.velocity_counters.adls_per_addr_current;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	inq_collection_count12           := le.acc_logs.collection.count12;
	inq_communications_count12       := le.acc_logs.communications.count12;
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
	inq_ssnsperadl                   := le.acc_logs.inquiryssnsperadl;
	inq_addrsperadl                  := le.acc_logs.inquiryaddrsperadl;
	inq_phonesperadl                 := le.acc_logs.inquiryphonesperadl;
	br_source_count                  := le.employment.source_ct;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	stl_inq_count                    := le.impulse.count;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_eviction_count90            := le.bjl.eviction_count90;
	attr_eviction_count180           := le.bjl.eviction_count180;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count24            := le.bjl.eviction_count24;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	college_file_type                := le.student.file_type2;
	college_attendance               := le.attended_college;
	prof_license_flag                := le.professional_license.professional_license_flag;



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

iv_add_apt := if(StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or not(out_unit_desig = '') or not(out_sec_range = ''), 1, 0);

rv_p88_phn_dst_to_inp_add := if(rc_disthphoneaddr = 9999, NULL, rc_disthphoneaddr);

rv_p85_phn_not_issued := map(
    not(hphnpop)                 => ' ',
    (rc_pwphonezipflag in ['4']) => '1',
                                    '0');

rv_l71_add_business := map(
    not(add_input_pop)                                                       => ' ',
    (trim(trim(add_input_advo_res_or_bus, LEFT), LEFT, RIGHT) in ['B', 'D']) => '1',
                                                                                '0');

add_ec1 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

add_ec3 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[3..3];

add_ec4 := (StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[4..4];

rv_l70_add_standardized := map(
    not(addrpop)                                         => '                           ',
    trim(trim(add_ec1, LEFT), LEFT, RIGHT) = 'E'         => '2 Standardization Error    ',
    add_ec1 = 'S' and (add_ec3 != '0' or add_ec4 != '0') => '1 Address was Standardized ',
                                                            '0 Address is Standard      ');

rv_l72_add_curr_vacant := map(
    not(add_curr_pop)                                          => ' ',
    trim(trim(add_curr_advo_vacancy, LEFT), LEFT, RIGHT) = 'Y' => '1',
                                                                  '0');

rv_f03_input_add_not_most_rec := if(not(truedid and add_input_pop), NULL, rc_input_addr_not_most_recent);

rv_c19_add_prison_hist := if(not(truedid), NULL, (integer)addrs_prison_history);

rv_f00_ssn_score := if(not(truedid and (integer)ssnlength > 0), NULL, min(if(combo_ssnscore = NULL, -NULL, combo_ssnscore), 999));

rv_f01_inp_addr_address_score := if(not(add_input_pop and truedid), NULL, min(if(add_input_address_score = NULL, -NULL, add_input_address_score), 999));

rv_d32_criminal_x_felony := if(not(truedid), '', trim((string)min(if(criminal_count = NULL, -NULL, criminal_count), 3), LEFT, RIGHT) + trim('-', LEFT, RIGHT) + trim((string)min(if(felony_count = NULL, -NULL, felony_count), 3), LEFT, RIGHT));

rv_c21_stl_inq_count := if(not(truedid), NULL, min(if(STL_Inq_count = NULL, -NULL, STL_Inq_count), 999));

rv_d33_eviction_recency := map(
    not(truedid)                                                => '  ',
    attr_eviction_count90   >0                                  => '03',
    attr_eviction_count180  >0                                  => '06',
    attr_eviction_count12   >0                                  => '12',
    (boolean)attr_eviction_count24 and attr_eviction_count >= 2 => '24',
    attr_eviction_count24 >0                                    => '25',
    (boolean)attr_eviction_count36 and attr_eviction_count >= 2 => '36',
    attr_eviction_count36 >0                                    => '37',
    (boolean)attr_eviction_count60 and attr_eviction_count >= 2 => '60',
    attr_eviction_count60 >0                                    => '61',
    attr_eviction_count >= 2                                    => '98',
    attr_eviction_count >= 1                                    => '99',
                                                                   '00');

bureau_adl_eq_fseen_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , ', ', 'E');

bureau_adl_fseen_eq := if(bureau_adl_eq_fseen_pos = 0, '       0', Models.Common.getw(ver_sources_first_seen, bureau_adl_eq_fseen_pos, ','));

_bureau_adl_fseen_eq := common.sas_date((string)(bureau_adl_fseen_eq));

_src_bureau_adl_fseen := min(if(_bureau_adl_fseen_eq = NULL, -NULL, _bureau_adl_fseen_eq), 999999);

rv_c20_m_bureau_adl_fs := map(
    not(truedid)                   => NULL,
    _src_bureau_adl_fseen = 999999 => -1,
                                      min(if(if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12))) = NULL, -NULL, if ((sysdate - _src_bureau_adl_fseen) / (365.25 / 12) >= 0, truncate((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)), roundup((sysdate - _src_bureau_adl_fseen) / (365.25 / 12)))), 999));

rv_c12_num_nonderogs := if(not(truedid), NULL, min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 4));

rv_f03_address_match := map(
    not(truedid)                                => '                          ',
    add_input_isbestmatch                       => '4 INPUT=CURR              ',
    not(add_input_pop) and add_curr_isbestmatch => '3 CURRAVAIL + NOINPUTPOP  ',
    add_input_pop and add_curr_isbestmatch      => '2 CURRAVAIL + INPUTNOTCURR',
    add_curr_pop                                => '1 CURR ONHDRONLY          ',
    add_input_pop                               => '0 INPUTPOP NOHISTAVAIL    ',
                                                   '');

rv_l80_inp_avm_autoval := if(not(add_input_pop), NULL, add_input_avm_auto_val);

rv_c14_addrs_15yr := if(not(truedid), NULL, min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 999));

rv_c22_inp_addr_occ_index := if(not(add_input_pop and truedid), NULL, add_input_occ_index);

rv_c22_inp_addr_owned_not_occ := if(not(add_input_pop and truedid), NULL, (integer)add_input_owned_not_occ);

rv_ever_asset_owner := map(
    not(truedid)                                                                                                                                                                                                 => '',
    add_input_naprop = 4 or add_curr_naprop = 4 or add_prev_naprop = 4 or property_owned_total > 0 or Models.Common.findw_cpp(ver_sources, 'P' ,', ', 'E') > 0 or watercraft_count > 0 or attr_num_aircraft > 0 => '1',
                                                                                                                                                                                                                    '0');

rv_e55_college_ind := map(
    not(truedid)                           => ' ',
    (college_file_type in ['H', 'C', 'A']) => '1',
    college_attendance                     => '1',
                                              '0');

rv_e57_prof_license_br_flag := if(not(truedid), NULL, 
																																				(integer)(if(max((integer)prof_license_flag, br_source_count) = NULL, NULL, 
																																				sum((integer)prof_license_flag, 
																																				if(br_source_count = NULL, 0, br_source_count)))
																																				>0));

rv_i61_inq_collection_count12 := if(not(truedid), NULL, min(if(inq_collection_count12 = NULL, -NULL, inq_collection_count12), 999));

rv_i60_inq_hiriskcred_recency := map(
    not(truedid)               => NULL,
    inq_highRiskCredit_count01 >0  => 1,
    inq_highRiskCredit_count03 >0  => 3,
    inq_highRiskCredit_count06 >0 => 6,
    inq_highRiskCredit_count12 >0  => 12,
    inq_highRiskCredit_count24 >0  => 24,
    inq_highRiskCredit_count >0    => 99,
                                  0);

rv_i60_inq_comm_count12 := if(not(truedid), NULL, min(if(inq_communications_count12 = NULL, -NULL, inq_communications_count12), 999));

rv_l79_adls_per_apt_addr := map(
    not(addrpop)     => NULL,
    iv_add_apt = 0 => -1,
                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_l79_adls_per_sfd_addr := map(
    not(addrpop)     => NULL,
    iv_add_apt = 1 => -1,
                        min(if(adls_per_addr_curr = NULL, -NULL, adls_per_addr_curr), 999));

rv_l79_adls_per_addr_c6 := if(not(addrpop), NULL, min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 999));

rv_f01_inp_add_house_num_match := if(not(add_input_pop and truedid), NULL, (integer)add_input_house_number_match);

rv_c12_inp_addr_source_count := if(not(add_input_pop and truedid), NULL, min(if(add_input_source_count = NULL, -NULL, add_input_source_count), 999));

rv_i60_inq_other_recency := map(
    not(truedid)      => NULL,
    inq_other_count01 >0 => 1,
    inq_other_count03 >0 => 3,
    inq_other_count06 >0 => 6,
    inq_other_count12 >0 => 12,
    inq_other_count24 >0 => 24,
    inq_other_count   >0 => 99,
                         0);

rv_i62_inq_ssns_per_adl := if(not(truedid), NULL, min(if(inq_ssnsperadl = NULL, -NULL, inq_ssnsperadl), 999));

rv_i62_inq_addrs_per_adl := if(not(truedid), NULL, min(if(inq_addrsperadl = NULL, -NULL, inq_addrsperadl), 999));

rv_i62_inq_phones_per_adl := if(not(truedid), NULL, min(if(inq_phonesperadl = NULL, -NULL, inq_phonesperadl), 999));

r_subscore0 := map(
    (rv_d32_criminal_x_felony in [' '])                 => 0,
    (rv_d32_criminal_x_felony in ['0-0'])               => 0.070497,
    (rv_d32_criminal_x_felony in ['1-0'])               => -0.528283,
    (rv_d32_criminal_x_felony in ['2-0'])               => -0.580532,
    (rv_d32_criminal_x_felony in ['3-0'])               => -0.772292,
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1']) => -0.992175,
    (rv_d32_criminal_x_felony in ['2-2', '3-2', '3-3']) => -1.282914,
                                                           0);

r_subscore1 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 0   => -0.426912,
    0 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 2     => -0.860439,
    2 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 153   => -0.186291,
    153 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 188 => -0.12397,
    188 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 214 => -0.057285,
    214 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 254 => 0.084967,
    254 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 298 => 0.134891,
    298 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 339 => 0.269778,
    339 <= rv_c20_m_bureau_adl_fs                                  => 0.374836,
                                                                      0);

r_subscore2 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 90  => -1.005182,
    90 <= rv_f00_ssn_score AND rv_f00_ssn_score < 100  => -0.65699,
    100 <= rv_f00_ssn_score AND rv_f00_ssn_score < 255 => 0.038741,
    255 <= rv_f00_ssn_score                            => 0,
                                                          0);

r_subscore3 := map(
    (rv_ever_asset_owner in [' ']) => 0,
    (rv_ever_asset_owner in ['0']) => -0.082602,
    (rv_ever_asset_owner in ['1']) => 0.260366,
                                      0);

r_subscore4 := map(
    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 0.050324,
    1 <= rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 2   => -0.34566,
    2 <= rv_i60_inq_comm_count12                                   => -0.482799,
                                                                      0);

r_subscore5 := map(
    (rv_p85_phn_not_issued in [' ']) => -0.077046,
    (rv_p85_phn_not_issued in ['0']) => 0.016095,
    (rv_p85_phn_not_issued in ['1']) => -1.023239,
                                        0);

r_subscore6 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 0 => -0.097319,
    0 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 1   => -0.08262,
    1 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 2   => 0.159338,
    2 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 4   => 0.125906,
    4 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 5   => -0.026992,
    5 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 6   => -0.031701,
    6 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 7   => -0.135451,
    7 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 10  => -0.274386,
    10 <= rv_l79_adls_per_sfd_addr                                   => -0.407361,
                                                                        0);

r_subscore7 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 80  => -0.136014,
    80 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100  => -0.075263,
    100 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 0.098356,
    255 <= rv_f01_inp_addr_address_score                                         => 0,
                                                                                    0);

r_subscore8 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 0.037296,
    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => -0.445165,
    3 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => -0.222013,
    6 <= rv_i60_inq_hiriskcred_recency                                         => -0.094265,
                                                                                  0);

r_subscore9 := map(
    (rv_d33_eviction_recency in [' '])        => 0,
    (rv_d33_eviction_recency in ['00'])       => 0.041285,
    (rv_d33_eviction_recency in ['03'])       => -0.324934,
    (rv_d33_eviction_recency in ['06', '12']) => -0.284889,
    (rv_d33_eviction_recency in ['24'])       => -0.281631,
    (rv_d33_eviction_recency in ['25'])       => -0.252506,
    (rv_d33_eviction_recency in ['36'])       => -0.235196,
    (rv_d33_eviction_recency in ['37'])       => -0.216557,
    (rv_d33_eviction_recency in ['60'])       => -0.160054,
    (rv_d33_eviction_recency in ['61', '98']) => -0.149835,
    (rv_d33_eviction_recency in ['99'])       => -0.122367,
                                                 0);

r_subscore10 := map(
    rv_f01_inp_add_house_num_match in [NULL] => 0,
    rv_f01_inp_add_house_num_match in [0] => -0.134693,
    rv_f01_inp_add_house_num_match in [1] => 0.064805,
                                                 0);

r_subscore11 := map(
    (rv_f03_address_match in [' '])                                                                                                    => 0,
    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => -0.100414,
    (rv_f03_address_match in ['4 INPUT=CURR'])                                                                                         => 0.078845,
                                                                                                                                          0);

r_subscore12 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1         => 0.015071,
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 29608       => -0.27809,
    29608 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 55780   => -0.023864,
    55780 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 78643   => 0.037828,
    78643 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 164350  => 0.063937,
    164350 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 219117 => 0.119332,
    219117 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 355183 => 0.027978,
    355183 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 607181 => -0.163657,
    607181 <= rv_l80_inp_avm_autoval                                     => -0.363823,
                                                                            0);

r_subscore13 := map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 1  => 0.198465,
    1 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 3    => -0.155621,
    3 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 4    => -0.264144,
    4 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 5    => -0.352238,
    5 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 9    => -0.356643,
    9 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 16   => -0.571237,
    16 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 143 => -0.59367,
    143 <= rv_p88_phn_dst_to_inp_add                                    => -0.852601,
                                                                           0);

r_subscore14 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2 => 0.03393,
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => -0.109187,
    3 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 4   => -0.250388,
    4 <= rv_i62_inq_phones_per_adl                                     => -0.494258,
                                                                          0);

r_subscore15 := map(
    NULL < rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 0 => -0.017633,
    0 <= rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 2   => 0.193075,
    2 <= rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 4   => 0.01364,
    4 <= rv_l79_adls_per_apt_addr                                    => -0.148276,
                                                                        0);

r_subscore16 := map(
    (rv_l70_add_standardized in [' '])                          => 0,
    (rv_l70_add_standardized in ['0 Address is Standard'])      => 0.046664,
    (rv_l70_add_standardized in ['1 Address was Standardized']) => -0.133945,
    (rv_l70_add_standardized in ['2 Standardization Error'])    => -0.154108,
                                                                   0);

r_subscore17 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 1 => -0.081369,
    1 <= rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2   => 0.064892,
    2 <= rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 3   => -0.107995,
    3 <= rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 4   => -0.368101,
    4 <= rv_i62_inq_ssns_per_adl                                   => -0.648189,
                                                                      0);

r_subscore18 := map(
    rv_f03_input_add_not_most_rec in [NULL ] => 0,
    rv_f03_input_add_not_most_rec in [0] => 0.029645,
    rv_f03_input_add_not_most_rec in [1] => -0.170273,
                                                0);

r_subscore19 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 0.044566,
    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2   => -0.020146,
    2 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 3   => -0.072624,
    3 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 4   => -0.131524,
    4 <= rv_l79_adls_per_addr_c6                                   => -0.139761,
                                                                      0);

r_subscore20 := map(
    (rv_e55_college_ind in [' ']) => 0,
    (rv_e55_college_ind in ['0']) => -0.018261,
    (rv_e55_college_ind in ['1']) => 0.203367,
                                     0);

r_subscore21 := map(
    NULL < rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 1 => 0.016643,
    1 <= rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 3   => -0.279952,
    3 <= rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 6   => -0.210561,
    6 <= rv_i60_inq_other_recency                                    => -0.061752,
                                                                        0);

r_subscore22 := map(
    rv_c22_inp_addr_occ_index in [NULL]                          => 0,
    rv_c22_inp_addr_occ_index in [0]                          => 0,
    rv_c22_inp_addr_occ_index in [1]                          => 0.040943,
    rv_c22_inp_addr_occ_index in [3, 4, 5, 6, 7, 8] => -0.047716,
                                                                     0);

r_subscore23 := map(
    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 0.008635,
    1 <= rv_i61_inq_collection_count12                                         => -0.20362,
                                                                                  0);

r_subscore24 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1 => -0.024836,
    1 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 2   => -0.020446,
    2 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 3   => 0.009971,
    3 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 4   => 0.019855,
    4 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 5   => 0.093993,
    5 <= rv_c12_inp_addr_source_count                                        => 0.189812,
                                                                                0);

r_subscore25 := map(
    rv_c22_inp_addr_owned_not_occ in [NULL] => 0,
    rv_c22_inp_addr_owned_not_occ in [0] => -0.003518,
    rv_c22_inp_addr_owned_not_occ in [1] => 0.482927,
                                                0);

r_subscore26 := map(
    rv_c19_add_prison_hist in [NULL] => 0,
    rv_c19_add_prison_hist in [0] => 0.003434,
    rv_c19_add_prison_hist in [1] => -0.505773,
                                         0);

r_subscore27 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1 => 0.02684,
    1 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 2   => 0.01933,
    2 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 3   => -0.024245,
    3 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 4   => -0.066166,
    4 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 5   => -0.069122,
    5 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 6   => -0.140518,
    6 <= rv_i62_inq_addrs_per_adl                                    => -0.185738,
                                                                        0);

r_subscore28 := map(
    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => -0.036465,
    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => -0.004501,
    3 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 4   => 0.051489,
    4 <= rv_c12_num_nonderogs                                => 0.069658,
                                                                0);

r_subscore29 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1 => -0.09297,
    1 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2   => -0.051081,
    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 10  => 0.02042,
    10 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 12 => 0.019242,
    12 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 15 => -0.03713,
    15 <= rv_c14_addrs_15yr                            => -0.18547,
                                                          0);

r_subscore30 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 0.01121,
    1 <= rv_c21_stl_inq_count                                => -0.103392,
                                                                0);

r_subscore31 := map(
    (rv_l72_add_curr_vacant in [' ']) => 0,
    (rv_l72_add_curr_vacant in ['0']) => 0.003708,
    (rv_l72_add_curr_vacant in ['1']) => -0.249711,
                                         0);

r_subscore32 := map(
    (rv_l71_add_business in [' ']) => 0,
    (rv_l71_add_business in ['0']) => 0.00429,
    (rv_l71_add_business in ['1']) => -0.081696,
                                      0);

r_subscore33 := map(
    rv_e57_prof_license_br_flag in [NULL] => 0,
    rv_e57_prof_license_br_flag in [0] => -0.005479,
    rv_e57_prof_license_br_flag in [1] => 0.051336,
                                              0);

r_rawscore := r_subscore0 +
    r_subscore1 +
    r_subscore2 +
    r_subscore3 +
    r_subscore4 +
    r_subscore5 +
    r_subscore6 +
    r_subscore7 +
    r_subscore8 +
    r_subscore9 +
    r_subscore10 +
    r_subscore11 +
    r_subscore12 +
    r_subscore13 +
    r_subscore14 +
    r_subscore15 +
    r_subscore16 +
    r_subscore17 +
    r_subscore18 +
    r_subscore19 +
    r_subscore20 +
    r_subscore21 +
    r_subscore22 +
    r_subscore23 +
    r_subscore24 +
    r_subscore25 +
    r_subscore26 +
    r_subscore27 +
    r_subscore28 +
    r_subscore29 +
    r_subscore30 +
    r_subscore31 +
    r_subscore32 +
    r_subscore33;

r_lnoddsscore := r_rawscore + 1.120666;

r_probscore := exp(r_lnoddsscore) / (1 + exp(r_lnoddsscore));

r_aacd_0 := map(
    (rv_d32_criminal_x_felony in [' '])                 => 'C12',
    (rv_d32_criminal_x_felony in ['0-0'])               => 'D32',
    (rv_d32_criminal_x_felony in ['1-0'])               => 'D32',
    (rv_d32_criminal_x_felony in ['2-0'])               => 'D32',
    (rv_d32_criminal_x_felony in ['3-0'])               => 'D32',
    (rv_d32_criminal_x_felony in ['1-1', '2-1', '3-1']) => 'D32',
    (rv_d32_criminal_x_felony in ['2-2', '3-2', '3-3']) => 'D32',
                                                           '');

r_dist_0 := r_subscore0 - 0.070497;

r_aacd_1 := map(
    NULL < rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 0   => 'C20',
    0 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 2     => 'C20',
    2 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 153   => 'C20',
    153 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 188 => 'C20',
    188 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 214 => 'C20',
    214 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 254 => 'C20',
    254 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 298 => 'C20',
    298 <= rv_c20_m_bureau_adl_fs AND rv_c20_m_bureau_adl_fs < 339 => 'C20',
    339 <= rv_c20_m_bureau_adl_fs                                  => 'C20',
                                                                      'C12');

r_dist_1 := r_subscore1 - 0.374836;

r_aacd_2 := map(
    NULL < rv_f00_ssn_score AND rv_f00_ssn_score < 90  => 'F00',
    90 <= rv_f00_ssn_score AND rv_f00_ssn_score < 100  => 'F00',
    100 <= rv_f00_ssn_score AND rv_f00_ssn_score < 255 => 'F00',
    255 <= rv_f00_ssn_score                            => 'F00',
                                                          if((integer)truedid = 0, 'C12', ''));

r_dist_2 := r_subscore2 - 0.038741;

r_aacd_3 := map(
    (rv_ever_asset_owner in [' ']) => 'C12',
    (rv_ever_asset_owner in ['0']) => 'A40',
    (rv_ever_asset_owner in ['1']) => 'A40',
                                      '');

r_dist_3 := r_subscore3 - 0.260366;

r_aacd_4 := map(
    NULL < rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 1 => 'I60',
    1 <= rv_i60_inq_comm_count12 AND rv_i60_inq_comm_count12 < 2   => 'I60',
    2 <= rv_i60_inq_comm_count12                                   => 'I60',
                                                                      'C12');

r_dist_4 := r_subscore4 - 0.050324;

r_aacd_5 := map(
    (rv_p85_phn_not_issued in [' ']) => '',
    (rv_p85_phn_not_issued in ['0']) => 'P85',
    (rv_p85_phn_not_issued in ['1']) => 'P85',
                                        '');

r_dist_5 := r_subscore5 - 0.016095;

r_aacd_6 := map(
    NULL < rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 0 => '',
    0 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 1   => '',
    1 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 2   => 'L79',
    2 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 4   => 'L79',
    4 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 5   => 'L79',
    5 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 6   => 'L79',
    6 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 7   => 'L79',
    7 <= rv_l79_adls_per_sfd_addr AND rv_l79_adls_per_sfd_addr < 10  => 'L79',
    10 <= rv_l79_adls_per_sfd_addr                                   => 'L79',
                                                                        '');

r_dist_6 := r_subscore6 - 0.159338;

r_aacd_7 := map(
    NULL < rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 80  => 'F01',
    80 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 100  => 'F01',
    100 <= rv_f01_inp_addr_address_score AND rv_f01_inp_addr_address_score < 255 => 'F01',
    255 <= rv_f01_inp_addr_address_score                                         => 'F01',
                                                                                    if((integer)truedid = 0, 'C12', ''));

r_dist_7 := r_subscore7 - 0.098356;

r_aacd_8 := map(
    NULL < rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 1 => 'I60',
    1 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 3   => 'I60',
    3 <= rv_i60_inq_hiriskcred_recency AND rv_i60_inq_hiriskcred_recency < 6   => 'I60',
    6 <= rv_i60_inq_hiriskcred_recency                                         => 'I60',
                                                                                  'C12');

r_dist_8 := r_subscore8 - 0.037296;

r_aacd_9 := map(
    (rv_d33_eviction_recency in [' '])        => 'C12',
    (rv_d33_eviction_recency in ['00'])       => 'D33',
    (rv_d33_eviction_recency in ['03'])       => 'D33',
    (rv_d33_eviction_recency in ['06', '12']) => 'D33',
    (rv_d33_eviction_recency in ['24'])       => 'D33',
    (rv_d33_eviction_recency in ['25'])       => 'D33',
    (rv_d33_eviction_recency in ['36'])       => 'D33',
    (rv_d33_eviction_recency in ['37'])       => 'D33',
    (rv_d33_eviction_recency in ['60'])       => 'D33',
    (rv_d33_eviction_recency in ['61', '98']) => 'D33',
    (rv_d33_eviction_recency in ['99'])       => 'D33',
                                                 '');

r_dist_9 := r_subscore9 - 0.041285;

r_aacd_10 := map(
    rv_f01_inp_add_house_num_match in [NULL] => if((integer)truedid = 0, 'C12', ''),
    rv_f01_inp_add_house_num_match in [0] => 'F01',
    rv_f01_inp_add_house_num_match in [1] => 'F01',
                                                 '');

r_dist_10 := r_subscore10 - 0.064805;

r_aacd_11 := map(
    (rv_f03_address_match in [' '])                                                                                                    => if((integer)truedid = 0, 'C12', ''),
    (rv_f03_address_match in ['0 INPUTPOP NOHISTAVAIL', '1 CURR ONHDRONLY', '2 CURRAVAIL + INPUTNOTCURR', '3 CURRAVAIL + NOINPUTPOP']) => 'F03',
    (rv_f03_address_match in ['4 INPUT=CURR'])                                                                                         => 'F03',
                                                                                                                                          '');

r_dist_11 := r_subscore11 - 0.078845;

r_aacd_12 := map(
    NULL < rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 1         => 'L80',
    1 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 29608       => 'L80',
    29608 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 55780   => 'L80',
    55780 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 78643   => 'L80',
    78643 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 164350  => 'L80',
    164350 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 219117 => 'L80',
    219117 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 355183 => '',
    355183 <= rv_l80_inp_avm_autoval AND rv_l80_inp_avm_autoval < 607181 => '',
    607181 <= rv_l80_inp_avm_autoval                                     => '',
                                                                            '');

r_dist_12 := r_subscore12 - 0.119332;

r_aacd_13 := map(
    NULL < rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 1  => 'P88',
    1 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 3    => 'P88',
    3 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 4    => 'P88',
    4 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 5    => 'P88',
    5 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 9    => 'P88',
    9 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 16   => 'P88',
    16 <= rv_p88_phn_dst_to_inp_add AND rv_p88_phn_dst_to_inp_add < 143 => 'P88',
    143 <= rv_p88_phn_dst_to_inp_add                                    => 'P88',
                                                                           '');

r_dist_13 := r_subscore13 - 0.198465;

r_aacd_14 := map(
    NULL < rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 2 => 'I62',
    2 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_phones_per_adl AND rv_i62_inq_phones_per_adl < 4   => 'I62',
    4 <= rv_i62_inq_phones_per_adl                                     => 'I62',
                                                                          'C12');

r_dist_14 := r_subscore14 - 0.03393;

r_aacd_15 := map(
    NULL < rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 0 => '',
    0 <= rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 2   => 'L79',
    2 <= rv_l79_adls_per_apt_addr AND rv_l79_adls_per_apt_addr < 4   => 'L79',
    4 <= rv_l79_adls_per_apt_addr                                    => 'L79',
                                                                        '');

r_dist_15 := r_subscore15 - 0.193075;

r_aacd_16 := map(
    (rv_l70_add_standardized in [' '])                          => '',
    (rv_l70_add_standardized in ['0 Address is Standard'])      => 'L70',
    (rv_l70_add_standardized in ['1 Address was Standardized']) => 'L70',
    (rv_l70_add_standardized in ['2 Standardization Error'])    => 'L70',
                                                                   '');

r_dist_16 := r_subscore16 - 0.046664;

r_aacd_17 := map(
    NULL < rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_ssns_per_adl AND rv_i62_inq_ssns_per_adl < 4   => 'I62',
    4 <= rv_i62_inq_ssns_per_adl                                   => 'I62',
                                                                      'C12');

r_dist_17 := r_subscore17 - 0.064892;

r_aacd_18 := map(
    rv_f03_input_add_not_most_rec in [NULL] => if((integer)truedid = 0, 'C12', ''),
    rv_f03_input_add_not_most_rec in [0] => 'F03',
    rv_f03_input_add_not_most_rec in [1] => 'F03',
                                                '');

r_dist_18 := r_subscore18 - 0.029645;

r_aacd_19 := map(
    NULL < rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 1 => 'L79',
    1 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 2   => 'L79',
    2 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 3   => 'L79',
    3 <= rv_l79_adls_per_addr_c6 AND rv_l79_adls_per_addr_c6 < 4   => 'L79',
    4 <= rv_l79_adls_per_addr_c6                                   => 'L79',
                                                                      '');

r_dist_19 := r_subscore19 - 0.044566;

r_aacd_20 := map(
    (rv_e55_college_ind in [' ']) => 'C12',
    (rv_e55_college_ind in ['0']) => 'E55',
    (rv_e55_college_ind in ['1']) => 'E55',
                                     '');

r_dist_20 := r_subscore20 - 0.203367;

r_aacd_21 := map(
    NULL < rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 1 => 'I60',
    1 <= rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 3   => 'I60',
    3 <= rv_i60_inq_other_recency AND rv_i60_inq_other_recency < 6   => 'I60',
    6 <= rv_i60_inq_other_recency                                    => 'I60',
                                                                        'C12');

r_dist_21 := r_subscore21 - 0.016643;

r_aacd_22 := map(
    rv_c22_inp_addr_occ_index in [NULL]                          => if((integer)truedid = 0, 'C12', ''),
    rv_c22_inp_addr_occ_index in [0]                          => '',
    rv_c22_inp_addr_occ_index in [1]                          => 'C22',
    rv_c22_inp_addr_occ_index in [3, 4, 5, 6, 7, 8] => 'C22',
                                                                     '');

r_dist_22 := r_subscore22 - 0.040943;

r_aacd_23 := map(
    NULL < rv_i61_inq_collection_count12 AND rv_i61_inq_collection_count12 < 1 => 'I61',
    1 <= rv_i61_inq_collection_count12                                         => 'I61',
                                                                                  'C12');

r_dist_23 := r_subscore23 - 0.008635;

r_aacd_24 := map(
    NULL < rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 1 => 'C12',
    1 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 2   => 'C12',
    2 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 3   => 'C12',
    3 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 4   => 'C12',
    4 <= rv_c12_inp_addr_source_count AND rv_c12_inp_addr_source_count < 5   => 'C12',
    5 <= rv_c12_inp_addr_source_count                                        => 'C12',
                                                                                if((integer)truedid = 0, 'C12', ''));

r_dist_24 := r_subscore24 - 0.189812;

r_aacd_25 := map(
    rv_c22_inp_addr_owned_not_occ in [NULL] => if((integer)truedid = 0, 'C12', ''),
    rv_c22_inp_addr_owned_not_occ in [0] => 'C22',
    rv_c22_inp_addr_owned_not_occ in [1] => 'C22',
                                                '');

r_dist_25 := r_subscore25 - 0.482927;

r_aacd_26 := map(
    rv_c19_add_prison_hist in [NULL] => 'C12',
    rv_c19_add_prison_hist in [0] => 'C19',
    rv_c19_add_prison_hist in [1] => 'C19',
                                         '');

r_dist_26 := r_subscore26 - 0.003434;

r_aacd_27 := map(
    NULL < rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 1 => 'I62',
    1 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 2   => 'I62',
    2 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 3   => 'I62',
    3 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 4   => 'I62',
    4 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 5   => 'I62',
    5 <= rv_i62_inq_addrs_per_adl AND rv_i62_inq_addrs_per_adl < 6   => 'I62',
    6 <= rv_i62_inq_addrs_per_adl                                    => 'I62',
                                                                        'C12');

r_dist_27 := r_subscore27 - 0.02684;

r_aacd_28 := map(
    NULL < rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 2 => 'C12',
    2 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 3   => 'C12',
    3 <= rv_c12_num_nonderogs AND rv_c12_num_nonderogs < 4   => 'C12',
    4 <= rv_c12_num_nonderogs                                => 'C12',
                                                                'C12');

r_dist_28 := r_subscore28 - 0.069658;

r_aacd_29 := map(
    NULL < rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 1 => '',
    1 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 2   => '',
    2 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 10  => 'C14',
    10 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 12 => 'C14',
    12 <= rv_c14_addrs_15yr AND rv_c14_addrs_15yr < 15 => 'C14',
    15 <= rv_c14_addrs_15yr                            => 'C14',
                                                          'C12');

r_dist_29 := r_subscore29 - 0.02042;

r_aacd_30 := map(
    NULL < rv_c21_stl_inq_count AND rv_c21_stl_inq_count < 1 => 'C21',
    1 <= rv_c21_stl_inq_count                                => 'C21',
                                                                'C12');

r_dist_30 := r_subscore30 - 0.01121;

r_aacd_31 := map(
    (rv_l72_add_curr_vacant in [' ']) => '',
    (rv_l72_add_curr_vacant in ['0']) => 'L72',
    (rv_l72_add_curr_vacant in ['1']) => 'L72',
                                         '');

r_dist_31 := r_subscore31 - 0.003708;

r_aacd_32 := map(
    (rv_l71_add_business in [' ']) => '',
    (rv_l71_add_business in ['0']) => 'L71',
    (rv_l71_add_business in ['1']) => 'L71',
                                      '');

r_dist_32 := r_subscore32 - 0.00429;

r_aacd_33 := map(
    rv_e57_prof_license_br_flag in [NULL] => 'C12',
    rv_e57_prof_license_br_flag in [0] => 'E57',
    rv_e57_prof_license_br_flag in [1] => 'E57',
                                              '');

r_dist_33 := r_subscore33 - 0.051336;

r_rcvaluel79 := (integer)(r_aacd_0 = 'L79') * r_dist_0 +
    (integer)(r_aacd_1 = 'L79') * r_dist_1 +
    (integer)(r_aacd_2 = 'L79') * r_dist_2 +
    (integer)(r_aacd_3 = 'L79') * r_dist_3 +
    (integer)(r_aacd_4 = 'L79') * r_dist_4 +
    (integer)(r_aacd_5 = 'L79') * r_dist_5 +
    (integer)(r_aacd_6 = 'L79') * r_dist_6 +
    (integer)(r_aacd_7 = 'L79') * r_dist_7 +
    (integer)(r_aacd_8 = 'L79') * r_dist_8 +
    (integer)(r_aacd_9 = 'L79') * r_dist_9 +
    (integer)(r_aacd_10 = 'L79') * r_dist_10 +
    (integer)(r_aacd_11 = 'L79') * r_dist_11 +
    (integer)(r_aacd_12 = 'L79') * r_dist_12 +
    (integer)(r_aacd_13 = 'L79') * r_dist_13 +
    (integer)(r_aacd_14 = 'L79') * r_dist_14 +
    (integer)(r_aacd_15 = 'L79') * r_dist_15 +
    (integer)(r_aacd_16 = 'L79') * r_dist_16 +
    (integer)(r_aacd_17 = 'L79') * r_dist_17 +
    (integer)(r_aacd_18 = 'L79') * r_dist_18 +
    (integer)(r_aacd_19 = 'L79') * r_dist_19 +
    (integer)(r_aacd_20 = 'L79') * r_dist_20 +
    (integer)(r_aacd_21 = 'L79') * r_dist_21 +
    (integer)(r_aacd_22 = 'L79') * r_dist_22 +
    (integer)(r_aacd_23 = 'L79') * r_dist_23 +
    (integer)(r_aacd_24 = 'L79') * r_dist_24 +
    (integer)(r_aacd_25 = 'L79') * r_dist_25 +
    (integer)(r_aacd_26 = 'L79') * r_dist_26 +
    (integer)(r_aacd_27 = 'L79') * r_dist_27 +
    (integer)(r_aacd_28 = 'L79') * r_dist_28 +
    (integer)(r_aacd_29 = 'L79') * r_dist_29 +
    (integer)(r_aacd_30 = 'L79') * r_dist_30 +
    (integer)(r_aacd_31 = 'L79') * r_dist_31 +
    (integer)(r_aacd_32 = 'L79') * r_dist_32 +
    (integer)(r_aacd_33 = 'L79') * r_dist_33;

r_rcvaluel72 := (integer)(r_aacd_0 = 'L72') * r_dist_0 +
    (integer)(r_aacd_1 = 'L72') * r_dist_1 +
    (integer)(r_aacd_2 = 'L72') * r_dist_2 +
    (integer)(r_aacd_3 = 'L72') * r_dist_3 +
    (integer)(r_aacd_4 = 'L72') * r_dist_4 +
    (integer)(r_aacd_5 = 'L72') * r_dist_5 +
    (integer)(r_aacd_6 = 'L72') * r_dist_6 +
    (integer)(r_aacd_7 = 'L72') * r_dist_7 +
    (integer)(r_aacd_8 = 'L72') * r_dist_8 +
    (integer)(r_aacd_9 = 'L72') * r_dist_9 +
    (integer)(r_aacd_10 = 'L72') * r_dist_10 +
    (integer)(r_aacd_11 = 'L72') * r_dist_11 +
    (integer)(r_aacd_12 = 'L72') * r_dist_12 +
    (integer)(r_aacd_13 = 'L72') * r_dist_13 +
    (integer)(r_aacd_14 = 'L72') * r_dist_14 +
    (integer)(r_aacd_15 = 'L72') * r_dist_15 +
    (integer)(r_aacd_16 = 'L72') * r_dist_16 +
    (integer)(r_aacd_17 = 'L72') * r_dist_17 +
    (integer)(r_aacd_18 = 'L72') * r_dist_18 +
    (integer)(r_aacd_19 = 'L72') * r_dist_19 +
    (integer)(r_aacd_20 = 'L72') * r_dist_20 +
    (integer)(r_aacd_21 = 'L72') * r_dist_21 +
    (integer)(r_aacd_22 = 'L72') * r_dist_22 +
    (integer)(r_aacd_23 = 'L72') * r_dist_23 +
    (integer)(r_aacd_24 = 'L72') * r_dist_24 +
    (integer)(r_aacd_25 = 'L72') * r_dist_25 +
    (integer)(r_aacd_26 = 'L72') * r_dist_26 +
    (integer)(r_aacd_27 = 'L72') * r_dist_27 +
    (integer)(r_aacd_28 = 'L72') * r_dist_28 +
    (integer)(r_aacd_29 = 'L72') * r_dist_29 +
    (integer)(r_aacd_30 = 'L72') * r_dist_30 +
    (integer)(r_aacd_31 = 'L72') * r_dist_31 +
    (integer)(r_aacd_32 = 'L72') * r_dist_32 +
    (integer)(r_aacd_33 = 'L72') * r_dist_33;

r_rcvaluel70 := (integer)(r_aacd_0 = 'L70') * r_dist_0 +
    (integer)(r_aacd_1 = 'L70') * r_dist_1 +
    (integer)(r_aacd_2 = 'L70') * r_dist_2 +
    (integer)(r_aacd_3 = 'L70') * r_dist_3 +
    (integer)(r_aacd_4 = 'L70') * r_dist_4 +
    (integer)(r_aacd_5 = 'L70') * r_dist_5 +
    (integer)(r_aacd_6 = 'L70') * r_dist_6 +
    (integer)(r_aacd_7 = 'L70') * r_dist_7 +
    (integer)(r_aacd_8 = 'L70') * r_dist_8 +
    (integer)(r_aacd_9 = 'L70') * r_dist_9 +
    (integer)(r_aacd_10 = 'L70') * r_dist_10 +
    (integer)(r_aacd_11 = 'L70') * r_dist_11 +
    (integer)(r_aacd_12 = 'L70') * r_dist_12 +
    (integer)(r_aacd_13 = 'L70') * r_dist_13 +
    (integer)(r_aacd_14 = 'L70') * r_dist_14 +
    (integer)(r_aacd_15 = 'L70') * r_dist_15 +
    (integer)(r_aacd_16 = 'L70') * r_dist_16 +
    (integer)(r_aacd_17 = 'L70') * r_dist_17 +
    (integer)(r_aacd_18 = 'L70') * r_dist_18 +
    (integer)(r_aacd_19 = 'L70') * r_dist_19 +
    (integer)(r_aacd_20 = 'L70') * r_dist_20 +
    (integer)(r_aacd_21 = 'L70') * r_dist_21 +
    (integer)(r_aacd_22 = 'L70') * r_dist_22 +
    (integer)(r_aacd_23 = 'L70') * r_dist_23 +
    (integer)(r_aacd_24 = 'L70') * r_dist_24 +
    (integer)(r_aacd_25 = 'L70') * r_dist_25 +
    (integer)(r_aacd_26 = 'L70') * r_dist_26 +
    (integer)(r_aacd_27 = 'L70') * r_dist_27 +
    (integer)(r_aacd_28 = 'L70') * r_dist_28 +
    (integer)(r_aacd_29 = 'L70') * r_dist_29 +
    (integer)(r_aacd_30 = 'L70') * r_dist_30 +
    (integer)(r_aacd_31 = 'L70') * r_dist_31 +
    (integer)(r_aacd_32 = 'L70') * r_dist_32 +
    (integer)(r_aacd_33 = 'L70') * r_dist_33;

r_rcvaluel71 := (integer)(r_aacd_0 = 'L71') * r_dist_0 +
    (integer)(r_aacd_1 = 'L71') * r_dist_1 +
    (integer)(r_aacd_2 = 'L71') * r_dist_2 +
    (integer)(r_aacd_3 = 'L71') * r_dist_3 +
    (integer)(r_aacd_4 = 'L71') * r_dist_4 +
    (integer)(r_aacd_5 = 'L71') * r_dist_5 +
    (integer)(r_aacd_6 = 'L71') * r_dist_6 +
    (integer)(r_aacd_7 = 'L71') * r_dist_7 +
    (integer)(r_aacd_8 = 'L71') * r_dist_8 +
    (integer)(r_aacd_9 = 'L71') * r_dist_9 +
    (integer)(r_aacd_10 = 'L71') * r_dist_10 +
    (integer)(r_aacd_11 = 'L71') * r_dist_11 +
    (integer)(r_aacd_12 = 'L71') * r_dist_12 +
    (integer)(r_aacd_13 = 'L71') * r_dist_13 +
    (integer)(r_aacd_14 = 'L71') * r_dist_14 +
    (integer)(r_aacd_15 = 'L71') * r_dist_15 +
    (integer)(r_aacd_16 = 'L71') * r_dist_16 +
    (integer)(r_aacd_17 = 'L71') * r_dist_17 +
    (integer)(r_aacd_18 = 'L71') * r_dist_18 +
    (integer)(r_aacd_19 = 'L71') * r_dist_19 +
    (integer)(r_aacd_20 = 'L71') * r_dist_20 +
    (integer)(r_aacd_21 = 'L71') * r_dist_21 +
    (integer)(r_aacd_22 = 'L71') * r_dist_22 +
    (integer)(r_aacd_23 = 'L71') * r_dist_23 +
    (integer)(r_aacd_24 = 'L71') * r_dist_24 +
    (integer)(r_aacd_25 = 'L71') * r_dist_25 +
    (integer)(r_aacd_26 = 'L71') * r_dist_26 +
    (integer)(r_aacd_27 = 'L71') * r_dist_27 +
    (integer)(r_aacd_28 = 'L71') * r_dist_28 +
    (integer)(r_aacd_29 = 'L71') * r_dist_29 +
    (integer)(r_aacd_30 = 'L71') * r_dist_30 +
    (integer)(r_aacd_31 = 'L71') * r_dist_31 +
    (integer)(r_aacd_32 = 'L71') * r_dist_32 +
    (integer)(r_aacd_33 = 'L71') * r_dist_33;

r_rcvalued32 := (integer)(r_aacd_0 = 'D32') * r_dist_0 +
    (integer)(r_aacd_1 = 'D32') * r_dist_1 +
    (integer)(r_aacd_2 = 'D32') * r_dist_2 +
    (integer)(r_aacd_3 = 'D32') * r_dist_3 +
    (integer)(r_aacd_4 = 'D32') * r_dist_4 +
    (integer)(r_aacd_5 = 'D32') * r_dist_5 +
    (integer)(r_aacd_6 = 'D32') * r_dist_6 +
    (integer)(r_aacd_7 = 'D32') * r_dist_7 +
    (integer)(r_aacd_8 = 'D32') * r_dist_8 +
    (integer)(r_aacd_9 = 'D32') * r_dist_9 +
    (integer)(r_aacd_10 = 'D32') * r_dist_10 +
    (integer)(r_aacd_11 = 'D32') * r_dist_11 +
    (integer)(r_aacd_12 = 'D32') * r_dist_12 +
    (integer)(r_aacd_13 = 'D32') * r_dist_13 +
    (integer)(r_aacd_14 = 'D32') * r_dist_14 +
    (integer)(r_aacd_15 = 'D32') * r_dist_15 +
    (integer)(r_aacd_16 = 'D32') * r_dist_16 +
    (integer)(r_aacd_17 = 'D32') * r_dist_17 +
    (integer)(r_aacd_18 = 'D32') * r_dist_18 +
    (integer)(r_aacd_19 = 'D32') * r_dist_19 +
    (integer)(r_aacd_20 = 'D32') * r_dist_20 +
    (integer)(r_aacd_21 = 'D32') * r_dist_21 +
    (integer)(r_aacd_22 = 'D32') * r_dist_22 +
    (integer)(r_aacd_23 = 'D32') * r_dist_23 +
    (integer)(r_aacd_24 = 'D32') * r_dist_24 +
    (integer)(r_aacd_25 = 'D32') * r_dist_25 +
    (integer)(r_aacd_26 = 'D32') * r_dist_26 +
    (integer)(r_aacd_27 = 'D32') * r_dist_27 +
    (integer)(r_aacd_28 = 'D32') * r_dist_28 +
    (integer)(r_aacd_29 = 'D32') * r_dist_29 +
    (integer)(r_aacd_30 = 'D32') * r_dist_30 +
    (integer)(r_aacd_31 = 'D32') * r_dist_31 +
    (integer)(r_aacd_32 = 'D32') * r_dist_32 +
    (integer)(r_aacd_33 = 'D32') * r_dist_33;

r_rcvalued33 := (integer)(r_aacd_0 = 'D33') * r_dist_0 +
    (integer)(r_aacd_1 = 'D33') * r_dist_1 +
    (integer)(r_aacd_2 = 'D33') * r_dist_2 +
    (integer)(r_aacd_3 = 'D33') * r_dist_3 +
    (integer)(r_aacd_4 = 'D33') * r_dist_4 +
    (integer)(r_aacd_5 = 'D33') * r_dist_5 +
    (integer)(r_aacd_6 = 'D33') * r_dist_6 +
    (integer)(r_aacd_7 = 'D33') * r_dist_7 +
    (integer)(r_aacd_8 = 'D33') * r_dist_8 +
    (integer)(r_aacd_9 = 'D33') * r_dist_9 +
    (integer)(r_aacd_10 = 'D33') * r_dist_10 +
    (integer)(r_aacd_11 = 'D33') * r_dist_11 +
    (integer)(r_aacd_12 = 'D33') * r_dist_12 +
    (integer)(r_aacd_13 = 'D33') * r_dist_13 +
    (integer)(r_aacd_14 = 'D33') * r_dist_14 +
    (integer)(r_aacd_15 = 'D33') * r_dist_15 +
    (integer)(r_aacd_16 = 'D33') * r_dist_16 +
    (integer)(r_aacd_17 = 'D33') * r_dist_17 +
    (integer)(r_aacd_18 = 'D33') * r_dist_18 +
    (integer)(r_aacd_19 = 'D33') * r_dist_19 +
    (integer)(r_aacd_20 = 'D33') * r_dist_20 +
    (integer)(r_aacd_21 = 'D33') * r_dist_21 +
    (integer)(r_aacd_22 = 'D33') * r_dist_22 +
    (integer)(r_aacd_23 = 'D33') * r_dist_23 +
    (integer)(r_aacd_24 = 'D33') * r_dist_24 +
    (integer)(r_aacd_25 = 'D33') * r_dist_25 +
    (integer)(r_aacd_26 = 'D33') * r_dist_26 +
    (integer)(r_aacd_27 = 'D33') * r_dist_27 +
    (integer)(r_aacd_28 = 'D33') * r_dist_28 +
    (integer)(r_aacd_29 = 'D33') * r_dist_29 +
    (integer)(r_aacd_30 = 'D33') * r_dist_30 +
    (integer)(r_aacd_31 = 'D33') * r_dist_31 +
    (integer)(r_aacd_32 = 'D33') * r_dist_32 +
    (integer)(r_aacd_33 = 'D33') * r_dist_33;

r_rcvaluec19 := (integer)(r_aacd_0 = 'C19') * r_dist_0 +
    (integer)(r_aacd_1 = 'C19') * r_dist_1 +
    (integer)(r_aacd_2 = 'C19') * r_dist_2 +
    (integer)(r_aacd_3 = 'C19') * r_dist_3 +
    (integer)(r_aacd_4 = 'C19') * r_dist_4 +
    (integer)(r_aacd_5 = 'C19') * r_dist_5 +
    (integer)(r_aacd_6 = 'C19') * r_dist_6 +
    (integer)(r_aacd_7 = 'C19') * r_dist_7 +
    (integer)(r_aacd_8 = 'C19') * r_dist_8 +
    (integer)(r_aacd_9 = 'C19') * r_dist_9 +
    (integer)(r_aacd_10 = 'C19') * r_dist_10 +
    (integer)(r_aacd_11 = 'C19') * r_dist_11 +
    (integer)(r_aacd_12 = 'C19') * r_dist_12 +
    (integer)(r_aacd_13 = 'C19') * r_dist_13 +
    (integer)(r_aacd_14 = 'C19') * r_dist_14 +
    (integer)(r_aacd_15 = 'C19') * r_dist_15 +
    (integer)(r_aacd_16 = 'C19') * r_dist_16 +
    (integer)(r_aacd_17 = 'C19') * r_dist_17 +
    (integer)(r_aacd_18 = 'C19') * r_dist_18 +
    (integer)(r_aacd_19 = 'C19') * r_dist_19 +
    (integer)(r_aacd_20 = 'C19') * r_dist_20 +
    (integer)(r_aacd_21 = 'C19') * r_dist_21 +
    (integer)(r_aacd_22 = 'C19') * r_dist_22 +
    (integer)(r_aacd_23 = 'C19') * r_dist_23 +
    (integer)(r_aacd_24 = 'C19') * r_dist_24 +
    (integer)(r_aacd_25 = 'C19') * r_dist_25 +
    (integer)(r_aacd_26 = 'C19') * r_dist_26 +
    (integer)(r_aacd_27 = 'C19') * r_dist_27 +
    (integer)(r_aacd_28 = 'C19') * r_dist_28 +
    (integer)(r_aacd_29 = 'C19') * r_dist_29 +
    (integer)(r_aacd_30 = 'C19') * r_dist_30 +
    (integer)(r_aacd_31 = 'C19') * r_dist_31 +
    (integer)(r_aacd_32 = 'C19') * r_dist_32 +
    (integer)(r_aacd_33 = 'C19') * r_dist_33;

r_rcvaluef01 := (integer)(r_aacd_0 = 'F01') * r_dist_0 +
    (integer)(r_aacd_1 = 'F01') * r_dist_1 +
    (integer)(r_aacd_2 = 'F01') * r_dist_2 +
    (integer)(r_aacd_3 = 'F01') * r_dist_3 +
    (integer)(r_aacd_4 = 'F01') * r_dist_4 +
    (integer)(r_aacd_5 = 'F01') * r_dist_5 +
    (integer)(r_aacd_6 = 'F01') * r_dist_6 +
    (integer)(r_aacd_7 = 'F01') * r_dist_7 +
    (integer)(r_aacd_8 = 'F01') * r_dist_8 +
    (integer)(r_aacd_9 = 'F01') * r_dist_9 +
    (integer)(r_aacd_10 = 'F01') * r_dist_10 +
    (integer)(r_aacd_11 = 'F01') * r_dist_11 +
    (integer)(r_aacd_12 = 'F01') * r_dist_12 +
    (integer)(r_aacd_13 = 'F01') * r_dist_13 +
    (integer)(r_aacd_14 = 'F01') * r_dist_14 +
    (integer)(r_aacd_15 = 'F01') * r_dist_15 +
    (integer)(r_aacd_16 = 'F01') * r_dist_16 +
    (integer)(r_aacd_17 = 'F01') * r_dist_17 +
    (integer)(r_aacd_18 = 'F01') * r_dist_18 +
    (integer)(r_aacd_19 = 'F01') * r_dist_19 +
    (integer)(r_aacd_20 = 'F01') * r_dist_20 +
    (integer)(r_aacd_21 = 'F01') * r_dist_21 +
    (integer)(r_aacd_22 = 'F01') * r_dist_22 +
    (integer)(r_aacd_23 = 'F01') * r_dist_23 +
    (integer)(r_aacd_24 = 'F01') * r_dist_24 +
    (integer)(r_aacd_25 = 'F01') * r_dist_25 +
    (integer)(r_aacd_26 = 'F01') * r_dist_26 +
    (integer)(r_aacd_27 = 'F01') * r_dist_27 +
    (integer)(r_aacd_28 = 'F01') * r_dist_28 +
    (integer)(r_aacd_29 = 'F01') * r_dist_29 +
    (integer)(r_aacd_30 = 'F01') * r_dist_30 +
    (integer)(r_aacd_31 = 'F01') * r_dist_31 +
    (integer)(r_aacd_32 = 'F01') * r_dist_32 +
    (integer)(r_aacd_33 = 'F01') * r_dist_33;

r_rcvaluef00 := (integer)(r_aacd_0 = 'F00') * r_dist_0 +
    (integer)(r_aacd_1 = 'F00') * r_dist_1 +
    (integer)(r_aacd_2 = 'F00') * r_dist_2 +
    (integer)(r_aacd_3 = 'F00') * r_dist_3 +
    (integer)(r_aacd_4 = 'F00') * r_dist_4 +
    (integer)(r_aacd_5 = 'F00') * r_dist_5 +
    (integer)(r_aacd_6 = 'F00') * r_dist_6 +
    (integer)(r_aacd_7 = 'F00') * r_dist_7 +
    (integer)(r_aacd_8 = 'F00') * r_dist_8 +
    (integer)(r_aacd_9 = 'F00') * r_dist_9 +
    (integer)(r_aacd_10 = 'F00') * r_dist_10 +
    (integer)(r_aacd_11 = 'F00') * r_dist_11 +
    (integer)(r_aacd_12 = 'F00') * r_dist_12 +
    (integer)(r_aacd_13 = 'F00') * r_dist_13 +
    (integer)(r_aacd_14 = 'F00') * r_dist_14 +
    (integer)(r_aacd_15 = 'F00') * r_dist_15 +
    (integer)(r_aacd_16 = 'F00') * r_dist_16 +
    (integer)(r_aacd_17 = 'F00') * r_dist_17 +
    (integer)(r_aacd_18 = 'F00') * r_dist_18 +
    (integer)(r_aacd_19 = 'F00') * r_dist_19 +
    (integer)(r_aacd_20 = 'F00') * r_dist_20 +
    (integer)(r_aacd_21 = 'F00') * r_dist_21 +
    (integer)(r_aacd_22 = 'F00') * r_dist_22 +
    (integer)(r_aacd_23 = 'F00') * r_dist_23 +
    (integer)(r_aacd_24 = 'F00') * r_dist_24 +
    (integer)(r_aacd_25 = 'F00') * r_dist_25 +
    (integer)(r_aacd_26 = 'F00') * r_dist_26 +
    (integer)(r_aacd_27 = 'F00') * r_dist_27 +
    (integer)(r_aacd_28 = 'F00') * r_dist_28 +
    (integer)(r_aacd_29 = 'F00') * r_dist_29 +
    (integer)(r_aacd_30 = 'F00') * r_dist_30 +
    (integer)(r_aacd_31 = 'F00') * r_dist_31 +
    (integer)(r_aacd_32 = 'F00') * r_dist_32 +
    (integer)(r_aacd_33 = 'F00') * r_dist_33;

r_rcvaluef03 := (integer)(r_aacd_0 = 'F03') * r_dist_0 +
    (integer)(r_aacd_1 = 'F03') * r_dist_1 +
    (integer)(r_aacd_2 = 'F03') * r_dist_2 +
    (integer)(r_aacd_3 = 'F03') * r_dist_3 +
    (integer)(r_aacd_4 = 'F03') * r_dist_4 +
    (integer)(r_aacd_5 = 'F03') * r_dist_5 +
    (integer)(r_aacd_6 = 'F03') * r_dist_6 +
    (integer)(r_aacd_7 = 'F03') * r_dist_7 +
    (integer)(r_aacd_8 = 'F03') * r_dist_8 +
    (integer)(r_aacd_9 = 'F03') * r_dist_9 +
    (integer)(r_aacd_10 = 'F03') * r_dist_10 +
    (integer)(r_aacd_11 = 'F03') * r_dist_11 +
    (integer)(r_aacd_12 = 'F03') * r_dist_12 +
    (integer)(r_aacd_13 = 'F03') * r_dist_13 +
    (integer)(r_aacd_14 = 'F03') * r_dist_14 +
    (integer)(r_aacd_15 = 'F03') * r_dist_15 +
    (integer)(r_aacd_16 = 'F03') * r_dist_16 +
    (integer)(r_aacd_17 = 'F03') * r_dist_17 +
    (integer)(r_aacd_18 = 'F03') * r_dist_18 +
    (integer)(r_aacd_19 = 'F03') * r_dist_19 +
    (integer)(r_aacd_20 = 'F03') * r_dist_20 +
    (integer)(r_aacd_21 = 'F03') * r_dist_21 +
    (integer)(r_aacd_22 = 'F03') * r_dist_22 +
    (integer)(r_aacd_23 = 'F03') * r_dist_23 +
    (integer)(r_aacd_24 = 'F03') * r_dist_24 +
    (integer)(r_aacd_25 = 'F03') * r_dist_25 +
    (integer)(r_aacd_26 = 'F03') * r_dist_26 +
    (integer)(r_aacd_27 = 'F03') * r_dist_27 +
    (integer)(r_aacd_28 = 'F03') * r_dist_28 +
    (integer)(r_aacd_29 = 'F03') * r_dist_29 +
    (integer)(r_aacd_30 = 'F03') * r_dist_30 +
    (integer)(r_aacd_31 = 'F03') * r_dist_31 +
    (integer)(r_aacd_32 = 'F03') * r_dist_32 +
    (integer)(r_aacd_33 = 'F03') * r_dist_33;

r_rcvaluee55 := (integer)(r_aacd_0 = 'E55') * r_dist_0 +
    (integer)(r_aacd_1 = 'E55') * r_dist_1 +
    (integer)(r_aacd_2 = 'E55') * r_dist_2 +
    (integer)(r_aacd_3 = 'E55') * r_dist_3 +
    (integer)(r_aacd_4 = 'E55') * r_dist_4 +
    (integer)(r_aacd_5 = 'E55') * r_dist_5 +
    (integer)(r_aacd_6 = 'E55') * r_dist_6 +
    (integer)(r_aacd_7 = 'E55') * r_dist_7 +
    (integer)(r_aacd_8 = 'E55') * r_dist_8 +
    (integer)(r_aacd_9 = 'E55') * r_dist_9 +
    (integer)(r_aacd_10 = 'E55') * r_dist_10 +
    (integer)(r_aacd_11 = 'E55') * r_dist_11 +
    (integer)(r_aacd_12 = 'E55') * r_dist_12 +
    (integer)(r_aacd_13 = 'E55') * r_dist_13 +
    (integer)(r_aacd_14 = 'E55') * r_dist_14 +
    (integer)(r_aacd_15 = 'E55') * r_dist_15 +
    (integer)(r_aacd_16 = 'E55') * r_dist_16 +
    (integer)(r_aacd_17 = 'E55') * r_dist_17 +
    (integer)(r_aacd_18 = 'E55') * r_dist_18 +
    (integer)(r_aacd_19 = 'E55') * r_dist_19 +
    (integer)(r_aacd_20 = 'E55') * r_dist_20 +
    (integer)(r_aacd_21 = 'E55') * r_dist_21 +
    (integer)(r_aacd_22 = 'E55') * r_dist_22 +
    (integer)(r_aacd_23 = 'E55') * r_dist_23 +
    (integer)(r_aacd_24 = 'E55') * r_dist_24 +
    (integer)(r_aacd_25 = 'E55') * r_dist_25 +
    (integer)(r_aacd_26 = 'E55') * r_dist_26 +
    (integer)(r_aacd_27 = 'E55') * r_dist_27 +
    (integer)(r_aacd_28 = 'E55') * r_dist_28 +
    (integer)(r_aacd_29 = 'E55') * r_dist_29 +
    (integer)(r_aacd_30 = 'E55') * r_dist_30 +
    (integer)(r_aacd_31 = 'E55') * r_dist_31 +
    (integer)(r_aacd_32 = 'E55') * r_dist_32 +
    (integer)(r_aacd_33 = 'E55') * r_dist_33;

r_rcvaluec12 := (integer)(r_aacd_0 = 'C12') * r_dist_0 +
    (integer)(r_aacd_1 = 'C12') * r_dist_1 +
    (integer)(r_aacd_2 = 'C12') * r_dist_2 +
    (integer)(r_aacd_3 = 'C12') * r_dist_3 +
    (integer)(r_aacd_4 = 'C12') * r_dist_4 +
    (integer)(r_aacd_5 = 'C12') * r_dist_5 +
    (integer)(r_aacd_6 = 'C12') * r_dist_6 +
    (integer)(r_aacd_7 = 'C12') * r_dist_7 +
    (integer)(r_aacd_8 = 'C12') * r_dist_8 +
    (integer)(r_aacd_9 = 'C12') * r_dist_9 +
    (integer)(r_aacd_10 = 'C12') * r_dist_10 +
    (integer)(r_aacd_11 = 'C12') * r_dist_11 +
    (integer)(r_aacd_12 = 'C12') * r_dist_12 +
    (integer)(r_aacd_13 = 'C12') * r_dist_13 +
    (integer)(r_aacd_14 = 'C12') * r_dist_14 +
    (integer)(r_aacd_15 = 'C12') * r_dist_15 +
    (integer)(r_aacd_16 = 'C12') * r_dist_16 +
    (integer)(r_aacd_17 = 'C12') * r_dist_17 +
    (integer)(r_aacd_18 = 'C12') * r_dist_18 +
    (integer)(r_aacd_19 = 'C12') * r_dist_19 +
    (integer)(r_aacd_20 = 'C12') * r_dist_20 +
    (integer)(r_aacd_21 = 'C12') * r_dist_21 +
    (integer)(r_aacd_22 = 'C12') * r_dist_22 +
    (integer)(r_aacd_23 = 'C12') * r_dist_23 +
    (integer)(r_aacd_24 = 'C12') * r_dist_24 +
    (integer)(r_aacd_25 = 'C12') * r_dist_25 +
    (integer)(r_aacd_26 = 'C12') * r_dist_26 +
    (integer)(r_aacd_27 = 'C12') * r_dist_27 +
    (integer)(r_aacd_28 = 'C12') * r_dist_28 +
    (integer)(r_aacd_29 = 'C12') * r_dist_29 +
    (integer)(r_aacd_30 = 'C12') * r_dist_30 +
    (integer)(r_aacd_31 = 'C12') * r_dist_31 +
    (integer)(r_aacd_32 = 'C12') * r_dist_32 +
    (integer)(r_aacd_33 = 'C12') * r_dist_33;

r_rcvaluee57 := (integer)(r_aacd_0 = 'E57') * r_dist_0 +
    (integer)(r_aacd_1 = 'E57') * r_dist_1 +
    (integer)(r_aacd_2 = 'E57') * r_dist_2 +
    (integer)(r_aacd_3 = 'E57') * r_dist_3 +
    (integer)(r_aacd_4 = 'E57') * r_dist_4 +
    (integer)(r_aacd_5 = 'E57') * r_dist_5 +
    (integer)(r_aacd_6 = 'E57') * r_dist_6 +
    (integer)(r_aacd_7 = 'E57') * r_dist_7 +
    (integer)(r_aacd_8 = 'E57') * r_dist_8 +
    (integer)(r_aacd_9 = 'E57') * r_dist_9 +
    (integer)(r_aacd_10 = 'E57') * r_dist_10 +
    (integer)(r_aacd_11 = 'E57') * r_dist_11 +
    (integer)(r_aacd_12 = 'E57') * r_dist_12 +
    (integer)(r_aacd_13 = 'E57') * r_dist_13 +
    (integer)(r_aacd_14 = 'E57') * r_dist_14 +
    (integer)(r_aacd_15 = 'E57') * r_dist_15 +
    (integer)(r_aacd_16 = 'E57') * r_dist_16 +
    (integer)(r_aacd_17 = 'E57') * r_dist_17 +
    (integer)(r_aacd_18 = 'E57') * r_dist_18 +
    (integer)(r_aacd_19 = 'E57') * r_dist_19 +
    (integer)(r_aacd_20 = 'E57') * r_dist_20 +
    (integer)(r_aacd_21 = 'E57') * r_dist_21 +
    (integer)(r_aacd_22 = 'E57') * r_dist_22 +
    (integer)(r_aacd_23 = 'E57') * r_dist_23 +
    (integer)(r_aacd_24 = 'E57') * r_dist_24 +
    (integer)(r_aacd_25 = 'E57') * r_dist_25 +
    (integer)(r_aacd_26 = 'E57') * r_dist_26 +
    (integer)(r_aacd_27 = 'E57') * r_dist_27 +
    (integer)(r_aacd_28 = 'E57') * r_dist_28 +
    (integer)(r_aacd_29 = 'E57') * r_dist_29 +
    (integer)(r_aacd_30 = 'E57') * r_dist_30 +
    (integer)(r_aacd_31 = 'E57') * r_dist_31 +
    (integer)(r_aacd_32 = 'E57') * r_dist_32 +
    (integer)(r_aacd_33 = 'E57') * r_dist_33;

r_rcvaluec14 := (integer)(r_aacd_0 = 'C14') * r_dist_0 +
    (integer)(r_aacd_1 = 'C14') * r_dist_1 +
    (integer)(r_aacd_2 = 'C14') * r_dist_2 +
    (integer)(r_aacd_3 = 'C14') * r_dist_3 +
    (integer)(r_aacd_4 = 'C14') * r_dist_4 +
    (integer)(r_aacd_5 = 'C14') * r_dist_5 +
    (integer)(r_aacd_6 = 'C14') * r_dist_6 +
    (integer)(r_aacd_7 = 'C14') * r_dist_7 +
    (integer)(r_aacd_8 = 'C14') * r_dist_8 +
    (integer)(r_aacd_9 = 'C14') * r_dist_9 +
    (integer)(r_aacd_10 = 'C14') * r_dist_10 +
    (integer)(r_aacd_11 = 'C14') * r_dist_11 +
    (integer)(r_aacd_12 = 'C14') * r_dist_12 +
    (integer)(r_aacd_13 = 'C14') * r_dist_13 +
    (integer)(r_aacd_14 = 'C14') * r_dist_14 +
    (integer)(r_aacd_15 = 'C14') * r_dist_15 +
    (integer)(r_aacd_16 = 'C14') * r_dist_16 +
    (integer)(r_aacd_17 = 'C14') * r_dist_17 +
    (integer)(r_aacd_18 = 'C14') * r_dist_18 +
    (integer)(r_aacd_19 = 'C14') * r_dist_19 +
    (integer)(r_aacd_20 = 'C14') * r_dist_20 +
    (integer)(r_aacd_21 = 'C14') * r_dist_21 +
    (integer)(r_aacd_22 = 'C14') * r_dist_22 +
    (integer)(r_aacd_23 = 'C14') * r_dist_23 +
    (integer)(r_aacd_24 = 'C14') * r_dist_24 +
    (integer)(r_aacd_25 = 'C14') * r_dist_25 +
    (integer)(r_aacd_26 = 'C14') * r_dist_26 +
    (integer)(r_aacd_27 = 'C14') * r_dist_27 +
    (integer)(r_aacd_28 = 'C14') * r_dist_28 +
    (integer)(r_aacd_29 = 'C14') * r_dist_29 +
    (integer)(r_aacd_30 = 'C14') * r_dist_30 +
    (integer)(r_aacd_31 = 'C14') * r_dist_31 +
    (integer)(r_aacd_32 = 'C14') * r_dist_32 +
    (integer)(r_aacd_33 = 'C14') * r_dist_33;

r_rcvaluel80 := (integer)(r_aacd_0 = 'L80') * r_dist_0 +
    (integer)(r_aacd_1 = 'L80') * r_dist_1 +
    (integer)(r_aacd_2 = 'L80') * r_dist_2 +
    (integer)(r_aacd_3 = 'L80') * r_dist_3 +
    (integer)(r_aacd_4 = 'L80') * r_dist_4 +
    (integer)(r_aacd_5 = 'L80') * r_dist_5 +
    (integer)(r_aacd_6 = 'L80') * r_dist_6 +
    (integer)(r_aacd_7 = 'L80') * r_dist_7 +
    (integer)(r_aacd_8 = 'L80') * r_dist_8 +
    (integer)(r_aacd_9 = 'L80') * r_dist_9 +
    (integer)(r_aacd_10 = 'L80') * r_dist_10 +
    (integer)(r_aacd_11 = 'L80') * r_dist_11 +
    (integer)(r_aacd_12 = 'L80') * r_dist_12 +
    (integer)(r_aacd_13 = 'L80') * r_dist_13 +
    (integer)(r_aacd_14 = 'L80') * r_dist_14 +
    (integer)(r_aacd_15 = 'L80') * r_dist_15 +
    (integer)(r_aacd_16 = 'L80') * r_dist_16 +
    (integer)(r_aacd_17 = 'L80') * r_dist_17 +
    (integer)(r_aacd_18 = 'L80') * r_dist_18 +
    (integer)(r_aacd_19 = 'L80') * r_dist_19 +
    (integer)(r_aacd_20 = 'L80') * r_dist_20 +
    (integer)(r_aacd_21 = 'L80') * r_dist_21 +
    (integer)(r_aacd_22 = 'L80') * r_dist_22 +
    (integer)(r_aacd_23 = 'L80') * r_dist_23 +
    (integer)(r_aacd_24 = 'L80') * r_dist_24 +
    (integer)(r_aacd_25 = 'L80') * r_dist_25 +
    (integer)(r_aacd_26 = 'L80') * r_dist_26 +
    (integer)(r_aacd_27 = 'L80') * r_dist_27 +
    (integer)(r_aacd_28 = 'L80') * r_dist_28 +
    (integer)(r_aacd_29 = 'L80') * r_dist_29 +
    (integer)(r_aacd_30 = 'L80') * r_dist_30 +
    (integer)(r_aacd_31 = 'L80') * r_dist_31 +
    (integer)(r_aacd_32 = 'L80') * r_dist_32 +
    (integer)(r_aacd_33 = 'L80') * r_dist_33;

r_rcvaluec22 := (integer)(r_aacd_0 = 'C22') * r_dist_0 +
    (integer)(r_aacd_1 = 'C22') * r_dist_1 +
    (integer)(r_aacd_2 = 'C22') * r_dist_2 +
    (integer)(r_aacd_3 = 'C22') * r_dist_3 +
    (integer)(r_aacd_4 = 'C22') * r_dist_4 +
    (integer)(r_aacd_5 = 'C22') * r_dist_5 +
    (integer)(r_aacd_6 = 'C22') * r_dist_6 +
    (integer)(r_aacd_7 = 'C22') * r_dist_7 +
    (integer)(r_aacd_8 = 'C22') * r_dist_8 +
    (integer)(r_aacd_9 = 'C22') * r_dist_9 +
    (integer)(r_aacd_10 = 'C22') * r_dist_10 +
    (integer)(r_aacd_11 = 'C22') * r_dist_11 +
    (integer)(r_aacd_12 = 'C22') * r_dist_12 +
    (integer)(r_aacd_13 = 'C22') * r_dist_13 +
    (integer)(r_aacd_14 = 'C22') * r_dist_14 +
    (integer)(r_aacd_15 = 'C22') * r_dist_15 +
    (integer)(r_aacd_16 = 'C22') * r_dist_16 +
    (integer)(r_aacd_17 = 'C22') * r_dist_17 +
    (integer)(r_aacd_18 = 'C22') * r_dist_18 +
    (integer)(r_aacd_19 = 'C22') * r_dist_19 +
    (integer)(r_aacd_20 = 'C22') * r_dist_20 +
    (integer)(r_aacd_21 = 'C22') * r_dist_21 +
    (integer)(r_aacd_22 = 'C22') * r_dist_22 +
    (integer)(r_aacd_23 = 'C22') * r_dist_23 +
    (integer)(r_aacd_24 = 'C22') * r_dist_24 +
    (integer)(r_aacd_25 = 'C22') * r_dist_25 +
    (integer)(r_aacd_26 = 'C22') * r_dist_26 +
    (integer)(r_aacd_27 = 'C22') * r_dist_27 +
    (integer)(r_aacd_28 = 'C22') * r_dist_28 +
    (integer)(r_aacd_29 = 'C22') * r_dist_29 +
    (integer)(r_aacd_30 = 'C22') * r_dist_30 +
    (integer)(r_aacd_31 = 'C22') * r_dist_31 +
    (integer)(r_aacd_32 = 'C22') * r_dist_32 +
    (integer)(r_aacd_33 = 'C22') * r_dist_33;

r_rcvaluec20 := (integer)(r_aacd_0 = 'C20') * r_dist_0 +
    (integer)(r_aacd_1 = 'C20') * r_dist_1 +
    (integer)(r_aacd_2 = 'C20') * r_dist_2 +
    (integer)(r_aacd_3 = 'C20') * r_dist_3 +
    (integer)(r_aacd_4 = 'C20') * r_dist_4 +
    (integer)(r_aacd_5 = 'C20') * r_dist_5 +
    (integer)(r_aacd_6 = 'C20') * r_dist_6 +
    (integer)(r_aacd_7 = 'C20') * r_dist_7 +
    (integer)(r_aacd_8 = 'C20') * r_dist_8 +
    (integer)(r_aacd_9 = 'C20') * r_dist_9 +
    (integer)(r_aacd_10 = 'C20') * r_dist_10 +
    (integer)(r_aacd_11 = 'C20') * r_dist_11 +
    (integer)(r_aacd_12 = 'C20') * r_dist_12 +
    (integer)(r_aacd_13 = 'C20') * r_dist_13 +
    (integer)(r_aacd_14 = 'C20') * r_dist_14 +
    (integer)(r_aacd_15 = 'C20') * r_dist_15 +
    (integer)(r_aacd_16 = 'C20') * r_dist_16 +
    (integer)(r_aacd_17 = 'C20') * r_dist_17 +
    (integer)(r_aacd_18 = 'C20') * r_dist_18 +
    (integer)(r_aacd_19 = 'C20') * r_dist_19 +
    (integer)(r_aacd_20 = 'C20') * r_dist_20 +
    (integer)(r_aacd_21 = 'C20') * r_dist_21 +
    (integer)(r_aacd_22 = 'C20') * r_dist_22 +
    (integer)(r_aacd_23 = 'C20') * r_dist_23 +
    (integer)(r_aacd_24 = 'C20') * r_dist_24 +
    (integer)(r_aacd_25 = 'C20') * r_dist_25 +
    (integer)(r_aacd_26 = 'C20') * r_dist_26 +
    (integer)(r_aacd_27 = 'C20') * r_dist_27 +
    (integer)(r_aacd_28 = 'C20') * r_dist_28 +
    (integer)(r_aacd_29 = 'C20') * r_dist_29 +
    (integer)(r_aacd_30 = 'C20') * r_dist_30 +
    (integer)(r_aacd_31 = 'C20') * r_dist_31 +
    (integer)(r_aacd_32 = 'C20') * r_dist_32 +
    (integer)(r_aacd_33 = 'C20') * r_dist_33;

r_rcvaluec21 := (integer)(r_aacd_0 = 'C21') * r_dist_0 +
    (integer)(r_aacd_1 = 'C21') * r_dist_1 +
    (integer)(r_aacd_2 = 'C21') * r_dist_2 +
    (integer)(r_aacd_3 = 'C21') * r_dist_3 +
    (integer)(r_aacd_4 = 'C21') * r_dist_4 +
    (integer)(r_aacd_5 = 'C21') * r_dist_5 +
    (integer)(r_aacd_6 = 'C21') * r_dist_6 +
    (integer)(r_aacd_7 = 'C21') * r_dist_7 +
    (integer)(r_aacd_8 = 'C21') * r_dist_8 +
    (integer)(r_aacd_9 = 'C21') * r_dist_9 +
    (integer)(r_aacd_10 = 'C21') * r_dist_10 +
    (integer)(r_aacd_11 = 'C21') * r_dist_11 +
    (integer)(r_aacd_12 = 'C21') * r_dist_12 +
    (integer)(r_aacd_13 = 'C21') * r_dist_13 +
    (integer)(r_aacd_14 = 'C21') * r_dist_14 +
    (integer)(r_aacd_15 = 'C21') * r_dist_15 +
    (integer)(r_aacd_16 = 'C21') * r_dist_16 +
    (integer)(r_aacd_17 = 'C21') * r_dist_17 +
    (integer)(r_aacd_18 = 'C21') * r_dist_18 +
    (integer)(r_aacd_19 = 'C21') * r_dist_19 +
    (integer)(r_aacd_20 = 'C21') * r_dist_20 +
    (integer)(r_aacd_21 = 'C21') * r_dist_21 +
    (integer)(r_aacd_22 = 'C21') * r_dist_22 +
    (integer)(r_aacd_23 = 'C21') * r_dist_23 +
    (integer)(r_aacd_24 = 'C21') * r_dist_24 +
    (integer)(r_aacd_25 = 'C21') * r_dist_25 +
    (integer)(r_aacd_26 = 'C21') * r_dist_26 +
    (integer)(r_aacd_27 = 'C21') * r_dist_27 +
    (integer)(r_aacd_28 = 'C21') * r_dist_28 +
    (integer)(r_aacd_29 = 'C21') * r_dist_29 +
    (integer)(r_aacd_30 = 'C21') * r_dist_30 +
    (integer)(r_aacd_31 = 'C21') * r_dist_31 +
    (integer)(r_aacd_32 = 'C21') * r_dist_32 +
    (integer)(r_aacd_33 = 'C21') * r_dist_33;

r_rcvaluea40 := (integer)(r_aacd_0 = 'A40') * r_dist_0 +
    (integer)(r_aacd_1 = 'A40') * r_dist_1 +
    (integer)(r_aacd_2 = 'A40') * r_dist_2 +
    (integer)(r_aacd_3 = 'A40') * r_dist_3 +
    (integer)(r_aacd_4 = 'A40') * r_dist_4 +
    (integer)(r_aacd_5 = 'A40') * r_dist_5 +
    (integer)(r_aacd_6 = 'A40') * r_dist_6 +
    (integer)(r_aacd_7 = 'A40') * r_dist_7 +
    (integer)(r_aacd_8 = 'A40') * r_dist_8 +
    (integer)(r_aacd_9 = 'A40') * r_dist_9 +
    (integer)(r_aacd_10 = 'A40') * r_dist_10 +
    (integer)(r_aacd_11 = 'A40') * r_dist_11 +
    (integer)(r_aacd_12 = 'A40') * r_dist_12 +
    (integer)(r_aacd_13 = 'A40') * r_dist_13 +
    (integer)(r_aacd_14 = 'A40') * r_dist_14 +
    (integer)(r_aacd_15 = 'A40') * r_dist_15 +
    (integer)(r_aacd_16 = 'A40') * r_dist_16 +
    (integer)(r_aacd_17 = 'A40') * r_dist_17 +
    (integer)(r_aacd_18 = 'A40') * r_dist_18 +
    (integer)(r_aacd_19 = 'A40') * r_dist_19 +
    (integer)(r_aacd_20 = 'A40') * r_dist_20 +
    (integer)(r_aacd_21 = 'A40') * r_dist_21 +
    (integer)(r_aacd_22 = 'A40') * r_dist_22 +
    (integer)(r_aacd_23 = 'A40') * r_dist_23 +
    (integer)(r_aacd_24 = 'A40') * r_dist_24 +
    (integer)(r_aacd_25 = 'A40') * r_dist_25 +
    (integer)(r_aacd_26 = 'A40') * r_dist_26 +
    (integer)(r_aacd_27 = 'A40') * r_dist_27 +
    (integer)(r_aacd_28 = 'A40') * r_dist_28 +
    (integer)(r_aacd_29 = 'A40') * r_dist_29 +
    (integer)(r_aacd_30 = 'A40') * r_dist_30 +
    (integer)(r_aacd_31 = 'A40') * r_dist_31 +
    (integer)(r_aacd_32 = 'A40') * r_dist_32 +
    (integer)(r_aacd_33 = 'A40') * r_dist_33;

r_rcvaluep88 := (integer)(r_aacd_0 = 'P88') * r_dist_0 +
    (integer)(r_aacd_1 = 'P88') * r_dist_1 +
    (integer)(r_aacd_2 = 'P88') * r_dist_2 +
    (integer)(r_aacd_3 = 'P88') * r_dist_3 +
    (integer)(r_aacd_4 = 'P88') * r_dist_4 +
    (integer)(r_aacd_5 = 'P88') * r_dist_5 +
    (integer)(r_aacd_6 = 'P88') * r_dist_6 +
    (integer)(r_aacd_7 = 'P88') * r_dist_7 +
    (integer)(r_aacd_8 = 'P88') * r_dist_8 +
    (integer)(r_aacd_9 = 'P88') * r_dist_9 +
    (integer)(r_aacd_10 = 'P88') * r_dist_10 +
    (integer)(r_aacd_11 = 'P88') * r_dist_11 +
    (integer)(r_aacd_12 = 'P88') * r_dist_12 +
    (integer)(r_aacd_13 = 'P88') * r_dist_13 +
    (integer)(r_aacd_14 = 'P88') * r_dist_14 +
    (integer)(r_aacd_15 = 'P88') * r_dist_15 +
    (integer)(r_aacd_16 = 'P88') * r_dist_16 +
    (integer)(r_aacd_17 = 'P88') * r_dist_17 +
    (integer)(r_aacd_18 = 'P88') * r_dist_18 +
    (integer)(r_aacd_19 = 'P88') * r_dist_19 +
    (integer)(r_aacd_20 = 'P88') * r_dist_20 +
    (integer)(r_aacd_21 = 'P88') * r_dist_21 +
    (integer)(r_aacd_22 = 'P88') * r_dist_22 +
    (integer)(r_aacd_23 = 'P88') * r_dist_23 +
    (integer)(r_aacd_24 = 'P88') * r_dist_24 +
    (integer)(r_aacd_25 = 'P88') * r_dist_25 +
    (integer)(r_aacd_26 = 'P88') * r_dist_26 +
    (integer)(r_aacd_27 = 'P88') * r_dist_27 +
    (integer)(r_aacd_28 = 'P88') * r_dist_28 +
    (integer)(r_aacd_29 = 'P88') * r_dist_29 +
    (integer)(r_aacd_30 = 'P88') * r_dist_30 +
    (integer)(r_aacd_31 = 'P88') * r_dist_31 +
    (integer)(r_aacd_32 = 'P88') * r_dist_32 +
    (integer)(r_aacd_33 = 'P88') * r_dist_33;

r_rcvaluep85 := (integer)(r_aacd_0 = 'P85') * r_dist_0 +
    (integer)(r_aacd_1 = 'P85') * r_dist_1 +
    (integer)(r_aacd_2 = 'P85') * r_dist_2 +
    (integer)(r_aacd_3 = 'P85') * r_dist_3 +
    (integer)(r_aacd_4 = 'P85') * r_dist_4 +
    (integer)(r_aacd_5 = 'P85') * r_dist_5 +
    (integer)(r_aacd_6 = 'P85') * r_dist_6 +
    (integer)(r_aacd_7 = 'P85') * r_dist_7 +
    (integer)(r_aacd_8 = 'P85') * r_dist_8 +
    (integer)(r_aacd_9 = 'P85') * r_dist_9 +
    (integer)(r_aacd_10 = 'P85') * r_dist_10 +
    (integer)(r_aacd_11 = 'P85') * r_dist_11 +
    (integer)(r_aacd_12 = 'P85') * r_dist_12 +
    (integer)(r_aacd_13 = 'P85') * r_dist_13 +
    (integer)(r_aacd_14 = 'P85') * r_dist_14 +
    (integer)(r_aacd_15 = 'P85') * r_dist_15 +
    (integer)(r_aacd_16 = 'P85') * r_dist_16 +
    (integer)(r_aacd_17 = 'P85') * r_dist_17 +
    (integer)(r_aacd_18 = 'P85') * r_dist_18 +
    (integer)(r_aacd_19 = 'P85') * r_dist_19 +
    (integer)(r_aacd_20 = 'P85') * r_dist_20 +
    (integer)(r_aacd_21 = 'P85') * r_dist_21 +
    (integer)(r_aacd_22 = 'P85') * r_dist_22 +
    (integer)(r_aacd_23 = 'P85') * r_dist_23 +
    (integer)(r_aacd_24 = 'P85') * r_dist_24 +
    (integer)(r_aacd_25 = 'P85') * r_dist_25 +
    (integer)(r_aacd_26 = 'P85') * r_dist_26 +
    (integer)(r_aacd_27 = 'P85') * r_dist_27 +
    (integer)(r_aacd_28 = 'P85') * r_dist_28 +
    (integer)(r_aacd_29 = 'P85') * r_dist_29 +
    (integer)(r_aacd_30 = 'P85') * r_dist_30 +
    (integer)(r_aacd_31 = 'P85') * r_dist_31 +
    (integer)(r_aacd_32 = 'P85') * r_dist_32 +
    (integer)(r_aacd_33 = 'P85') * r_dist_33;

r_rcvaluei60 := (integer)(r_aacd_0 = 'I60') * r_dist_0 +
    (integer)(r_aacd_1 = 'I60') * r_dist_1 +
    (integer)(r_aacd_2 = 'I60') * r_dist_2 +
    (integer)(r_aacd_3 = 'I60') * r_dist_3 +
    (integer)(r_aacd_4 = 'I60') * r_dist_4 +
    (integer)(r_aacd_5 = 'I60') * r_dist_5 +
    (integer)(r_aacd_6 = 'I60') * r_dist_6 +
    (integer)(r_aacd_7 = 'I60') * r_dist_7 +
    (integer)(r_aacd_8 = 'I60') * r_dist_8 +
    (integer)(r_aacd_9 = 'I60') * r_dist_9 +
    (integer)(r_aacd_10 = 'I60') * r_dist_10 +
    (integer)(r_aacd_11 = 'I60') * r_dist_11 +
    (integer)(r_aacd_12 = 'I60') * r_dist_12 +
    (integer)(r_aacd_13 = 'I60') * r_dist_13 +
    (integer)(r_aacd_14 = 'I60') * r_dist_14 +
    (integer)(r_aacd_15 = 'I60') * r_dist_15 +
    (integer)(r_aacd_16 = 'I60') * r_dist_16 +
    (integer)(r_aacd_17 = 'I60') * r_dist_17 +
    (integer)(r_aacd_18 = 'I60') * r_dist_18 +
    (integer)(r_aacd_19 = 'I60') * r_dist_19 +
    (integer)(r_aacd_20 = 'I60') * r_dist_20 +
    (integer)(r_aacd_21 = 'I60') * r_dist_21 +
    (integer)(r_aacd_22 = 'I60') * r_dist_22 +
    (integer)(r_aacd_23 = 'I60') * r_dist_23 +
    (integer)(r_aacd_24 = 'I60') * r_dist_24 +
    (integer)(r_aacd_25 = 'I60') * r_dist_25 +
    (integer)(r_aacd_26 = 'I60') * r_dist_26 +
    (integer)(r_aacd_27 = 'I60') * r_dist_27 +
    (integer)(r_aacd_28 = 'I60') * r_dist_28 +
    (integer)(r_aacd_29 = 'I60') * r_dist_29 +
    (integer)(r_aacd_30 = 'I60') * r_dist_30 +
    (integer)(r_aacd_31 = 'I60') * r_dist_31 +
    (integer)(r_aacd_32 = 'I60') * r_dist_32 +
    (integer)(r_aacd_33 = 'I60') * r_dist_33;

r_rcvaluei61 := (integer)(r_aacd_0 = 'I61') * r_dist_0 +
    (integer)(r_aacd_1 = 'I61') * r_dist_1 +
    (integer)(r_aacd_2 = 'I61') * r_dist_2 +
    (integer)(r_aacd_3 = 'I61') * r_dist_3 +
    (integer)(r_aacd_4 = 'I61') * r_dist_4 +
    (integer)(r_aacd_5 = 'I61') * r_dist_5 +
    (integer)(r_aacd_6 = 'I61') * r_dist_6 +
    (integer)(r_aacd_7 = 'I61') * r_dist_7 +
    (integer)(r_aacd_8 = 'I61') * r_dist_8 +
    (integer)(r_aacd_9 = 'I61') * r_dist_9 +
    (integer)(r_aacd_10 = 'I61') * r_dist_10 +
    (integer)(r_aacd_11 = 'I61') * r_dist_11 +
    (integer)(r_aacd_12 = 'I61') * r_dist_12 +
    (integer)(r_aacd_13 = 'I61') * r_dist_13 +
    (integer)(r_aacd_14 = 'I61') * r_dist_14 +
    (integer)(r_aacd_15 = 'I61') * r_dist_15 +
    (integer)(r_aacd_16 = 'I61') * r_dist_16 +
    (integer)(r_aacd_17 = 'I61') * r_dist_17 +
    (integer)(r_aacd_18 = 'I61') * r_dist_18 +
    (integer)(r_aacd_19 = 'I61') * r_dist_19 +
    (integer)(r_aacd_20 = 'I61') * r_dist_20 +
    (integer)(r_aacd_21 = 'I61') * r_dist_21 +
    (integer)(r_aacd_22 = 'I61') * r_dist_22 +
    (integer)(r_aacd_23 = 'I61') * r_dist_23 +
    (integer)(r_aacd_24 = 'I61') * r_dist_24 +
    (integer)(r_aacd_25 = 'I61') * r_dist_25 +
    (integer)(r_aacd_26 = 'I61') * r_dist_26 +
    (integer)(r_aacd_27 = 'I61') * r_dist_27 +
    (integer)(r_aacd_28 = 'I61') * r_dist_28 +
    (integer)(r_aacd_29 = 'I61') * r_dist_29 +
    (integer)(r_aacd_30 = 'I61') * r_dist_30 +
    (integer)(r_aacd_31 = 'I61') * r_dist_31 +
    (integer)(r_aacd_32 = 'I61') * r_dist_32 +
    (integer)(r_aacd_33 = 'I61') * r_dist_33;

r_rcvaluei62 := (integer)(r_aacd_0 = 'I62') * r_dist_0 +
    (integer)(r_aacd_1 = 'I62') * r_dist_1 +
    (integer)(r_aacd_2 = 'I62') * r_dist_2 +
    (integer)(r_aacd_3 = 'I62') * r_dist_3 +
    (integer)(r_aacd_4 = 'I62') * r_dist_4 +
    (integer)(r_aacd_5 = 'I62') * r_dist_5 +
    (integer)(r_aacd_6 = 'I62') * r_dist_6 +
    (integer)(r_aacd_7 = 'I62') * r_dist_7 +
    (integer)(r_aacd_8 = 'I62') * r_dist_8 +
    (integer)(r_aacd_9 = 'I62') * r_dist_9 +
    (integer)(r_aacd_10 = 'I62') * r_dist_10 +
    (integer)(r_aacd_11 = 'I62') * r_dist_11 +
    (integer)(r_aacd_12 = 'I62') * r_dist_12 +
    (integer)(r_aacd_13 = 'I62') * r_dist_13 +
    (integer)(r_aacd_14 = 'I62') * r_dist_14 +
    (integer)(r_aacd_15 = 'I62') * r_dist_15 +
    (integer)(r_aacd_16 = 'I62') * r_dist_16 +
    (integer)(r_aacd_17 = 'I62') * r_dist_17 +
    (integer)(r_aacd_18 = 'I62') * r_dist_18 +
    (integer)(r_aacd_19 = 'I62') * r_dist_19 +
    (integer)(r_aacd_20 = 'I62') * r_dist_20 +
    (integer)(r_aacd_21 = 'I62') * r_dist_21 +
    (integer)(r_aacd_22 = 'I62') * r_dist_22 +
    (integer)(r_aacd_23 = 'I62') * r_dist_23 +
    (integer)(r_aacd_24 = 'I62') * r_dist_24 +
    (integer)(r_aacd_25 = 'I62') * r_dist_25 +
    (integer)(r_aacd_26 = 'I62') * r_dist_26 +
    (integer)(r_aacd_27 = 'I62') * r_dist_27 +
    (integer)(r_aacd_28 = 'I62') * r_dist_28 +
    (integer)(r_aacd_29 = 'I62') * r_dist_29 +
    (integer)(r_aacd_30 = 'I62') * r_dist_30 +
    (integer)(r_aacd_31 = 'I62') * r_dist_31 +
    (integer)(r_aacd_32 = 'I62') * r_dist_32 +
    (integer)(r_aacd_33 = 'I62') * r_dist_33;

iv_rv5_deceased := rc_decsflag = '1' or rc_ssndod != 0 or (integer)(indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DS', ',')) > 0 or (integer)(indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'DE', ',')) > 0;

iv_rv5_unscorable := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), '1', '0');

base := 700;

pts := 40;

odds := (1 - .1472) / .1472;

rvg1610_1_0 := map(
    iv_rv5_deceased      => 200,
    iv_rv5_unscorable = '1' => 222,
                               min(if(max(round(pts * (ln(r_probscore / (1 - r_probscore)) - ln(odds)) / ln(2) + base), 501) = NULL, -NULL, max(round(pts * (ln(r_probscore / (1 - r_probscore)) - ln(odds)) / ln(2) + base), 501)), 900));


//*************************************************************************************//
// I have no idea how the reason code logic gets implemented in ECL, so everything below 
// probably needs to get changed or replaced.  The methodology for creating the reason codes is
// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
// that model code for guidance on implementing reason codes. 
//*************************************************************************************//

ds_layout := {STRING rc, REAL value};

 
//*************************************************************************************//
rc_dataset_r := DATASET([
    {'L79', r_rcvalueL79},
    {'L72', r_rcvalueL72},
    {'L70', r_rcvalueL70},
    {'L71', r_rcvalueL71},
    {'D32', r_rcvalueD32},
    {'D33', r_rcvalueD33},
    {'C19', r_rcvalueC19},
    {'F01', r_rcvalueF01},
    {'F00', r_rcvalueF00},
    {'F03', r_rcvalueF03},
    {'E55', r_rcvalueE55},
    {'C12', r_rcvalueC12},
    {'E57', r_rcvalueE57},
    {'C14', r_rcvalueC14},
    {'L80', r_rcvalueL80},
    {'C22', r_rcvalueC22},
    {'C20', r_rcvalueC20},
    {'C21', r_rcvalueC21},
    {'A40', r_rcvalueA40},
    {'P88', r_rcvalueP88},
    {'P85', r_rcvalueP85},
    {'I60', r_rcvalueI60},
    {'I61', r_rcvalueI61},
    {'I62', r_rcvalueI62}
    ], ds_layout) (value < 0);

//*************************************************************************************//
// IMPORTANT NOTE:  Select ONLY reason codes with an RCValue < 0.  I'll leave the 
//   implementation of this to the Engineer
//*************************************************************************************//
rc_dataset_r_sorted := sort(rc_dataset_r, rc_dataset_r.value);

r_rc1 := rc_dataset_r_sorted[1].rc;
r_rc2 := rc_dataset_r_sorted[2].rc;
r_rc3 := rc_dataset_r_sorted[3].rc;
r_rc4 := rc_dataset_r_sorted[4].rc;

r_vl1 := rc_dataset_r_sorted[1].value;
r_vl2 := rc_dataset_r_sorted[2].value;
r_vl3 := rc_dataset_r_sorted[3].value;
r_vl4 := rc_dataset_r_sorted[4].value;
//*************************************************************************************//

rc1_2 := r_rc1;

rc2_2 := r_rc2;

rc3_2 := r_rc3;

rc4_2 := r_rc4;

rc5_2 := '';

_rc_inq := map(
    rv_i60_inq_comm_count12 > 0       => 'I60',
    rv_i60_inq_hiriskcred_recency > 0 => 'I60',
    rv_i62_inq_phones_per_adl > 0     => 'I62',
    rv_i62_inq_ssns_per_adl > 0       => 'I62',
    rv_i60_inq_other_recency > 0      => 'I60',
    rv_i61_inq_collection_count12 > 0 => 'I61',
    rv_i62_inq_addrs_per_adl > 0      => 'I62',
                                         '');

rc3_c109 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc4_c109 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => _rc_inq,
                                             '');

rc1_c109 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc2_c109 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => _rc_inq,
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             '');

rc5_c109 := map(
    trim((string)rc1_2, LEFT, RIGHT) = '' => '',
    trim((string)rc2_2, LEFT, RIGHT) = '' => '',
    trim((string)rc3_2, LEFT, RIGHT) = '' => '',
    trim((string)rc4_2, LEFT, RIGHT) = '' => '',
                                             _rc_inq);

rc5_1 := if(rc5_c109 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc5_c109, rc5_2);

rc2_1 := if(rc2_c109 != '' and  not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc2_c109, rc2_2);

rc1_1 := if(rc1_c109 != '' and  not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc1_c109, rc1_2);

rc4_1 := if(rc4_c109 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc4_c109, rc4_2);

rc3_1 := if(rc3_c109 != '' and not((rc1_2 in ['I60', 'I61', 'I62'])) and not((rc2_2 in ['I60', 'I61', 'I62'])) and not((rc3_2 in ['I60', 'I61', 'I62'])) and not((rc4_2 in ['I60', 'I61', 'I62'])), rc3_c109, rc3_2);


rc4 := if((rvg1610_1_0 in [200, 222, 900]), '', rc4_1);

rc3 := if((rvg1610_1_0 in [200, 222, 900]), '', rc3_1);

rc2 := if((rvg1610_1_0 in [200, 222, 900]), '', rc2_1);

rc1 := if((rvg1610_1_0 in [200, 222, 900]), '', rc1_1);

rc5 := if((rvg1610_1_0 in [200, 222, 900]), '', rc5_1);







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
													RVG1610_1_0 = 200 => DATASET([{'00'}], HRILayout),
													RVG1610_1_0 = 222 => DATASET([{'00'}], HRILayout),
													RVG1610_1_0 = 900 => DATASET([{'00'}], HRILayout),
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
                    self.sysdate                          := sysdate;
                    self.iv_add_apt                       := iv_add_apt;
                    self.rv_p88_phn_dst_to_inp_add        := rv_p88_phn_dst_to_inp_add;
                    self.rv_p85_phn_not_issued            := rv_p85_phn_not_issued;
                    self.rv_l71_add_business              := rv_l71_add_business;
         //           self.add_ec1                          := add_ec1;
            //        self.add_ec3                          := add_ec3;
           //         self.add_ec4                          := add_ec4;
                    self.rv_l70_add_standardized          := rv_l70_add_standardized;
                    self.rv_l72_add_curr_vacant           := rv_l72_add_curr_vacant;
                    self.rv_f03_input_add_not_most_rec    := rv_f03_input_add_not_most_rec;
                    self.rv_c19_add_prison_hist           := rv_c19_add_prison_hist;
                    self.rv_f00_ssn_score                 := rv_f00_ssn_score;
                    self.rv_f01_inp_addr_address_score    := rv_f01_inp_addr_address_score;
                    self.rv_d32_criminal_x_felony         := rv_d32_criminal_x_felony;
                    self.rv_c21_stl_inq_count             := rv_c21_stl_inq_count;
                    self.rv_d33_eviction_recency          := rv_d33_eviction_recency;
                    self.bureau_adl_eq_fseen_pos          := bureau_adl_eq_fseen_pos;
                    self.bureau_adl_fseen_eq              := bureau_adl_fseen_eq;
                    self._bureau_adl_fseen_eq             := _bureau_adl_fseen_eq;
                    self._src_bureau_adl_fseen            := _src_bureau_adl_fseen;
                    self.rv_c20_m_bureau_adl_fs           := rv_c20_m_bureau_adl_fs;
                    self.rv_c12_num_nonderogs             := rv_c12_num_nonderogs;
                    self.rv_f03_address_match             := rv_f03_address_match;
                    self.rv_l80_inp_avm_autoval           := rv_l80_inp_avm_autoval;
                    self.rv_c14_addrs_15yr                := rv_c14_addrs_15yr;
                    self.rv_c22_inp_addr_occ_index        := rv_c22_inp_addr_occ_index;
                    self.rv_c22_inp_addr_owned_not_occ    := rv_c22_inp_addr_owned_not_occ;
                    self.rv_ever_asset_owner              := rv_ever_asset_owner;
                    self.rv_e55_college_ind               := rv_e55_college_ind;
                    self.rv_e57_prof_license_br_flag      := rv_e57_prof_license_br_flag;
                    self.rv_i61_inq_collection_count12    := rv_i61_inq_collection_count12;
                    self.rv_i60_inq_hiriskcred_recency    := rv_i60_inq_hiriskcred_recency;
                    self.rv_i60_inq_comm_count12          := rv_i60_inq_comm_count12;
                    self.rv_l79_adls_per_apt_addr         := rv_l79_adls_per_apt_addr;
                    self.rv_l79_adls_per_sfd_addr         := rv_l79_adls_per_sfd_addr;
                    self.rv_l79_adls_per_addr_c6          := rv_l79_adls_per_addr_c6;
                    self.rv_f01_inp_add_house_num_match   := rv_f01_inp_add_house_num_match;
                    self.rv_c12_inp_addr_source_count     := rv_c12_inp_addr_source_count;
                    self.rv_i60_inq_other_recency         := rv_i60_inq_other_recency;
                    self.rv_i62_inq_ssns_per_adl          := rv_i62_inq_ssns_per_adl;
                    self.rv_i62_inq_addrs_per_adl         := rv_i62_inq_addrs_per_adl;
                    self.rv_i62_inq_phones_per_adl        := rv_i62_inq_phones_per_adl;
                    self.r_subscore0                      := r_subscore0;
                    self.r_subscore1                      := r_subscore1;
                    self.r_subscore2                      := r_subscore2;
                    self.r_subscore3                      := r_subscore3;
                    self.r_subscore4                      := r_subscore4;
                    self.r_subscore5                      := r_subscore5;
                    self.r_subscore6                      := r_subscore6;
                    self.r_subscore7                      := r_subscore7;
                    self.r_subscore8                      := r_subscore8;
                    self.r_subscore9                      := r_subscore9;
                    self.r_subscore10                     := r_subscore10;
                    self.r_subscore11                     := r_subscore11;
                    self.r_subscore12                     := r_subscore12;
                    self.r_subscore13                     := r_subscore13;
                    self.r_subscore14                     := r_subscore14;
                    self.r_subscore15                     := r_subscore15;
                    self.r_subscore16                     := r_subscore16;
                    self.r_subscore17                     := r_subscore17;
                    self.r_subscore18                     := r_subscore18;
                    self.r_subscore19                     := r_subscore19;
                    self.r_subscore20                     := r_subscore20;
                    self.r_subscore21                     := r_subscore21;
                    self.r_subscore22                     := r_subscore22;
                    self.r_subscore23                     := r_subscore23;
                    self.r_subscore24                     := r_subscore24;
                    self.r_subscore25                     := r_subscore25;
                    self.r_subscore26                     := r_subscore26;
                    self.r_subscore27                     := r_subscore27;
                    self.r_subscore28                     := r_subscore28;
                    self.r_subscore29                     := r_subscore29;
                    self.r_subscore30                     := r_subscore30;
                    self.r_subscore31                     := r_subscore31;
                    self.r_subscore32                     := r_subscore32;
                    self.r_subscore33                     := r_subscore33;
                    self.r_rawscore                       := r_rawscore;
                    self.r_lnoddsscore                    := r_lnoddsscore;
                    self.r_probscore                      := r_probscore;
                    self.r_aacd_0                         := r_aacd_0;
                    self.r_dist_0                         := r_dist_0;
                    self.r_aacd_1                         := r_aacd_1;
                    self.r_dist_1                         := r_dist_1;
                    self.r_aacd_2                         := r_aacd_2;
                    self.r_dist_2                         := r_dist_2;
                    self.r_aacd_3                         := r_aacd_3;
                    self.r_dist_3                         := r_dist_3;
                    self.r_aacd_4                         := r_aacd_4;
                    self.r_dist_4                         := r_dist_4;
                    self.r_aacd_5                         := r_aacd_5;
                    self.r_dist_5                         := r_dist_5;
                    self.r_aacd_6                         := r_aacd_6;
                    self.r_dist_6                         := r_dist_6;
                    self.r_aacd_7                         := r_aacd_7;
                    self.r_dist_7                         := r_dist_7;
                    self.r_aacd_8                         := r_aacd_8;
                    self.r_dist_8                         := r_dist_8;
                    self.r_aacd_9                         := r_aacd_9;
                    self.r_dist_9                         := r_dist_9;
                    self.r_aacd_10                        := r_aacd_10;
                    self.r_dist_10                        := r_dist_10;
                    self.r_aacd_11                        := r_aacd_11;
                    self.r_dist_11                        := r_dist_11;
                    self.r_aacd_12                        := r_aacd_12;
                    self.r_dist_12                        := r_dist_12;
                    self.r_aacd_13                        := r_aacd_13;
                    self.r_dist_13                        := r_dist_13;
                    self.r_aacd_14                        := r_aacd_14;
                    self.r_dist_14                        := r_dist_14;
                    self.r_aacd_15                        := r_aacd_15;
                    self.r_dist_15                        := r_dist_15;
                    self.r_aacd_16                        := r_aacd_16;
                    self.r_dist_16                        := r_dist_16;
                    self.r_aacd_17                        := r_aacd_17;
                    self.r_dist_17                        := r_dist_17;
                    self.r_aacd_18                        := r_aacd_18;
                    self.r_dist_18                        := r_dist_18;
                    self.r_aacd_19                        := r_aacd_19;
                    self.r_dist_19                        := r_dist_19;
                    self.r_aacd_20                        := r_aacd_20;
                    self.r_dist_20                        := r_dist_20;
                    self.r_aacd_21                        := r_aacd_21;
                    self.r_dist_21                        := r_dist_21;
                    self.r_aacd_22                        := r_aacd_22;
                    self.r_dist_22                        := r_dist_22;
                    self.r_aacd_23                        := r_aacd_23;
                    self.r_dist_23                        := r_dist_23;
                    self.r_aacd_24                        := r_aacd_24;
                    self.r_dist_24                        := r_dist_24;
                    self.r_aacd_25                        := r_aacd_25;
                    self.r_dist_25                        := r_dist_25;
                    self.r_aacd_26                        := r_aacd_26;
                    self.r_dist_26                        := r_dist_26;
                    self.r_aacd_27                        := r_aacd_27;
                    self.r_dist_27                        := r_dist_27;
                    self.r_aacd_28                        := r_aacd_28;
                    self.r_dist_28                        := r_dist_28;
                    self.r_aacd_29                        := r_aacd_29;
                    self.r_dist_29                        := r_dist_29;
                    self.r_aacd_30                        := r_aacd_30;
                    self.r_dist_30                        := r_dist_30;
                    self.r_aacd_31                        := r_aacd_31;
                    self.r_dist_31                        := r_dist_31;
                    self.r_aacd_32                        := r_aacd_32;
                    self.r_dist_32                        := r_dist_32;
                    self.r_aacd_33                        := r_aacd_33;
                    self.r_dist_33                        := r_dist_33;
                    self.r_rcvaluel79                     := r_rcvaluel79;
                    self.r_rcvaluel72                     := r_rcvaluel72;
                    self.r_rcvaluel70                     := r_rcvaluel70;
                    self.r_rcvaluel71                     := r_rcvaluel71;
                    self.r_rcvalued32                     := r_rcvalued32;
                    self.r_rcvalued33                     := r_rcvalued33;
                    self.r_rcvaluec19                     := r_rcvaluec19;
                    self.r_rcvaluef01                     := r_rcvaluef01;
                    self.r_rcvaluef00                     := r_rcvaluef00;
                    self.r_rcvaluef03                     := r_rcvaluef03;
                    self.r_rcvaluee55                     := r_rcvaluee55;
                    self.r_rcvaluec12                     := r_rcvaluec12;
                    self.r_rcvaluee57                     := r_rcvaluee57;
                    self.r_rcvaluec14                     := r_rcvaluec14;
                    self.r_rcvaluel80                     := r_rcvaluel80;
                    self.r_rcvaluec22                     := r_rcvaluec22;
                    self.r_rcvaluec20                     := r_rcvaluec20;
                    self.r_rcvaluec21                     := r_rcvaluec21;
                    self.r_rcvaluea40                     := r_rcvaluea40;
                    self.r_rcvaluep88                     := r_rcvaluep88;
                    self.r_rcvaluep85                     := r_rcvaluep85;
                    self.r_rcvaluei60                     := r_rcvaluei60;
                    self.r_rcvaluei61                     := r_rcvaluei61;
                    self.r_rcvaluei62                     := r_rcvaluei62;
                    self.iv_rv5_deceased                  := iv_rv5_deceased;
                    self.iv_rv5_unscorable                := iv_rv5_unscorable;
                    self.base                             := base;
                    self.pts                              := pts;
                    self.odds                             := odds;
                    self.rvg1610_1_0                      := rvg1610_1_0;
                    self.r_rc1                            := r_rc1;
                    self.r_rc2                            := r_rc2;
                    self.r_rc3                            := r_rc3;
                    self.r_rc4                            := r_rc4;
                    self.r_vl1                            := r_vl1;
                    self.r_vl2                            := r_vl2;
                    self.r_vl3                            := r_vl3;
                    self.r_vl4                            := r_vl4;
                    self._rc_inq                          := _rc_inq;
                    self.rc2                              := rc2;
                    self.rc3                              := rc3;
                    self.rc5                              := rc5;
                    self.rc4                              := rc4;
                    self.rc1                              := rc1;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasonCodes, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)rvg1610_1_0;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;


			
			
			
			
			