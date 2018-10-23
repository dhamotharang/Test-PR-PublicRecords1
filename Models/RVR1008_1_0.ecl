IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT RVR1008_1_0(GROUPED DATASET(risk_indicators.layout_boca_shell) clam, BOOLEAN inCalif=FALSE, BOOLEAN PreScreenOptOut=FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;
	
	#if(MODEL_DEBUG)
		layout_debug := RECORD
			risk_indicators.layout_boca_shell clam;
			
			/* Model Input Variables */
			BOOLEAN truedid;
			STRING adl_category;
			STRING out_unit_desig;
			STRING out_sec_range;
			STRING out_addr_type;
			STRING out_addr_status;
			STRING in_dob;
			INTEGER nas_summary;
			INTEGER nap_summary;
			INTEGER did_count;
			INTEGER rc_dirsaddr_lastscore;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			STRING rc_phonevalflag;
			STRING rc_hphonevalflag;
			STRING rc_phonezipflag;
			STRING rc_pwphonezipflag;
			STRING rc_hriskaddrflag;
			STRING rc_decsflag;
			STRING rc_ssndobflag;
			STRING rc_pwssndobflag;
			STRING rc_ssnvalflag;
			STRING rc_pwssnvalflag;
			UNSIGNED rc_ssnlowissue;
			STRING rc_areacodesplitflag;
			STRING rc_addrvalflag;
			STRING rc_dwelltype;
			STRING rc_bansflag;
			STRING rc_sources;
			INTEGER rc_addrcount;
			INTEGER rc_ssncount;
			INTEGER rc_numelever;
			BOOLEAN rc_ssnmiskeyflag;
			BOOLEAN rc_hphonemiskeyflag;
			BOOLEAN rc_addrmiskeyflag;
			STRING rc_addrcommflag;
			STRING rc_phonetype;
			STRING rc_ziptypeflag;
			STRING rc_zipclass;
			BOOLEAN rc_altlname1_flag;
			BOOLEAN rc_altlname2_flag;
			INTEGER combo_addrscore;
			INTEGER combo_ssnscore;
			INTEGER combo_dobscore;
			INTEGER combo_addrcount;
			INTEGER combo_dobcount;
			INTEGER eq_count;
			UNSIGNED pr_count;
			UNSIGNED w_count;
			INTEGER add1_address_score;
			BOOLEAN add1_isbestmatch;
			INTEGER add1_unit_count;
			STRING add1_avm_land_use;
			INTEGER add1_avm_automated_valuation;
			INTEGER add1_avm_med_fips;
			INTEGER add1_avm_med_geo11;
			INTEGER add1_avm_med_geo12;
			BOOLEAN add1_applicant_owned;
			BOOLEAN add1_occupant_owned;
			BOOLEAN add1_family_owned;
			INTEGER add1_naprop;
			STRING add1_mortgage_type;
			STRING add1_financing_type;
			INTEGER property_owned_total;
			INTEGER property_sold_total;
			INTEGER addrs_5yr;
			INTEGER addrs_10yr;
			INTEGER addrs_15yr;
			BOOLEAN addrs_prison_history;
			STRING telcordia_type;
			INTEGER recent_disconnects;
			STRING gong_did_first_seen;
			STRING gong_did_last_seen;
			INTEGER gong_did_phone_ct;
			INTEGER gong_did_addr_ct;
			INTEGER gong_did_first_ct;
			INTEGER ssns_per_adl;
			INTEGER phones_per_adl;
			INTEGER adlperssn_count;
			INTEGER ssns_per_addr;
			INTEGER phones_per_addr;
			INTEGER ssns_per_adl_c6;
			INTEGER addrs_per_adl_c6;
			INTEGER phones_per_adl_c6;
			INTEGER addrs_per_ssn_c6;
			INTEGER adls_per_addr_c6;
			INTEGER ssns_per_addr_c6;
			INTEGER adls_per_phone_c6;
			INTEGER vo_addrs_per_adl;
			INTEGER pl_addrs_per_adl;
			INTEGER impulse_count;
			INTEGER attr_total_number_derogs;
			INTEGER attr_eviction_count;
			INTEGER attr_num_nonderogs;
			INTEGER attr_num_proflic30;
			INTEGER attr_num_proflic90;
			INTEGER attr_num_proflic180;
			INTEGER attr_num_proflic12;
			INTEGER attr_num_proflic24;
			INTEGER attr_num_proflic36;
			INTEGER attr_num_proflic60;
			BOOLEAN bankrupt;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_recent_released_count;
			INTEGER liens_historical_released_count;
			INTEGER liens_unrel_sc_ct;
			INTEGER criminal_count;
			INTEGER felony_count;
			STRING ams_age;
			STRING ams_college_code;
			STRING ams_income_level_code;
			STRING wealth_index;
			STRING input_dob_match_level;
			STRING addr_stability;
			INTEGER archive_date;
			
			/* Model Intermediate Variables */
			INTEGER today;
			INTEGER gong_did_first_seen2;
			INTEGER gong_did_last_seen2;
			REAL time_on_gong;
			BOOLEAN contrary_ssn;
			BOOLEAN verfst_s;
			BOOLEAN verlst_s;
			BOOLEAN veradd_s;
			BOOLEAN verssn_s;
			BOOLEAN ver_nas479;
			BOOLEAN contrary_phn;
			BOOLEAN verfst_p;
			BOOLEAN verlst_p;
			BOOLEAN veradd_p;
			BOOLEAN verphn_p;
			BOOLEAN ver_nap6;
			INTEGER ver_phncount;
			BOOLEAN nas12;
			BOOLEAN name_change_flag;
			BOOLEAN add_highrisk;
			BOOLEAN add_pobox;
			BOOLEAN add_inval;
			BOOLEAN add_unit;
			BOOLEAN add_sec;
			BOOLEAN add_apt;
			BOOLEAN phn_disconnected;
			BOOLEAN phn_inval;
			BOOLEAN phn_nonus;
			BOOLEAN phn_highrisk;
			BOOLEAN phn_highrisk2;
			BOOLEAN phn_notpots;
			BOOLEAN phn_zipmismatch;
			BOOLEAN phn_business;
			BOOLEAN ssn_priordob;
			BOOLEAN ssn_inval;
			BOOLEAN ssn_issued18;
			BOOLEAN add1_avm_hit;
			INTEGER add1_avm_med;
			REAL add1_avm_to_med_ratio;
			BOOLEAN source_tot_l2;
			BOOLEAN source_tot_li;
			BOOLEAN lien_rec_unrel_flag;
			BOOLEAN lien_hist_unrel_flag;
			BOOLEAN lien_flag;
			BOOLEAN source_tot_ba;
			BOOLEAN bk_flag;
			BOOLEAN source_tot_ds;
			BOOLEAN ssn_deceased;
			INTEGER pk_impulse_count;
			INTEGER pk_adl_cat_deceased;
			STRING bs_own_rent;
			INTEGER bs_attr_derog_flag;
			INTEGER bs_attr_eviction_flag;
			INTEGER bs_attr_derog_flag2;
			STRING np_segment;
			BOOLEAN core_adl;
			BOOLEAN single_did;
			INTEGER s01_did_ver;
			INTEGER s01_ver_fst_lst;
			INTEGER s01_ver_fst_lst_add;
			REAL s01_verx;
			INTEGER s01_rc_addrcount_bin;
			INTEGER s01_rc_ssncount_cap;
			BOOLEAN s01_pr_count_ind;
			BOOLEAN s01_w_count_ind;
			REAL s01_did_ver_m;
			REAL s01_verx_m;
			REAL s01_rc_addrcount_bin_m;
			REAL s01_rc_ssncount_cap_m;
			REAL derog_isb1;
			BOOLEAN s00_ssn_addr_miskey_ind;
			INTEGER s00_ver_fst_lst;
			REAL s00_verx;
			INTEGER s00_rc_ssncount_cap;
			INTEGER s00_combo_dobcount_cap;
			BOOLEAN s00_add1_addscr_ind;
			INTEGER s00_pr_count_cap;
			REAL s00_verx_m;
			REAL s00_rc_ssncount_cap_m;
			REAL s00_combo_dobcount_cap_m;
			REAL s00_pr_count_cap_m;
			REAL derog_isb0;
			REAL vermod_dm;
			REAL s0_addrs_15yr_bin;
			REAL s0_addr_stability_bin;
			REAL s0_addrs_15yr_bin_m;
			REAL s0_addr_stability_bin_m;
			INTEGER s0_liens_recent_unrel_cnt_cap;
			INTEGER s0_liens_recent_rel_cnt_cap;
			INTEGER s0_liens_hist_rel_cnt_cap;
			INTEGER s0_liens_rel_bin;
			INTEGER s0_liens_unrel_sc_ct_cap;
			INTEGER s0_attr_num_nonderogs_bin;
			INTEGER s0_criminal_count_bin;
			BOOLEAN s0_felony_count_ind;
			INTEGER s0_crim_fel_bin;
			INTEGER s0_impulse_cnt_cap;
			INTEGER s0_attr_eviction_count_cap;
			REAL s0_liens_recent_unrel_cnt_cap_m;
			REAL s0_liens_rel_bin_m;
			REAL s0_liens_unrel_sc_ct_cap_m;
			REAL s0_attr_num_nonderogs_bin_m;
			REAL s0_crim_fel_bin_m;
			REAL s0_impulse_cnt_cap_m;
			REAL s0_attr_eviction_count_cap_m;
			REAL derogmodel_dm;
			REAL derog_dm;
			BOOLEAN s0_add1_avm_to_med_ratio_ind;
			INTEGER s0_ssns_per_adl_bin;
			INTEGER s0_phones_per_adl_bin;
			INTEGER s0_adlperssn_count_bin;
			BOOLEAN s0_ssn_per_addr_ind;
			BOOLEAN s0_phones_per_addr_ind;
			INTEGER s0_ssns_per_adl_c6_cap;
			INTEGER s0_addrs_per_ssn_c6_cap;
			INTEGER s0_ssns_per_addr_c6_cap;
			INTEGER s0_vo_addrs_per_adl_bin;
			REAL s0_ssns_per_adl_bin_m;
			REAL s0_phones_per_adl_bin_m;
			REAL s0_adlperssn_count_bin_m;
			REAL s0_ssns_per_adl_c6_cap_m;
			REAL s0_addrs_per_ssn_c6_cap_m;
			REAL s0_ssns_per_addr_c6_cap_m;
			REAL s0_vo_addrs_per_adl_bin_m;
			REAL velocity_derog;
			REAL velocity_dm;
			BOOLEAN s0_add1_hr_mortgage_type;
			INTEGER s0_financing_mort_type;
			INTEGER s0_appl_fam;
			INTEGER s0_owned_bin;
			INTEGER s0_naprop_propowned_bin;
			REAL s0_financing_mort_type_m;
			REAL s0_owned_bin_m;
			REAL s0_naprop_propowned_bin_m;
			REAL property_derog;
			REAL property_dm;
			BOOLEAN s0_hi_addrs_per_adl_c6;
			BOOLEAN s0_lo_combo_addrscore;
			INTEGER s0_add_apt_unit;
			REAL s0_add_prob;
			REAL s0_add_prob_m;
			REAL addprob_derog;
			REAL addprob_dm;
			BOOLEAN s0_recent_disconnects_ind;
			INTEGER s0_phn_disc;
			INTEGER s0_phn_disc_inval;
			INTEGER s0_phn_disc_inval_zipmis;
			INTEGER s0_phn_prob;
			REAL s0_phn_prob_m;
			INTEGER s0_pk_area_code_split;
			BOOLEAN s0_lo_rc_dirsaddr_lastscore;
			BOOLEAN s0_hi_gong_did_phone_ct;
			BOOLEAN s0_hi_gong_did_addr_ct;
			BOOLEAN s0_hi_gong_did_first_ct;
			INTEGER s0_gong_hist_summary;
			REAL s0_time_on_gong;
			REAL phnprob_derog;
			REAL phnprob_dm;
			INTEGER _rc_ssnlowissue_1;
			INTEGER yrsince_rc_ssnlowissue_1;
			INTEGER _in_dob_1;
			INTEGER yrs_at_lowissue_1;
			BOOLEAN s0_yrs_at_lowissue_gt25;
			INTEGER s0_yrsince_rc_ssnlowissue_bin;
			BOOLEAN s0_lo_combo_ssnscore;
			REAL s0_yrsince_rc_ssnlowissue_bin_m;
			REAL ssnprob_derog;
			REAL ssnprob_dm;
			REAL fpmod_derog;
			REAL fpmod_dm;
			REAL dm_outest;
			INTEGER s1_addrs_5yr_cap;
			INTEGER s1_wealth_index_bin;
			INTEGER s1_addr_stability_bin;
			INTEGER s1_attr_proflic_ind;
			REAL s1_addrs_5yr_cap_m;
			REAL s1_wealth_index_bin_m;
			REAL s1_addr_stability_bin_m;
			INTEGER s1_ams_age_bin;
			INTEGER s1_ams_college_cd_bin;
			INTEGER s1_ams_income_level_code_bin;
			REAL s1_ams_age_bin_m;
			REAL s1_ams_college_cd_bin_m;
			REAL s1_ams_income_level_code_bin_m;
			INTEGER s1_adlperssn_count_bin;
			INTEGER s1_phones_per_adl_c6_cap;
			INTEGER s1_adls_per_addr_c6_bin;
			REAL s1_adlperssn_count_bin_m;
			REAL s1_phones_per_adl_c6_cap_m;
			REAL s1_adls_per_addr_c6_bin_m;
			INTEGER s11_combo_dobcount_bin;
			BOOLEAN s11_combo_ssnscr_ind;
			INTEGER s11_pr_count_cap;
			REAL s11_combo_dobcount_bin_m;
			REAL s11_pr_count_cap_m;
			REAL vermod_isb1_or;
			INTEGER s10_combo_addrcount_bin;
			INTEGER s10_combo_dobcount_bin;
			INTEGER s10_pr_count_cap;
			REAL s10_combo_addrcount_bin_m;
			REAL s10_combo_dobcount_bin_m;
			REAL s10_pr_count_cap_m;
			REAL vermod_isb0_or;
			REAL vermod_or;
			INTEGER s1_add_e412;
			BOOLEAN s1_hi_addrs_per_adl_c6;
			BOOLEAN s1_lo_combo_addrscore;
			INTEGER s1_add_apt_unit;
			INTEGER s1_add_prob;
			REAL s1_add_prob_m;
			REAL addprob_ownerrenter;
			REAL addprob_or;
			BOOLEAN s1_lo_rc_dirsaddr_lastscore;
			BOOLEAN s1_hi_gong_did_phone_ct;
			REAL s1_time_on_gong;
			BOOLEAN s1_recent_disconnects_ind;
			INTEGER s1_phn_disc;
			INTEGER s1_phn_disc_zipmis;
			INTEGER s1_phn_prob;
			REAL s1_phn_prob_m;
			REAL phnprob_ownerrenter;
			REAL phnprob_or;
			BOOLEAN s1_yrs_at_lowissue_ind;
			INTEGER s1_yrsince_rc_ssnlowissue_bin;
			INTEGER s1_yrsince_rc_ssnlowissue_bin_;
			REAL s1_yrsince_rc_ssnlowissue_bin_m;
			BOOLEAN s1_lo_combo_ssnscore;
			REAL ssnprob_ownerrenter;
			REAL ssnprob_or;
			REAL fpmod_ownerrenter;
			REAL fpmod_or;
			REAL or_outest;
			INTEGER s2_addrs_10yr_cap;
			INTEGER s2_wealth_index_bin;
			REAL s2_addrs_10yr_cap_m;
			REAL s2_wealth_index_bin_m;
			INTEGER s2_ams_age_bin;
			INTEGER s2_ams_college_cd_bin;
			INTEGER s2_ams_income_level_code_bin;
			REAL s2_ams_age_bin_m;
			REAL s2_ams_college_cd_bin_m;
			REAL s2_ams_income_level_code_bin_m;
			REAL amsmod_other;
			REAL amsmod_om;
			INTEGER s2_phones_per_adl_bin;
			INTEGER s2_adlperssn_count_bin;
			INTEGER s2_phones_per_addr_bin;
			INTEGER s2_addrs_per_adl_c6_cap;
			INTEGER s2_addrs_per_ssn_c6_cap;
			INTEGER s2_adls_per_addr_c6_cap;
			BOOLEAN s2_adls_per_phone_c6_ind;
			BOOLEAN s2_vo_addrs_per_adl_ind;
			BOOLEAN s2_pl_addrs_per_adl_ind;
			REAL s2_phones_per_adl_bin_m;
			REAL s2_adlperssn_count_bin_m;
			REAL s2_phones_per_addr_bin_m;
			REAL s2_addrs_per_adl_c6_cap_m;
			REAL s2_addrs_per_ssn_c6_cap_m;
			REAL s2_adls_per_addr_c6_cap_m;
			REAL velocitymod_other;
			REAL velocitymod_om;
			INTEGER s21_rc_addrcount_bin;
			INTEGER s21_combo_dobcount_bin;
			INTEGER s21_eq_cnt_bin;
			BOOLEAN s21_pr_count_ind;
			REAL s21_rc_addrcount_bin_m;
			REAL s21_combo_dobcount_bin_m;
			REAL s21_eq_cnt_bin_m;
			REAL vermod_isb1_other;
			BOOLEAN source_tot_em;
			BOOLEAN source_tot_p;
			BOOLEAN source_tot_pl;
			BOOLEAN source_tot_sl;
			BOOLEAN source_tot_vo;
			BOOLEAN source_tot_w;
			BOOLEAN source_tot_voter;
			INTEGER s20_pos_sources_count;
			INTEGER s20_pos_sources_count_bin;
			INTEGER s20_ver_phncnt_bin;
			INTEGER s20_cont_nap6;
			INTEGER s20_verx_phn;
			INTEGER s20_verx;
			INTEGER s20_eq_cnt_bin;
			REAL s20_pos_sources_count_bin_m;
			REAL s20_eq_cnt_bin_m;
			REAL s20_verx_m;
			REAL vermod_isb0_other;
			REAL vermod_om;
			BOOLEAN s2_hi_addrs_per_adl_c6;
			BOOLEAN s2_lo_combo_addrscore;
			REAL addprob_other;
			REAL addprob_om;
			BOOLEAN s2_lo_rc_dirsaddr_lastscore;
			BOOLEAN s2_hi_gong_did_phone_ct;
			BOOLEAN s2_hi_gong_did_first_ct;
			REAL s2_time_on_gong;
			BOOLEAN s2_recent_disconnects_ind;
			INTEGER s2_phn_disc;
			INTEGER s2_phn_disc_zipmis;
			INTEGER s2_phn_prob;
			REAL s2_phn_prob_m;
			REAL phnprob_other;
			REAL phnprob_om;
			INTEGER _rc_ssnlowissue;
			INTEGER yrsince_rc_ssnlowissue;
			INTEGER _in_dob;
			INTEGER yrs_at_lowissue;
			BOOLEAN s2_yrs_at_lowissue_ind;
			INTEGER s2_yrsince_rc_ssnlowissue_bin;
			INTEGER s2_yrsince_rc_ssnlowissue_bin_;
			REAL s2_yrsince_rc_ssnlowissue_bin_m;
			REAL ssnprob_other;
			REAL ssnprob_om;
			REAL fpmod_other;
			REAL fpmod_om;
			INTEGER s2_add1_avm_to_med_ratio_bin;
			REAL s2_add1_avm_to_med_ratio_bin_m;
			REAL om_outest;
			REAL phat;
			INTEGER score;
			INTEGER _rvr1008;
			BOOLEAN scored_222s;
			INTEGER rvr1008;
			
			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
		END;
		layout_debug doModel( clam le ) := TRANSFORM
	#else
		layout_modelout doModel( clam le ) := TRANSFORM // probably not the right layout to use
	#end

		/* Score produced is called  rvr1008 - Range of 501 to 900 */

	truedid                          := le.truedid;
	adl_category                     := le.adlcategory;
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_addr_type                    := le.shell_input.addr_type;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	did_count                        := le.iid.didcount;
	rc_dirsaddr_lastscore            := le.iid.dirsaddr_lastscore;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_phonevalflag                  := le.iid.phonevalflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_phonezipflag                  := le.iid.phonezipflag;
	rc_pwphonezipflag                := le.iid.pwphonezipflag;
	rc_hriskaddrflag                 := le.iid.hriskaddrflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssndobflag                    := le.iid.socsdobflag;
	rc_pwssndobflag                  := le.iid.pwsocsdobflag;
	rc_ssnvalflag                    := le.iid.socsvalflag;
	rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
	rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
	rc_areacodesplitflag             := le.iid.areacodesplitflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	rc_sources                       := le.iid.sources;
	rc_addrcount                     := le.iid.addrcount;
	rc_ssncount                      := le.iid.socscount;
	rc_numelever                     := le.iid.numelever;
	rc_ssnmiskeyflag                 := le.iid.socsmiskeyflag;
	rc_hphonemiskeyflag              := le.iid.hphonemiskeyflag;
	rc_addrmiskeyflag                := le.iid.addrmiskeyflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_phonetype                     := le.iid.phonetype;
	rc_ziptypeflag                   := le.iid.ziptypeflag;
	rc_zipclass                      := le.iid.zipclass;
	rc_altlname1_flag                := le.iid.altlastpop;
	rc_altlname2_flag                := le.iid.altlast2pop;
	combo_addrscore                  := le.iid.combo_addrscore;
	combo_ssnscore                   := le.iid.combo_ssnscore;
	combo_dobscore                   := le.iid.combo_dobscore;
	combo_addrcount                  := le.iid.combo_addrcount;
	combo_dobcount                   := le.iid.combo_dobcount;
	eq_count                         := le.source_verification.eq_count;
	pr_count                         := le.source_verification.pr_count;
	w_count                          := le.source_verification.w_count;
	add1_address_score               := le.address_verification.input_address_information.address_score;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_unit_count                  := le.address_verification.input_address_information.unit_count;
	add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
	add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_financing_type              := le.address_verification.input_address_information.type_financing;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	telcordia_type                   := le.phone_verification.telcordia_type;
	recent_disconnects               := le.phone_verification.recent_disconnects;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
	gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	phones_per_adl                   := le.velocity_counters.phones_per_adl;
	adlperssn_count                  := le.ssn_verification.adlperssn_count;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	phones_per_addr                  := le.velocity_counters.phones_per_addr;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
	vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
	pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
	impulse_count                    := le.impulse.count;
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
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.BJL.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.BJL.liens_historical_unreleased_count;
	liens_recent_released_count      := le.BJL.liens_recent_released_count;
	liens_historical_released_count  := le.BJL.liens_historical_released_count;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	ams_age                          := le.student.age;
	ams_college_code                 := le.student.college_code;
	ams_income_level_code            := le.student.income_level_code;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	addr_stability                   := le.mobility_indicator;
	archive_date                     := IF(le.historydate = 999999, (STRING)Std.Date.Today(), (STRING)le.historydate);

/* ***********************************************************
	*                   Generated ECL                          *
	************************************************************ */
NULL := -999999999;

today := common.sas_date((STRING)archive_date);

gong_did_first_seen2 := common.sas_date(gong_did_first_seen);

gong_did_last_seen2 := common.sas_date(gong_did_last_seen);

time_on_gong := (gong_did_last_seen2 - IF(gong_did_first_seen2 = NULL, -NULL, gong_did_first_seen2)) / 30.5;

contrary_ssn := (nas_summary in [1]);

verfst_s := (nas_summary in [2, 3, 4, 8, 9, 10, 12]);

verlst_s := (nas_summary in [2, 5, 7, 8, 9, 11, 12]);

veradd_s := (nas_summary in [3, 5, 6, 8, 10, 11, 12]);

verssn_s := (nas_summary in [4, 6, 7, 9, 10, 11, 12]);

ver_nas479 := (nas_summary in [4, 7, 9]);

contrary_phn := (nap_summary in [1]);

verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

ver_nap6 := (nap_summary in [6]);

ver_phncount := sum((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p);

nas12 := nas_summary = 12;

name_change_flag := (integer)rc_altlname1_flag = 1 or (integer)rc_altlname2_flag = 1;

add_highrisk := rc_hriskaddrflag = (string)4 or rc_addrcommflag = (string)2;

add_pobox := rc_hriskaddrflag = (string)1 or rc_ziptypeflag = (string)1 or StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P';

add_inval := StringLib.StringToUpperCase(trim(rc_addrvalflag, LEFT, RIGHT)) != 'V';

add_unit := out_unit_desig != ' ';

add_sec := out_sec_range != ' ';

add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

phn_disconnected := rc_hriskphoneflag = (string)5;

phn_inval := rc_phonevalflag = (string)0 or rc_hphonevalflag = (string)0 or (rc_phonetype in ['5']);

phn_nonus := (rc_phonetype in ['3', '4']);

phn_highrisk := rc_hriskphoneflag = (string)6 or rc_hphonetypeflag = '5' or rc_hphonevalflag = (string)3 or rc_addrcommflag = (string)1;

phn_highrisk2 := not((rc_hriskphoneflag in ['0', '7']));

phn_notpots := not((telcordia_type in ['00', '50', '51', '52', '54']));

phn_zipmismatch := rc_phonezipflag = (string)1 or rc_pwphonezipflag = (string)1;

phn_business := rc_hphonevalflag = (string)1;

ssn_priordob := rc_ssndobflag = (string)1 or rc_pwssndobflag = (string)1;

ssn_inval := rc_ssnvalflag = (string)1 or (rc_pwssnvalflag in ['1', '2', '3']);

ssn_issued18 := rc_pwssnvalflag = (string)5;

add1_avm_hit := ADD1_AVM_LAND_USE > (string)0;

add1_avm_med := map(
    ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
    ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
                              ADD1_AVM_MED_FIPS);

add1_avm_to_med_ratio := if(add1_avm_automated_valuation > 0 and add1_avm_med > 0, (REAL)add1_avm_automated_valuation / (REAL)add1_avm_med, NULL);

Common.findw(rc_sources, 'L2', ' ,', 'I', source_tot_l2, 'bool');

Common.findw(rc_sources, 'LI', ' ,', 'I', source_tot_li, 'bool');

lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_ba, 'bool');

bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

Common.findw(rc_sources, 'DS', ' ,', 'I', source_tot_ds, 'bool');

ssn_deceased := rc_decsflag = (string)1 or (integer)source_tot_ds = 1;

pk_impulse_count := min(if(impulse_count = NULL, -NULL, impulse_count), 2);

pk_adl_cat_deceased := if(trim(trim(adl_category, LEFT), LEFT, RIGHT) = '1 DEAD', 1, 0);

bs_own_rent := map(
    Add1_NaProp = 4 or Property_Owned_Total > 0                                                  => '1 Owner',
    trim(trim(Out_Addr_Type, LEFT), LEFT, RIGHT) = 'H' or Add1_NAProp = 1 or Add1_Unit_Count > 3 => '2 Renter',
                                                                                                    '3 Other');

bs_attr_derog_flag := if(attr_total_number_derogs > 0, 1, 0);

bs_attr_eviction_flag := if(attr_eviction_count > 0, 1, 0);

bs_attr_derog_flag2 := if(bs_attr_derog_flag > 0 or (integer)lien_flag > 0 or bs_attr_eviction_flag > 0 or pk_impulse_count > 0 or (integer)bk_flag > 0 or pk_adl_cat_deceased > 0 or (integer)ssn_deceased > 0, 1, 0);

np_segment := map(
    bs_attr_derog_flag2 = 1                  => '0 Derog      ',
    (bs_own_rent in ['1 Owner', '2 Renter']) => '1 OwnerRenter',
                                                '2 Other      ');

core_adl := (adl_category)[1..1] = '8';

single_did := did_count = 1;

s01_did_ver := map(
    single_did and combo_dobscore = 255 => 0,
    single_did and rc_numelever < 5     => 1,
                                           2);

s01_ver_fst_lst := map(
    (integer)verlst_p = 0                           => 0,
    (integer)verfst_p = 0 and (integer)verlst_p = 1 => 1,
                                                       2);

s01_ver_fst_lst_add := map(
    s01_ver_fst_lst = 0 and (integer)veradd_p = 1 => 0,
    (integer)veradd_p = 0                         => 1,
    s01_ver_fst_lst = 1 and (integer)veradd_p = 1 => 2,
                                                     3);

s01_verx := map(
    (integer)contrary_phn = 1 or (integer)ver_nap6 = 1 => -1.5,
    (integer)nas12 = 0                                 => -1,
                                                          s01_ver_fst_lst_add);

s01_rc_addrcount_bin := map(
    rc_addrcount <= 1 => 0,
    rc_addrcount = 1  => 1,
    rc_addrcount = 2  => 2,
    rc_addrcount = 3  => 3,
    rc_addrcount = 4  => 4,
                         5);

s01_rc_ssncount_cap := min(if(rc_ssncount = NULL, -NULL, rc_ssncount), 2);

s01_pr_count_ind := PR_count > 0;

s01_w_count_ind := W_count > 0;

s01_did_ver_m := map(
    s01_did_ver = 0 => 0.3579766537,
    s01_did_ver = 1 => 0.2388059701,
    s01_did_ver = 2 => 0.1997976732,
                       0.2053259429);

s01_verx_m := map(
    s01_verx = -1.5 => 0.283625731,
    s01_verx = -1   => 0.2481203008,
    s01_verx = 0    => 0.2192982456,
    s01_verx = 1    => 0.2148194271,
    s01_verx = 2    => 0.1924198251,
    s01_verx = 3    => 0.1903390915,
                       0.2053259429);

s01_rc_addrcount_bin_m := map(
    s01_rc_addrcount_bin = 0 => 0.2393187067,
    s01_rc_addrcount_bin = 2 => 0.1926931781,
    s01_rc_addrcount_bin = 3 => 0.1665438467,
    s01_rc_addrcount_bin = 4 => 0.1489361702,
    s01_rc_addrcount_bin = 5 => 0.0714285714,
                                0.2053259429);

s01_rc_ssncount_cap_m := map(
    s01_rc_ssncount_cap = 0 => 0.3728813559,
    s01_rc_ssncount_cap = 1 => 0.2292075966,
    s01_rc_ssncount_cap = 2 => 0.1727247882,
                               0.2053259429);

derog_isb1 := -3.930143278 +
    s01_did_ver_m * 3.1813678236 +
    s01_verx_m * 2.6442643429 +
    (integer)s01_pr_count_ind * -0.570886621 +
    (integer)s01_w_count_ind * -0.470368768 +
    s01_rc_addrcount_bin_m * 3.2698762893 +
    s01_rc_ssncount_cap_m * 4.3812337563;

s00_ssn_addr_miskey_ind := (integer)rc_ssnmiskeyflag = 1 or (integer)rc_hphonemiskeyflag = 1 or (integer)rc_addrmiskeyflag = 1;

s00_ver_fst_lst := map(
    (integer)verlst_p = 0                           => 0,
    (integer)verfst_p = 0 and (integer)verlst_p = 1 => 1,
                                                       2);

s00_verx := map(
    (integer)ver_nap6 = 1     => -1.5,
    (integer)contrary_phn = 1 => -1,
                                 s00_ver_fst_lst);

s00_rc_ssncount_cap := min(if(rc_ssncount = NULL, -NULL, rc_ssncount), 2);

s00_combo_dobcount_cap := min(if(combo_dobcount = NULL, -NULL, combo_dobcount), 6);

s00_add1_addscr_ind := add1_address_score = 100;

s00_pr_count_cap := min(if(PR_count = NULL, -NULL, PR_count), 4);

s00_verx_m := map(
    s00_verx = -1.5 => 0.3990610329,
    s00_verx = -1   => 0.3315508021,
    s00_verx = 0    => 0.2948938612,
    s00_verx = 1    => 0.2873082287,
    s00_verx = 2    => 0.2782608696,
                       0.2963968858);

s00_rc_ssncount_cap_m := map(
    s00_rc_ssncount_cap = 0 => 0.4054054054,
    s00_rc_ssncount_cap = 1 => 0.3241581259,
    s00_rc_ssncount_cap = 2 => 0.2486721391,
                               0.2963968858);

s00_combo_dobcount_cap_m := map(
    s00_combo_dobcount_cap = 0 => 0.3973333333,
    s00_combo_dobcount_cap = 1 => 0.350877193,
    s00_combo_dobcount_cap = 2 => 0.3495007133,
    s00_combo_dobcount_cap = 3 => 0.3224553225,
    s00_combo_dobcount_cap = 4 => 0.2904624277,
    s00_combo_dobcount_cap = 5 => 0.23669924,
    s00_combo_dobcount_cap = 6 => 0.2041467305,
                                  0.2963968858);

s00_pr_count_cap_m := map(
    s00_pr_count_cap = 0 => 0.3335762877,
    s00_pr_count_cap = 1 => 0.2041587902,
    s00_pr_count_cap = 2 => 0.1899791232,
    s00_pr_count_cap = 3 => 0.1818181818,
    s00_pr_count_cap = 4 => 0.144278607,
                            0.2963968858);

derog_isb0 := -4.646127442 +
    (integer)s00_ssn_addr_miskey_ind * 0.2461747503 +
    s00_verx_m * 3.4063214515 +
    s00_rc_ssncount_cap_m * 3.2357524823 +
    s00_combo_dobcount_cap_m * 1.9807555604 +
    (integer)s00_add1_addscr_ind * -0.192964932 +
    s00_pr_count_cap_m * 4.1327046151;

vermod_dm := map(
    add1_isbestmatch => exp(derog_isb1) / (1 + exp(derog_isb1)),
                        exp(derog_isb0) / (1 + exp(derog_isb0)));

s0_addrs_15yr_bin := map(
    (addrs_15yr in [3, 4]) => 3.5,
    addrs_15yr >= 9        => 9,
                              addrs_15yr);

s0_addr_stability_bin := if(addr_stability <= (string)1, 0, (real)addr_stability - 1);

s0_addrs_15yr_bin_m := map(
    s0_addrs_15yr_bin = 0   => 0.1188118812,
    s0_addrs_15yr_bin = 1   => 0.1532756489,
    s0_addrs_15yr_bin = 2   => 0.1759729272,
    s0_addrs_15yr_bin = 3.5 => 0.2091932458,
    s0_addrs_15yr_bin = 5   => 0.2234234234,
    s0_addrs_15yr_bin = 6   => 0.2546174142,
    s0_addrs_15yr_bin = 7   => 0.2767925983,
    s0_addrs_15yr_bin = 8   => 0.2836734694,
    s0_addrs_15yr_bin = 9   => 0.323709852,
                               0.2417161048);

s0_addr_stability_bin_m := map(
    s0_addr_stability_bin = 0 => 0.3540390784,
    s0_addr_stability_bin = 1 => 0.2601572739,
    s0_addr_stability_bin = 2 => 0.2374670185,
    s0_addr_stability_bin = 3 => 0.1988950276,
    s0_addr_stability_bin = 4 => 0.1736474695,
    s0_addr_stability_bin = 5 => 0.1263630532,
                                 0.2417161048);

s0_liens_recent_unrel_cnt_cap := min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 5);

