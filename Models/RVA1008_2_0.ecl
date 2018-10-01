import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVA1008_2_0(dataset(risk_indicators.Layout_Boca_Shell) clam,boolean isCalifornia) := FUNCTION	
	
	
RVA_DEBUG := false;

	#if(RVA_DEBUG)
		debug_layout := record
						risk_indicators.Layout_Boca_Shell clam;
						Boolean truedid;
						String adl_category;
						String out_unit_desig;
						String out_sec_range;
						String out_addr_type;
						String in_dob;
						Integer nas_summary;
						Integer nap_summary;
						Integer did_count;
						String rc_hriskphoneflag;
						String rc_hphonetypeflag;
						String rc_hphonevalflag;
						String rc_phonezipflag;
						String rc_pwphonezipflag;
						String rc_decsflag;
						String rc_ssndobflag;
						String rc_pwssndobflag;
						String rc_ssnvalflag;
						String rc_pwssnvalflag;
						Integer rc_ssnlowissue;
						String rc_addrvalflag;
						String rc_dwelltype;
						String rc_bansflag;
						String rc_sources;
						Integer rc_fnamecount;
						Integer rc_addrcount;
						Integer rc_numelever;
						String rc_phonetype;
						Boolean rc_altlname1_flag;
						Boolean rc_altlname2_flag;
						Integer combo_hphonescore;
						Integer combo_ssnscore;
						Integer combo_dobscore;
						Integer combo_lnamecount;
						Integer combo_addrcount;
						Integer combo_hphonecount;
						Integer combo_ssncount;
						Integer combo_dobcount;
						Boolean add1_isbestmatch;
						Integer add1_unit_count;
						Integer add1_source_count;
						Boolean add1_applicant_owned;
						Boolean add1_occupant_owned;
						Boolean add1_family_owned;
						Integer add1_naprop;
						Integer add1_purchase_amount;
						String add1_land_use_code;
						Integer property_owned_total;
						Integer property_sold_total;
						Integer avg_lres;
						Integer addrs_5yr;
						Integer addrs_10yr;
						Integer addrs_15yr;
						String gong_did_first_seen;
						String gong_did_last_seen;
						Integer gong_did_phone_ct;
						Integer gong_did_addr_ct;
						Integer gong_did_first_ct;
						String inputssncharflag;
						Integer ssns_per_adl;
						Integer addrs_per_adl;
						Integer ssns_per_adl_c6;
						Integer addrs_per_adl_c6;
						Integer pl_addrs_per_adl;
						Integer invalid_ssns_per_adl;
						Integer impulse_count;
						Integer attr_addrs_last30;
						Integer attr_addrs_last90;
						Integer attr_addrs_last12;
						Integer attr_addrs_last24;
						Integer attr_addrs_last36;
						Integer attr_total_number_derogs;
						Integer attr_eviction_count;
						Integer attr_num_nonderogs;
						Integer attr_num_proflic30;
						Integer attr_num_proflic90;
						Integer attr_num_proflic180;
						Integer attr_num_proflic12;
						Integer attr_num_proflic24;
						Integer attr_num_proflic36;
						Integer attr_num_proflic60;
						Boolean bankrupt;
						String disposition;
						Integer filing_count;
						Integer bk_recent_count;
						Integer bk_disposed_recent_count;
						Integer bk_disposed_historical_count;
						Integer liens_recent_unreleased_count;
						Integer liens_historical_unreleased_ct;
						Integer criminal_count;
						Integer felony_count;
						String ams_income_level_code;
						String ams_college_tier;
						String wealth_index;
						String input_dob_match_level;
						String addr_stability;
						Integer estimated_income;
						Integer sysdate;
						Integer _in_dob;
						Integer _rc_ssnlowissue;
						Boolean add_unit;
						Boolean add_apt;
						Boolean core_adl;
						Boolean single_did;
						Boolean nas12;
						Boolean ver_nap6;
						Boolean verphn_p;
						Boolean contrary_phn;
						Boolean veradd_p;
						Boolean impulse_flag;
						Boolean dismissed_bk;
						Boolean bad_bk;
						Boolean add_inval;
						Boolean phn_cellpager;
						Boolean phn_nonus;
						Boolean name_change_flag;
						Boolean ssn_priordob;
						Boolean ssn_inval;
						Boolean phn_business;
						Boolean phn_zipmismatch;
						Boolean contrary_ssn;
						Boolean verlst_p;
						Boolean verfst_p;
						Boolean phn_disconnected;
						Boolean phn_highrisk2;
						String add1_land_use_code_summary;
						String out_addr_type_summary;
						Integer gong_did_first_seen2;
						Integer gong_did_last_seen2;
						Real time_on_gong;
						Integer s0_addr_stability_bin;
						Real s0_addr_stability_bin_m;
						Integer bm1_s0_did_ver;
						Real bm1_s0_did_ver_m;
						Integer bm1_s0_ver_phn;
						Integer bm1_s0_verx;
						Real bm1_s0_verx_m;
						Boolean bm1_s0_rc_addrcount_ind;
						Integer bm1_s0_combo_dobcount_bin;
						Real bm1_s0_combo_dobcount_bin_m;
						Real bm1_s0_vermod;
						Integer bm0_s0_did_ver;
						Boolean bm0_s0_did_ver_ind;
						Integer bm0_s0_ver_p;
						Integer bm0_s0_verx;
						Real bm0_s0_verx_m;
						Real bm0_s0_vermod;
						Real s0_vermod_derog;
						Integer s0_crime_felony_bin;
						Real s0_crime_felony_bin_m;
						Integer s0_liens_cnt_bin;
						Real s0_liens_cnt_bin_m;
						Integer s0_attr_totnum_derogs_bin;
						Real s0_attr_totnum_derogs_bin_m;
						Integer s0_attr_num_nonderogs_bin;
						Real s0_attr_num_nonderogs_bin_m;
						Integer s0_bk_bin;
						Integer s0_bk_bin2;
						Real s0_bk_bin2_m;
						Real s0_derogmod_d;
						Real s0_derogmod_dm;
						Integer s0_add_unit_apt_2;
						Integer s0_add_unit_apt_1;
						Integer s0_add_unit_apt;
						Integer s0_add_prob;
						Real s0_add_prob_m;
						Boolean s0_hi_addrs_per_adl;
						Boolean s0_hi_addrs_per_adl_c6;
						Real s0_mod_addrprob;
						Real s0_mod_addrprob_dm;
						Boolean s0_phn_zipmis_bus;
						Integer s0_phn_zipmis_bus_cell;
						Integer s0_phn_prob;
						Real s0_phn_prob_m;
						Integer s0_gong_hist_summary;
						Real s0_gong_hist_summary_m;
						Real s0_time_on_gong;
						Real s0_mod_phnprob;
						Real s0_mod_phnprob_dm;
						Real s0_ssn_lowissue_age;
						Boolean s0_ssn_lowissue_age_cap;
						Integer s0_yrsince_rc_ssnlowissue;
						Boolean s0_yrsince_rc_ssnlowissue_cap;
						Boolean s0_ssns_per_adl_2;
						Real s0_mod_ssnprob;
						Real s0_mod_ssnprob_dm;
						Real s0_fpmod;
						Real s0_fpmod_dm;
						Real seg0_log_odds;
						Integer s1_ams_college_tier_bin;
						Real s1_ams_college_tier_bin_m;
						Integer s1_addrs_15yr_cap;
						Integer s1_addr_stability_bin;
						Real s1_addr_stability_bin_m;
						Integer s1_address_recency;
						Integer s1_add_recency_bin;
						Real s1_add_recency_bin_m;
						Boolean s1_aptflag;
						Boolean s1_add1_purchamt_ind;
						Integer s1_appl_fam;
						Integer s1_owned_bin;
						Real s1_owned_bin_m;
						Real s1_propmod_p;
						Real s1_propmod_pm;
						Integer bm1_s1_combo_addrcount_bin;
						Real bm1_s1_combo_addrcount_bin_m;
						Integer bm1_s1_combo_dobcount_bin;
						Real bm1_s1_combo_dobcount_bin_m;
						Real bm1_s1_prop_vermod;
						Boolean bm0_s1_rc_addrcount_ind;
						Integer bm0_s1_combo_lnamecount_bin;
						Real bm0_s1_combo_lnamecount_bin_m;
						Boolean bm0_s1_combo_hphnscr_ind;
						Real bm0_s1_prop_vermod;
						Real s1_vermod_pm;
						Integer s1_add_unit_apt;
						Integer s1_add_prob;
						Real s1_add_prob_m;
						Boolean s1_slim_addr_info;
						Boolean s1_hi_addrs_per_adl;
						Real s1_fpmod_addprob;
						Real s1_fpmod_addprob_pm;
						Boolean s1_lo_combo_hphonescore;
						Boolean s1_hi_gong_did_phnadd;
						Real s1_time_on_gong;
						Real s1_fpmod_phnprob;
						Real s1_fpmod_phnprob_pm;
						Integer s1_ssn_lowissue_age;
						Boolean s1_yrs_at_lowissue_ind;
						Integer s1_yrsince_rc_ssnlowissue;
						Boolean s1_yrsince_rc_ssnlowissue_ind;
						Integer s1_ssns_per_adl_bin;
						Real s1_ssns_per_adl_bin_m;
						Boolean s1_hi_ssns_per_adl_c6;
						Real s1_fpmod_ssnprob;
						Real s1_fpmod_ssnprob_pm;
						Real s1_fpmod;
						Real s1_fpmod_pm;
						Real seg1_log_odds;
						Integer s2_addr_stability_bin;
						Real s2_addr_stability_bin_m;
						Boolean b1_s2_combo_dobscr_ind;
						Real b1_s2_renter_vermod;
						Integer b0_s2_pos_sources_count;
						Integer b0_s2_pos_sources_count_bin;
						Real b0_s2_pos_sources_count_bin_m;
						Boolean b0_s2_combo_lnamecount_ind;
						Boolean b0_s2_combo_dobscr_ind;
						Integer b0_s2_cont_nap6_p;
						Integer b0_s2_verx;
						Real b0_s2_verx_m;
						Real b0_s2_renter_vermod;
						Real s2_vermod_rm;
						Integer s2_ssn_lowissue_age;
						Boolean s2_yrs_at_lowissue_ind;
						Integer s2_ssns_per_adl_bin;
						Real s2_ssns_per_adl_bin_m;
						Real s2_fpmod;
						Real s2_fpmod_rm;
						Integer s2_ams_inclevel_bin;
						Real s2_ams_inclevel_bin_m;
						Integer s2_ams_college_tier_bin;
						Real s2_ams_college_tier_bin_m;
						Real s2_amsmod;
						Real s2_amsmod_rm;
						Real seg2_log_odds;
						Integer b1_s3_pos_sources_count;
						Integer b1_s3_pos_sources_count_bin;
						Real b1_s3_pos_sources_count_bin_m;
						Integer b1_s3_ver_lstadd_p;
						Integer b1_s3_ver_lstaddphn_p;
						Real b1_s3_verx;
						Real b1_s3_verx_m;
						Real b1_s3_vermod;
						Integer b0_s3_rc_fnamecount_bin;
						Real b0_s3_rc_fnamecount_bin_m;
						Integer b0_s3_cont_phn_p;
						Integer b0_s3_cont_phn_fst_p;
						Integer b0_s3_cont_phn_fst_nap6_p;
						Real b0_s3_cont_phn_fst_nap6_p_m;
						Real b0_s3_vermod;
						Real s3_vermod_om;
						Boolean s3_no_add1_sources;
						Boolean s3_hi_addrs_per_adl_c6;
						Boolean s3_no_pl_addrs_per_adl;
						Real s3_addprob_mod;
						Real s3_addprob_mod_om;
						Real s3_time_on_gong;
						Integer s3_phn_disc_zipmis;
						Integer s3_phn_disc_zipmis_hirisk;
						Integer s3_phn_prob;
						Real s3_phn_prob_m;
						Real s3_phnprob_mod;
						Real s3_phnprob_mod_om;
						Boolean s3_hi_ssns_per_adl_c6;
						Boolean s3_ssnprob;
						Real s3_ssnprob_mod;
						Real s3_ssnprob_mod_om;
						Real s3_fpmod_mod;
						Real s3_fpmod_om;
						Integer s3_ams_college_tier_bin;
						Real s3_ams_college_tier_bin_m;
						Integer s3_addrs_10yr_bin;
						Real s3_addrs_10yr_bin_m;
						Boolean s3_wealth_index_ind;
						Integer s3_attr_proflic_ind;
						Real seg3_log_odds;
						String np_segment;
						Real final_log_odds;
						Real odds;
						Real phat;
						Integer score_np;
						Integer _rva1008;
						Boolean scored_222s;
						Integer rva1008_2_0;
	//start adding 
			models.layout_modelout;
		end;
		
		debug_layout doModel(clam le) := TRANSFORM
	#else
	
		models.Layout_ModelOut doModel(clam le) := TRANSFORM
	#end
	
	truedid                          := le.truedid;
	adl_category                     := le.adlcategory;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	did_count                        := le.iid.didcount;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_phonezipflag                  := le.iid.phonezipflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_sources                       := le.iid.sources;
	rc_fnamecount                    := le.iid.firstcount;
	rc_addrcount                     := le.iid.addrcount;
	rc_numelever                     := le.iid.numelever;
	rc_phonetype                     := le.iid.phonetype;
	rc_altlname1_flag                := le.iid.altlastpop;
	rc_altlname2_flag                := le.iid.altlast2pop;
	combo_hphonescore                := le.iid.combo_hphonescore;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_lnamecount                 := le.iid.combo_lastcount;
	combo_addrcount                  := le.iid.combo_addrcount;
	combo_hphonecount                := le.iid.combo_hphonecount;
	combo_ssncount                   := le.iid.combo_ssncount;
	combo_dobcount                   := le.iid.combo_dobcount;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_unit_count                  := le.address_verification.input_address_information.unit_count;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
	add1_land_use_code               := le.address_verification.input_address_information.standardized_land_use_code;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	avg_lres                         := le.other_address_info.avg_lres;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
	gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	impulse_count                    := le.impulse.count;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_total_number_derogs         := le.total_number_derogs;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	attr_num_proflic30               := le.professional_license.proflic_count30;
	attr_num_proflic90               := le.professional_license.proflic_count90;
	attr_num_proflic180              := le.professional_license.proflic_count180;
	attr_num_proflic12               := le.professional_license.proflic_count12;
	attr_num_proflic24               := le.professional_license.proflic_count24;
	attr_num_proflic36               := le.professional_license.proflic_count36;
	attr_num_proflic60               := le.professional_license.proflic_count60;
	bankrupt                         := le.bjl.bankrupt;
	disposition                      := le.bjl.disposition;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
	bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_income_level_code            := le.student.income_level_code;
	ams_college_tier                 := le.student.college_tier;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	addr_stability                   := le.mobility_indicator;
	estimated_income                 := le.estimated_income;

