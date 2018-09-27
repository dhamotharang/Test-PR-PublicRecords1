IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT rvd1110_1_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE, BOOLEAN PreScreenOptOut = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;

			/* Model Input Variables */
			BOOLEAN truedid;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			STRING rc_hphonevalflag;
			STRING rc_decsflag;
			INTEGER rc_ssnlowissue;
			INTEGER rc_ssnhighissue;
			STRING rc_bansflag;
			STRING rc_addrcommflag;
			STRING rc_phonetype;
			INTEGER combo_dobscore;
			STRING ver_sources;
			STRING ver_sources_last_seen;
			BOOLEAN add1_isbestmatch;
			BOOLEAN add1_applicant_owned;
			BOOLEAN add1_family_owned;
			INTEGER add1_naprop;
			INTEGER add1_mortgage_date;
			STRING add1_mortgage_type;
			STRING add1_financing_type;
			STRING add1_mortgage_due_date;
			INTEGER add1_date_last_seen;
			INTEGER property_owned_total;
			INTEGER property_sold_total;
			INTEGER dist_a1toa2;
			INTEGER dist_a2toa3;
			INTEGER addrs_5yr;
			INTEGER addrs_10yr;
			INTEGER addrs_15yr;
			BOOLEAN addrs_prison_history;
			STRING telcordia_type;
			STRING gong_did_last_seen;
			INTEGER gong_did_first_ct;
			INTEGER gong_did_last_ct;
			INTEGER ssns_per_adl;
			INTEGER addrs_per_adl;
			INTEGER addrs_per_ssn;
			INTEGER ssns_per_adl_c6;
			INTEGER adls_per_addr_c6;
			INTEGER ssns_per_addr_c6;
			INTEGER impulse_count;
			INTEGER impulse_annual_income;
			STRING email_source_list;
			INTEGER attr_addrs_last12;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER attr_date_first_purchase;
			BOOLEAN bankrupt;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_unrel_ot_ct;
			INTEGER liens_unrel_ot_first_seen;
			INTEGER liens_unrel_ot_last_seen;
			INTEGER liens_rel_ot_ct;
			INTEGER liens_rel_ot_first_seen;
			INTEGER liens_rel_ot_last_seen;
			INTEGER criminal_count;
			INTEGER criminal_last_date;
			INTEGER felony_count;
			STRING ams_age;
			STRING input_dob_age;
			STRING input_dob_match_level;
			INTEGER inferred_age;
			INTEGER reported_dob;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			INTEGER days_to_tax_day;
			REAL8 ln_days_to_tax_day_c;
			REAL8 ln_days_to_tax_day_lg;
			REAL8 ln_days_to_tax_day_rt;
			REAL8 ln_days_to_tax_day_sq;
			INTEGER _dist_a1toa2;
			INTEGER _dist_a2toa3;
			INTEGER ln_distance_lvl;
			REAL8 ln_distance_lvl_m;
			INTEGER _criminal_last_date;
			INTEGER mos_criminal_last_seen;
			INTEGER ln_criminal_lvl;
			REAL8 ln_criminal_lvl_m;
			INTEGER _reported_dob;
			INTEGER reported_age;
			INTEGER applicant_age;
			INTEGER ln_applicant_age_lvl;
			REAL8 ln_applicant_age_lvl_m;
			INTEGER ssn_lowissuedate;
			INTEGER ssn_highissuedate;
			INTEGER yrs_ssn_lowissuedate;
			INTEGER yrs_ssn_highissuedate;
			INTEGER age_ssn_lowissue;
			INTEGER age_ssn_highissue;
			INTEGER _age_ssn_lowissue;
			INTEGER ln_age_at_lowissue_lvl;
			REAL8 ln_age_at_lowissue_lvl_m;
			BOOLEAN impulse_email;
			INTEGER ln_impulse_lvl;
			REAL8 ln_impulse_lvl_m;
			INTEGER _add1_mortgage_date;
			INTEGER _add1_mortgage_due_date;
			INTEGER mtg_term;
			INTEGER _mtg_term;
			BOOLEAN mtg_typ_va;
			BOOLEAN mtg_typ_r;
			INTEGER ln_mtg_risk_lvl;
			REAL8 ln_mtg_risk_lvl_m;
			INTEGER _add1_date_last_seen;
			INTEGER mos_add1_date_last_seen;
			BOOLEAN seen_recently;
			BOOLEAN family_owned;
			BOOLEAN app_owned;
			BOOLEAN stolen_addr;
			BOOLEAN nothing_found;
			BOOLEAN property_owner;
			REAL8 naprop_log;
			REAL8 ln_naprop_model_c;
			REAL8 ln_naprop_model_c_m;
			INTEGER _liens_unrel_ot_first_seen;
			INTEGER _liens_unrel_ot_last_seen;
			INTEGER _liens_rel_ot_first_seen;
			INTEGER _liens_rel_ot_last_seen;
			INTEGER mos_ot_unrel_first_seen;
			INTEGER mos_ot_unrel_last_seen;
			INTEGER mos_ot_rel_first_seen;
			INTEGER mos_ot_rel_last_seen;
			INTEGER hr_liens_ot_lvl;
			REAL8 hr_liens_ot_lvl_m;
			INTEGER _gong_did_last_seen;
			INTEGER mos_since_gong_last_seen;
			BOOLEAN phn_last_seen_rec;
			BOOLEAN phn_pots;
			BOOLEAN phn_nonus;
			BOOLEAN phn_highrisk;
			BOOLEAN phn_notpots;
			BOOLEAN phn_bad_counts;
			INTEGER hr_phone_prob_lvl;
			REAL8 hr_phone_prob_lvl_m;
			INTEGER hr_max_ids_per_addr_c6_5;
			REAL8 hr_max_ids_per_addr_c6_5_m;
			INTEGER hr_ssns_per_adl_lvl;
			INTEGER ver_sources_count;
			STRING l2_date_last_seen;
			INTEGER _l2_date_last_seen;
			INTEGER l2_date_last_seen_mos;
			INTEGER hr_l2_date_last_seen_mos_c;
			REAL8 hr_l2_date_last_seen_mos_lg;
			REAL8 avg_addrs_per_age;
			INTEGER hr_avg_addrs_per_age_c;
			INTEGER addrs_per_id_max;
			INTEGER hr_addrs_per_id_max_c;
			REAL8 hr_addrs_per_id_max_lg;
			INTEGER _attr_date_first_purchase;
			INTEGER yrs_attr_date_first_purchase;
			INTEGER age_attr_date_first_purchase;
			INTEGER _age_attr_date_first_purchase;
			INTEGER ln_age_attr_date_first_purch_c;
			REAL8 ln_age_attr_date_first_purch_rt;
			REAL8 repb_log_v2;
			REAL8 phat;
			INTEGER base;
			INTEGER point;
			REAL8 odds;
			INTEGER repb_mod;
			INTEGER custom_republic_ral_score;
			BOOLEAN source_tot_ds;
			BOOLEAN source_tot_ba;
			BOOLEAN bk_flag;
			BOOLEAN lien_rec_unrel_flag;
			BOOLEAN lien_hist_unrel_flag;
			BOOLEAN source_tot_l2;
			BOOLEAN source_tot_li;
			BOOLEAN lien_flag;
			BOOLEAN ssn_deceased;
			BOOLEAN scored_222s;
			INTEGER rvd1110_1_0;

			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_hphonetypeflag                := le.iid.hphonetypeflag;
	rc_hphonevalflag                 := le.iid.hphonevalflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_ssnlowissue                   := (unsigned)le.iid.socllowissue;
	rc_ssnhighissue                  := (unsigned)le.iid.soclhighissue;
	rc_bansflag                      := le.iid.bansflag;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_phonetype                     := le.iid.phonetype;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_mortgage_date               := le.address_verification.input_address_information.mortgage_date;
	add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
	add1_financing_type              := le.address_verification.input_address_information.type_financing;
	add1_mortgage_due_date           := le.address_verification.input_address_information.first_td_due_date;
	add1_date_last_seen              := le.address_verification.input_address_information.date_last_seen;
	property_owned_total             := le.address_verification.owned.property_total;
	property_sold_total              := le.address_verification.sold.property_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	addrs_prison_history             := le.other_address_info.isprison;
	telcordia_type                   := le.phone_verification.telcordia_type;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
	gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	impulse_count                    := le.impulse.count;
	impulse_annual_income            := le.impulse.annual_income;
	email_source_list                := le.email_summary.email_source_list;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_date_first_purchase         := le.other_address_info.date_first_purchase;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
	liens_unrel_ot_first_seen        := le.liens.liens_unreleased_other_tax.earliest_filing_date;
	liens_unrel_ot_last_seen         := le.liens.liens_unreleased_other_tax.most_recent_filing_date;
	liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
	liens_rel_ot_first_seen          := le.liens.liens_released_other_tax.earliest_filing_date;
	liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
	criminal_count                   := le.bjl.criminal_count;
	criminal_last_date               := le.bjl.last_criminal_date;
	felony_count                     := le.bjl.felony_count;
	ams_age                          := le.student.age;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */
	NULL := -999999999;
	
	INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
	
	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
	
	INTEGER year(integer sas_date) :=
		if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));
	
	sysdate := Common.SAS_Date((STRING)(archive_date));
	
	fullarchivedate := (STRING)IF(le.historydate = 999999, (INTEGER)Std.Date.Today(), (INTEGER)(archive_date + '01'));

	fullarchivedatesas := Models.Common.SAS_Date(fullarchivedate);

	taxdate := Models.Common.SAS2ECL_Date(fullarchivedatesas + 180)[1..4] + '0415';

	taxdatesas := Models.Common.SAS_Date(taxdate);

	days_to_tax_day := taxdatesas - fullarchivedatesas;
		
	// days_to_tax_day := (ut.DaysSince1900((string)year(sysdate + 180), (string)4, (string)15) - ut.DaysSince1900('1960', '1', '1')) - sysdate;
	// days_to_tax_day := (((INTEGER)(Common.SAS_Date(archive_date[1..4] + '0415')) + 180) - (INTEGER)Common.SAS_Date((STRING)IF(le.historydate = 999999, (INTEGER)ut.GetDate, (INTEGER)(archive_date + '01'))));
	
	
	ln_days_to_tax_day_c := min(if(max(days_to_tax_day, (real)1) = NULL, -NULL, max(days_to_tax_day, (real)1)), 90);
	
	ln_days_to_tax_day_lg := ln(ln_days_to_tax_day_c);
	
	ln_days_to_tax_day_rt := sqrt(ln_days_to_tax_day_c);
	
	ln_days_to_tax_day_sq := ln_days_to_tax_day_c * ln_days_to_tax_day_c;
	
	_dist_a1toa2 := map(
	    dist_a1toa2 = 9999 => 9999,
	    dist_a1toa2 = 0    => 0,
	    dist_a1toa2 < 25   => 25,
	    dist_a1toa2 < 300  => 300,
	    dist_a1toa2 < 2000 => 2000,
	                          2001);
	
	_dist_a2toa3 := map(
	    dist_a2toa3 = 9999 => 9999,
	    dist_a2toa3 = 0    => 0,
	    dist_a2toa3 < 25   => 25,
	    dist_a2toa3 < 300  => 300,
	    dist_a2toa3 < 2000 => 2000,
	                          2001);
	
	ln_distance_lvl := map(
	    _dist_a1toa2 = 9999 or _dist_a2toa3 = 9999                       => 0,
	    _dist_a1toa2 = 0 and _dist_a2toa3 = 0                            => 0,
	    _dist_a1toa2 = 2001                                              => 7,
	    _dist_a1toa2 > 0 and _dist_a2toa3 = 2001                         => 7,
	    _dist_a1toa2 = 2000 and 0 < _dist_a2toa3 AND _dist_a2toa3 < 2001 => 6,
	    _dist_a1toa2 = 300 and _dist_a2toa3 = 2000                       => 6,
	    _dist_a1toa2 = 300 and _dist_a2toa3 = 300                        => 5,
	    _dist_a1toa2 = 25 and _dist_a2toa3 = 2000                        => 5,
	    _dist_a1toa2 = 300 and _dist_a2toa3 = 25                         => 4,
	    _dist_a1toa2 = 25 and _dist_a2toa3 = 300                         => 4,
	    _dist_a1toa2 = 0 and _dist_a2toa3 > 300                          => 3,
	    _dist_a1toa2 = 25 and _dist_a2toa3 = 25                          => 2,
	    _dist_a1toa2 > 25                                                => 2,
	                                                                        1);
	
	ln_distance_lvl_m := map(
	    ln_distance_lvl = 0 => 0.0399877666,
	    ln_distance_lvl = 1 => 0.049380531,
	    ln_distance_lvl = 2 => 0.0514192103,
	    ln_distance_lvl = 3 => 0.0528148578,
	    ln_distance_lvl = 4 => 0.0610045662,
	    ln_distance_lvl = 5 => 0.0650747102,
	    ln_distance_lvl = 6 => 0.0675012688,
	                           0.0880989181);
	
	_criminal_last_date := Common.SAS_Date((STRING)(criminal_last_date));
	
	mos_criminal_last_seen := if(min(sysdate, _criminal_last_date) = NULL, NULL, truncate((sysdate - _criminal_last_date) / (365.25 / 12)));
	
	ln_criminal_lvl := map(
	    felony_count > 0 or criminal_count > 2 or (integer)addrs_prison_history > 0 => 3,
	    0 < mos_criminal_last_seen AND mos_criminal_last_seen <= 24                 => 2,
	    criminal_count > 0                                                          => 1,
	                                                                                   0);
	
	ln_criminal_lvl_m := map(
	    ln_criminal_lvl = 0 => 0.0485011252,
	    ln_criminal_lvl = 1 => 0.0706655711,
	    ln_criminal_lvl = 2 => 0.1035598706,
	                           0.103908956);
	
	_reported_dob := Common.SAS_Date((STRING)(reported_dob));
	
	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));
	
	applicant_age := map(
	    (INTEGER)input_dob_age > 0 => (INTEGER)input_dob_age,
	    (INTEGER)inferred_age > 0  => (INTEGER)inferred_age,
	    (INTEGER)reported_age > 0  => (INTEGER)reported_age,
	    (INTEGER)ams_age > 0       => (INTEGER)ams_age,
	                                 -1);
	
	ln_applicant_age_lvl := map(
	    applicant_age >= 62 or applicant_age <= 20 => 0,
	    applicant_age = 21                         => 1,
	    applicant_age = 22                         => 2,
	    applicant_age = 23                         => 3,
	    applicant_age = 24                         => 4,
	    applicant_age = 25                         => 5,
	    applicant_age <= 30                        => 6,
	    applicant_age <= 35                        => 5,
	    applicant_age < 45                         => 4,
	    applicant_age <= 53                        => 3,
	                                                  2);
	
	ln_applicant_age_lvl_m := map(
	    ln_applicant_age_lvl = 0 => 0.0209032258,
	    ln_applicant_age_lvl = 1 => 0.0287058824,
	    ln_applicant_age_lvl = 2 => 0.0330358332,
	    ln_applicant_age_lvl = 3 => 0.0392063962,
	    ln_applicant_age_lvl = 4 => 0.0533115057,
	    ln_applicant_age_lvl = 5 => 0.0599346168,
	                                0.0617167427);
	
	// ssn_lowissuedate := (ut.DaysSince1900((string)(integer)((string)rc_ssnlowissue)[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1'));
	// ssn_lowissuedate_1 := Common.SAS_Date((STRING)rc_ssnlowissue[1..4] + '0101');
	// ssn_lowissuedate := IF((UNSIGNED)(rc_ssnlowissue[1..4]) < 1000 OR (INTEGER)ssn_lowissuedate_1 > 100000000000 OR (INTEGER)ssn_lowissuedate_1 < 0, NULL, (INTEGER)ssn_lowissuedate_1);
	
	// ssn_highissuedate := (ut.DaysSince1900((string)(integer)((string)rc_ssnhighissue)[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1'));
	// ssn_highissuedate_1 := Common.SAS_Date((STRING)rc_ssnhighissue[1..4] + '0101');
	// ssn_highissuedate := IF((UNSIGNED)(rc_ssnhighissue[1..4]) < 1000 OR (INTEGER)ssn_highissuedate_1 > 100000000000 OR (INTEGER)ssn_highissuedate_1 < 0, NULL, (INTEGER)ssn_highissuedate_1);
	
	// yrs_ssn_lowissuedate := if(min(sysdate, ssn_lowissuedate) = NULL, NULL, truncate((sysdate - ssn_lowissuedate) / 365.25));
	
	// yrs_ssn_highissuedate := if(min(sysdate, ssn_highissuedate) = NULL, NULL, truncate((sysdate - ssn_highissuedate) / 365.25));
	
	// age_ssn_lowissue := IF(MIN(applicant_age, yrs_ssn_lowissuedate) = NULL, NULL, applicant_age - yrs_ssn_lowissuedate);
	
	// age_ssn_highissue := IF(MIN(applicant_age, yrs_ssn_highissuedate) = NULL, NULL, applicant_age - yrs_ssn_highissuedate);
	
	/* ** START SAS CHANGES 11/03/11 ***/
		ssn_lowissuedate := MAP(
																rc_ssnlowissue > 0 => Common.SAS_Date(((STRING)rc_ssnlowissue)[1..4] + '0101'),
																												NULL
													);
													
		ssn_highissuedate := MAP(
																rc_ssnhighissue > 0 => Common.SAS_Date((STRING)rc_ssnhighissue[1..4] + '0101'),
																												NULL
													 );
     
    yrs_ssn_lowissuedate := MAP(
																ssn_lowissuedate <> NULL => IF(MIN(sysdate, ssn_lowissuedate) = NULL, NULL, TRUNCATE((sysdate - ssn_lowissuedate) / 365.25)),
																														NULL
															);
		
		yrs_ssn_highissuedate := MAP(
																ssn_highissuedate <> NULL => IF(MIN(sysdate, ssn_highissuedate) = NULL, NULL, TRUNCATE((sysdate - ssn_highissuedate) / 365.25)),
																														 NULL
																);

    age_ssn_lowissue := MAP(
																yrs_ssn_lowissuedate <> NULL => IF(MIN(applicant_age, yrs_ssn_lowissuedate) = NULL, NULL, (applicant_age - yrs_ssn_lowissuedate)),
																																1
												 );

    age_ssn_highissue := MAP(
																yrs_ssn_highissuedate <> NULL => IF(MIN(applicant_age, yrs_ssn_highissuedate) = NULL, NULL, (applicant_age - yrs_ssn_highissuedate)),
																																	1
														);
	/* ** END CHANGES ***/
	
	_age_ssn_lowissue := map(
	    age_ssn_lowissue < -1 => -2,
	    age_ssn_lowissue < 10 => 10,
	                             11);
	
	ln_age_at_lowissue_lvl := map(
	    _age_ssn_lowissue = 11 and applicant_age > 35                                  => 0,
	    (_age_ssn_lowissue in [10, 11]) and 18 < applicant_age AND applicant_age <= 25 => 0,
	    applicant_age <= 18                                                            => 0,
	    _age_ssn_lowissue = 10 and 35 < applicant_age AND applicant_age <= 45          => 1,
	    _age_ssn_lowissue = 11 and 25 < applicant_age AND applicant_age <= 35          => 1,
	                                                                                      2);
	
	ln_age_at_lowissue_lvl_m := map(
	    ln_age_at_lowissue_lvl = 0 => 0.0389596327,
	    ln_age_at_lowissue_lvl = 1 => 0.0569939922,
	                                  0.0628883558);
	
	impulse_email := (integer)contains_i(email_source_list, 'IM') > 0;
	
	ln_impulse_lvl := map(
	    impulse_annual_income > 20000 or impulse_count > 1 => 2,
	    impulse_count > 0 or impulse_email                 => 1,
	                                                          0);
	
	ln_impulse_lvl_m := map(
	    ln_impulse_lvl = 0 => 0.0488464473,
	    ln_impulse_lvl = 1 => 0.0574775764,
	                          0.0758937488);
	
	_add1_mortgage_date := Common.SAS_Date((STRING)(add1_mortgage_date));
	
	_add1_mortgage_due_date := Common.SAS_Date((STRING)(add1_mortgage_due_date));
	
	mtg_term := if(min(_add1_mortgage_due_date, _add1_mortgage_date) = NULL, NULL, truncate((_add1_mortgage_due_date - _add1_mortgage_date) / 365.25));
	
	_mtg_term := map(
	    (mtg_term in [9, 10])  => 10,
	    (mtg_term in [14, 15]) => 15,
	    (mtg_term in [19, 20]) => 20,
	    (mtg_term in [24, 25]) => 25,
	    (mtg_term in [29, 30]) => 30,
	    (mtg_term in [39, 40]) => 40,
	    not(mtg_term = NULL)   => 0,
	                              -1);
	
	mtg_typ_va := add1_mortgage_type = 'VA';
	
	mtg_typ_r := add1_mortgage_type = 'R';
	
	ln_mtg_risk_lvl := map(
	    add1_financing_type = 'CNV' or mtg_typ_va or mtg_typ_r => 0,
	    add1_financing_type = ' ' and _mtg_term != 40          => 1,
	    _mtg_term >= 10 or add1_financing_type = 'OTH'         => 2,
	    _mtg_term = -1 and add1_financing_type = 'ADJ'         => 3,
	                                                              4);
	
	ln_mtg_risk_lvl_m := map(
	    ln_mtg_risk_lvl = 0 => 0.0410447761,
	    ln_mtg_risk_lvl = 1 => 0.0505549221,
	    ln_mtg_risk_lvl = 2 => 0.055,
	    ln_mtg_risk_lvl = 3 => 0.0652503794,
	                           0.0904255319);
	
	_add1_date_last_seen := Common.SAS_Date((STRING)(add1_date_last_seen));
	
	mos_add1_date_last_seen := if(min(sysdate, _add1_date_last_seen) = NULL, NULL, truncate((sysdate - _add1_date_last_seen) / (365.25 / 12)));
	
	seen_recently := mos_add1_date_last_seen = 0;
	
	family_owned := add1_naprop = 3 or add1_family_owned;
	
	app_owned := add1_naprop = 4 and add1_applicant_owned and property_owned_total > 0;
	
	stolen_addr := (add1_naprop in [1, 2]);
	
	nothing_found := add1_naprop = 0;
	
	property_owner := property_owned_total > 0;
	
	naprop_log := -2.7537 +
	    (integer)add1_isbestmatch * -0.2230 +
	    (integer)app_owned * -0.4260 +
	    (integer)nothing_found * -0.0940;
	
	ln_naprop_model_c := round(100 * exp(naprop_log) / (1 + exp(naprop_log))/.1)*.1;
	
	ln_naprop_model_c_m := map(
	    (STRING3)TRIM((STRING)(ln_naprop_model_c)) = '3.2' => 0.032300885,
	    TRIM((STRING)(ln_naprop_model_c)) = '4'  					 => 0.0393912265,
	    (STRING3)TRIM((STRING)(ln_naprop_model_c)) = '4.4' => 0.0451516005,
	    (STRING3)TRIM((STRING)(ln_naprop_model_c)) = '4.8' => 0.0475954142,
	    (STRING3)TRIM((STRING)(ln_naprop_model_c)) = '5.5' => 0.0541926929,
																													0.060712796);
	
	_liens_unrel_ot_first_seen := Common.SAS_Date((STRING)(liens_unrel_OT_first_seen));
	
	_liens_unrel_ot_last_seen := Common.SAS_Date((STRING)(liens_unrel_OT_last_seen));
	
	_liens_rel_ot_first_seen := Common.SAS_Date((STRING)(liens_rel_OT_first_seen));
	
	_liens_rel_ot_last_seen := Common.SAS_Date((STRING)(liens_rel_OT_last_seen));
	
	mos_ot_unrel_first_seen := if(min(sysdate, _liens_unrel_ot_first_seen) = NULL, NULL, truncate((sysdate - _liens_unrel_ot_first_seen) / (365.25 / 12)));
	
	mos_ot_unrel_last_seen := if(min(sysdate, _liens_unrel_ot_last_seen) = NULL, NULL, truncate((sysdate - _liens_unrel_ot_last_seen) / (365.25 / 12)));
	
	mos_ot_rel_first_seen := if(min(sysdate, _liens_rel_ot_first_seen) = NULL, NULL, truncate((sysdate - _liens_rel_ot_first_seen) / (365.25 / 12)));
	
	mos_ot_rel_last_seen := if(min(sysdate, _liens_rel_ot_last_seen) = NULL, NULL, truncate((sysdate - _liens_rel_ot_last_seen) / (365.25 / 12)));
	
	hr_liens_ot_lvl := map(
	    0 <= mos_ot_rel_first_seen AND mos_ot_rel_first_seen <= 6 or 0 <= mos_ot_rel_last_seen AND mos_ot_rel_last_seen <= 6                                                                                                                                     => 4,
	    0 <= mos_ot_unrel_first_seen AND mos_ot_unrel_first_seen <= 12 or 0 <= mos_ot_unrel_last_seen AND mos_ot_unrel_last_seen <= 12 or 0 <= mos_ot_rel_first_seen AND mos_ot_rel_first_seen <= 12 or 0 <= mos_ot_rel_last_seen AND mos_ot_rel_last_seen <= 12 => 3,
	    0 <= mos_ot_unrel_first_seen AND mos_ot_unrel_first_seen <= 48 or 0 <= mos_ot_unrel_last_seen AND mos_ot_unrel_last_seen <= 48 or 0 <= mos_ot_rel_first_seen AND mos_ot_rel_first_seen <= 48 or 0 <= mos_ot_rel_last_seen AND mos_ot_rel_last_seen <= 48 => 2,
	    liens_unrel_OT_ct > 0 or liens_rel_OT_ct > 0                                                                                                                                                                                                             => 1,
	                                                                                                                                                                                                                                                                0);
	
	hr_liens_ot_lvl_m := map(
	    hr_liens_ot_lvl = 0 => 0.0482690508,
	    hr_liens_ot_lvl = 1 => 0.0658561297,
	    hr_liens_ot_lvl = 2 => 0.0948012232,
	    hr_liens_ot_lvl = 3 => 0.2080838323,
	                           0.4245283019);
	
	_gong_did_last_seen := Common.SAS_Date((STRING)(gong_did_last_seen));
	
	mos_since_gong_last_seen := if(min(sysdate, _gong_did_last_seen) = NULL, NULL, truncate((sysdate - _gong_did_last_seen) / (365.25 / 12)));
	
	phn_last_seen_rec := mos_since_gong_last_seen = 0;
	
	phn_pots := (telcordia_type in ['00', '50', '51', '52', '54']);
	
	phn_nonus := (rc_phonetype in ['3', '4']);
	
	phn_highrisk := rc_hriskphoneflag = (string)6 or rc_hphonetypeflag = '5' or rc_hphonevalflag = (string)3 or rc_addrcommflag = (string)1;
	
	// phn_notpots := not((telcordia_type in ['0', '50', '51', '52', '54']));
	phn_notpots := NOT phn_pots;
	
	phn_bad_counts := gong_did_first_ct > 2 or gong_did_last_ct > 2;
	
	hr_phone_prob_lvl := map(
	    phn_highrisk or phn_nonus           => 3,
	    phn_pots and phn_last_seen_rec      => 0,
	    phn_pots                            => 1,
	    phn_notpots and not(phn_bad_counts) => 2,
	                                           3);
	
	hr_phone_prob_lvl_m := map(
	    hr_phone_prob_lvl = 0 => 0.0344536633,
	    hr_phone_prob_lvl = 1 => 0.0484062797,
	    hr_phone_prob_lvl = 2 => 0.0526735505,
	                             0.0536202186);
	
	hr_max_ids_per_addr_c6_5 := min(if(max(ssns_per_addr_c6, adls_per_addr_c6) = NULL, -NULL, max(ssns_per_addr_c6, adls_per_addr_c6)), 5);
	
	hr_max_ids_per_addr_c6_5_m := map(
	    hr_max_ids_per_addr_c6_5 = 0 => 0.0476780186,
	    hr_max_ids_per_addr_c6_5 = 1 => 0.0505766408,
	    hr_max_ids_per_addr_c6_5 = 2 => 0.0592015932,
	    hr_max_ids_per_addr_c6_5 = 3 => 0.0585131894,
	    hr_max_ids_per_addr_c6_5 = 4 => 0.0673267327,
	                                    0.079401611);
	
	hr_ssns_per_adl_lvl := map(
	    ssns_per_adl = 0                         => 0,
	    ssns_per_adl = 1 and ssns_per_adl_c6 = 0 => 1,
	    ssns_per_adl = 2 and ssns_per_adl_c6 = 0 => 2,
	    ssns_per_adl = 3 and ssns_per_adl_c6 = 0 => 3,
	    ssns_per_adl = 1 and ssns_per_adl_c6 = 1 => 3,
	    ssns_per_adl < 6 and ssns_per_adl_c6 = 0 => 4,
	    ssns_per_adl = 2 and ssns_per_adl_c6 = 1 => 4,
	    ssns_per_adl = 2 and ssns_per_adl_c6 = 2 => 5,
	    ssns_per_adl = 3 and ssns_per_adl_c6 = 1 => 5,
	    ssns_per_adl = 4 and ssns_per_adl_c6 = 1 => 6,
	    ssns_per_adl = 3 and ssns_per_adl_c6 = 2 => 6,
	                                                7);
	/*
	####################################################################################################
	# manually added code here to accomodate SAS do loop;  this might need some changes to work properly
	####################################################################################################
	*/
	ver_sources_count := Models.Common.countw(ver_sources, ',');
	
	ds_layout := {
		integer 	pos,
		string 		source
	};
	
	l2_pos_dataset := dataset([
		{ 1, if(ver_sources_count >=  1, Models.Common.getw(ver_sources,  1), ' ')}, 
		{ 2, if(ver_sources_count >=  2, Models.Common.getw(ver_sources,  2), ' ')}, 
		{ 3, if(ver_sources_count >=  3, Models.Common.getw(ver_sources,  3), ' ')}, 
		{ 4, if(ver_sources_count >=  4, Models.Common.getw(ver_sources,  4), ' ')}, 
		{ 5, if(ver_sources_count >=  5, Models.Common.getw(ver_sources,  5), ' ')}, 
		{ 6, if(ver_sources_count >=  6, Models.Common.getw(ver_sources,  6), ' ')}, 
		{ 7, if(ver_sources_count >=  7, Models.Common.getw(ver_sources,  7), ' ')}, 
		{ 8, if(ver_sources_count >=  8, Models.Common.getw(ver_sources,  8), ' ')}, 
		{ 9, if(ver_sources_count >=  9, Models.Common.getw(ver_sources,  9), ' ')}, 
		{10, if(ver_sources_count >= 10, Models.Common.getw(ver_sources, 10), ' ')}, 
		{11, if(ver_sources_count >= 11, Models.Common.getw(ver_sources, 11), ' ')}, 
		{12, if(ver_sources_count >= 12, Models.Common.getw(ver_sources, 12), ' ')}, 
		{13, if(ver_sources_count >= 13, Models.Common.getw(ver_sources, 13), ' ')}, 
		{14, if(ver_sources_count >= 14, Models.Common.getw(ver_sources, 14), ' ')}, 
		{15, if(ver_sources_count >= 15, Models.Common.getw(ver_sources, 15), ' ')}, 
		{16, if(ver_sources_count >= 16, Models.Common.getw(ver_sources, 16), ' ')}, 
		{17, if(ver_sources_count >= 17, Models.Common.getw(ver_sources, 17), ' ')}, 
		{18, if(ver_sources_count >= 18, Models.Common.getw(ver_sources, 18), ' ')}, 
		{19, if(ver_sources_count >= 19, Models.Common.getw(ver_sources, 19), ' ')}, 
		{20, if(ver_sources_count >= 20, Models.Common.getw(ver_sources, 20), ' ')}
		], ds_layout)(source = 'L2');
	
	l2_pos_dataset_sorted := sort(l2_pos_dataset, -pos);
	
	l2_pos := if(count(l2_pos_dataset_sorted) > 0, l2_pos_dataset_sorted[1].pos, 0);
	
	l2_date_last_seen := if(l2_pos > 0, Models.Common.getw(ver_sources_last_seen, l2_pos), ' ');
	/*
	####################################################################################################
	# end of manual code
	####################################################################################################
	*/
	
	_l2_date_last_seen := Common.SAS_Date((STRING)(l2_date_last_seen));
	
	l2_date_last_seen_mos := if(min(sysdate, _l2_date_last_seen) = NULL, NULL, truncate((sysdate - _l2_date_last_seen) / (365.25 / 12)));
	
	hr_l2_date_last_seen_mos_c := if(l2_date_last_seen_mos < 0, 200, min(if(max(l2_date_last_seen_mos, 0) = NULL, -NULL, max(l2_date_last_seen_mos, 0)), 200));
	
	hr_l2_date_last_seen_mos_lg := ln(hr_l2_date_last_seen_mos_c + 1);
	
	avg_addrs_per_age := map(
	    applicant_age >= 18 + 15 => addrs_15yr / applicant_age,
	    applicant_age >= 18 + 10 => addrs_10yr / applicant_age,
	    applicant_age >= 18 + 5  => addrs_5yr / applicant_age,
	    applicant_age >= 18 + 3  => attr_addrs_last36 / applicant_age,
	    applicant_age >= 18 + 2  => attr_addrs_last24 / applicant_age,
	    applicant_age >= 18 + 1  => attr_addrs_last12 / applicant_age,
	                                -1);
	
	hr_avg_addrs_per_age_c := round(max(avg_addrs_per_age, (real)0) * 100);
	
	addrs_per_id_max := max(addrs_per_adl, addrs_per_ssn);
	
	hr_addrs_per_id_max_c := min(if(addrs_per_id_max = NULL, -NULL, addrs_per_id_max), 50);
	
	hr_addrs_per_id_max_lg := ln(hr_addrs_per_id_max_c + 1);
	
	_attr_date_first_purchase := Common.SAS_Date((STRING)(attr_date_first_purchase));
	
	yrs_attr_date_first_purchase := if(min(sysdate, _attr_date_first_purchase) = NULL, NULL, truncate((sysdate - _attr_date_first_purchase) / 365.25));
		
	age_attr_date_first_purchase := if(min(applicant_age, yrs_attr_date_first_purchase) = NULL, NULL, applicant_age - yrs_attr_date_first_purchase);
	
	_age_attr_date_first_purchase := map(
	    age_attr_date_first_purchase = NULL => -2,
	    age_attr_date_first_purchase < 0    => -1,
	                                           age_attr_date_first_purchase);
	
	ln_age_attr_date_first_purch_c := if((_age_attr_date_first_purchase in [-1, -2]), 30, min(if(max(_age_attr_date_first_purchase, 0) = NULL, -NULL, max(_age_attr_date_first_purchase, 0)), 60));
	
	ln_age_attr_date_first_purch_rt := sqrt(ln_age_attr_date_first_purch_c);
	
	repb_log_v2 := -7.406220965 +
	    ln_distance_lvl_m * 8.9283390068 +
	    ln_criminal_lvl_m * 13.032610391 +
	    ln_applicant_age_lvl_m * 12.295897357 +
	    ln_age_at_lowissue_lvl_m * 8.2213226938 +
	    ln_impulse_lvl_m * 10.524817414 +
	    ln_mtg_risk_lvl_m * 15.538834006 +
	    ln_naprop_model_c_m * 15.947934429 +
	    hr_liens_ot_lvl_m * 7.2551732836 +
	    hr_phone_prob_lvl_m * 13.287137917 +
	    hr_max_ids_per_addr_c6_5_m * 10.260652678 +
	    hr_l2_date_last_seen_mos_lg * -0.098684013 +
	    hr_avg_addrs_per_age_c * 0.0038843476 +
	    hr_addrs_per_id_max_lg * 0.2782708293 +
	    ln_age_attr_date_first_purch_rt * -0.140141533 +
	    ln_days_to_tax_day_sq * -0.000160304;
	
	phat := exp(repb_log_v2) / (1 + exp(repb_log_v2));
	
	base := 700;
	
	point := -40;
	
	odds := .0507 / (1 - .0507);
	
	repb_mod := round(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);
	
	custom_republic_ral_score := max(501, min(900, if(repb_mod = NULL, -NULL, repb_mod)));
	
	source_tot_ds := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'DS', ',') > 0;
	
	source_tot_ba := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'BA', ',') > 0;
	
	bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;
	
	lien_rec_unrel_flag := liens_recent_unreleased_count > 0;
	
	lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;
	
	source_tot_l2 := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'L2', ',') > 0;
	
	source_tot_li := (integer)indexw(StringLib.StringToUpperCase(trim((string)ver_sources, ALL)), 'LI', ',') > 0;
	
	lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;
	
	ssn_deceased := rc_decsflag = (string)1 or (integer)source_tot_ds = 1;
	
	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 or 90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid;
	
	rvd1110_1_0 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, custom_republic_ral_score);
	
	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

	inCalifornia := (isCalifornia and (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3);

	reasons := map(
			riTemp[1].hri <> '00' => riTemp,
			rvd1110_1_0 = 222 and ~inCalifornia => DATASET([{'19',risk_indicators.getHRIDesc('19')}, {'00',''}, {'00',''}, {'00',''}, {'00',''} ],risk_indicators.Layout_Desc),
			RiskWise.rv3retailReasonCodes(le, 4, inCalifornia, PreScreenOptOut)
		);

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.rc_hphonevalflag := rc_hphonevalflag;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_ssnlowissue := rc_ssnlowissue;
		SELF.rc_ssnhighissue := rc_ssnhighissue;
		SELF.rc_bansflag := rc_bansflag;
		SELF.rc_addrcommflag := rc_addrcommflag;
		SELF.rc_phonetype := rc_phonetype;
		SELF.combo_dobscore := combo_dobscore;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_last_seen := ver_sources_last_seen;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_applicant_owned := add1_applicant_owned;
		SELF.add1_family_owned := add1_family_owned;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_mortgage_date := add1_mortgage_date;
		SELF.add1_mortgage_type := add1_mortgage_type;
		SELF.add1_financing_type := add1_financing_type;
		SELF.add1_mortgage_due_date := add1_mortgage_due_date;
		SELF.add1_date_last_seen := add1_date_last_seen;
		SELF.property_owned_total := property_owned_total;
		SELF.property_sold_total := property_sold_total;
		SELF.dist_a1toa2 := dist_a1toa2;
		SELF.dist_a2toa3 := dist_a2toa3;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_10yr := addrs_10yr;
		SELF.addrs_15yr := addrs_15yr;
		SELF.addrs_prison_history := addrs_prison_history;
		SELF.telcordia_type := telcordia_type;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.gong_did_first_ct := gong_did_first_ct;
		SELF.gong_did_last_ct := gong_did_last_ct;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.addrs_per_ssn := addrs_per_ssn;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.ssns_per_addr_c6 := ssns_per_addr_c6;
		SELF.impulse_count := impulse_count;
		SELF.impulse_annual_income := impulse_annual_income;
		SELF.email_source_list := email_source_list;
		SELF.attr_addrs_last12 := attr_addrs_last12;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.attr_date_first_purchase := attr_date_first_purchase;
		SELF.bankrupt := bankrupt;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_unrel_ot_ct := liens_unrel_ot_ct;
		SELF.liens_unrel_ot_first_seen := liens_unrel_ot_first_seen;
		SELF.liens_unrel_ot_last_seen := liens_unrel_ot_last_seen;
		SELF.liens_rel_ot_ct := liens_rel_ot_ct;
		SELF.liens_rel_ot_first_seen := liens_rel_ot_first_seen;
		SELF.liens_rel_ot_last_seen := liens_rel_ot_last_seen;
		SELF.criminal_count := criminal_count;
		SELF.criminal_last_date := criminal_last_date;
		SELF.felony_count := felony_count;
		SELF.ams_age := ams_age;
		SELF.input_dob_age := input_dob_age;
		SELF.input_dob_match_level := input_dob_match_level;
		SELF.inferred_age := inferred_age;
		SELF.reported_dob := reported_dob;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.days_to_tax_day := days_to_tax_day;
		SELF.ln_days_to_tax_day_c := ln_days_to_tax_day_c;
		SELF.ln_days_to_tax_day_lg := ln_days_to_tax_day_lg;
		SELF.ln_days_to_tax_day_rt := ln_days_to_tax_day_rt;
		SELF.ln_days_to_tax_day_sq := ln_days_to_tax_day_sq;
		SELF._dist_a1toa2 := _dist_a1toa2;
		SELF._dist_a2toa3 := _dist_a2toa3;
		SELF.ln_distance_lvl := ln_distance_lvl;
		SELF.ln_distance_lvl_m := ln_distance_lvl_m;
		SELF._criminal_last_date := _criminal_last_date;
		SELF.mos_criminal_last_seen := mos_criminal_last_seen;
		SELF.ln_criminal_lvl := ln_criminal_lvl;
		SELF.ln_criminal_lvl_m := ln_criminal_lvl_m;
		SELF._reported_dob := _reported_dob;
		SELF.reported_age := reported_age;
		SELF.applicant_age := applicant_age;
		SELF.ln_applicant_age_lvl := ln_applicant_age_lvl;
		SELF.ln_applicant_age_lvl_m := ln_applicant_age_lvl_m;
		SELF.ssn_lowissuedate := ssn_lowissuedate;
		SELF.ssn_highissuedate := ssn_highissuedate;
		SELF.yrs_ssn_lowissuedate := yrs_ssn_lowissuedate;
		SELF.yrs_ssn_highissuedate := yrs_ssn_highissuedate;
		SELF.age_ssn_lowissue := age_ssn_lowissue;
		SELF.age_ssn_highissue := age_ssn_highissue;
		SELF._age_ssn_lowissue := _age_ssn_lowissue;
		SELF.ln_age_at_lowissue_lvl := ln_age_at_lowissue_lvl;
		SELF.ln_age_at_lowissue_lvl_m := ln_age_at_lowissue_lvl_m;
		SELF.impulse_email := impulse_email;
		SELF.ln_impulse_lvl := ln_impulse_lvl;
		SELF.ln_impulse_lvl_m := ln_impulse_lvl_m;
		SELF._add1_mortgage_date := _add1_mortgage_date;
		SELF._add1_mortgage_due_date := _add1_mortgage_due_date;
		SELF.mtg_term := mtg_term;
		SELF._mtg_term := _mtg_term;
		SELF.mtg_typ_va := mtg_typ_va;
		SELF.mtg_typ_r := mtg_typ_r;
		SELF.ln_mtg_risk_lvl := ln_mtg_risk_lvl;
		SELF.ln_mtg_risk_lvl_m := ln_mtg_risk_lvl_m;
		SELF._add1_date_last_seen := _add1_date_last_seen;
		SELF.mos_add1_date_last_seen := mos_add1_date_last_seen;
		SELF.seen_recently := seen_recently;
		SELF.family_owned := family_owned;
		SELF.app_owned := app_owned;
		SELF.stolen_addr := stolen_addr;
		SELF.nothing_found := nothing_found;
		SELF.property_owner := property_owner;
		SELF.naprop_log := naprop_log;
		SELF.ln_naprop_model_c := ln_naprop_model_c;
		SELF.ln_naprop_model_c_m := ln_naprop_model_c_m;
		SELF._liens_unrel_ot_first_seen := _liens_unrel_ot_first_seen;
		SELF._liens_unrel_ot_last_seen := _liens_unrel_ot_last_seen;
		SELF._liens_rel_ot_first_seen := _liens_rel_ot_first_seen;
		SELF._liens_rel_ot_last_seen := _liens_rel_ot_last_seen;
		SELF.mos_ot_unrel_first_seen := mos_ot_unrel_first_seen;
		SELF.mos_ot_unrel_last_seen := mos_ot_unrel_last_seen;
		SELF.mos_ot_rel_first_seen := mos_ot_rel_first_seen;
		SELF.mos_ot_rel_last_seen := mos_ot_rel_last_seen;
		SELF.hr_liens_ot_lvl := hr_liens_ot_lvl;
		SELF.hr_liens_ot_lvl_m := hr_liens_ot_lvl_m;
		SELF._gong_did_last_seen := _gong_did_last_seen;
		SELF.mos_since_gong_last_seen := mos_since_gong_last_seen;
		SELF.phn_last_seen_rec := phn_last_seen_rec;
		SELF.phn_pots := phn_pots;
		SELF.phn_nonus := phn_nonus;
		SELF.phn_highrisk := phn_highrisk;
		SELF.phn_notpots := phn_notpots;
		SELF.phn_bad_counts := phn_bad_counts;
		SELF.hr_phone_prob_lvl := hr_phone_prob_lvl;
		SELF.hr_phone_prob_lvl_m := hr_phone_prob_lvl_m;
		SELF.hr_max_ids_per_addr_c6_5 := hr_max_ids_per_addr_c6_5;
		SELF.hr_max_ids_per_addr_c6_5_m := hr_max_ids_per_addr_c6_5_m;
		SELF.hr_ssns_per_adl_lvl := hr_ssns_per_adl_lvl;
		SELF.ver_sources_count := ver_sources_count;
		SELF.l2_date_last_seen := l2_date_last_seen;
		SELF._l2_date_last_seen := _l2_date_last_seen;
		SELF.l2_date_last_seen_mos := l2_date_last_seen_mos;
		SELF.hr_l2_date_last_seen_mos_c := hr_l2_date_last_seen_mos_c;
		SELF.hr_l2_date_last_seen_mos_lg := hr_l2_date_last_seen_mos_lg;
		SELF.avg_addrs_per_age := avg_addrs_per_age;
		SELF.hr_avg_addrs_per_age_c := hr_avg_addrs_per_age_c;
		SELF.addrs_per_id_max := addrs_per_id_max;
		SELF.hr_addrs_per_id_max_c := hr_addrs_per_id_max_c;
		SELF.hr_addrs_per_id_max_lg := hr_addrs_per_id_max_lg;
		SELF._attr_date_first_purchase := _attr_date_first_purchase;
		SELF.yrs_attr_date_first_purchase := yrs_attr_date_first_purchase;
		SELF.age_attr_date_first_purchase := age_attr_date_first_purchase;
		SELF._age_attr_date_first_purchase := _age_attr_date_first_purchase;
		SELF.ln_age_attr_date_first_purch_c := ln_age_attr_date_first_purch_c;
		SELF.ln_age_attr_date_first_purch_rt := ln_age_attr_date_first_purch_rt;
		SELF.repb_log_v2 := repb_log_v2;
		SELF.phat := phat;
		SELF.base := base;
		SELF.point := point;
		SELF.odds := odds;
		SELF.repb_mod := repb_mod;
		SELF.custom_republic_ral_score := custom_republic_ral_score;
		SELF.source_tot_ds := source_tot_ds;
		SELF.source_tot_ba := source_tot_ba;
		SELF.bk_flag := bk_flag;
		SELF.lien_rec_unrel_flag := lien_rec_unrel_flag;
		SELF.lien_hist_unrel_flag := lien_hist_unrel_flag;
		SELF.source_tot_l2 := source_tot_l2;
		SELF.source_tot_li := source_tot_li;
		SELF.lien_flag := lien_flag;
		SELF.ssn_deceased := ssn_deceased;
		SELF.scored_222s := scored_222s;
		SELF.rvd1110_1_0 := rvd1110_1_0;

		SELF.rc1 := reasons[1].hri;
		SELF.rc2 := reasons[2].hri;
		SELF.rc3 := reasons[3].hri;
		SELF.rc4 := reasons[4].hri;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := MAP(
											riTemp[1].hri in ['91','92','93','94','95'] => (STRING3)((INTEGER)riTemp[1].hri + 10),
											SELF.ri[1].hri='35' 												=> '100',
																																		 (STRING3)rvd1110_1_0
											);
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