s0_liens_recent_rel_cnt_cap := min(if(liens_recent_released_count = NULL, -NULL, liens_recent_released_count), 2);

s0_liens_hist_rel_cnt_cap := min(if(liens_historical_released_count = NULL, -NULL, liens_historical_released_count), 2);

s0_liens_rel_bin := map(
    s0_liens_recent_rel_cnt_cap = 0 and s0_liens_hist_rel_cnt_cap = 0 => 0,
    s0_liens_recent_rel_cnt_cap = 0 and s0_liens_hist_rel_cnt_cap = 1 => 1,
    s0_liens_recent_rel_cnt_cap = 0 and s0_liens_hist_rel_cnt_cap = 2 => 2,
    s0_liens_recent_rel_cnt_cap = 1                                   => 3,
                                                                         4);

s0_liens_unrel_sc_ct_cap := min(if(liens_unrel_SC_ct = NULL, -NULL, liens_unrel_SC_ct), 3);

s0_attr_num_nonderogs_bin := map(
    attr_num_nonderogs <= 1 => 0,
    attr_num_nonderogs >= 6 => 5,
                               attr_num_nonderogs - 1);

s0_criminal_count_bin := map(
    criminal_count = 0         => 0,
    (criminal_count in [1, 2]) => 1,
                                  2);