NULL := -999999999;


BOOLEAN indexw(string source, string target, string delim) :=
	// (source = target) OR
	// (StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	// (source[1..length(target)+1] = target + delim) OR
	// (StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
	models.Common.findw_cpp( source,  target,  delim) > 0;

sysdate := Models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

_in_dob := Models.common.sas_date((string)(in_dob));

_rc_ssnlowissue := Models.common.sas_date((string)(rc_ssnlowissue));

add_unit := out_unit_desig != ' ';

add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

core_adl := (adl_category)[1..1] = '8';

single_did := did_count = 1;

nas12 := nas_summary = 12;

ver_nap6 := (nap_summary in [6]);

verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

contrary_phn := (nap_summary in [1]);

veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

impulse_flag := impulse_count > 0;

dismissed_bk := StringLib.StringToUpperCase(disposition) = 'DISMISSED';

bad_bk := dismissed_bk or filing_count >= 2 or bk_recent_count > 0 or bk_disposed_recent_count > 0 or bk_disposed_historical_count >= 2;

add_inval := StringLib.StringToUpperCase(trim(rc_addrvalflag, LEFT, RIGHT)) != 'V';

phn_cellpager := (rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']);

phn_nonus := (rc_phonetype in ['3', '4']);

name_change_flag := rc_altlname1_flag  or rc_altlname2_flag ;

ssn_priordob := rc_ssndobflag = '1' or rc_pwssndobflag = '1';

ssn_inval := rc_ssnvalflag = '1' or (rc_pwssnvalflag in ['1', '2', '3']);

phn_business := rc_hphonevalflag = '1';

phn_zipmismatch := rc_phonezipflag = '1' or rc_pwphonezipflag = '1';

contrary_ssn := nas_summary = 1;

verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

phn_disconnected := rc_hriskphoneflag = '5';

phn_highrisk2 := not((rc_hriskphoneflag in ['0', '7']));

add1_land_use_code_summary := map(
    (add1_land_use_code)[1..2] = ''              => '         ',
    ((add1_land_use_code)[1..2] in ['10', '70']) => 'SingleFam',
    ((add1_land_use_code)[1..2] in ['11', '19']) => 'MultiFam ',
                                                    'NonRes   ');

out_addr_type_summary := if((out_addr_type in ['H', 'P', 'R']), out_addr_type, 'Other');

gong_did_first_seen2 := if(length(trim(gong_did_first_seen, LEFT, RIGHT)) = 8 and (trim(gong_did_first_seen, LEFT))[1..4] >= '1800', (ut.DaysSince1900((trim(gong_did_first_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + min(31, if(max(1, (integer)(trim(gong_did_first_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(gong_did_first_seen, LEFT))[7..8]))) - 1, NULL);

gong_did_last_seen2 := if(length(trim(gong_did_last_seen, LEFT, RIGHT)) = 8 and (trim(gong_did_last_seen, LEFT))[1..4] >= '1800', (ut.DaysSince1900((trim(gong_did_last_seen, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(gong_did_last_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(gong_did_last_seen, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')) + min(31, if(max(1, (integer)(trim(gong_did_last_seen, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(gong_did_last_seen, LEFT))[7..8]))) - 1, NULL);

time_on_gong := if(gong_did_first_seen2 != NULL and gong_did_last_seen2 != NULL, 
									(gong_did_last_seen2 - gong_did_first_seen2) / 30.5, NULL);

s0_addr_stability_bin := map(
    (addr_stability in ['0', '1', '2']) => 0,
    (addr_stability in ['3', '4', '5']) => 1,
    (addr_stability in ['6']) 					=> 2,
                                           NULL);

s0_addr_stability_bin_m := map(
    s0_addr_stability_bin = 0 => 0.2742768595,
    s0_addr_stability_bin = 1 => 0.2062818336,
    s0_addr_stability_bin = 2 => 0.1581699346,
                                 0.2250346055);

bm1_s0_did_ver := map(
    not(core_adl)                                                             => 3,
    core_adl and not(single_did and rc_numelever > 3) or combo_dobscore = 255 => 2,
    combo_dobscore < 100                                                      => 1,
                                                                                 0);

bm1_s0_did_ver_m := map(
    bm1_s0_did_ver = 0 => 0.1944095477,
    bm1_s0_did_ver = 1 => 0.2315270936,
    bm1_s0_did_ver = 2 => 0.2432432432,
    bm1_s0_did_ver = 3 => 0.6902654867,
                          0.213514262);

bm1_s0_ver_phn := map(
											ver_nap6  => 0,
											NOT ver_nap6 and NOT verphn_p => 1,
                      2);

bm1_s0_verx := map(
    NOT nas12 or bm1_s0_ver_phn = 0 and nas12 => 0,
    bm1_s0_ver_phn = 1 and nas12  => 1,
    2);

bm1_s0_verx_m := map(
    bm1_s0_verx = 0 => 0.26,
    bm1_s0_verx = 1 => 0.2276243094,
    bm1_s0_verx = 2 => 0.191755153,
                       0.213514262);

bm1_s0_rc_addrcount_ind := rc_addrcount > 1;

bm1_s0_combo_dobcount_bin := map(
    combo_dobcount <= 2 => 0,
    combo_dobcount <= 4 => 1,
                           2);

bm1_s0_combo_dobcount_bin_m := map(
    bm1_s0_combo_dobcount_bin = 0 => 0.2546468401,
    bm1_s0_combo_dobcount_bin = 1 => 0.2342657343,
    bm1_s0_combo_dobcount_bin = 2 => 0.1709653648,
                                     0.213514262);

bm1_s0_vermod := -3.901640288 +
    bm1_s0_did_ver_m * 4.4202587779 +
    bm1_s0_verx_m * 5.13250582 +
    (integer)bm1_s0_rc_addrcount_ind * -0.22963591 +
    bm1_s0_combo_dobcount_bin_m * 3.0843078608;

bm0_s0_did_ver := map(
    not(core_adl)                                                             => 3,
    core_adl and not(single_did and rc_numelever > 3) or combo_dobscore = 255 => 2,
    combo_dobscore < 100                                                      => 1,
                                                                                 0);

bm0_s0_did_ver_ind := bm0_s0_did_ver > 0;

bm0_s0_ver_p := map(
    contrary_phn => 0,
    NOT contrary_phn and NOT veradd_p => 1,
	   2);

bm0_s0_verx := map(
    bm0_s0_ver_p = 0               => 0,
    bm0_s0_ver_p = 1               => 1,
    bm0_s0_ver_p = 2 and NOT nas12 => 2,
                                      3);

bm0_s0_verx_m := map(
    bm0_s0_verx = 0 => 0.3333333333,
    bm0_s0_verx = 1 => 0.2610132159,
    bm0_s0_verx = 2 => 0.2333333333,
    bm0_s0_verx = 3 => 0.2276923077,
                       0.2538035961);

bm0_s0_vermod := -2.392301402 +
    (integer)bm0_s0_did_ver_ind * 0.4872437186 +
    bm0_s0_verx_m * 4.8430207805;

s0_vermod_derog := if(add1_isbestmatch, exp(bm1_s0_vermod) / (1 + exp(bm1_s0_vermod)), exp(bm0_s0_vermod) / (1 + exp(bm0_s0_vermod)));

s0_crime_felony_bin := map(
    criminal_count = 0 and felony_count = 0 => 0,
    criminal_count > 0 and felony_count = 0 => 1,
                                               2);

s0_crime_felony_bin_m := map(
    s0_crime_felony_bin = 0 => 0.2204674668,
    s0_crime_felony_bin = 1 => 0.2840909091,
    s0_crime_felony_bin = 2 => 0.3636363636,
                               0.2250346055);

s0_liens_cnt_bin := map(
    liens_recent_unreleased_count = 0                                        => 0,
    liens_historical_unreleased_ct = 0 and liens_recent_unreleased_count > 0 => 1,
                                                                                2);

s0_liens_cnt_bin_m := map(
    s0_liens_cnt_bin = 0 => 0.2148349163,
    s0_liens_cnt_bin = 1 => 0.288248337,
    s0_liens_cnt_bin = 2 => 0.3152173913,
                            0.2250346055);

s0_attr_totnum_derogs_bin := min(if(attr_total_number_derogs = NULL, -NULL, attr_total_number_derogs), 2);

s0_attr_totnum_derogs_bin_m := map(
    s0_attr_totnum_derogs_bin = 0 => 0.2117073171,
    s0_attr_totnum_derogs_bin = 1 => 0.213559322,
    s0_attr_totnum_derogs_bin = 2 => 0.2791932059,
                                     0.2250346055);

s0_attr_num_nonderogs_bin := map(
    attr_num_nonderogs <= 1 => 0,
    attr_num_nonderogs = 2  => 1,
    attr_num_nonderogs = 3  => 2,
    attr_num_nonderogs = 4  => 3,
                               4);

s0_attr_num_nonderogs_bin_m := map(
    s0_attr_num_nonderogs_bin = 0 => 0.2633663366,
    s0_attr_num_nonderogs_bin = 1 => 0.245508982,
    s0_attr_num_nonderogs_bin = 2 => 0.2213788741,
    s0_attr_num_nonderogs_bin = 3 => 0.2085561497,
    s0_attr_num_nonderogs_bin = 4 => 0.1970588235,
                                     0.2250346055);

s0_bk_bin := map(
    disposition = ' '                               => 1,
    (disposition in ['Discharge NA', 'Discharged']) => 0,
                                                       2);

s0_bk_bin2 := map(
    bad_bk     => 2,
    s0_bk_bin = 1 => 1,
                     0);

s0_bk_bin2_m := map(
    s0_bk_bin2 = 0 => 0.1910331384,
    s0_bk_bin2 = 1 => 0.2292891502,
    s0_bk_bin2 = 2 => 0.2906574394,
                      0.2250346055);

s0_derogmod_d := -6.055017812 +
    (integer)impulse_flag * 1.7230320134 +
    s0_crime_felony_bin_m * 4.9619977926 +
    s0_liens_cnt_bin_m * 4.1766523753 +
    s0_attr_totnum_derogs_bin_m * 2.768874775 +
    s0_attr_num_nonderogs_bin_m * 4.8723489101 +
    s0_bk_bin2_m * 4.4911409113;

s0_derogmod_dm := exp(s0_derogmod_d) / (1 + exp(s0_derogmod_d));

s0_add_unit_apt_2 := if(NOT add_unit and NOT add_apt, 0, NULL);

s0_add_unit_apt_1 := if(NOT add_unit and add_apt, 1, s0_add_unit_apt_2);

s0_add_unit_apt := if(add_unit, 2, s0_add_unit_apt_1);

s0_add_prob := map(
    s0_add_unit_apt = 0 and NOT add_inval => 0,
    s0_add_unit_apt = 1 and NOT add_inval => 1,
    add_inval                             => 2,
                                             3);

s0_add_prob_m := map(
    s0_add_prob = 0 => 0.2165932452,
    s0_add_prob = 1 => 0.224,
    s0_add_prob = 2 => 0.2363636364,
    s0_add_prob = 3 => 0.2703804348,
                       0.2250346055);

s0_hi_addrs_per_adl := addrs_per_adl >= 17;

s0_hi_addrs_per_adl_c6 := addrs_per_adl_c6 > 0;

s0_mod_addrprob := -2.510225689 +
    s0_add_prob_m * 5.2049664665 +
    (integer)s0_hi_addrs_per_adl * 0.5714229028 +
    (integer)s0_hi_addrs_per_adl_c6 * 0.365264708;

s0_mod_addrprob_dm := exp(s0_mod_addrprob) / (1 + exp(s0_mod_addrprob));

s0_phn_zipmis_bus := phn_business  or NOT phn_business and phn_zipmismatch;

s0_phn_zipmis_bus_cell := map(
    s0_phn_zipmis_bus                           => 2,
    NOT s0_phn_zipmis_bus and phn_cellpager => 1,
                                                   0);

s0_phn_prob := if(s0_phn_zipmis_bus_cell = 2 or phn_nonus, 2, s0_phn_zipmis_bus_cell);

s0_phn_prob_m := map(
    s0_phn_prob = 0 => 0.2140405616,
    s0_phn_prob = 1 => 0.2409090909,
    s0_phn_prob = 2 => 0.2596153846,
                       0.2250346055);

s0_gong_hist_summary := map(
    not(gong_did_phone_ct >= 3) and not(gong_did_addr_ct >= 3) and not(gong_did_first_ct >= 3)       => 0,
    not(gong_did_phone_ct >= 3) and sum((integer)(gong_did_addr_ct >= 3),(integer)(gong_did_first_ct >= 3))=1          => 1,
    
                                                                                                        2);

s0_gong_hist_summary_m := map(
    s0_gong_hist_summary = 0 => 0.2163840459,
    s0_gong_hist_summary = 1 => 0.2644927536,
    s0_gong_hist_summary = 2 => 0.2676767677,
                                0.2250346055);


s0_time_on_gong := if(time_on_gong = NULL, 62, time_on_gong);

s0_mod_phnprob := -3.648949242 +
    s0_phn_prob_m * 4.4706434839 +
    s0_gong_hist_summary_m * 7.3767371886 +
    s0_time_on_gong * -0.00423571;

s0_mod_phnprob_dm := exp(s0_mod_phnprob) / (1 + exp(s0_mod_phnprob));

s0_ssn_lowissue_age := if(min(_rc_ssnlowissue, _in_dob) = NULL, NULL, (_rc_ssnlowissue - _in_dob) / 365.2);

s0_ssn_lowissue_age_cap := s0_ssn_lowissue_age < 0 or s0_ssn_lowissue_age > 25;

s0_yrsince_rc_ssnlowissue := if(min(sysdate, _rc_ssnlowissue) = NULL, NULL, truncate((sysdate - _rc_ssnlowissue) / 365.25));

s0_yrsince_rc_ssnlowissue_cap := s0_yrsince_rc_ssnlowissue <= 18 or s0_yrsince_rc_ssnlowissue > 55;

s0_ssns_per_adl_2 := ssns_per_adl >= 2;

s0_mod_ssnprob := -1.451292165 +
    (integer)s0_ssn_lowissue_age_cap * 0.2017092998 +
    (integer)s0_yrsince_rc_ssnlowissue_cap * 0.5788254923 +
    (integer)s0_ssns_per_adl_2 * 0.3280897772;

s0_mod_ssnprob_dm := exp(s0_mod_ssnprob) / (1 + exp(s0_mod_ssnprob));

s0_fpmod := -4.312276139 +
    s0_mod_addrprob_dm * 4.3059087094 +
    s0_mod_phnprob_dm * 4.2572653351 +
    s0_mod_ssnprob_dm * 4.9539962437;

s0_fpmod_dm := exp(s0_fpmod) / (1 + exp(s0_fpmod));

seg0_log_odds := -4.389586413 +
    estimated_income * -5.204197E-6 +
    s0_addr_stability_bin_m * 4.7196586229 +
    s0_vermod_derog * 1.9411310446 +
    s0_derogmod_dm * 4.119650696 +
    s0_fpmod_dm * 4.6439947001;

s1_ams_college_tier_bin := map(
    (ams_college_tier in ['1', '2', '3']) => 0,
    ams_college_tier = '4'                  => 1,
    ams_college_tier in ['0', '5', '6']    => 2,
                                             NULL);

s1_ams_college_tier_bin_m := map(
    s1_ams_college_tier_bin = 0 => 0.0403458213,
    s1_ams_college_tier_bin = 1 => 0.0828402367,
    s1_ams_college_tier_bin = 2 => 0.097692965,
                                   0.0947200849);

s1_addrs_15yr_cap := min(if(addrs_15yr = NULL, -NULL, addrs_15yr), 4);

s1_addr_stability_bin := map(
    addr_stability <= '2'            => 0,
    addr_stability = '3'             => 1,
    (addr_stability in ['4', '5']) => 2,
                                      3);

s1_addr_stability_bin_m := map(
    s1_addr_stability_bin = 0 => 0.1273071462,
    s1_addr_stability_bin = 1 => 0.120754717,
    s1_addr_stability_bin = 2 => 0.0881420419,
    s1_addr_stability_bin = 3 => 0.0591614015,
                                 0.0947200849);

s1_address_recency := map(
    attr_addrs_last30 > 0 => 8,
    attr_addrs_last90 > 0 => 7,
    attr_addrs_last12 > 0 => 6,
    attr_addrs_last24 > 0 => 5,
    attr_addrs_last36 > 0 => 4,
    addrs_5yr > 0         => 3,
    addrs_10yr > 0        => 2,
    addrs_15yr > 0        => 1,
                             0);

s1_add_recency_bin := map(
    s1_address_recency <= 3        => s1_address_recency,
    (s1_address_recency in [4, 5]) => 4,
    (s1_address_recency in [6, 7]) => 5,
                                      6);

s1_add_recency_bin_m := map(
    s1_add_recency_bin = 0 => 0.0631578947,
    s1_add_recency_bin = 1 => 0.0692717584,
    s1_add_recency_bin = 2 => 0.0826330532,
    s1_add_recency_bin = 3 => 0.0977393617,
    s1_add_recency_bin = 4 => 0.0993814433,
    s1_add_recency_bin = 5 => 0.115270936,
    s1_add_recency_bin = 6 => 0.171875,
                              0.0947200849);

s1_aptflag := out_addr_type_summary = 'H' or add1_land_use_code_summary = 'MultiFam' or add1_unit_count >= 5;

s1_add1_purchamt_ind := add1_purchase_amount > 0;

s1_appl_fam := map(
    add1_applicant_owned and add1_family_owned => 3,
    add1_applicant_owned and not add1_family_owned => 2,
    not add1_applicant_owned and add1_family_owned  => 1,
                                                          0);

s1_owned_bin := map(
    s1_appl_fam = 0 and add1_occupant_owned                    => 0,
    s1_appl_fam = 0 and not add1_occupant_owned or s1_appl_fam = 1 => 1,
                                                                      s1_appl_fam);

s1_owned_bin_m := map(
    s1_owned_bin = 0 => 0.1571125265,
    s1_owned_bin = 1 => 0.1322525597,
    s1_owned_bin = 2 => 0.0943298969,
    s1_owned_bin = 3 => 0.0763590392,
                        0.0947200849);

s1_propmod_p := -3.832718048 +
    s1_add_recency_bin_m * 8.5549206936 +
    (integer)s1_aptflag * 0.318136907 +
    (integer)s1_add1_purchamt_ind * -0.21764572 +
    s1_owned_bin_m * 8.0031738947;

s1_propmod_pm := exp(s1_propmod_p) / (1 + exp(s1_propmod_p));

bm1_s1_combo_addrcount_bin := map(
    combo_addrcount <= 1 => 0,
    combo_addrcount = 2  => 1,
    combo_addrcount = 3  => 2,
    combo_addrcount = 4  => 3,
                            4);

bm1_s1_combo_addrcount_bin_m := map(
    bm1_s1_combo_addrcount_bin = 0 => 0.1190184049,
    bm1_s1_combo_addrcount_bin = 1 => 0.1111111111,
    bm1_s1_combo_addrcount_bin = 2 => 0.0752438458,
    bm1_s1_combo_addrcount_bin = 3 => 0.0612612613,
    bm1_s1_combo_addrcount_bin = 4 => 0.0483271375,
                                      0.0872180451);

bm1_s1_combo_dobcount_bin := map(
    combo_dobcount = 0  => 0,
    combo_dobcount <= 2 => 1,
    combo_dobcount = 3  => 2,
    combo_dobcount = 4  => 3,
    combo_dobcount = 5  => 4,
                           5);

bm1_s1_combo_dobcount_bin_m := map(
    bm1_s1_combo_dobcount_bin = 0 => 0.1355932203,
    bm1_s1_combo_dobcount_bin = 1 => 0.1156316916,
    bm1_s1_combo_dobcount_bin = 2 => 0.0824453169,
    bm1_s1_combo_dobcount_bin = 3 => 0.0788381743,
    bm1_s1_combo_dobcount_bin = 4 => 0.0670807453,
    bm1_s1_combo_dobcount_bin = 5 => 0.0661157025,
                                     0.0872180451);

bm1_s1_prop_vermod := -3.448253985 +
    bm1_s1_combo_addrcount_bin_m * 7.0159010403 +
    combo_hphonecount * -0.367607758 +
    bm1_s1_combo_dobcount_bin_m * 7.4876783149;

bm0_s1_rc_addrcount_ind := rc_addrcount > 1;

bm0_s1_combo_lnamecount_bin := map(
    combo_lnamecount <= 1 => 0,
    combo_lnamecount <= 3 => 1,
    combo_lnamecount = 4  => 2,
                             3);

bm0_s1_combo_lnamecount_bin_m := map(
    bm0_s1_combo_lnamecount_bin = 0 => 0.2602739726,
    bm0_s1_combo_lnamecount_bin = 1 => 0.1490196078,
    bm0_s1_combo_lnamecount_bin = 2 => 0.1027568922,
    bm0_s1_combo_lnamecount_bin = 3 => 0.0980735552,
                                       0.1236316806);

bm0_s1_combo_hphnscr_ind := combo_hphonescore >= 80 and combo_hphonescore <= 100;

bm0_s1_prop_vermod := -2.367774274 +
    (integer)bm0_s1_rc_addrcount_ind * -0.586842626 +
    bm0_s1_combo_lnamecount_bin_m * 5.3190148072 +
    (integer)bm0_s1_combo_hphnscr_ind * -0.322270541;

s1_vermod_pm := if(add1_isbestmatch, exp(bm1_s1_prop_vermod) / (1 + exp(bm1_s1_prop_vermod)), exp(bm0_s1_prop_vermod) / (1 + exp(bm0_s1_prop_vermod)));

s1_add_unit_apt := map(
    not add_unit and not add_apt => 0,
    not add_unit and add_apt     => 2,
                                    1);

s1_add_prob := map(
    s1_add_unit_apt = 2 and not add_inval => 3,
    s1_add_unit_apt = 1 and not add_inval => 2,
    add_inval                             => 1,
                                             0);

s1_add_prob_m := map(
    s1_add_prob = 0 => 0.0904294299,
    s1_add_prob = 1 => 0.1202531646,
    s1_add_prob = 2 => 0.1340206186,
    s1_add_prob = 3 => 0.1805555556,
                       0.0947200849);

s1_slim_addr_info := combo_addrcount = 0 or avg_lres = 0 or addrs_per_adl = 0;

s1_hi_addrs_per_adl := addrs_per_adl >= 15;

s1_fpmod_addprob := -3.047890901 +
    s1_add_prob_m * 7.3754221621 +
    (integer)s1_slim_addr_info * 0.5193950685 +
    (integer)s1_hi_addrs_per_adl * 0.3980551565;

s1_fpmod_addprob_pm := exp(s1_fpmod_addprob) / (1 + exp(s1_fpmod_addprob));

s1_lo_combo_hphonescore := combo_hphonescore < 80 or combo_hphonescore = 255;

s1_hi_gong_did_phnadd := not(gong_did_phone_ct < 4 and gong_did_addr_ct < 4);


s1_time_on_gong := if(time_on_gong = NULL, 70, time_on_gong);

s1_fpmod_phnprob := -2.028896443 +
    (integer)s1_lo_combo_hphonescore * 0.426432432 +
    (integer)s1_hi_gong_did_phnadd * 0.7340642451 +
    s1_time_on_gong * -0.007189457;

s1_fpmod_phnprob_pm := exp(s1_fpmod_phnprob) / (1 + exp(s1_fpmod_phnprob));

s1_ssn_lowissue_age := if(min(_rc_ssnlowissue, _in_dob) = NULL, NULL, truncate((_rc_ssnlowissue - _in_dob) / 365.25));

s1_yrs_at_lowissue_ind := s1_ssn_lowissue_age <= 0 or s1_ssn_lowissue_age > 18;

s1_yrsince_rc_ssnlowissue := if(min(sysdate, _rc_ssnlowissue) = NULL, NULL, truncate((sysdate - _rc_ssnlowissue) / 365.25));

s1_yrsince_rc_ssnlowissue_ind := s1_yrsince_rc_ssnlowissue <= 25 or s1_yrsince_rc_ssnlowissue > 55;

s1_ssns_per_adl_bin := if(ssns_per_adl = 0, 4, min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 4));

s1_ssns_per_adl_bin_m := map(
    s1_ssns_per_adl_bin = 1 => 0.0889040862,
    s1_ssns_per_adl_bin = 2 => 0.1056129985,
    s1_ssns_per_adl_bin = 3 => 0.1265822785,
    s1_ssns_per_adl_bin = 4 => 0.2142857143,
                               0.0947200849);

s1_hi_ssns_per_adl_c6 := ssns_per_adl_c6 >= 1;

s1_fpmod_ssnprob := -3.372328192 +
    (integer)s1_yrs_at_lowissue_ind * 0.4481392763 +
    (integer)s1_yrsince_rc_ssnlowissue_ind * 0.506665567 +
    s1_ssns_per_adl_bin_m * 7.7216771487 +
    (integer)s1_hi_ssns_per_adl_c6 * 0.2329585168;

s1_fpmod_ssnprob_pm := exp(s1_fpmod_ssnprob) / (1 + exp(s1_fpmod_ssnprob));

s1_fpmod := -4.479309264 +
    s1_fpmod_addprob_pm * 6.4998402832 +
    s1_fpmod_phnprob_pm * 7.7308853928 +
    s1_fpmod_ssnprob_pm * 7.9899208007 +
    (integer)name_change_flag * 0.268392817;

s1_fpmod_pm := exp(s1_fpmod) / (1 + exp(s1_fpmod));

seg1_log_odds := -5.646839044 +
    s1_ams_college_tier_bin_m * 17.541982829 +
    estimated_income * -5.812829E-6 +
    s1_addrs_15yr_cap * 0.124147664 +
    s1_addr_stability_bin_m * 4.0046429084 +
    s1_propmod_pm * 3.1178071761 +
    s1_vermod_pm * 4.2952077945 +
    s1_fpmod_pm * 5.1296676943;

s2_addr_stability_bin := map(
    addr_stability <= '1' => 0,
    addr_stability <= '4' => 1,
                           2);

s2_addr_stability_bin_m := map(
    s2_addr_stability_bin = 0 => 0.1803108808,
    s2_addr_stability_bin = 1 => 0.1422261484,
    s2_addr_stability_bin = 2 => 0.1227336123,
                                 0.1479979726);

b1_s2_combo_dobscr_ind := combo_dobscore = 100;

b1_s2_renter_vermod := -1.537449311 + (integer)b1_s2_combo_dobscr_ind * -0.444923277;

														
b0_s2_pos_sources_count := sum((integer)indexw(rc_sources,'EQ',' ,'),
                              (integer)indexw(rc_sources,'SL',' ,'),
                              (integer)indexw(rc_sources,'VO',' ,'),
                              (integer)(indexw(rc_sources,'EM',' ,') or indexw(rc_sources,'VO',' ,')));
																	 
b0_s2_pos_sources_count_bin := map(b0_s2_pos_sources_count = 0  => 0,
																	 b0_s2_pos_sources_count <= 3 => 1,
																																	 2);

b0_s2_pos_sources_count_bin_m := map(
																			b0_s2_pos_sources_count_bin = 0 => 0.2,
																			b0_s2_pos_sources_count_bin = 1 => 0.1642905635,
																			b0_s2_pos_sources_count_bin = 2 => 0.0862944162,
																																				 0.1554896142);

b0_s2_combo_lnamecount_ind := combo_lnamecount <= 2;

b0_s2_combo_dobscr_ind := combo_dobscore = 100;

b0_s2_cont_nap6_p := map(ver_nap6        => 2,
												contrary_phn     => 1,
																					0);

b0_s2_verx := map(
    contrary_ssn or b0_s2_cont_nap6_p = 2 => 0,
    contrary_phn 		                          => 1,
                                                 2);

b0_s2_verx_m := map(
    b0_s2_verx = 0 => 0.2686567164,
    b0_s2_verx = 1 => 0.1578947368,
    b0_s2_verx = 2 => 0.1504539559,
                      0.1554896142);

b0_s2_renter_vermod := -3.84750103 +
    b0_s2_pos_sources_count_bin_m * 10.848001705 +
    (integer)b0_s2_combo_lnamecount_ind * -0.483933778 +
    (integer)b0_s2_combo_dobscr_ind * -0.387221265 +
    b0_s2_verx_m * 6.2793170431;

s2_vermod_rm := if(add1_isbestmatch, exp(b1_s2_renter_vermod) / (1 + exp(b1_s2_renter_vermod)), exp(b0_s2_renter_vermod) / (1 + exp(b0_s2_renter_vermod)));

s2_ssn_lowissue_age := if(min(_rc_ssnlowissue, _in_dob) = NULL, NULL, truncate((_rc_ssnlowissue - _in_dob) / 365.25));

s2_yrs_at_lowissue_ind := s2_ssn_lowissue_age <= 0 or s2_ssn_lowissue_age > 18;

s2_ssns_per_adl_bin := if(ssns_per_adl = 0, 3, min(if(ssns_per_adl = NULL, -NULL, ssns_per_adl), 3));

s2_ssns_per_adl_bin_m := map(
    s2_ssns_per_adl_bin = 1 => 0.1412156033,
    s2_ssns_per_adl_bin = 2 => 0.169921875,
    s2_ssns_per_adl_bin = 3 => 0.2362204724,
                               0.1479979726);

s2_fpmod := -2.913397017 +
    (integer)name_change_flag * 0.2577635645 +
    (integer)s2_yrs_at_lowissue_ind * 0.3316188604 +
    s2_ssns_per_adl_bin_m * 6.4705514501;

s2_fpmod_rm := exp(s2_fpmod) / (1 + exp(s2_fpmod));

s2_ams_inclevel_bin := map(
    (ams_income_level_code in [' ', 'A', 'B', 'C']) 			=> 0,
    (ams_income_level_code in ['D'])           						=> 1,
    (ams_income_level_code in ['E'])           						=> 2,
    (ams_income_level_code in ['F','G','H','I','J','K'])  => 3,
                                                  NULL);

s2_ams_inclevel_bin_m := map(
    s2_ams_inclevel_bin = 0 => 0.1627758235,
    s2_ams_inclevel_bin = 1 => 0.1181818182,
    s2_ams_inclevel_bin = 2 => 0.0977443609,
    s2_ams_inclevel_bin = 3 => 0.0850694444,
                               0.1479979726);

s2_ams_college_tier_bin := map(
    ams_college_tier = '0'                  => 3,
    (ams_college_tier in ['1', '2', '3']) => 0,
    ams_college_tier = '4'                  => 1,
    ams_college_tier > '4'                  => 2,
                                             NULL);

s2_ams_college_tier_bin_m := map(
    s2_ams_college_tier_bin = 0 => 0.037037037,
    s2_ams_college_tier_bin = 1 => 0.1025641026,
    s2_ams_college_tier_bin = 2 => 0.1454545455,
    s2_ams_college_tier_bin = 3 => 0.1555240793,
                                   0.1479979726);

s2_amsmod := -3.933695325 +
    s2_ams_inclevel_bin_m * 6.2760545767 +
    s2_ams_college_tier_bin_m * 8.2215275019;

s2_amsmod_rm := exp(s2_amsmod) / (1 + exp(s2_amsmod));

seg2_log_odds := -5.402723639 +
    estimated_income * -5.17867E-6 +
    s2_addr_stability_bin_m * 7.6069925377 +
    s2_vermod_rm * 4.9188491395 +
    s2_fpmod_rm * 4.8557874303 +
    s2_amsmod_rm * 8.0547801187;


b1_s3_pos_sources_count := sum((integer)indexw(rc_sources, 'EB', ' ,') , 
															(integer)indexw(rc_sources, 'EM', ' ,') , 
															(integer)indexw(rc_sources, 'PL', ' ,') , 
															(integer)indexw(rc_sources, 'SL', ' ,') , 
															(integer)indexw(rc_sources, 'VO', ' ,') , 
															(integer)indexw(rc_sources, 'W', ' ,') , 
															(integer)(indexw(rc_sources, 'EM', ' ,') or indexw(rc_sources, 'VO', ' ,')));

b1_s3_pos_sources_count_bin := map(
    b1_s3_pos_sources_count = 0  => 0,
    b1_s3_pos_sources_count <= 2 => 1,
                                    2);

b1_s3_pos_sources_count_bin_m := map(
    b1_s3_pos_sources_count_bin = 0 => 0.1590909091,
    b1_s3_pos_sources_count_bin = 1 => 0.1206896552,
    b1_s3_pos_sources_count_bin = 2 => 0.1084812623,
                                       0.1332423829);

b1_s3_ver_lstadd_p := map(
    not veradd_p              => 0,
    not verlst_p and veradd_p => 1,
                              2);

b1_s3_ver_lstaddphn_p := map(
    b1_s3_ver_lstadd_p = 0 or b1_s3_ver_lstadd_p = 1 and not verphn_p                  => 0,
    b1_s3_ver_lstadd_p = 1 and verphn_p or b1_s3_ver_lstadd_p = 2 and not verphn_p     => 1,
                                                                                          2);

b1_s3_verx := if(ver_nap6, 0.5, b1_s3_ver_lstaddphn_p);

b1_s3_verx_m := map(
    b1_s3_verx = 0   => 0.1596752368,
    b1_s3_verx = 0.5 => 0.1358024691,
    b1_s3_verx = 1   => 0.1238938053,
    b1_s3_verx = 2   => 0.1165048544,
                        0.1332423829);

b1_s3_vermod := -3.957762493 +
    b1_s3_pos_sources_count_bin_m * 7.9148843707 +
    b1_s3_verx_m * 7.5823081031;

b0_s3_rc_fnamecount_bin := map(
    rc_fnamecount <= 1 => 0,
    rc_fnamecount = 2  => 1,
                          2);

b0_s3_rc_fnamecount_bin_m := map(
    b0_s3_rc_fnamecount_bin = 0 => 0.21,
    b0_s3_rc_fnamecount_bin = 1 => 0.1775147929,
    b0_s3_rc_fnamecount_bin = 2 => 0.1276041667,
                                   0.168297456);

b0_s3_cont_phn_p := map(
    verphn_p                          => 0,
    not contrary_phn and not verphn_p => 1,
                                         2);

b0_s3_cont_phn_fst_p := if(verfst_p, -1, b0_s3_cont_phn_p);

b0_s3_cont_phn_fst_nap6_p := if(ver_nap6, 2, b0_s3_cont_phn_fst_p);

b0_s3_cont_phn_fst_nap6_p_m := map(
    b0_s3_cont_phn_fst_nap6_p = -1 => 0.11,
    b0_s3_cont_phn_fst_nap6_p = 0  => 0.1741935484,
    b0_s3_cont_phn_fst_nap6_p = 1  => 0.1767676768,
    b0_s3_cont_phn_fst_nap6_p = 2  => 0.2465753425,
                                      0.168297456);

b0_s3_vermod := -3.756046701 +
    b0_s3_rc_fnamecount_bin_m * 6.2527072684 +
    b0_s3_cont_phn_fst_nap6_p_m * 6.3614532762;

s3_vermod_om := if(add1_isbestmatch, exp(b1_s3_vermod) / (1 + exp(b1_s3_vermod)), exp(b0_s3_vermod) / (1 + exp(b0_s3_vermod)));

s3_no_add1_sources := add1_source_count = 0;

s3_hi_addrs_per_adl_c6 := addrs_per_adl_c6 > 0;

s3_no_pl_addrs_per_adl := pl_addrs_per_adl = 0;

s3_addprob_mod := -2.550798371 +
    (integer)s3_no_add1_sources * 0.3356642283 +
    (integer)s3_hi_addrs_per_adl_c6 * 0.2901961983 +
    (integer)s3_no_pl_addrs_per_adl * 0.6884463119;

s3_addprob_mod_om := exp(s3_addprob_mod) / (1 + exp(s3_addprob_mod));


s3_time_on_gong := if(time_on_gong = NULL, 57, time_on_gong);

s3_phn_disc_zipmis := map(
    phn_disconnected                          => 2,
    not phn_disconnected  and phn_zipmismatch => 1,
                                                 0);

s3_phn_disc_zipmis_hirisk := map(
    s3_phn_disc_zipmis = 0 and not phn_highrisk2 => 0,
    s3_phn_disc_zipmis = 0 and phn_highrisk2 => 1,
    s3_phn_disc_zipmis = 1                       => 2,
                                                    3);

s3_phn_prob := if(phn_business, 3, s3_phn_disc_zipmis_hirisk);

s3_phn_prob_m := map(
										s3_phn_prob = 0 => 0.133441383,
										s3_phn_prob = 1 => 0.1498287671,
										s3_phn_prob = 2 => 0.201754386,
										s3_phn_prob = 3 => 0.2272727273,
																		 0.144365104);

s3_phnprob_mod := -2.393361239 +
									s3_time_on_gong * -0.006782339 +
									s3_phn_prob_m * 6.8269757877;

s3_phnprob_mod_om := exp(s3_phnprob_mod) / (1 + exp(s3_phnprob_mod));

s3_hi_ssns_per_adl_c6 := ssns_per_adl_c6 >= 1;

s3_ssnprob := ssn_priordob or ssn_inval or combo_ssncount = 0 or combo_ssnscore != 100 or (inputssncharflag in ['1', '2', '4']) or invalid_ssns_per_adl > 0;

s3_ssnprob_mod := -1.883095688 +
    (integer)s3_hi_ssns_per_adl_c6 * 0.2958134068 +
    (integer)s3_ssnprob * 0.7171929547;

s3_ssnprob_mod_om := exp(s3_ssnprob_mod) / (1 + exp(s3_ssnprob_mod));

s3_fpmod_mod := -4.22929057 +
    s3_addprob_mod_om * 5.4152320172 +
    s3_phnprob_mod_om * 6.3698612058 +
    s3_ssnprob_mod_om * 4.9585876387;

s3_fpmod_om := exp(s3_fpmod_mod) / (1 + exp(s3_fpmod_mod));

s3_ams_college_tier_bin := map(
    ams_college_tier = '0'                  => 3,
    (ams_college_tier in ['1', '2', '3']) => 0,
    ams_college_tier = '4'                  => 1,
    ams_college_tier > '4'                  => 2,
                                             NULL);

s3_ams_college_tier_bin_m := map(
    s3_ams_college_tier_bin = 0 => 0.0432098765,
    s3_ams_college_tier_bin = 1 => 0.0438596491,
    s3_ams_college_tier_bin = 2 => 0.0816326531,
    s3_ams_college_tier_bin = 3 => 0.1563048823,
                                   0.144365104);

s3_addrs_10yr_bin := map(
    addrs_10yr <= 1 => 0,
    addrs_10yr <= 3 => 1,
    addrs_10yr = 4  => 2,
    addrs_10yr <= 6 => 3,
                       4);

s3_addrs_10yr_bin_m := map(
    s3_addrs_10yr_bin = 0 => 0.1112,
    s3_addrs_10yr_bin = 1 => 0.1520417029,
    s3_addrs_10yr_bin = 2 => 0.16,
    s3_addrs_10yr_bin = 3 => 0.1949152542,
    s3_addrs_10yr_bin = 4 => 0.2048192771,
                             0.144365104);

s3_wealth_index_ind := wealth_index > '3';

s3_attr_proflic_ind := if(attr_num_proflic30 > 0 or attr_num_proflic90 > 0 or attr_num_proflic180 > 0 or attr_num_proflic12 > 0 or attr_num_proflic24 > 0 or attr_num_proflic36 > 0 or attr_num_proflic60 > 0, 1, 0);

seg3_log_odds := -5.39692383 +
    s3_vermod_om * 3.240292443 +
    s3_fpmod_om * 4.377758576 +
    s3_ams_college_tier_bin_m * 10.866528569 +
    s3_addrs_10yr_bin_m * 6.4920461358 +
    (integer)s3_wealth_index_ind * -0.522458031 +
    s3_attr_proflic_ind * -0.65158372;

np_segment := map(attr_total_number_derogs > 0 or 
									liens_recent_unreleased_count > 0 or 
									liens_historical_unreleased_ct > 0 or 
									(integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'L2', ', ') > 0 or 
									(integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'LI', ', ') > 0 or 
									attr_eviction_count > 0 or impulse_count > 0 or (rc_bansflag in ['1', '2']) or 
									(integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'BA', ', ') > 0 or 
									bankrupt  or filing_count > 0 or bk_recent_count > 0 or rc_decsflag = '1' or 
									(integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'DS', ', ') > 0 => '0 Derog ',
									add1_naprop = 4 or property_owned_total > 0                                                        => '1 Owner ',
									trim(trim(out_addr_type, LEFT), LEFT, RIGHT) = 'H' or add1_naprop = 1 or add1_unit_count > 3       => '2 Renter',
                                                                                                                     '3 Other ');

final_log_odds := map(
    np_segment = '0 Derog ' => seg0_log_odds,
    np_segment = '1 Owner ' => seg1_log_odds,
    np_segment = '2 Renter' => seg2_log_odds,
                               seg3_log_odds);

odds := 1 / 20;

phat := exp(final_log_odds) / (1 + exp(final_log_odds));

score_np := round(-40 * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + 700);

_rva1008 := min(900, if(max(501, score_np) = NULL, -NULL, max(501, score_np)));

scored_222s := if(max(property_owned_total, property_sold_total) = NULL, 
											NULL, 
											sum(if(property_owned_total = NULL, 0, property_owned_total), 
											if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= '7' 
											or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0 
											or (integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'L2', ',') > 0 
											or (integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'LI', ',') > 0 
											or criminal_count > 0 or (rc_bansflag in ['1', '2']) 
											or (integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'BA', ',') > 0 
											or bankrupt or filing_count > 0 or bk_recent_count > 0 or rc_decsflag = '1' or truedid;

rva1008_2_0 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, _rva1008);
#if (RVA_debug)
		self.clam                         		:= le;
		self.truedid                         := truedid;
		self.adl_category                    := adl_category;
		self.out_unit_desig                  := out_unit_desig;
		self.out_sec_range                   := out_sec_range;
		self.out_addr_type                   := out_addr_type;
		self.in_dob                          := in_dob;
		self.nas_summary                     := nas_summary;
		self.nap_summary                     := nap_summary;
		self.did_count                       := did_count;
		self.rc_hriskphoneflag               := rc_hriskphoneflag;
		self.rc_hphonetypeflag               := rc_hphonetypeflag;
		self.rc_hphonevalflag                := rc_hphonevalflag;
		self.rc_phonezipflag                 := rc_phonezipflag;
		self.rc_pwphonezipflag               := rc_pwphonezipflag;
		self.rc_decsflag                     := rc_decsflag;
		self.rc_ssndobflag                   := rc_ssndobflag;
		self.rc_pwssndobflag                 := rc_pwssndobflag;
		self.rc_ssnvalflag                   := rc_ssnvalflag;
		self.rc_pwssnvalflag                 := rc_pwssnvalflag;
		self.rc_ssnlowissue                  := rc_ssnlowissue;
		self.rc_addrvalflag                  := rc_addrvalflag;
		self.rc_dwelltype                    := rc_dwelltype;
		self.rc_bansflag                     := rc_bansflag;
		self.rc_sources                      := rc_sources;
		self.rc_fnamecount                   := rc_fnamecount;
		self.rc_addrcount                    := rc_addrcount;
		self.rc_numelever                    := rc_numelever;
		self.rc_phonetype                    := rc_phonetype;
		self.rc_altlname1_flag               := rc_altlname1_flag;
		self.rc_altlname2_flag               := rc_altlname2_flag;
		self.combo_hphonescore               := combo_hphonescore;
		self.combo_ssnscore                  := combo_ssnscore;
		self.combo_dobscore                  := combo_dobscore;
		self.combo_lnamecount                := combo_lnamecount;
		self.combo_addrcount                 := combo_addrcount;
		self.combo_hphonecount               := combo_hphonecount;
		self.combo_ssncount                  := combo_ssncount;
		self.combo_dobcount                  := combo_dobcount;
		self.add1_isbestmatch                := add1_isbestmatch;
		self.add1_unit_count                 := add1_unit_count;
		self.add1_source_count               := add1_source_count;
		self.add1_applicant_owned            := add1_applicant_owned;
		self.add1_occupant_owned             := add1_occupant_owned;
		self.add1_family_owned               := add1_family_owned;
		self.add1_naprop                     := add1_naprop;
		self.add1_purchase_amount            := add1_purchase_amount;
		self.add1_land_use_code              := add1_land_use_code;
		self.property_owned_total            := property_owned_total;
		self.property_sold_total             := property_sold_total;
		self.avg_lres                        := avg_lres;
		self.addrs_5yr                       := addrs_5yr;
		self.addrs_10yr                      := addrs_10yr;
		self.addrs_15yr                      := addrs_15yr;
		self.gong_did_first_seen             := gong_did_first_seen;
		self.gong_did_last_seen              := gong_did_last_seen;
		self.gong_did_phone_ct               := gong_did_phone_ct;
		self.gong_did_addr_ct                := gong_did_addr_ct;
		self.gong_did_first_ct               := gong_did_first_ct;
		self.inputssncharflag                := inputssncharflag;
		self.ssns_per_adl                    := ssns_per_adl;
		self.addrs_per_adl                   := addrs_per_adl;
		self.ssns_per_adl_c6                 := ssns_per_adl_c6;
		self.addrs_per_adl_c6                := addrs_per_adl_c6;
		self.pl_addrs_per_adl                := pl_addrs_per_adl;
		self.invalid_ssns_per_adl            := invalid_ssns_per_adl;
		self.impulse_count                   := impulse_count;
		self.attr_addrs_last30               := attr_addrs_last30;
		self.attr_addrs_last90               := attr_addrs_last90;
		self.attr_addrs_last12               := attr_addrs_last12;
		self.attr_addrs_last24               := attr_addrs_last24;
		self.attr_addrs_last36               := attr_addrs_last36;
		self.attr_total_number_derogs        := attr_total_number_derogs;
		self.attr_eviction_count             := attr_eviction_count;
		self.attr_num_nonderogs              := attr_num_nonderogs;
		self.attr_num_proflic30              := attr_num_proflic30;
		self.attr_num_proflic90              := attr_num_proflic90;
		self.attr_num_proflic180             := attr_num_proflic180;
		self.attr_num_proflic12              := attr_num_proflic12;
		self.attr_num_proflic24              := attr_num_proflic24;
		self.attr_num_proflic36              := attr_num_proflic36;
		self.attr_num_proflic60              := attr_num_proflic60;
		self.bankrupt                        := bankrupt;
		self.disposition                     := disposition;
		self.filing_count                    := filing_count;
		self.bk_recent_count                 := bk_recent_count;
		self.bk_disposed_recent_count        := bk_disposed_recent_count;
		self.bk_disposed_historical_count    := bk_disposed_historical_count;
		self.liens_recent_unreleased_count   := liens_recent_unreleased_count;
		self.liens_historical_unreleased_ct  := liens_historical_unreleased_ct;
		self.criminal_count                  := criminal_count;
		self.felony_count                    := felony_count;
		self.ams_income_level_code           := ams_income_level_code;
		self.ams_college_tier                := ams_college_tier;
		self.wealth_index                    := wealth_index;
		self.input_dob_match_level           := input_dob_match_level;
		self.addr_stability                  := addr_stability;
		self.estimated_income                := estimated_income;
		self.sysdate                         := sysdate;
		self._in_dob                         := _in_dob;
		self._rc_ssnlowissue                 := _rc_ssnlowissue;
		self.add_unit                        := add_unit;
		self.add_apt                         := add_apt;
		self.core_adl                        := core_adl;
		self.single_did                      := single_did;
		self.nas12                           := nas12;
		self.ver_nap6                        := ver_nap6;
		self.verphn_p                        := verphn_p;
		self.contrary_phn                    := contrary_phn;
		self.veradd_p                        := veradd_p;
		self.impulse_flag                    := impulse_flag;
		self.dismissed_bk                    := dismissed_bk;
		self.bad_bk                          := bad_bk;
		self.add_inval                       := add_inval;
		self.phn_cellpager                   := phn_cellpager;
		self.phn_nonus                       := phn_nonus;
		self.name_change_flag                := name_change_flag;
		self.ssn_priordob                    := ssn_priordob;
		self.ssn_inval                       := ssn_inval;
		self.phn_business                    := phn_business;
		self.phn_zipmismatch                 := phn_zipmismatch;
		self.contrary_ssn                    := contrary_ssn;
		self.verlst_p                        := verlst_p;
		self.verfst_p                        := verfst_p;
		self.phn_disconnected                := phn_disconnected;
		self.phn_highrisk2                   := phn_highrisk2;
		self.add1_land_use_code_summary      := add1_land_use_code_summary;
		self.out_addr_type_summary           := out_addr_type_summary;
		self.gong_did_first_seen2            := gong_did_first_seen2;
		self.gong_did_last_seen2             := gong_did_last_seen2;
		self.time_on_gong                    := time_on_gong;
		self.s0_addr_stability_bin           := s0_addr_stability_bin;
		self.s0_addr_stability_bin_m         := s0_addr_stability_bin_m;
		self.bm1_s0_did_ver                  := bm1_s0_did_ver;
		self.bm1_s0_did_ver_m                := bm1_s0_did_ver_m;
		self.bm1_s0_ver_phn                  := bm1_s0_ver_phn;
		self.bm1_s0_verx                     := bm1_s0_verx;
		self.bm1_s0_verx_m                   := bm1_s0_verx_m;
		self.bm1_s0_rc_addrcount_ind         := bm1_s0_rc_addrcount_ind;
		self.bm1_s0_combo_dobcount_bin       := bm1_s0_combo_dobcount_bin;
		self.bm1_s0_combo_dobcount_bin_m     := bm1_s0_combo_dobcount_bin_m;
		self.bm1_s0_vermod                   := bm1_s0_vermod;
		self.bm0_s0_did_ver                  := bm0_s0_did_ver;
		self.bm0_s0_did_ver_ind              := bm0_s0_did_ver_ind;
		self.bm0_s0_ver_p                    := bm0_s0_ver_p;
		self.bm0_s0_verx                     := bm0_s0_verx;
		self.bm0_s0_verx_m                   := bm0_s0_verx_m;
		self.bm0_s0_vermod                   := bm0_s0_vermod;
		self.s0_vermod_derog                 := s0_vermod_derog;
		self.s0_crime_felony_bin             := s0_crime_felony_bin;
		self.s0_crime_felony_bin_m           := s0_crime_felony_bin_m;
		self.s0_liens_cnt_bin                := s0_liens_cnt_bin;
		self.s0_liens_cnt_bin_m              := s0_liens_cnt_bin_m;
		self.s0_attr_totnum_derogs_bin       := s0_attr_totnum_derogs_bin;
		self.s0_attr_totnum_derogs_bin_m     := s0_attr_totnum_derogs_bin_m;
		self.s0_attr_num_nonderogs_bin       := s0_attr_num_nonderogs_bin;
		self.s0_attr_num_nonderogs_bin_m     := s0_attr_num_nonderogs_bin_m;
		self.s0_bk_bin                       := s0_bk_bin;
		self.s0_bk_bin2                      := s0_bk_bin2;
		self.s0_bk_bin2_m                    := s0_bk_bin2_m;
		self.s0_derogmod_d                   := s0_derogmod_d;
		self.s0_derogmod_dm                  := s0_derogmod_dm;
		self.s0_add_unit_apt_2               := s0_add_unit_apt_2;
		self.s0_add_unit_apt_1               := s0_add_unit_apt_1;
		self.s0_add_unit_apt                 := s0_add_unit_apt;
		self.s0_add_prob                     := s0_add_prob;
		self.s0_add_prob_m                   := s0_add_prob_m;
		self.s0_hi_addrs_per_adl             := s0_hi_addrs_per_adl;
		self.s0_hi_addrs_per_adl_c6          := s0_hi_addrs_per_adl_c6;
		self.s0_mod_addrprob                 := s0_mod_addrprob;
		self.s0_mod_addrprob_dm              := s0_mod_addrprob_dm;
		self.s0_phn_zipmis_bus               := s0_phn_zipmis_bus;
		self.s0_phn_zipmis_bus_cell          := s0_phn_zipmis_bus_cell;
		self.s0_phn_prob                     := s0_phn_prob;
		self.s0_phn_prob_m                   := s0_phn_prob_m;
		self.s0_gong_hist_summary            := s0_gong_hist_summary;
		self.s0_gong_hist_summary_m          := s0_gong_hist_summary_m;
		self.s0_time_on_gong                 := s0_time_on_gong;
		self.s0_mod_phnprob                  := s0_mod_phnprob;
		self.s0_mod_phnprob_dm               := s0_mod_phnprob_dm;
		self.s0_ssn_lowissue_age             := s0_ssn_lowissue_age;
		self.s0_ssn_lowissue_age_cap         := s0_ssn_lowissue_age_cap;
		self.s0_yrsince_rc_ssnlowissue       := s0_yrsince_rc_ssnlowissue;
		self.s0_yrsince_rc_ssnlowissue_cap   := s0_yrsince_rc_ssnlowissue_cap;
		self.s0_ssns_per_adl_2               := s0_ssns_per_adl_2;
		self.s0_mod_ssnprob                  := s0_mod_ssnprob;
		self.s0_mod_ssnprob_dm               := s0_mod_ssnprob_dm;
		self.s0_fpmod                        := s0_fpmod;
		self.s0_fpmod_dm                     := s0_fpmod_dm;
		self.seg0_log_odds                   := seg0_log_odds;
		self.s1_ams_college_tier_bin         := s1_ams_college_tier_bin;
		self.s1_ams_college_tier_bin_m       := s1_ams_college_tier_bin_m;
		self.s1_addrs_15yr_cap               := s1_addrs_15yr_cap;
		self.s1_addr_stability_bin           := s1_addr_stability_bin;
		self.s1_addr_stability_bin_m         := s1_addr_stability_bin_m;
		self.s1_address_recency              := s1_address_recency;
		self.s1_add_recency_bin              := s1_add_recency_bin;
		self.s1_add_recency_bin_m            := s1_add_recency_bin_m;
		self.s1_aptflag                      := s1_aptflag;
		self.s1_add1_purchamt_ind            := s1_add1_purchamt_ind;
		self.s1_appl_fam                     := s1_appl_fam;
		self.s1_owned_bin                    := s1_owned_bin;
		self.s1_owned_bin_m                  := s1_owned_bin_m;
		self.s1_propmod_p                    := s1_propmod_p;
		self.s1_propmod_pm                   := s1_propmod_pm;
		self.bm1_s1_combo_addrcount_bin      := bm1_s1_combo_addrcount_bin;
		self.bm1_s1_combo_addrcount_bin_m    := bm1_s1_combo_addrcount_bin_m;
		self.bm1_s1_combo_dobcount_bin       := bm1_s1_combo_dobcount_bin;
		self.bm1_s1_combo_dobcount_bin_m     := bm1_s1_combo_dobcount_bin_m;
		self.bm1_s1_prop_vermod              := bm1_s1_prop_vermod;
		self.bm0_s1_rc_addrcount_ind         := bm0_s1_rc_addrcount_ind;
		self.bm0_s1_combo_lnamecount_bin     := bm0_s1_combo_lnamecount_bin;
		self.bm0_s1_combo_lnamecount_bin_m   := bm0_s1_combo_lnamecount_bin_m;
		self.bm0_s1_combo_hphnscr_ind        := bm0_s1_combo_hphnscr_ind;
		self.bm0_s1_prop_vermod              := bm0_s1_prop_vermod;
		self.s1_vermod_pm                    := s1_vermod_pm;
		self.s1_add_unit_apt                 := s1_add_unit_apt;
		self.s1_add_prob                     := s1_add_prob;
		self.s1_add_prob_m                   := s1_add_prob_m;
		self.s1_slim_addr_info               := s1_slim_addr_info;
		self.s1_hi_addrs_per_adl             := s1_hi_addrs_per_adl;
		self.s1_fpmod_addprob                := s1_fpmod_addprob;
		self.s1_fpmod_addprob_pm             := s1_fpmod_addprob_pm;
		self.s1_lo_combo_hphonescore         := s1_lo_combo_hphonescore;
		self.s1_hi_gong_did_phnadd           := s1_hi_gong_did_phnadd;
		self.s1_time_on_gong                 := s1_time_on_gong;
		self.s1_fpmod_phnprob                := s1_fpmod_phnprob;
		self.s1_fpmod_phnprob_pm             := s1_fpmod_phnprob_pm;
		self.s1_ssn_lowissue_age             := s1_ssn_lowissue_age;
		self.s1_yrs_at_lowissue_ind          := s1_yrs_at_lowissue_ind;
		self.s1_yrsince_rc_ssnlowissue       := s1_yrsince_rc_ssnlowissue;
		self.s1_yrsince_rc_ssnlowissue_ind   := s1_yrsince_rc_ssnlowissue_ind;
		self.s1_ssns_per_adl_bin             := s1_ssns_per_adl_bin;
		self.s1_ssns_per_adl_bin_m           := s1_ssns_per_adl_bin_m;
		self.s1_hi_ssns_per_adl_c6           := s1_hi_ssns_per_adl_c6;
		self.s1_fpmod_ssnprob                := s1_fpmod_ssnprob;
		self.s1_fpmod_ssnprob_pm             := s1_fpmod_ssnprob_pm;
		self.s1_fpmod                        := s1_fpmod;
		self.s1_fpmod_pm                     := s1_fpmod_pm;
		self.seg1_log_odds                   := seg1_log_odds;
		self.s2_addr_stability_bin           := s2_addr_stability_bin;
		self.s2_addr_stability_bin_m         := s2_addr_stability_bin_m;
		self.b1_s2_combo_dobscr_ind          := b1_s2_combo_dobscr_ind;
		self.b1_s2_renter_vermod             := b1_s2_renter_vermod;
		self.b0_s2_pos_sources_count         := b0_s2_pos_sources_count;
		self.b0_s2_pos_sources_count_bin     := b0_s2_pos_sources_count_bin;
		self.b0_s2_pos_sources_count_bin_m   := b0_s2_pos_sources_count_bin_m;
		self.b0_s2_combo_lnamecount_ind      := b0_s2_combo_lnamecount_ind;
		self.b0_s2_combo_dobscr_ind          := b0_s2_combo_dobscr_ind;
		self.b0_s2_cont_nap6_p               := b0_s2_cont_nap6_p;
		self.b0_s2_verx                      := b0_s2_verx;
		self.b0_s2_verx_m                    := b0_s2_verx_m;
		self.b0_s2_renter_vermod             := b0_s2_renter_vermod;
		self.s2_vermod_rm                    := s2_vermod_rm;
		self.s2_ssn_lowissue_age             := s2_ssn_lowissue_age;
		self.s2_yrs_at_lowissue_ind          := s2_yrs_at_lowissue_ind;
		self.s2_ssns_per_adl_bin             := s2_ssns_per_adl_bin;
		self.s2_ssns_per_adl_bin_m           := s2_ssns_per_adl_bin_m;
		self.s2_fpmod                        := s2_fpmod;
		self.s2_fpmod_rm                     := s2_fpmod_rm;
		self.s2_ams_inclevel_bin             := s2_ams_inclevel_bin;
		self.s2_ams_inclevel_bin_m           := s2_ams_inclevel_bin_m;
		self.s2_ams_college_tier_bin         := s2_ams_college_tier_bin;
		self.s2_ams_college_tier_bin_m       := s2_ams_college_tier_bin_m;
		self.s2_amsmod                       := s2_amsmod;
		self.s2_amsmod_rm                    := s2_amsmod_rm;
		self.seg2_log_odds                   := seg2_log_odds;
		self.b1_s3_pos_sources_count         := b1_s3_pos_sources_count;
		self.b1_s3_pos_sources_count_bin     := b1_s3_pos_sources_count_bin;
		self.b1_s3_pos_sources_count_bin_m   := b1_s3_pos_sources_count_bin_m;
		self.b1_s3_ver_lstadd_p              := b1_s3_ver_lstadd_p;
		self.b1_s3_ver_lstaddphn_p           := b1_s3_ver_lstaddphn_p;
		self.b1_s3_verx                      := b1_s3_verx;
		self.b1_s3_verx_m                    := b1_s3_verx_m;
		self.b1_s3_vermod                    := b1_s3_vermod;
		self.b0_s3_rc_fnamecount_bin         := b0_s3_rc_fnamecount_bin;
		self.b0_s3_rc_fnamecount_bin_m       := b0_s3_rc_fnamecount_bin_m;
		self.b0_s3_cont_phn_p                := b0_s3_cont_phn_p;
		self.b0_s3_cont_phn_fst_p            := b0_s3_cont_phn_fst_p;
		self.b0_s3_cont_phn_fst_nap6_p       := b0_s3_cont_phn_fst_nap6_p;
		self.b0_s3_cont_phn_fst_nap6_p_m     := b0_s3_cont_phn_fst_nap6_p_m;
		self.b0_s3_vermod                    := b0_s3_vermod;
		self.s3_vermod_om                    := s3_vermod_om;
		self.s3_no_add1_sources              := s3_no_add1_sources;
		self.s3_hi_addrs_per_adl_c6          := s3_hi_addrs_per_adl_c6;
		self.s3_no_pl_addrs_per_adl          := s3_no_pl_addrs_per_adl;
		self.s3_addprob_mod                  := s3_addprob_mod;
		self.s3_addprob_mod_om               := s3_addprob_mod_om;
		self.s3_time_on_gong                 := s3_time_on_gong;
		self.s3_phn_disc_zipmis              := s3_phn_disc_zipmis;
		self.s3_phn_disc_zipmis_hirisk       := s3_phn_disc_zipmis_hirisk;
		self.s3_phn_prob                     := s3_phn_prob;
		self.s3_phn_prob_m                   := s3_phn_prob_m;
		self.s3_phnprob_mod                  := s3_phnprob_mod;
		self.s3_phnprob_mod_om               := s3_phnprob_mod_om;
		self.s3_hi_ssns_per_adl_c6           := s3_hi_ssns_per_adl_c6;
		self.s3_ssnprob                      := s3_ssnprob;
		self.s3_ssnprob_mod                  := s3_ssnprob_mod;
		self.s3_ssnprob_mod_om               := s3_ssnprob_mod_om;
		self.s3_fpmod_mod                    := s3_fpmod_mod;
		self.s3_fpmod_om                     := s3_fpmod_om;
		self.s3_ams_college_tier_bin         := s3_ams_college_tier_bin;
		self.s3_ams_college_tier_bin_m       := s3_ams_college_tier_bin_m;
		self.s3_addrs_10yr_bin               := s3_addrs_10yr_bin;
		self.s3_addrs_10yr_bin_m             := s3_addrs_10yr_bin_m;
		self.s3_wealth_index_ind             := s3_wealth_index_ind;
		self.s3_attr_proflic_ind             := s3_attr_proflic_ind;
		self.seg3_log_odds                   := seg3_log_odds;
		self.np_segment                      := np_segment;
		self.final_log_odds                  := final_log_odds;
		self.odds                            := odds;
		self.phat                            := phat;
		self.score_np                        := score_np;
		self._rva1008                        := _rva1008;
		self.scored_222s                     := scored_222s;
		self.rva1008_2_0                     := rva1008_2_0;
#end
		self.seq                             := le.seq;

		inCalif := isCalifornia and (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		self.ri := riskwise.rv3autoReasonCodes( le, 4, inCalif, PreScreenOptOut :=False);

		self.score := map(
				self.ri[1].hri in ['91','92','93','94'] => (string)((integer)self.ri[1].hri + 10),
				self.ri[1].hri='95' => '222', // per bug 52525, 95 returns a score of 222
				self.ri[1].hri='35' => '000',
				(string)rva1008_2_0
			);

END;

model := Project(clam, doModel(left));
Return model;

END;