s0_felony_count_ind := felony_count > 0;

s0_crim_fel_bin := map(
    s0_criminal_count_bin = 0 and (integer)s0_felony_count_ind = 0 => 0,
    s0_criminal_count_bin = 1 and (integer)s0_felony_count_ind = 0 => 1,
                                                                      2);

s0_impulse_cnt_cap := min(if(impulse_count = NULL, -NULL, impulse_count), 2);

s0_attr_eviction_count_cap := min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 4);

s0_liens_recent_unrel_cnt_cap_m := map(
    s0_liens_recent_unrel_cnt_cap = 0 => 0.2252287327,
    s0_liens_recent_unrel_cnt_cap = 1 => 0.2566772295,
    s0_liens_recent_unrel_cnt_cap = 2 => 0.3199023199,
    s0_liens_recent_unrel_cnt_cap = 3 => 0.3529411765,
    s0_liens_recent_unrel_cnt_cap = 4 => 0.3740458015,
    s0_liens_recent_unrel_cnt_cap = 5 => 0.47,
                                         0.2417161048);

s0_liens_rel_bin_m := map(
    s0_liens_rel_bin = 0 => 0.2460110995,
    s0_liens_rel_bin = 1 => 0.23515625,
    s0_liens_rel_bin = 2 => 0.2175141243,
    s0_liens_rel_bin = 3 => 0.192920354,
    s0_liens_rel_bin = 4 => 0.1868131868,
                            0.2417161048);

s0_liens_unrel_sc_ct_cap_m := map(
    s0_liens_unrel_sc_ct_cap = 0 => 0.2291534055,
    s0_liens_unrel_sc_ct_cap = 1 => 0.2733437663,
    s0_liens_unrel_sc_ct_cap = 2 => 0.3244206774,
    s0_liens_unrel_sc_ct_cap = 3 => 0.3314121037,
                                    0.2417161048);

s0_attr_num_nonderogs_bin_m := map(
    s0_attr_num_nonderogs_bin = 0 => 0.3077316948,
    s0_attr_num_nonderogs_bin = 1 => 0.2677224736,
    s0_attr_num_nonderogs_bin = 2 => 0.2340585146,
    s0_attr_num_nonderogs_bin = 3 => 0.1963746224,
    s0_attr_num_nonderogs_bin = 4 => 0.1813576494,
    s0_attr_num_nonderogs_bin = 5 => 0.1556420233,
                                     0.2417161048);

s0_crim_fel_bin_m := map(
    s0_crim_fel_bin = 0 => 0.2306798823,
    s0_crim_fel_bin = 1 => 0.2921568627,
    s0_crim_fel_bin = 2 => 0.5351758794,
                           0.2417161048);

s0_impulse_cnt_cap_m := map(
    s0_impulse_cnt_cap = 0 => 0.2259484553,
    s0_impulse_cnt_cap = 1 => 0.3739279588,
    s0_impulse_cnt_cap = 2 => 0.5061728395,
                              0.2417161048);

s0_attr_eviction_count_cap_m := map(
    s0_attr_eviction_count_cap = 0 => 0.2096158738,
    s0_attr_eviction_count_cap = 1 => 0.3684210526,
    s0_attr_eviction_count_cap = 2 => 0.4358552632,
    s0_attr_eviction_count_cap = 3 => 0.4976525822,
    s0_attr_eviction_count_cap = 4 => 0.5184135977,
                                      0.2417161048);

derogmodel_dm := -9.998972526 +
    s0_liens_recent_unrel_cnt_cap_m * 2.9459354347 +
    s0_liens_rel_bin_m * 11.057768623 +
    s0_liens_unrel_sc_ct_cap_m * 3.2940689319 +
    s0_attr_num_nonderogs_bin_m * 5.0873541308 +
    s0_crim_fel_bin_m * 4.4614977737 +
    s0_impulse_cnt_cap_m * 5.0499388346 +
    s0_attr_eviction_count_cap_m * 4.4236500219;

derog_dm := exp(derogmodel_dm) / (1 + exp(derogmodel_dm));

s0_add1_avm_to_med_ratio_ind := add1_avm_to_med_ratio > 1;

s0_ssns_per_adl_bin := map(
    ssns_per_adl <= 1 => 0,
    ssns_per_adl <= 4 => ssns_per_adl - 1,
                         4);

s0_phones_per_adl_bin := map(
    phones_per_adl = 1 => 0,
    phones_per_adl = 0 => 1,
    phones_per_adl = 2 => 2,
                          3);

s0_adlperssn_count_bin := map(
    adlperssn_count <= 1 => 0,
    adlperssn_count <= 4 => adlperssn_count - 1,
                            4);

s0_ssn_per_addr_ind := ssns_per_addr != 0 and ssns_per_addr <= 11;

s0_phones_per_addr_ind := phones_per_addr <= 1;

s0_ssns_per_adl_c6_cap := min(if(ssns_per_adl_c6 = NULL, -NULL, ssns_per_adl_c6), 2);

s0_addrs_per_ssn_c6_cap := min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 2);

s0_ssns_per_addr_c6_cap := min(if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6), 3);

s0_vo_addrs_per_adl_bin := map(
    vo_addrs_per_adl = 0 => 3,
    vo_addrs_per_adl > 4 => 4,
                            vo_addrs_per_adl - 1);

s0_ssns_per_adl_bin_m := map(
    s0_ssns_per_adl_bin = 0 => 0.2328048236,
    s0_ssns_per_adl_bin = 1 => 0.2450558899,
    s0_ssns_per_adl_bin = 2 => 0.2672672673,
    s0_ssns_per_adl_bin = 3 => 0.288973384,
    s0_ssns_per_adl_bin = 4 => 0.5043478261,
                               0.2417161048);

s0_phones_per_adl_bin_m := map(
    s0_phones_per_adl_bin = 0 => 0.2178623014,
    s0_phones_per_adl_bin = 1 => 0.2471565059,
    s0_phones_per_adl_bin = 2 => 0.2883845127,
    s0_phones_per_adl_bin = 3 => 0.3700787402,
                                 0.2417161048);

s0_adlperssn_count_bin_m := map(
    s0_adlperssn_count_bin = 0 => 0.2345164364,
    s0_adlperssn_count_bin = 1 => 0.2417692888,
    s0_adlperssn_count_bin = 2 => 0.2719546742,
    s0_adlperssn_count_bin = 3 => 0.2943396226,
    s0_adlperssn_count_bin = 4 => 0.3577235772,
                                  0.2417161048);

s0_ssns_per_adl_c6_cap_m := map(
    s0_ssns_per_adl_c6_cap = 0 => 0.2165305894,
    s0_ssns_per_adl_c6_cap = 1 => 0.2858931553,
    s0_ssns_per_adl_c6_cap = 2 => 0.393258427,
                                  0.2417161048);

s0_addrs_per_ssn_c6_cap_m := map(
    s0_addrs_per_ssn_c6_cap = 0 => 0.2296497287,
    s0_addrs_per_ssn_c6_cap = 1 => 0.321219987,
    s0_addrs_per_ssn_c6_cap = 2 => 0.4453781513,
                                   0.2417161048);

s0_ssns_per_addr_c6_cap_m := map(
    s0_ssns_per_addr_c6_cap = 0 => 0.2179539852,
    s0_ssns_per_addr_c6_cap = 1 => 0.2834879406,
    s0_ssns_per_addr_c6_cap = 2 => 0.3244312562,
    s0_ssns_per_addr_c6_cap = 3 => 0.3342105263,
                                   0.2417161048);

s0_vo_addrs_per_adl_bin_m := map(
    s0_vo_addrs_per_adl_bin = 0 => 0.2105094521,
    s0_vo_addrs_per_adl_bin = 1 => 0.2333702882,
    s0_vo_addrs_per_adl_bin = 2 => 0.2445255474,
    s0_vo_addrs_per_adl_bin = 3 => 0.2545958197,
    s0_vo_addrs_per_adl_bin = 4 => 0.3007518797,
                                   0.2417161048);

velocity_derog := -7.314213634 +
    s0_ssns_per_adl_bin_m * 3.6991872605 +
    s0_phones_per_adl_bin_m * 3.4897214616 +
    s0_adlperssn_count_bin_m * 3.6764467783 +
    (integer)s0_ssn_per_addr_ind * -0.248570858 +
    (integer)s0_phones_per_addr_ind * -0.272583925 +
    s0_ssns_per_adl_c6_cap_m * 3.0001932256 +
    s0_addrs_per_ssn_c6_cap_m * 3.8511053789 +
    s0_ssns_per_addr_c6_cap_m * 4.1537185698 +
    s0_vo_addrs_per_adl_bin_m * 4.9649878405;

velocity_dm := exp(velocity_derog) / (1 + exp(velocity_derog));

s0_add1_hr_mortgage_type := (add1_mortgage_type in ['E', 'H', 'N', 'P', 'S']);

s0_financing_mort_type := map(
    add1_financing_type = '' and not(s0_add1_hr_mortgage_type)    => 1,
    add1_financing_type = 'ADJ' and not(s0_add1_hr_mortgage_type) => 2,
    add1_financing_type = 'CNV' and not(s0_add1_hr_mortgage_type) => 3,
                                                                     0);

s0_appl_fam := map(
    (integer)add1_applicant_owned = 1                                    => 2,
    (integer)add1_applicant_owned = 0 and (integer)add1_family_owned = 1 => 1,
                                                                            0);

s0_owned_bin := map(
    s0_appl_fam = 0 and (integer)add1_occupant_owned = 1 => 0,
    (integer)add1_occupant_owned = 0                     => 1,
    s0_appl_fam = 1 and (integer)add1_occupant_owned = 1 => 2,
                                                            3);

s0_naprop_propowned_bin := map(
    add1_naprop <= 1 and property_owned_total = 0 => 0,
    add1_naprop > 1 and property_owned_total = 0  => 1,
    add1_naprop < 4 and property_owned_total > 0  => 2,
                                                     3);

s0_financing_mort_type_m := map(
    s0_financing_mort_type = 0 => 0.3027210884,
    s0_financing_mort_type = 1 => 0.2410361592,
    s0_financing_mort_type = 2 => 0.2302158273,
    s0_financing_mort_type = 3 => 0.1744186047,
                                  0.2417161048);

s0_owned_bin_m := map(
    s0_owned_bin = 0 => 0.2794837561,
    s0_owned_bin = 1 => 0.2561810155,
    s0_owned_bin = 2 => 0.2377521614,
    s0_owned_bin = 3 => 0.124656782,
                        0.2417161048);

s0_naprop_propowned_bin_m := map(
    s0_naprop_propowned_bin = 0 => 0.2767222163,
    s0_naprop_propowned_bin = 1 => 0.2328094303,
    s0_naprop_propowned_bin = 2 => 0.1768558952,
    s0_naprop_propowned_bin = 3 => 0.1264310602,
                                   0.2417161048);

property_derog := -4.249441992 +
    s0_financing_mort_type_m * 5.6979038707 +
    s0_owned_bin_m * 1.7022629266 +
    s0_naprop_propowned_bin_m * 5.3043888717;

property_dm := exp(property_derog) / (1 + exp(property_derog));

s0_hi_addrs_per_adl_c6 := addrs_per_adl_c6 > 0;

s0_lo_combo_addrscore := combo_addrscore < 100 or combo_addrscore = 255;

s0_add_apt_unit := map(
    (integer)add_apt = 0 and (integer)add_unit = 0 => 0,
    (integer)add_unit = 1                          => 1,
                                                      2);

s0_add_prob := map(
    (integer)add_inval = 1    => 0.5,
    (integer)add_highrisk = 1 => 2,
                                 s0_add_apt_unit);

s0_add_prob_m := map(
    s0_add_prob = 0   => 0.2305799981,
    s0_add_prob = 0.5 => 0.2607489598,
    s0_add_prob = 1   => 0.273593899,
    s0_add_prob = 2   => 0.3271889401,
                         0.2417161048);

addprob_derog := -1.883849589 +
    (integer)addrs_prison_history * 1.1502676229 +
    (integer)s0_hi_addrs_per_adl_c6 * 0.5524726441 +
    (integer)s0_lo_combo_addrscore * 0.3808161913 +
    s0_add_prob_m * 2.1201466612;

addprob_dm := exp(addprob_derog) / (1 + exp(addprob_derog));

s0_recent_disconnects_ind := recent_disconnects > 0;

s0_phn_disc := map(
    (integer)phn_disconnected = 0 and (integer)s0_recent_disconnects_ind = 0 => 0,
    (integer)s0_recent_disconnects_ind = 1                                   => 1,
                                                                                2);

s0_phn_disc_inval := if((integer)phn_inval = 1, 1, s0_phn_disc);

s0_phn_disc_inval_zipmis := map(
    s0_phn_disc_inval = 0 and (integer)phn_zipmismatch = 0 => 0,
    s0_phn_disc_inval = 0 and (integer)phn_zipmismatch = 1 => 1,
    s0_phn_disc_inval = 1 and (integer)phn_zipmismatch = 0 => 2,
                                                              3);

s0_phn_prob := if((integer)phn_highrisk = 1, 3, s0_phn_disc_inval_zipmis);

s0_phn_prob_m := map(
    s0_phn_prob = 0 => 0.2326964974,
    s0_phn_prob = 1 => 0.2443609023,
    s0_phn_prob = 2 => 0.3036377134,
    s0_phn_prob = 3 => 0.3272727273,
                       0.2417161048);

s0_pk_area_code_split := if(trim(trim(rc_areacodesplitflag, LEFT), LEFT, RIGHT) = 'Y', 1, 0);

s0_lo_rc_dirsaddr_lastscore := rc_dirsaddr_lastscore < 80 or rc_dirsaddr_lastscore = 255;

s0_hi_gong_did_phone_ct := gong_did_phone_ct >= 3;

s0_hi_gong_did_addr_ct := gong_did_addr_ct >= 2;

s0_hi_gong_did_first_ct := gong_did_first_ct >= 3;

s0_gong_hist_summary := map(
    not(s0_hi_gong_did_phone_ct) and not(s0_hi_gong_did_addr_ct) and not(s0_hi_gong_did_first_ct)                                                                                                        => 0,
    not(s0_hi_gong_did_phone_ct) and if(max((integer)s0_hi_gong_did_addr_ct, (integer)s0_hi_gong_did_first_ct) = NULL, NULL, sum((integer)s0_hi_gong_did_addr_ct, (integer)s0_hi_gong_did_first_ct)) = 1 => 1,
                                                                                                                                                                                                            2);

// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
s0_time_on_gong := if(time_on_gong < 0, 55, time_on_gong);

phnprob_derog := -2.254580652 +
    s0_phn_prob_m * 5.2343968691 +
    s0_pk_area_code_split * 0.2814214562 +
    (integer)s0_lo_rc_dirsaddr_lastscore * 0.209790989 +
    s0_gong_hist_summary * 0.3971611114 +
    s0_time_on_gong * -0.010557844;

phnprob_dm := exp(phnprob_derog) / (1 + exp(phnprob_derog));

_rc_ssnlowissue_1 := common.sas_date((STRING)rc_ssnlowissue);

yrsince_rc_ssnlowissue_1 := truncate((today - IF(_rc_ssnlowissue_1 = NULL, -NULL, _rc_ssnlowissue_1)) / 365.25);

_in_dob_1 := common.sas_date(in_dob);

yrs_at_lowissue_1 := truncate((_rc_ssnlowissue_1 - IF(_in_dob_1 = NULL, -NULL, _in_dob_1)) / 365.25);

s0_yrs_at_lowissue_gt25 := yrs_at_lowissue_1 <= 0 or yrs_at_lowissue_1 > 25;

s0_yrsince_rc_ssnlowissue_bin := map(
    yrsince_rc_ssnlowissue_1 <= 0  => 0,
    yrsince_rc_ssnlowissue_1 <= 18 => 1,
    yrsince_rc_ssnlowissue_1 <= 25 => 2,
    yrsince_rc_ssnlowissue_1 <= 35 => 3,
    yrsince_rc_ssnlowissue_1 <= 45 => 4,
                                      5);

s0_lo_combo_ssnscore := combo_ssnscore != 100 or combo_ssnscore = 255;

s0_yrsince_rc_ssnlowissue_bin_m := map(
    s0_yrsince_rc_ssnlowissue_bin = 0 => 0.4074074074,
    s0_yrsince_rc_ssnlowissue_bin = 1 => 0.3431952663,
    s0_yrsince_rc_ssnlowissue_bin = 2 => 0.3143086817,
    s0_yrsince_rc_ssnlowissue_bin = 3 => 0.2773650322,
    s0_yrsince_rc_ssnlowissue_bin = 4 => 0.1732891832,
    s0_yrsince_rc_ssnlowissue_bin = 5 => 0.1249142073,
                                         0.2417161048);

ssnprob_derog := -2.601252877 +
    (integer)s0_yrs_at_lowissue_gt25 * 0.4978269885 +
    s0_yrsince_rc_ssnlowissue_bin_m * 5.3771451446 +
    (integer)s0_lo_combo_ssnscore * 0.3984383731 +
    pk_adl_cat_deceased * 1.4835634854;

ssnprob_dm := exp(ssnprob_derog) / (1 + exp(ssnprob_derog));

fpmod_derog := -4.161484363 +
    addprob_dm * 3.2908448444 +
    phnprob_dm * 4.1488249558 +
    ssnprob_dm * 4.630262416 +
    (integer)name_change_flag * 0.1704429295;

fpmod_dm := exp(fpmod_derog) / (1 + exp(fpmod_derog));

dm_outest := -4.446913659 +
    vermod_dm * 1.3061586654 +
    derog_dm * 3.3714698929 +
    velocity_dm * 2.3114157213 +
    property_dm * 1.0805392294 +
    fpmod_dm * 2.8209461264 +
    s0_addrs_15yr_bin_m * 1.2086807484 +
    s0_addr_stability_bin_m * 0.9971644655;

s1_addrs_5yr_cap := min(if(addrs_5yr = NULL, -NULL, addrs_5yr), 3);

s1_wealth_index_bin := map(
    wealth_index = (string)1 => 0,
    wealth_index = (string)0 => 1,
    wealth_index = (string)2 => 2,
    wealth_index = (string)3 => 3,
    wealth_index = (string)4 => 4,
                                5);

s1_addr_stability_bin := map(
    (addr_stability in ['0', '1']) => 0,
    addr_stability = (string)2     => 1,
    addr_stability = (string)3     => 2,
    (addr_stability in ['4', '5']) => 3,
                                      4);

s1_attr_proflic_ind := if(attr_num_proflic30 > 0 or attr_num_proflic90 > 0 or attr_num_proflic180 > 0 or attr_num_proflic12 > 0 or attr_num_proflic24 > 0 or attr_num_proflic36 > 0 or attr_num_proflic60 > 0, 1, 0);

s1_addrs_5yr_cap_m := map(
    s1_addrs_5yr_cap = 0 => 0.1423220974,
    s1_addrs_5yr_cap = 1 => 0.2368647717,
    s1_addrs_5yr_cap = 2 => 0.2437311936,
    s1_addrs_5yr_cap = 3 => 0.3165033911,
                            0.2394025917);

s1_wealth_index_bin_m := map(
    s1_wealth_index_bin = 0 => 0.3305263158,
    s1_wealth_index_bin = 1 => 0.2879318978,
    s1_wealth_index_bin = 2 => 0.2078125,
    s1_wealth_index_bin = 3 => 0.1812227074,
    s1_wealth_index_bin = 4 => 0.1205673759,
    s1_wealth_index_bin = 5 => 0.0784313725,
                               0.2394025917);

s1_addr_stability_bin_m := map(
    s1_addr_stability_bin = 0 => 0.3337066069,
    s1_addr_stability_bin = 1 => 0.2591292135,
    s1_addr_stability_bin = 2 => 0.2579710145,
    s1_addr_stability_bin = 3 => 0.202247191,
    s1_addr_stability_bin = 4 => 0.0985010707,
                                 0.2394025917);

s1_ams_age_bin := map(
    TRIM(ams_age) = '' 		 => 2,
    ams_age < (string)18   => 0,
    ams_age <= (string)25  => 1,
    ams_age <= (string)30  => 3,
    ams_age <= (string)35  => 4,
                              5);

s1_ams_college_cd_bin := map(
    TRIM(ams_college_code) = ''		  => 0,
		ams_college_code = (STRING)1		=> 2,
    ams_college_code = (string)2    => 1,
                                       2);

s1_ams_income_level_code_bin := map(
    TRIM(ams_income_level_code) = ''           => 2,
    (TRIM(ams_income_level_code) IN ['A', 'B']) => 0,
    ams_income_level_code = 'C'           => 1,
    (TRIM(ams_income_level_code) in ['D', 'E']) => 3,
                                             4);

s1_ams_age_bin_m := map(
    s1_ams_age_bin = 0 => 0.5882352941,
    s1_ams_age_bin = 1 => 0.306122449,
    s1_ams_age_bin = 2 => 0.2397645855,
    s1_ams_age_bin = 3 => 0.206185567,
    s1_ams_age_bin = 4 => 0.201754386,
    s1_ams_age_bin = 5 => 0.0666666667,
                          0.2394025917);

s1_ams_college_cd_bin_m := map(
    s1_ams_college_cd_bin = 0 => 0.2479790775,
    s1_ams_college_cd_bin = 1 => 0.1732283465,
    s1_ams_college_cd_bin = 2 => 0.1136363636,
                                 0.2394025917);

s1_ams_income_level_code_bin_m := map(
    s1_ams_income_level_code_bin = 0 => 0.3538461538,
    s1_ams_income_level_code_bin = 1 => 0.2614379085,
    s1_ams_income_level_code_bin = 2 => 0.2473265698,
    s1_ams_income_level_code_bin = 3 => 0.1829573935,
    s1_ams_income_level_code_bin = 4 => 0.1799307958,
                                        0.2394025917);

s1_adlperssn_count_bin := map(
    adlperssn_count <= 1 => 0,
    adlperssn_count = 2  => 1,
                            2);

s1_phones_per_adl_c6_cap := min(if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6), 2);

s1_adls_per_addr_c6_bin := map(
    adls_per_addr_c6 = 0         => 0,
    (adls_per_addr_c6 in [1, 2]) => 1,
    adls_per_addr_c6 = 3         => 2,
                                    3);

s1_adlperssn_count_bin_m := map(
    s1_adlperssn_count_bin = 0 => 0.2305621003,
    s1_adlperssn_count_bin = 1 => 0.2374784111,
    s1_adlperssn_count_bin = 2 => 0.3066037736,
                                  0.2394025917);

s1_phones_per_adl_c6_cap_m := map(
    s1_phones_per_adl_c6_cap = 0 => 0.2331783704,
    s1_phones_per_adl_c6_cap = 1 => 0.2807424594,
    s1_phones_per_adl_c6_cap = 2 => 0.4571428571,
                                    0.2394025917);

s1_adls_per_addr_c6_bin_m := map(
    s1_adls_per_addr_c6_bin = 0 => 0.2267777066,
    s1_adls_per_addr_c6_bin = 1 => 0.2610722611,
    s1_adls_per_addr_c6_bin = 2 => 0.27,
    s1_adls_per_addr_c6_bin = 3 => 0.4318181818,
                                   0.2394025917);

s11_combo_dobcount_bin := map(
    combo_dobcount = 0 => 0,
    combo_dobcount = 1 => 1,
    combo_dobcount = 2 => 2,
    combo_dobcount = 3 => 3,
                          4);

s11_combo_ssnscr_ind := combo_ssnscore = 100;

s11_pr_count_cap := min(if(PR_count = NULL, -NULL, PR_count), 3);

s11_combo_dobcount_bin_m := map(
    s11_combo_dobcount_bin = 0 => 0.290617849,
    s11_combo_dobcount_bin = 1 => 0.2290909091,
    s11_combo_dobcount_bin = 2 => 0.2210884354,
    s11_combo_dobcount_bin = 3 => 0.1844802343,
    s11_combo_dobcount_bin = 4 => 0.1222222222,
                                  0.1975582686);

s11_pr_count_cap_m := map(
    s11_pr_count_cap = 0 => 0.2486421243,
    s11_pr_count_cap = 1 => 0.1282722513,
    s11_pr_count_cap = 2 => 0.1273712737,
    s11_pr_count_cap = 3 => 0.0881355932,
                            0.1975582686);

vermod_isb1_or := -2.688091563 +
    s11_combo_dobcount_bin_m * 3.3403939842 +
    (integer)s11_combo_ssnscr_ind * -0.565386701 +
    s11_pr_count_cap_m * 5.5499703024;

s10_combo_addrcount_bin := map(
    combo_addrcount <= 1 => 0,
    combo_addrcount = 2  => 1,
                            2);

s10_combo_dobcount_bin := map(
    combo_dobcount <= 1 => 0,
    combo_dobcount <= 3 => 1,
    combo_dobcount = 4  => 2,
                           3);

s10_pr_count_cap := min(if(PR_count = NULL, -NULL, PR_count), 2);

s10_combo_addrcount_bin_m := map(
    s10_combo_addrcount_bin = 0 => 0.3161533627,
    s10_combo_addrcount_bin = 1 => 0.2245989305,
    s10_combo_addrcount_bin = 2 => 0.1527777778,
                                   0.3005405405);

s10_combo_dobcount_bin_m := map(
    s10_combo_dobcount_bin = 0 => 0.3751668892,
    s10_combo_dobcount_bin = 1 => 0.2641975309,
    s10_combo_dobcount_bin = 2 => 0.220657277,
    s10_combo_dobcount_bin = 3 => 0.1794871795,
                                  0.3005405405);

s10_pr_count_cap_m := map(
    s10_pr_count_cap = 0 => 0.3260582011,
    s10_pr_count_cap = 1 => 0.2268907563,
    s10_pr_count_cap = 2 => 0.1643835616,
                            0.3005405405);

vermod_isb0_or := -3.932128428 +
    s10_combo_addrcount_bin_m * 3.3566310431 +
    s10_combo_dobcount_bin_m * 3.4422437868 +
    s10_pr_count_cap_m * 3.3620543609;

vermod_or := map(
    add1_isbestmatch => exp(vermod_isb1_or) / (1 + exp(vermod_isb1_or)),
                        exp(vermod_isb0_or) / (1 + exp(vermod_isb0_or)));

s1_add_e412 := if(trim(trim(out_addr_status, LEFT), LEFT, RIGHT) = 'E412', 1, 0);

s1_hi_addrs_per_adl_c6 := addrs_per_adl_c6 > 0;

s1_lo_combo_addrscore := combo_addrscore < 100 or combo_addrscore = 255;

s1_add_apt_unit := map(
    (integer)add_apt = 0 and (integer)add_unit = 0 => 0,
    (integer)add_unit = 1                          => 1,
                                                      2);

s1_add_prob := if(s1_add_e412 = 1 or (integer)addrs_prison_history = 1, 2, s1_add_apt_unit);

s1_add_prob_m := map(
    s1_add_prob = 0 => 0.2023602916,
    s1_add_prob = 1 => 0.2980561555,
    s1_add_prob = 2 => 0.3286219081,
                       0.2394025917);

addprob_ownerrenter := -2.289443421 +
    (integer)s1_hi_addrs_per_adl_c6 * 0.3941119014 +
    (integer)s1_lo_combo_addrscore * 0.4041953587 +
    s1_add_prob_m * 3.7599006111;

addprob_or := exp(addprob_ownerrenter) / (1 + exp(addprob_ownerrenter));

s1_lo_rc_dirsaddr_lastscore := rc_dirsaddr_lastscore < 80 or rc_dirsaddr_lastscore = 255;

s1_hi_gong_did_phone_ct := gong_did_phone_ct >= 2;

// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
s1_time_on_gong := if(time_on_gong < 0, 49, time_on_gong);

s1_recent_disconnects_ind := recent_disconnects > 0;

s1_phn_disc := map(
    (integer)phn_disconnected = 0 and (integer)s1_recent_disconnects_ind = 0 => 0,
                                                                                1);

s1_phn_disc_zipmis := map(
    s1_phn_disc = 0 and (integer)phn_zipmismatch = 0 => 0,
    s1_phn_disc = 1                                  => 1,
                                                        2);

s1_phn_prob := map(
    (integer)phn_nonus = 1 or (integer)phn_business = 1 => 2,
    (integer)phn_inval = 1                              => 1,
                                                           s1_phn_disc_zipmis);

s1_phn_prob_m := map(
    s1_phn_prob = 0 => 0.2305541434,
    s1_phn_prob = 1 => 0.2887596899,
    s1_phn_prob = 2 => 0.3300970874,
                       0.2394025917);

phnprob_ownerrenter := -2.424027884 +
    s1_phn_prob_m * 5.9814159877 +
    (integer)s1_lo_rc_dirsaddr_lastscore * 0.3733838711 +
    (integer)s1_hi_gong_did_phone_ct * 0.5289660746 +
    s1_time_on_gong * -0.011863237;

phnprob_or := exp(phnprob_ownerrenter) / (1 + exp(phnprob_ownerrenter));

s1_yrs_at_lowissue_ind := yrs_at_lowissue_1 <= 0;

s1_yrsince_rc_ssnlowissue_bin := map(
    yrsince_rc_ssnlowissue_1 <= 25 => 0,
    yrsince_rc_ssnlowissue_1 <= 35 => 1,
    yrsince_rc_ssnlowissue_1 <= 45 => 2,
                                      3);

s1_yrsince_rc_ssnlowissue_bin_ := if((integer)ssn_priordob = 1, 0, s1_yrsince_rc_ssnlowissue_bin);

s1_yrsince_rc_ssnlowissue_bin_m := map(
    s1_yrsince_rc_ssnlowissue_bin_ = 0 => 0.2839632278,
    s1_yrsince_rc_ssnlowissue_bin_ = 1 => 0.2573266619,
    s1_yrsince_rc_ssnlowissue_bin_ = 2 => 0.1590330789,
    s1_yrsince_rc_ssnlowissue_bin_ = 3 => 0.1195121951,
                                          0.2394025917);

s1_lo_combo_ssnscore := combo_ssnscore != 100 or combo_ssnscore = 255;

ssnprob_ownerrenter := -2.51409648 +
    (integer)s1_yrs_at_lowissue_ind * 0.4462268709 +
    s1_yrsince_rc_ssnlowissue_bin_m * 4.8295751448 +
    (integer)s1_lo_combo_ssnscore * 0.5603339799;

ssnprob_or := exp(ssnprob_ownerrenter) / (1 + exp(ssnprob_ownerrenter));

fpmod_ownerrenter := -4.000702237 +
    addprob_or * 3.1804688116 +
    phnprob_or * 4.0574139832 +
    ssnprob_or * 4.2991458007;

fpmod_or := exp(fpmod_ownerrenter) / (1 + exp(fpmod_ownerrenter));

or_outest := -9.770397392 +
    s1_adlperssn_count_bin_m * 5.6831078552 +
    s1_phones_per_adl_c6_cap_m * 3.193819927 +
    s1_adls_per_addr_c6_bin_m * 2.6753240998 +
    vermod_or * 2.2344564591 +
    fpmod_or * 2.9559370223 +
    s1_addrs_5yr_cap_m * 1.8634209329 +
    s1_wealth_index_bin_m * 2.5771241335 +
    s1_addr_stability_bin_m * 1.9215172561 +
    s1_attr_proflic_ind * -1.301733596 +
    s1_ams_age_bin_m * 3.7913271181 +
    s1_ams_college_cd_bin_m * 5.0226996449 +
    s1_ams_income_level_code_bin_m * 3.5750002856;

s2_addrs_10yr_cap := min(if(addrs_10yr = NULL, -NULL, addrs_10yr), 4);

s2_wealth_index_bin := map(
    wealth_index = (string)1 => 0,
    wealth_index = (string)0 => 2,
    wealth_index = (string)2 => 1,
                                3);

s2_addrs_10yr_cap_m := map(
    s2_addrs_10yr_cap = 0 => 0.1734475375,
    s2_addrs_10yr_cap = 1 => 0.2213017751,
    s2_addrs_10yr_cap = 2 => 0.2351543943,
    s2_addrs_10yr_cap = 3 => 0.2691729323,
    s2_addrs_10yr_cap = 4 => 0.2693409742,
                             0.2422301305);

s2_wealth_index_bin_m := map(
    s2_wealth_index_bin = 0 => 0.2897727273,
    s2_wealth_index_bin = 1 => 0.2777777778,
    s2_wealth_index_bin = 2 => 0.2415147265,
    s2_wealth_index_bin = 3 => 0.2006802721,
                               0.2422301305);

s2_ams_age_bin := map(
    TRIM(ams_age) = '' 		 => 2,
    ams_age < (string)18   => 0,
    ams_age <= (string)25  => 1,
    ams_age <= (string)30  => 3,
                              4);

s2_ams_college_cd_bin := map(
    TRIM(ams_college_code) = '' 		=> 0,
		ams_college_code = (STRING)1		=> 2,
    ams_college_code = (string)2    => 1,
                                       2);

s2_ams_income_level_code_bin := map(
    ams_income_level_code = ' '                => 1,
    (ams_income_level_code in ['A', 'B', 'C']) => 0,
    (ams_income_level_code in ['D', 'E', 'F']) => 2,
                                                  3);

s2_ams_age_bin_m := map(
    s2_ams_age_bin = 0 => 0.3529411765,
    s2_ams_age_bin = 1 => 0.2832764505,
    s2_ams_age_bin = 2 => 0.2434510251,
    s2_ams_age_bin = 3 => 0.2186046512,
    s2_ams_age_bin = 4 => 0.1685393258,
                          0.2422301305);

s2_ams_college_cd_bin_m := map(
    s2_ams_college_cd_bin = 0 => 0.2494136044,
    s2_ams_college_cd_bin = 1 => 0.1870967742,
    s2_ams_college_cd_bin = 2 => 0.1569506726,
                                 0.2422301305);

s2_ams_income_level_code_bin_m := map(
    s2_ams_income_level_code_bin = 0 => 0.2996108949,
    s2_ams_income_level_code_bin = 1 => 0.2496909765,
    s2_ams_income_level_code_bin = 2 => 0.2062937063,
    s2_ams_income_level_code_bin = 3 => 0.12,
                                        0.2422301305);

amsmod_other := -4.896231137 +
    s2_ams_age_bin_m * 5.7873035433 +
    s2_ams_college_cd_bin_m * 4.1714642103 +
    s2_ams_income_level_code_bin_m * 5.478731086;

amsmod_om := exp(amsmod_other) / (1 + exp(amsmod_other));

s2_phones_per_adl_bin := map(
    phones_per_adl = 1 => 0,
    phones_per_adl = 0 => 1,
                          2);

s2_adlperssn_count_bin := map(
    adlperssn_count <= 1 => 0,
    adlperssn_count = 2  => 1,
    adlperssn_count = 3  => 2,
                            3);

s2_phones_per_addr_bin := map(
    phones_per_addr <= 1 => 0,
    phones_per_addr = 2  => 1,
                            2);

s2_addrs_per_adl_c6_cap := min(if(addrs_per_adl_c6 = NULL, -NULL, addrs_per_adl_c6), 2);

s2_addrs_per_ssn_c6_cap := min(if(addrs_per_ssn_c6 = NULL, -NULL, addrs_per_ssn_c6), 2);

s2_adls_per_addr_c6_cap := min(if(adls_per_addr_c6 = NULL, -NULL, adls_per_addr_c6), 3);

s2_adls_per_phone_c6_ind := adls_per_phone_c6 >= 1;

s2_vo_addrs_per_adl_ind := vo_addrs_per_adl > 0;

s2_pl_addrs_per_adl_ind := pl_addrs_per_adl >= 1;

s2_phones_per_adl_bin_m := map(
    s2_phones_per_adl_bin = 0 => 0.2207792208,
    s2_phones_per_adl_bin = 1 => 0.2488554611,
    s2_phones_per_adl_bin = 2 => 0.25,
                                 0.2422301305);

s2_adlperssn_count_bin_m := map(
    s2_adlperssn_count_bin = 0 => 0.2332951508,
    s2_adlperssn_count_bin = 1 => 0.2502099076,
    s2_adlperssn_count_bin = 2 => 0.2577319588,
    s2_adlperssn_count_bin = 3 => 0.3245614035,
                                  0.2422301305);

s2_phones_per_addr_bin_m := map(
    s2_phones_per_addr_bin = 0 => 0.2336870027,
    s2_phones_per_addr_bin = 1 => 0.298102981,
    s2_phones_per_addr_bin = 2 => 0.3947368421,
                                  0.2422301305);

s2_addrs_per_adl_c6_cap_m := map(
    s2_addrs_per_adl_c6_cap = 0 => 0.2320553474,
    s2_addrs_per_adl_c6_cap = 1 => 0.2810559006,
    s2_addrs_per_adl_c6_cap = 2 => 0.3431372549,
                                   0.2422301305);

s2_addrs_per_ssn_c6_cap_m := map(
    s2_addrs_per_ssn_c6_cap = 0 => 0.236461126,
    s2_addrs_per_ssn_c6_cap = 1 => 0.2840909091,
    s2_addrs_per_ssn_c6_cap = 2 => 0.3111111111,
                                   0.2422301305);

s2_adls_per_addr_c6_cap_m := map(
    s2_adls_per_addr_c6_cap = 0 => 0.2234559334,
    s2_adls_per_addr_c6_cap = 1 => 0.2746400886,
    s2_adls_per_addr_c6_cap = 2 => 0.2939297125,
    s2_adls_per_addr_c6_cap = 3 => 0.3162393162,
                                   0.2422301305);

velocitymod_other := -7.656992901 +
    s2_phones_per_adl_bin_m * 7.1560826962 +
    s2_adlperssn_count_bin_m * 4.3259996782 +
    s2_phones_per_addr_bin_m * 4.1178163218 +
    s2_addrs_per_adl_c6_cap_m * 3.4153144354 +
    s2_addrs_per_ssn_c6_cap_m * 4.3992810704 +
    s2_adls_per_addr_c6_cap_m * 3.5322933858 +
    (integer)s2_adls_per_phone_c6_ind * 0.3698788096 +
    (integer)s2_vo_addrs_per_adl_ind * -0.172454095 +
    (integer)s2_pl_addrs_per_adl_ind * -0.679238893;

velocitymod_om := exp(velocitymod_other) / (1 + exp(velocitymod_other));

s21_rc_addrcount_bin := map(
    rc_addrcount <= 1 => 0,
    rc_addrcount = 2  => 1,
                         2);

s21_combo_dobcount_bin := map(
    combo_dobcount = 0 => 0,
    combo_dobcount = 1 => 1,
    combo_dobcount = 2 => 2,
    combo_dobcount = 3 => 3,
                          4);

s21_eq_cnt_bin := map(
    EQ_count <= 1  => 0,
    EQ_count <= 3  => 1,
    EQ_count <= 6  => 2,
    EQ_count <= 9  => 3,
    EQ_count <= 14 => 4,
                      5);

s21_pr_count_ind := PR_count > 0;

s21_rc_addrcount_bin_m := map(
    s21_rc_addrcount_bin = 0 => 0.2375726275,
    s21_rc_addrcount_bin = 1 => 0.1538461538,
    s21_rc_addrcount_bin = 2 => 0.099009901,
                                0.2069260368);

s21_combo_dobcount_bin_m := map(
    s21_combo_dobcount_bin = 0 => 0.2997946612,
    s21_combo_dobcount_bin = 1 => 0.2146341463,
    s21_combo_dobcount_bin = 2 => 0.2005899705,
    s21_combo_dobcount_bin = 3 => 0.156504065,
    s21_combo_dobcount_bin = 4 => 0.1360294118,
                                  0.2069260368);

s21_eq_cnt_bin_m := map(
    s21_eq_cnt_bin = 0 => 0.35,
    s21_eq_cnt_bin = 1 => 0.2767857143,
    s21_eq_cnt_bin = 2 => 0.2432432432,
    s21_eq_cnt_bin = 3 => 0.1949367089,
    s21_eq_cnt_bin = 4 => 0.1714922049,
    s21_eq_cnt_bin = 5 => 0.1601941748,
                          0.2069260368);

vermod_isb1_other := -3.674158634 +
    s21_rc_addrcount_bin_m * 4.5062239619 +
    s21_combo_dobcount_bin_m * 3.0015807221 +
    s21_eq_cnt_bin_m * 3.6801504014 +
    (integer)s21_pr_count_ind * -0.518210666;

Common.findw(rc_sources, 'EM', ' ,', 'I', source_tot_em, 'bool');

Common.findw(rc_sources, 'P', ' ,', 'I', source_tot_p, 'bool');

Common.findw(rc_sources, 'PL', ' ,', 'I', source_tot_pl, 'bool');

Common.findw(rc_sources, 'SL', ' ,', 'I', source_tot_sl, 'bool');

Common.findw(rc_sources, 'VO', ' ,', 'I', source_tot_vo, 'bool');

Common.findw(rc_sources, 'W', ' ,', 'I', source_tot_w, 'bool');

source_tot_voter := source_tot_em or source_tot_vo;

s20_pos_sources_count := sum((integer)source_tot_em, (integer)source_tot_p, (integer)source_tot_pl, (integer)source_tot_sl, (integer)source_tot_vo, (integer)source_tot_w, (integer)source_tot_voter);

s20_pos_sources_count_bin := map(
    s20_pos_sources_count = 0  => 0,
    s20_pos_sources_count <= 2 => 1,
                                  2);

s20_ver_phncnt_bin := map(
    ver_phncount = 0  => 0,
    ver_phncount <= 3 => 1,
                         2);

s20_cont_nap6 := if((integer)contrary_phn = 1 or (integer)ver_nap6 = 1, 1, 0);

s20_verx_phn := map(
    s20_cont_nap6 = 1      => -1,
    s20_ver_phncnt_bin = 0 => 1,
    s20_ver_phncnt_bin = 1 => 2,
                              3);

s20_verx := map(
    s20_verx_phn = -1                                                                              => 0,
    (s20_verx_phn in [1, 2, 3]) and (integer)nas12 = 0 or s20_verx_phn = -1 and (integer)nas12 = 1 => 1,
    (s20_verx_phn in [1, 2]) and (integer)nas12 = 1 or s20_verx_phn = 2                            => 2,
                                                                                                      3);

s20_eq_cnt_bin := map(
    EQ_count <= 8  => 0,
    EQ_count <= 14 => 1,
                      2);

s20_pos_sources_count_bin_m := map(
    s20_pos_sources_count_bin = 0 => 0.3220512821,
    s20_pos_sources_count_bin = 1 => 0.2682926829,
    s20_pos_sources_count_bin = 2 => 0.2110091743,
                                     0.2862473348);

s20_eq_cnt_bin_m := map(
    s20_eq_cnt_bin = 0 => 0.3198458574,
    s20_eq_cnt_bin = 1 => 0.2637614679,
    s20_eq_cnt_bin = 2 => 0.223880597,
                          0.2862473348);

s20_verx_m := map(
    s20_verx = 0 => 0.3642384106,
    s20_verx = 1 => 0.2962356792,
    s20_verx = 2 => 0.2416666667,
    s20_verx = 3 => 0.1739130435,
                    0.2862473348);

vermod_isb0_other := -4.699865068 +
    s20_pos_sources_count_bin_m * 4.5552034688 +
    s20_eq_cnt_bin_m * 4.4277066535 +
    s20_verx_m * 4.166776681;

vermod_om := map(
    add1_isbestmatch => exp(vermod_isb1_other) / (1 + exp(vermod_isb1_other)),
                        exp(vermod_isb0_other) / (1 + exp(vermod_isb0_other)));

s2_hi_addrs_per_adl_c6 := addrs_per_adl_c6 > 0;

s2_lo_combo_addrscore := combo_addrscore < 40 or combo_addrscore = 255;

addprob_other := -1.316170232 +
    (integer)s2_hi_addrs_per_adl_c6 * 0.3069980481 +
    (integer)s2_lo_combo_addrscore * 0.4898872605;

addprob_om := exp(addprob_other) / (1 + exp(addprob_other));

s2_lo_rc_dirsaddr_lastscore := rc_dirsaddr_lastscore < 100 or rc_dirsaddr_lastscore = 255;

s2_hi_gong_did_phone_ct := gong_did_phone_ct >= 2;

s2_hi_gong_did_first_ct := gong_did_first_ct >= 3;

// # warning:  engineer intervention needed -- missing or NULL values do not exist in ECL.  Implement missing() function accordingly.
s2_time_on_gong := if(time_on_gong < 0, 46, time_on_gong);

s2_recent_disconnects_ind := recent_disconnects > 0;

s2_phn_disc := map(
    (integer)phn_disconnected = 0 and (integer)s2_recent_disconnects_ind = 0 => 0,
                                                                                1);

s2_phn_disc_zipmis := map(
    s2_phn_disc = 0 and (integer)phn_zipmismatch = 0 => 0,
    (integer)phn_zipmismatch = 1                     => 1,
                                                        2);

s2_phn_prob := if((integer)phn_inval = 1 or (integer)phn_business = 1, 2, s2_phn_disc_zipmis);

s2_phn_prob_m := map(
    s2_phn_prob = 0 => 0.2334333242,
    s2_phn_prob = 1 => 0.2555555556,
    s2_phn_prob = 2 => 0.3100436681,
                       0.2422301305);

phnprob_other := -2.224169608 +
    (integer)s2_lo_rc_dirsaddr_lastscore * 0.2343085754 +
    (integer)s2_hi_gong_did_phone_ct * 0.4233275572 +
    (integer)s2_hi_gong_did_first_ct * 0.896594243 +
    s2_time_on_gong * -0.012640533 +
    s2_phn_prob_m * 5.6627574788;

phnprob_om := exp(phnprob_other) / (1 + exp(phnprob_other));

_rc_ssnlowissue := common.sas_date((STRING)rc_ssnlowissue);

yrsince_rc_ssnlowissue := truncate((today - IF(_rc_ssnlowissue = NULL, -NULL, _rc_ssnlowissue)) / 365.25);

_in_dob := common.sas_date(in_dob);

yrs_at_lowissue := truncate((_rc_ssnlowissue - IF(_in_dob = NULL, -NULL, _in_dob)) / 365.25);

s2_yrs_at_lowissue_ind := yrs_at_lowissue <= 0;

s2_yrsince_rc_ssnlowissue_bin := map(
    yrsince_rc_ssnlowissue <= 18 => 0,
    yrsince_rc_ssnlowissue <= 25 => 1,
    yrsince_rc_ssnlowissue <= 35 => 2,
    yrsince_rc_ssnlowissue <= 45 => 2,
                                    3);

s2_yrsince_rc_ssnlowissue_bin_ := if((integer)ssn_priordob = 1, 0, s2_yrsince_rc_ssnlowissue_bin);

s2_yrsince_rc_ssnlowissue_bin_m := map(
    s2_yrsince_rc_ssnlowissue_bin_ = 0 => 0.3319502075,
    s2_yrsince_rc_ssnlowissue_bin_ = 1 => 0.2738095238,
    s2_yrsince_rc_ssnlowissue_bin_ = 2 => 0.2208525937,
    s2_yrsince_rc_ssnlowissue_bin_ = 3 => 0.1064638783,
                                          0.2422301305);

ssnprob_other := -2.467955406 +
    (integer)s2_yrs_at_lowissue_ind * 0.425943364 +
    s2_yrsince_rc_ssnlowissue_bin_m * 4.7627038485;

ssnprob_om := exp(ssnprob_other) / (1 + exp(ssnprob_other));

fpmod_other := -4.201425832 +
    addprob_om * 2.9625829267 +
    phnprob_om * 4.5547091729 +
    ssnprob_om * 4.8601675293;

fpmod_om := exp(fpmod_other) / (1 + exp(fpmod_other));

s2_add1_avm_to_med_ratio_bin := map(
    add1_avm_to_med_ratio = NULL => 1,
    add1_avm_to_med_ratio < 1.5  => 0,
                                    2);

s2_add1_avm_to_med_ratio_bin_m := map(
    s2_add1_avm_to_med_ratio_bin = 0 => 0.2702078522,
    s2_add1_avm_to_med_ratio_bin = 1 => 0.240182894,
    s2_add1_avm_to_med_ratio_bin = 2 => 0.171875,
                                        0.2422301305);

om_outest := -9.645884599 +
    s2_addrs_10yr_cap_m * 5.1530725037 +
    s2_wealth_index_bin_m * 4.9115018821 +
    amsmod_om * 4.3526264917 +
    velocitymod_om * 2.9152537943 +
    s2_add1_avm_to_med_ratio_bin_m * 10.253976515 +
    vermod_om * 3.7408458888 +
    fpmod_om * 3.3573837941;

phat := map(
    np_segment = '0 Derog      ' => exp(dm_outest) / (1 + exp(dm_outest)),
    np_segment = '1 OwnerRenter' => exp(or_outest) / (1 + exp(or_outest)),
                                    exp(om_outest) / (1 + exp(om_outest)));

score := round(-40 * (ln(phat / (1 - phat)) - ln(1 / 20)) / ln(2) + 700);

_rvr1008 := min(900, if(max(501, score) = NULL, -NULL, max(501, score)));

scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

rvr1008 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, _rvr1008);

riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

inCalifornia := (inCalif and (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3);

reasons := map(
			riTemp[1].hri <> '00' => riTemp,
			rvr1008 = 222 and ~inCalifornia => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			RiskWise.rv3retailReasonCodes(le, 4, inCalifornia, PreScreenOptOut)
		);

#if(MODEL_DEBUG)
		SELF.truedid := truedid;
		SELF.adl_category := adl_category;
		SELF.out_unit_desig := out_unit_desig;
		SELF.out_sec_range := out_sec_range;
		SELF.out_addr_type := out_addr_type;
		SELF.out_addr_status := out_addr_status;
		SELF.in_dob := in_dob;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.did_count := did_count;
		SELF.rc_dirsaddr_lastscore := rc_dirsaddr_lastscore;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.rc_phonevalflag := rc_phonevalflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_phonezipflag := rc_phonezipflag;
		SELF.rc_pwphonezipflag := rc_pwphonezipflag;
		SELF.rc_hriskaddrflag := rc_hriskaddrflag;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssndobflag := rc_ssndobflag;
		SELF.rc_pwssndobflag := rc_pwssndobflag;
		SELF.rc_ssnvalflag := rc_ssnvalflag;
		SELF.rc_pwssnvalflag := rc_pwssnvalflag;
		SELF.rc_ssnlowissue := rc_ssnlowissue;
		SELF.rc_areacodesplitflag := rc_areacodesplitflag;
		SELF.rc_addrvalflag := rc_addrvalflag;
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.rc_bansflag := rc_bansflag;
		SELF.rc_sources := rc_sources;
		SELF.rc_addrcount := rc_addrcount;
		SELF.rc_ssncount := rc_ssncount;
		SELF.rc_numelever := rc_numelever;
		SELF.rc_ssnmiskeyflag := rc_ssnmiskeyflag;
		SELF.rc_hphonemiskeyflag := rc_hphonemiskeyflag;
		SELF.rc_addrmiskeyflag := rc_addrmiskeyflag;
		SELF.rc_addrcommflag := rc_addrcommflag;
		SELF.rc_phonetype := rc_phonetype;
		SELF.rc_ziptypeflag := rc_ziptypeflag;
		SELF.rc_zipclass := rc_zipclass;
		SELF.rc_altlname1_flag := rc_altlname1_flag;
		SELF.rc_altlname2_flag := rc_altlname2_flag;
		SELF.combo_addrscore := combo_addrscore;
		SELF.combo_ssnscore := combo_ssnscore;
		SELF.combo_dobscore := combo_dobscore;
		SELF.combo_addrcount := combo_addrcount;
		SELF.combo_dobcount := combo_dobcount;
		SELF.eq_count := eq_count;
		SELF.pr_count := pr_count;
		SELF.w_count := w_count;
		SELF.add1_address_score := add1_address_score;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_unit_count := add1_unit_count;
		SELF.add1_avm_land_use := add1_avm_land_use;
		SELF.add1_avm_automated_valuation := add1_avm_automated_valuation;
		SELF.add1_avm_med_fips := add1_avm_med_fips;
		SELF.add1_avm_med_geo11 := add1_avm_med_geo11;
		SELF.add1_avm_med_geo12 := add1_avm_med_geo12;
		SELF.add1_applicant_owned := add1_applicant_owned;
		SELF.add1_occupant_owned := add1_occupant_owned;
		SELF.add1_family_owned := add1_family_owned;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_mortgage_type := add1_mortgage_type;
		SELF.add1_financing_type := add1_financing_type;
		SELF.property_owned_total := property_owned_total;
		SELF.property_sold_total := property_sold_total;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_10yr := addrs_10yr;
		SELF.addrs_15yr := addrs_15yr;
		SELF.addrs_prison_history := addrs_prison_history;
		SELF.telcordia_type := telcordia_type;
		SELF.recent_disconnects := recent_disconnects;
		SELF.gong_did_first_seen := gong_did_first_seen;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.gong_did_phone_ct := gong_did_phone_ct;
		SELF.gong_did_addr_ct := gong_did_addr_ct;
		SELF.gong_did_first_ct := gong_did_first_ct;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.phones_per_adl := phones_per_adl;
		SELF.adlperssn_count := adlperssn_count;
		SELF.ssns_per_addr := ssns_per_addr;
		SELF.phones_per_addr := phones_per_addr;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.addrs_per_adl_c6 := addrs_per_adl_c6;
		SELF.phones_per_adl_c6 := phones_per_adl_c6;
		SELF.addrs_per_ssn_c6 := addrs_per_ssn_c6;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.ssns_per_addr_c6 := ssns_per_addr_c6;
		SELF.adls_per_phone_c6 := adls_per_phone_c6;
		SELF.vo_addrs_per_adl := vo_addrs_per_adl;
		SELF.pl_addrs_per_adl := pl_addrs_per_adl;
		SELF.impulse_count := impulse_count;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
		SELF.attr_num_proflic30 := attr_num_proflic30;
		SELF.attr_num_proflic90 := attr_num_proflic90;
		SELF.attr_num_proflic180 := attr_num_proflic180;
		SELF.attr_num_proflic12 := attr_num_proflic12;
		SELF.attr_num_proflic24 := attr_num_proflic24;
		SELF.attr_num_proflic36 := attr_num_proflic36;
		SELF.attr_num_proflic60 := attr_num_proflic60;
		SELF.bankrupt := bankrupt;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_recent_released_count := liens_recent_released_count;
		SELF.liens_historical_released_count := liens_historical_released_count;
		SELF.liens_unrel_sc_ct := liens_unrel_sc_ct;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.ams_age := ams_age;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_income_level_code := ams_income_level_code;
		SELF.wealth_index := wealth_index;
		SELF.input_dob_match_level := input_dob_match_level;
		SELF.addr_stability := addr_stability;
		SELF.archive_date := archive_date;
			
	/* Model Intermediate Variables */		
      SELF.today                        := today;
      SELF.gong_did_first_seen2            := gong_did_first_seen2;
      SELF.gong_did_last_seen2            := gong_did_last_seen2;
      SELF.time_on_gong                  := time_on_gong;
      SELF.contrary_ssn                  := contrary_ssn;
      SELF.verfst_s                     := verfst_s;
      SELF.verlst_s                     := verlst_s;
      SELF.veradd_s                     := veradd_s;
      SELF.verssn_s                     := verssn_s;
      SELF.ver_nas479                     := ver_nas479;
      SELF.contrary_phn                  := contrary_phn;
      SELF.verfst_p                     := verfst_p;
      SELF.verlst_p                     := verlst_p;
      SELF.veradd_p                     := veradd_p;
      SELF.verphn_p                     := verphn_p;
      SELF.ver_nap6                     := ver_nap6;
      SELF.ver_phncount                  := ver_phncount;
      SELF.nas12                        := nas12;
      SELF.name_change_flag               := name_change_flag;
      SELF.add_highrisk                  := add_highrisk;
      SELF.add_pobox                     := add_pobox;
      SELF.add_inval                     := add_inval;
      SELF.add_unit                     := add_unit;
      SELF.add_sec                     := add_sec;
      SELF.add_apt                     := add_apt;
      SELF.phn_disconnected               := phn_disconnected;
      SELF.phn_inval                     := phn_inval;
      SELF.phn_nonus                     := phn_nonus;
      SELF.phn_highrisk                  := phn_highrisk;
      SELF.phn_highrisk2                  := phn_highrisk2;
      SELF.phn_notpots                  := phn_notpots;
      SELF.phn_zipmismatch               := phn_zipmismatch;
      SELF.phn_business                  := phn_business;
      SELF.ssn_priordob                  := ssn_priordob;
      SELF.ssn_inval                     := ssn_inval;
      SELF.ssn_issued18                  := ssn_issued18;
      SELF.add1_avm_hit                  := add1_avm_hit;
      SELF.add1_avm_med                  := add1_avm_med;
      SELF.add1_avm_to_med_ratio            := add1_avm_to_med_ratio;
      SELF.source_tot_l2                  := source_tot_l2;
      SELF.source_tot_li                  := source_tot_li;
      SELF.lien_rec_unrel_flag            := lien_rec_unrel_flag;
      SELF.lien_hist_unrel_flag            := lien_hist_unrel_flag;
      SELF.lien_flag                     := lien_flag;
      SELF.source_tot_ba                  := source_tot_ba;
      SELF.bk_flag                     := bk_flag;
      SELF.source_tot_ds                  := source_tot_ds;
      SELF.ssn_deceased                  := ssn_deceased;
      SELF.pk_impulse_count               := pk_impulse_count;
      SELF.pk_adl_cat_deceased            := pk_adl_cat_deceased;
      SELF.bs_own_rent                  := bs_own_rent;
      SELF.bs_attr_derog_flag               := bs_attr_derog_flag;
      SELF.bs_attr_eviction_flag            := bs_attr_eviction_flag;
      SELF.bs_attr_derog_flag2            := bs_attr_derog_flag2;
      SELF.np_segment                     := np_segment;
      SELF.core_adl                     := core_adl;
      SELF.single_did                     := single_did;
      SELF.s01_did_ver                  := s01_did_ver;
      SELF.s01_ver_fst_lst               := s01_ver_fst_lst;
      SELF.s01_ver_fst_lst_add            := s01_ver_fst_lst_add;
      SELF.s01_verx                     := s01_verx;
      SELF.s01_rc_addrcount_bin            := s01_rc_addrcount_bin;
      SELF.s01_rc_ssncount_cap            := s01_rc_ssncount_cap;
      SELF.s01_pr_count_ind               := s01_pr_count_ind;
      SELF.s01_w_count_ind               := s01_w_count_ind;
      SELF.s01_did_ver_m                  := s01_did_ver_m;
      SELF.s01_verx_m                     := s01_verx_m;
      SELF.s01_rc_addrcount_bin_m            := s01_rc_addrcount_bin_m;
      SELF.s01_rc_ssncount_cap_m            := s01_rc_ssncount_cap_m;
      SELF.derog_isb1                     := derog_isb1;
      SELF.s00_ssn_addr_miskey_ind         := s00_ssn_addr_miskey_ind;
      SELF.s00_ver_fst_lst               := s00_ver_fst_lst;
      SELF.s00_verx                     := s00_verx;
      SELF.s00_rc_ssncount_cap            := s00_rc_ssncount_cap;
      SELF.s00_combo_dobcount_cap            := s00_combo_dobcount_cap;
      SELF.s00_add1_addscr_ind            := s00_add1_addscr_ind;
      SELF.s00_pr_count_cap               := s00_pr_count_cap;
      SELF.s00_verx_m                     := s00_verx_m;
      SELF.s00_rc_ssncount_cap_m            := s00_rc_ssncount_cap_m;
      SELF.s00_combo_dobcount_cap_m         := s00_combo_dobcount_cap_m;
      SELF.s00_pr_count_cap_m               := s00_pr_count_cap_m;
      SELF.derog_isb0                     := derog_isb0;
      SELF.vermod_dm                     := vermod_dm;
      SELF.s0_addrs_15yr_bin               := s0_addrs_15yr_bin;
      SELF.s0_addr_stability_bin            := s0_addr_stability_bin;
      SELF.s0_addrs_15yr_bin_m            := s0_addrs_15yr_bin_m;
      SELF.s0_addr_stability_bin_m         := s0_addr_stability_bin_m;
      SELF.s0_liens_recent_unrel_cnt_cap      := s0_liens_recent_unrel_cnt_cap;
      SELF.s0_liens_recent_rel_cnt_cap      := s0_liens_recent_rel_cnt_cap;
      SELF.s0_liens_hist_rel_cnt_cap         := s0_liens_hist_rel_cnt_cap;
      SELF.s0_liens_rel_bin               := s0_liens_rel_bin;
      SELF.s0_liens_unrel_sc_ct_cap         := s0_liens_unrel_sc_ct_cap;
      SELF.s0_attr_num_nonderogs_bin         := s0_attr_num_nonderogs_bin;
      SELF.s0_criminal_count_bin            := s0_criminal_count_bin;
      SELF.s0_felony_count_ind            := s0_felony_count_ind;
      SELF.s0_crim_fel_bin               := s0_crim_fel_bin;
      SELF.s0_impulse_cnt_cap               := s0_impulse_cnt_cap;
      SELF.s0_attr_eviction_count_cap         := s0_attr_eviction_count_cap;
      SELF.s0_liens_recent_unrel_cnt_cap_m   := s0_liens_recent_unrel_cnt_cap_m;
      SELF.s0_liens_rel_bin_m               := s0_liens_rel_bin_m;
      SELF.s0_liens_unrel_sc_ct_cap_m         := s0_liens_unrel_sc_ct_cap_m;
      SELF.s0_attr_num_nonderogs_bin_m      := s0_attr_num_nonderogs_bin_m;
      SELF.s0_crim_fel_bin_m               := s0_crim_fel_bin_m;
      SELF.s0_impulse_cnt_cap_m            := s0_impulse_cnt_cap_m;
      SELF.s0_attr_eviction_count_cap_m      := s0_attr_eviction_count_cap_m;
      SELF.derogmodel_dm                  := derogmodel_dm;
      SELF.derog_dm                     := derog_dm;
      SELF.s0_add1_avm_to_med_ratio_ind      := s0_add1_avm_to_med_ratio_ind;
      SELF.s0_ssns_per_adl_bin            := s0_ssns_per_adl_bin;
      SELF.s0_phones_per_adl_bin            := s0_phones_per_adl_bin;
      SELF.s0_adlperssn_count_bin            := s0_adlperssn_count_bin;
      SELF.s0_ssn_per_addr_ind            := s0_ssn_per_addr_ind;
      SELF.s0_phones_per_addr_ind            := s0_phones_per_addr_ind;
      SELF.s0_ssns_per_adl_c6_cap            := s0_ssns_per_adl_c6_cap;
      SELF.s0_addrs_per_ssn_c6_cap         := s0_addrs_per_ssn_c6_cap;
      SELF.s0_ssns_per_addr_c6_cap         := s0_ssns_per_addr_c6_cap;
      SELF.s0_vo_addrs_per_adl_bin         := s0_vo_addrs_per_adl_bin;
      SELF.s0_ssns_per_adl_bin_m            := s0_ssns_per_adl_bin_m;
      SELF.s0_phones_per_adl_bin_m         := s0_phones_per_adl_bin_m;
      SELF.s0_adlperssn_count_bin_m         := s0_adlperssn_count_bin_m;
      SELF.s0_ssns_per_adl_c6_cap_m         := s0_ssns_per_adl_c6_cap_m;
      SELF.s0_addrs_per_ssn_c6_cap_m         := s0_addrs_per_ssn_c6_cap_m;
      SELF.s0_ssns_per_addr_c6_cap_m         := s0_ssns_per_addr_c6_cap_m;
      SELF.s0_vo_addrs_per_adl_bin_m         := s0_vo_addrs_per_adl_bin_m;
      SELF.velocity_derog                  := velocity_derog;
      SELF.velocity_dm                  := velocity_dm;
      SELF.s0_add1_hr_mortgage_type         := s0_add1_hr_mortgage_type;
      SELF.s0_financing_mort_type            := s0_financing_mort_type;
      SELF.s0_appl_fam                  := s0_appl_fam;
      SELF.s0_owned_bin                  := s0_owned_bin;
      SELF.s0_naprop_propowned_bin         := s0_naprop_propowned_bin;
      SELF.s0_financing_mort_type_m         := s0_financing_mort_type_m;
      SELF.s0_owned_bin_m                  := s0_owned_bin_m;
      SELF.s0_naprop_propowned_bin_m         := s0_naprop_propowned_bin_m;
      SELF.property_derog                  := property_derog;
      SELF.property_dm                  := property_dm;
      SELF.s0_hi_addrs_per_adl_c6            := s0_hi_addrs_per_adl_c6;
      SELF.s0_lo_combo_addrscore            := s0_lo_combo_addrscore;
      SELF.s0_add_apt_unit               := s0_add_apt_unit;
      SELF.s0_add_prob                  := s0_add_prob;
      SELF.s0_add_prob_m                  := s0_add_prob_m;
      SELF.addprob_derog                  := addprob_derog;
      SELF.addprob_dm                     := addprob_dm;
      SELF.s0_recent_disconnects_ind         := s0_recent_disconnects_ind;
      SELF.s0_phn_disc                  := s0_phn_disc;
      SELF.s0_phn_disc_inval               := s0_phn_disc_inval;
      SELF.s0_phn_disc_inval_zipmis         := s0_phn_disc_inval_zipmis;
      SELF.s0_phn_prob                  := s0_phn_prob;
      SELF.s0_phn_prob_m                  := s0_phn_prob_m;
      SELF.s0_pk_area_code_split            := s0_pk_area_code_split;
      SELF.s0_lo_rc_dirsaddr_lastscore      := s0_lo_rc_dirsaddr_lastscore;
      SELF.s0_hi_gong_did_phone_ct         := s0_hi_gong_did_phone_ct;
      SELF.s0_hi_gong_did_addr_ct            := s0_hi_gong_did_addr_ct;
      SELF.s0_hi_gong_did_first_ct         := s0_hi_gong_did_first_ct;
      SELF.s0_gong_hist_summary            := s0_gong_hist_summary;
      SELF.s0_time_on_gong               := s0_time_on_gong;
      SELF.phnprob_derog                  := phnprob_derog;
      SELF.phnprob_dm                     := phnprob_dm;
      SELF._rc_ssnlowissue_1               := _rc_ssnlowissue_1;
      SELF.yrsince_rc_ssnlowissue_1         := yrsince_rc_ssnlowissue_1;
      SELF._in_dob_1                     := _in_dob_1;
      SELF.yrs_at_lowissue_1               := yrs_at_lowissue_1;
      SELF.s0_yrs_at_lowissue_gt25         := s0_yrs_at_lowissue_gt25;
      SELF.s0_yrsince_rc_ssnlowissue_bin      := s0_yrsince_rc_ssnlowissue_bin;
      SELF.s0_lo_combo_ssnscore            := s0_lo_combo_ssnscore;
      SELF.s0_yrsince_rc_ssnlowissue_bin_m   := s0_yrsince_rc_ssnlowissue_bin_m;
      SELF.ssnprob_derog                  := ssnprob_derog;
      SELF.ssnprob_dm                     := ssnprob_dm;
      SELF.fpmod_derog                  := fpmod_derog;
      SELF.fpmod_dm                     := fpmod_dm;
      SELF.dm_outest                     := dm_outest;
      SELF.s1_addrs_5yr_cap               := s1_addrs_5yr_cap;
      SELF.s1_wealth_index_bin            := s1_wealth_index_bin;
      SELF.s1_addr_stability_bin            := s1_addr_stability_bin;
      SELF.s1_attr_proflic_ind            := s1_attr_proflic_ind;
      SELF.s1_addrs_5yr_cap_m               := s1_addrs_5yr_cap_m;
      SELF.s1_wealth_index_bin_m            := s1_wealth_index_bin_m;
      SELF.s1_addr_stability_bin_m         := s1_addr_stability_bin_m;
      SELF.s1_ams_age_bin                  := s1_ams_age_bin;
      SELF.s1_ams_college_cd_bin            := s1_ams_college_cd_bin;
      SELF.s1_ams_income_level_code_bin      := s1_ams_income_level_code_bin;
      SELF.s1_ams_age_bin_m               := s1_ams_age_bin_m;
      SELF.s1_ams_college_cd_bin_m         := s1_ams_college_cd_bin_m;
      SELF.s1_ams_income_level_code_bin_m      := s1_ams_income_level_code_bin_m;
      SELF.s1_adlperssn_count_bin            := s1_adlperssn_count_bin;
      SELF.s1_phones_per_adl_c6_cap         := s1_phones_per_adl_c6_cap;
      SELF.s1_adls_per_addr_c6_bin         := s1_adls_per_addr_c6_bin;
      SELF.s1_adlperssn_count_bin_m         := s1_adlperssn_count_bin_m;
      SELF.s1_phones_per_adl_c6_cap_m         := s1_phones_per_adl_c6_cap_m;
      SELF.s1_adls_per_addr_c6_bin_m         := s1_adls_per_addr_c6_bin_m;
      SELF.s11_combo_dobcount_bin            := s11_combo_dobcount_bin;
      SELF.s11_combo_ssnscr_ind            := s11_combo_ssnscr_ind;
      SELF.s11_pr_count_cap               := s11_pr_count_cap;
      SELF.s11_combo_dobcount_bin_m         := s11_combo_dobcount_bin_m;
      SELF.s11_pr_count_cap_m               := s11_pr_count_cap_m;
      SELF.vermod_isb1_or                  := vermod_isb1_or;
      SELF.s10_combo_addrcount_bin         := s10_combo_addrcount_bin;
      SELF.s10_combo_dobcount_bin            := s10_combo_dobcount_bin;
      SELF.s10_pr_count_cap               := s10_pr_count_cap;
      SELF.s10_combo_addrcount_bin_m         := s10_combo_addrcount_bin_m;
      SELF.s10_combo_dobcount_bin_m         := s10_combo_dobcount_bin_m;
      SELF.s10_pr_count_cap_m               := s10_pr_count_cap_m;
      SELF.vermod_isb0_or                  := vermod_isb0_or;
      SELF.vermod_or                     := vermod_or;
      SELF.s1_add_e412                  := s1_add_e412;
      SELF.s1_hi_addrs_per_adl_c6            := s1_hi_addrs_per_adl_c6;
      SELF.s1_lo_combo_addrscore            := s1_lo_combo_addrscore;
      SELF.s1_add_apt_unit               := s1_add_apt_unit;
      SELF.s1_add_prob                  := s1_add_prob;
      SELF.s1_add_prob_m                  := s1_add_prob_m;
      SELF.addprob_ownerrenter            := addprob_ownerrenter;
      SELF.addprob_or                     := addprob_or;
      SELF.s1_lo_rc_dirsaddr_lastscore      := s1_lo_rc_dirsaddr_lastscore;
      SELF.s1_hi_gong_did_phone_ct         := s1_hi_gong_did_phone_ct;
      SELF.s1_time_on_gong               := s1_time_on_gong;
      SELF.s1_recent_disconnects_ind         := s1_recent_disconnects_ind;
      SELF.s1_phn_disc                  := s1_phn_disc;
      SELF.s1_phn_disc_zipmis               := s1_phn_disc_zipmis;
      SELF.s1_phn_prob                  := s1_phn_prob;
      SELF.s1_phn_prob_m                  := s1_phn_prob_m;
      SELF.phnprob_ownerrenter            := phnprob_ownerrenter;
      SELF.phnprob_or                     := phnprob_or;
      SELF.s1_yrs_at_lowissue_ind            := s1_yrs_at_lowissue_ind;
      SELF.s1_yrsince_rc_ssnlowissue_bin      := s1_yrsince_rc_ssnlowissue_bin;
      SELF.s1_yrsince_rc_ssnlowissue_bin_      := s1_yrsince_rc_ssnlowissue_bin_;
      SELF.s1_yrsince_rc_ssnlowissue_bin_m   := s1_yrsince_rc_ssnlowissue_bin_m;
      SELF.s1_lo_combo_ssnscore            := s1_lo_combo_ssnscore;
      SELF.ssnprob_ownerrenter            := ssnprob_ownerrenter;
      SELF.ssnprob_or                     := ssnprob_or;
      SELF.fpmod_ownerrenter               := fpmod_ownerrenter;
      SELF.fpmod_or                     := fpmod_or;
      SELF.or_outest                     := or_outest;
      SELF.s2_addrs_10yr_cap               := s2_addrs_10yr_cap;
      SELF.s2_wealth_index_bin            := s2_wealth_index_bin;
      SELF.s2_addrs_10yr_cap_m            := s2_addrs_10yr_cap_m;
      SELF.s2_wealth_index_bin_m            := s2_wealth_index_bin_m;
      SELF.s2_ams_age_bin                  := s2_ams_age_bin;
      SELF.s2_ams_college_cd_bin            := s2_ams_college_cd_bin;
      SELF.s2_ams_income_level_code_bin      := s2_ams_income_level_code_bin;
      SELF.s2_ams_age_bin_m               := s2_ams_age_bin_m;
      SELF.s2_ams_college_cd_bin_m         := s2_ams_college_cd_bin_m;
      SELF.s2_ams_income_level_code_bin_m      := s2_ams_income_level_code_bin_m;
      SELF.amsmod_other                  := amsmod_other;
      SELF.amsmod_om                     := amsmod_om;
      SELF.s2_phones_per_adl_bin            := s2_phones_per_adl_bin;
      SELF.s2_adlperssn_count_bin            := s2_adlperssn_count_bin;
      SELF.s2_phones_per_addr_bin            := s2_phones_per_addr_bin;
      SELF.s2_addrs_per_adl_c6_cap         := s2_addrs_per_adl_c6_cap;
      SELF.s2_addrs_per_ssn_c6_cap         := s2_addrs_per_ssn_c6_cap;
      SELF.s2_adls_per_addr_c6_cap         := s2_adls_per_addr_c6_cap;
      SELF.s2_adls_per_phone_c6_ind         := s2_adls_per_phone_c6_ind;
      SELF.s2_vo_addrs_per_adl_ind         := s2_vo_addrs_per_adl_ind;
      SELF.s2_pl_addrs_per_adl_ind         := s2_pl_addrs_per_adl_ind;
      SELF.s2_phones_per_adl_bin_m         := s2_phones_per_adl_bin_m;
      SELF.s2_adlperssn_count_bin_m         := s2_adlperssn_count_bin_m;
      SELF.s2_phones_per_addr_bin_m         := s2_phones_per_addr_bin_m;
      SELF.s2_addrs_per_adl_c6_cap_m         := s2_addrs_per_adl_c6_cap_m;
      SELF.s2_addrs_per_ssn_c6_cap_m         := s2_addrs_per_ssn_c6_cap_m;
      SELF.s2_adls_per_addr_c6_cap_m         := s2_adls_per_addr_c6_cap_m;
      SELF.velocitymod_other               := velocitymod_other;
      SELF.velocitymod_om                  := velocitymod_om;
      SELF.s21_rc_addrcount_bin            := s21_rc_addrcount_bin;
      SELF.s21_combo_dobcount_bin            := s21_combo_dobcount_bin;
      SELF.s21_eq_cnt_bin                  := s21_eq_cnt_bin;
      SELF.s21_pr_count_ind               := s21_pr_count_ind;
      SELF.s21_rc_addrcount_bin_m            := s21_rc_addrcount_bin_m;
      SELF.s21_combo_dobcount_bin_m         := s21_combo_dobcount_bin_m;
      SELF.s21_eq_cnt_bin_m               := s21_eq_cnt_bin_m;
      SELF.vermod_isb1_other               := vermod_isb1_other;
      SELF.source_tot_em                  := source_tot_em;
      SELF.source_tot_p                  := source_tot_p;
      SELF.source_tot_pl                  := source_tot_pl;
      SELF.source_tot_sl                  := source_tot_sl;
      SELF.source_tot_vo                  := source_tot_vo;
      SELF.source_tot_w                  := source_tot_w;
      SELF.source_tot_voter               := source_tot_voter;
      SELF.s20_pos_sources_count            := s20_pos_sources_count;
      SELF.s20_pos_sources_count_bin         := s20_pos_sources_count_bin;
      SELF.s20_ver_phncnt_bin               := s20_ver_phncnt_bin;
      SELF.s20_cont_nap6                  := s20_cont_nap6;
      SELF.s20_verx_phn                  := s20_verx_phn;
      SELF.s20_verx                     := s20_verx;
      SELF.s20_eq_cnt_bin                  := s20_eq_cnt_bin;
      SELF.s20_pos_sources_count_bin_m      := s20_pos_sources_count_bin_m;
      SELF.s20_eq_cnt_bin_m               := s20_eq_cnt_bin_m;
      SELF.s20_verx_m                     := s20_verx_m;
      SELF.vermod_isb0_other               := vermod_isb0_other;
      SELF.vermod_om                     := vermod_om;
      SELF.s2_hi_addrs_per_adl_c6            := s2_hi_addrs_per_adl_c6;
      SELF.s2_lo_combo_addrscore            := s2_lo_combo_addrscore;
      SELF.addprob_other                  := addprob_other;
      SELF.addprob_om                     := addprob_om;
      SELF.s2_lo_rc_dirsaddr_lastscore      := s2_lo_rc_dirsaddr_lastscore;
      SELF.s2_hi_gong_did_phone_ct         := s2_hi_gong_did_phone_ct;
      SELF.s2_hi_gong_did_first_ct         := s2_hi_gong_did_first_ct;
      SELF.s2_time_on_gong               := s2_time_on_gong;
      SELF.s2_recent_disconnects_ind         := s2_recent_disconnects_ind;
      SELF.s2_phn_disc                  := s2_phn_disc;
      SELF.s2_phn_disc_zipmis               := s2_phn_disc_zipmis;
      SELF.s2_phn_prob                  := s2_phn_prob;
      SELF.s2_phn_prob_m                  := s2_phn_prob_m;
      SELF.phnprob_other                  := phnprob_other;
      SELF.phnprob_om                     := phnprob_om;
      SELF._rc_ssnlowissue               := _rc_ssnlowissue;
      SELF.yrsince_rc_ssnlowissue            := yrsince_rc_ssnlowissue;
      SELF._in_dob                     := _in_dob;
      SELF.yrs_at_lowissue               := yrs_at_lowissue;
      SELF.s2_yrs_at_lowissue_ind            := s2_yrs_at_lowissue_ind;
      SELF.s2_yrsince_rc_ssnlowissue_bin      := s2_yrsince_rc_ssnlowissue_bin;
      SELF.s2_yrsince_rc_ssnlowissue_bin_      := s2_yrsince_rc_ssnlowissue_bin_;
      SELF.s2_yrsince_rc_ssnlowissue_bin_m   := s2_yrsince_rc_ssnlowissue_bin_m;
      SELF.ssnprob_other                  := ssnprob_other;
      SELF.ssnprob_om                     := ssnprob_om;
      SELF.fpmod_other                  := fpmod_other;
      SELF.fpmod_om                     := fpmod_om;
      SELF.s2_add1_avm_to_med_ratio_bin      := s2_add1_avm_to_med_ratio_bin;
      SELF.s2_add1_avm_to_med_ratio_bin_m      := s2_add1_avm_to_med_ratio_bin_m;
      SELF.om_outest                     := om_outest;
      SELF.phat                        := phat;
      SELF.score                        := score;
      SELF._rvr1008                     := _rvr1008;
      SELF.scored_222s                  := scored_222s;
      SELF.rvr1008                     := rvr1008;

			SELF.rc1 := reasons[1].hri;
			SELF.rc2 := reasons[2].hri;
			SELF.rc3 := reasons[3].hri;
			SELF.rc4 := reasons[4].hri;
			
			SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasons, TRANSFORM( Risk_Indicators.Layout_Desc,
																							SELF.hri  := LEFT.hri,
																							SELF.desc := risk_indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := map(
				self.ri[1].hri in ['91','92','93','94'] => (string)((integer)self.ri[1].hri + 10),
				self.ri[1].hri='95' => '222', // per bug 52525, 95 returns a score of 222
				self.ri[1].hri='35' => '000',
				(STRING3)rvr1008
				);
		SELF.seq := le.seq;
	#end
	END;
	
	model := PROJECT(clam, doModel(LEFT));
	
	RETURN(model);
END;