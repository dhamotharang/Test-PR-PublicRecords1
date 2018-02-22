import ut, Risk_Indicators, RiskWise, RiskWiseFCRA, easi, lib_date, std;

export FP3905_1_0(dataset(risk_indicators.Layout_Boca_Shell) clam) := FUNCTION

temp := record
	layout_modelout;

#if(Risk_Indicators.iid_constants.validation_debug)
		Risk_Indicators.Layout_Boca_Shell clam;
		Easi.layout_census ea;
		
		//intermediates
		real prof_license_flag;
		real wealth_index; 
		real av_verx1_m; 
		real av_phn_prob_m; 
		real av_ssn_prob_m; 
		real av_add1_ownership_m; 
		real av_add1_prop_level_m; 
		real av_crime_lvl_m; 
		real av_liens_unrel_m; 
		real av_rel_lvl_m; 
		real adlperssn_count_c_m; 
		real adls_per_addr_c_m; 
		real ssns_per_addr_c6_c_m; 
		real phones_per_addr_c6_c_m; 
		real adls_per_phone_c6_c_m;
		real av_yrs_since_seen1_rt; 
		real av_combo_age; 
		real av_c_med_rent_lg; 
		real av_c_fammar_p; 
		real av_c_child; 
		real nossn_verx1_m; 
		real nossn_phn_prob_m; 
		real nossn_addr_prob_m; 
		real nossn_add1_census_education_m; 
		real nossn_add1_naprop_m; 
		real nossn_crime_lvl_m; 
		real nossn_poor_neighborhood2; 
		real nossn_phones_per_adl_c6; 
		real nossn_liens_unr; 
		real nossn_c_med_rent_lg; 
		real nossn_c_child; 
		real nossn_combo_age; 
		real cap_phninval; 
		real cap_hr_phn; 
		real cap_notdeliverable; 
		real cap_corrections; 
		real cap_ssnprob; 
		real cap_adlperssn; 
		real cap_dobmismatch; 
		real AV_log;
		real nossn_log;
		real fp3905_1_0; 

		real add1_date;
		real phn_notpots;
		real phn_cellpager;
		real phn_cell;
		real phn_highrisk2;
		real rel_count;
		real rel_prop_owned_count;
		real rel_prop_owned_count_pct;
		real rel_prop;	


#end
	
end;

	temp doModel(clam le, easi.Key_Easi_Census rt) := TRANSFORM

// field mapping		
	truedid                          := le.truedid;
	out_addr_status                  := le.shell_input.addr_status;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
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
	rc_ssnhighissue                  := le.iid.soclhighissue;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_sources                       := le.iid.sources;
	rc_addrcount                     := le.iid.addrcount;
	rc_addrcommflag                  := le.iid.addrcommflag;
	rc_hrisksic                      := le.iid.hrisksic;
	rc_hrisksicphone                 := le.iid.hrisksicphone;
	rc_phonetype                     := le.iid.phonetype;
	combo_dobscore                   := le.iid.combo_dobscore;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_address_score               := le.address_verification.input_address_information.address_score;
	add1_lres                        := le.lres;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	add1_census_income               := le.address_verification.input_address_information.census_income;
	add1_census_home_value           := le.address_verification.input_address_information.census_home_value;
	add1_census_education            := le.address_verification.input_address_information.census_education;
	add1_census_full_match           := le.address_verification.input_address_information.full_match;
	property_owned_total             := le.address_verification.owned.property_total;
	telcordia_type                   := le.phone_verification.telcordia_type;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	adlperssn_count                  := le.SSN_Verification.adlPerSSN_count;
	adls_per_addr                    := le.velocity_counters.adls_per_addr;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	phones_per_adl_c6                := le.velocity_counters.phones_per_adl_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
	adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	rel_count                        := le.relatives.relative_count;
	rel_criminal_count               := le.relatives.relative_criminal_count;
	rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
	rel_within25miles_count          := le.relatives.relative_within25miles_count;
	rel_incomeunder25_count          := le.relatives.relative_incomeunder25_count;
	rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
	rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
	rel_homeunder300_count           := le.relatives.relative_homeunder300_count;
	rel_homeunder500_count           := le.relatives.relative_homeunder500_count;
	rel_homeover500_count            := le.relatives.relative_homeover500_count;
	prof_license_flag                := le.professional_license.professional_license_flag;
	wealth_index                     := (integer)le.wealth_indicator;
	inferred_dob                     := le.reported_dob;
	archive_date                     := if(le.historydate=risk_indicators.iid_constants.default_history_date, 
																						(unsigned)Std.Date.Today(), 
																						(unsigned)risk_indicators.iid_constants.full_history_date(le.historydate) );
	c_child                          := rt.child;
	c_fammar_p                       := rt.fammar_p;
	c_med_rent                       := rt.med_rent;

// code generated from the converter		
NULL := -999999999;

BOOLEAN indexw(string source, string target, string delim) :=
	(source = target) OR
	(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
	(source[1..length(target)+1] = target + delim) OR
	(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);

v_nap_b1 := map(nap_summary in [7, 9, 11, 12]  => 3,
                nap_summary in [5, 8, 10]      => 2,
                nap_summary in [0, 2, 3, 4, 6] => 1,
                                                  0);

v_nap_b2 := map(nap_summary in [4, 5, 6, 7, 8] => 2,
                nap_summary in [0, 2, 3]       => 1,
                                                  0);

v_nap := if(hphnpop, v_nap_b1, v_nap_b2);

av_verx1 :=  map((nas_summary = 12) and (v_nap = 3)  => 7,
                 (nas_summary + v_nap) >= 13         => 6,
                 (nas_summary = 9) and (v_nap = 3)   => 4,
                 nas_summary = 1                     => 0,
                 (nas_summary = 0) and (v_nap = 0)   => 0,
                 (nas_summary <= 2) and (v_nap <= 1) => 2,
                 nas_summary in [4, 7, 9]            => 1,
                                                        5);

av_verx1_m :=  map(av_verx1 = 0 => 0.5724331927,
                   av_verx1 = 1 => 0.4743419303,
                   av_verx1 = 2 => 0.4505376344,
                   av_verx1 = 4 => 0.4214592275,
                   av_verx1 = 5 => 0.3177905308,
                   av_verx1 = 6 => 0.2460809587,
                                   0.1496702182);

phn_disconnected := ((integer)rc_hriskphoneflag = 5);

phn_inval := (((integer)rc_phonevalflag = 0) or (((integer)rc_hphonevalflag = 0) or (rc_phonetype in ['5'])));

phn_nonUs := (rc_phonetype in ['3', '4']);

phn_highrisk2 := not((rc_hriskphoneflag in ['0', '7']));

phn_notpots := not((telcordia_type in ['00', '50', '51', '52', '54']));

phn_cellpager := ((rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']));

phn_cell := ((rc_hriskphoneflag in ['1', '3']) or (rc_hphonetypeflag in ['1', '3']));

phn_zipmismatch := (((integer)rc_phonezipflag = 1) or ((integer)rc_pwphonezipflag = 1));

av_phn_prob :=  map(not(hphnpop)                                                  => -1,
                    phn_inval or phn_disconnected                                 => 3,
                    phn_nonUs or phn_zipmismatch                                  => 2,
                    phn_notpots or (phn_cellpager or (phn_cell or phn_highrisk2)) => 1,
                                                                                     0);
		
av_phn_prob_m :=  map(av_phn_prob = -1 => 0.3994528044,
                      av_phn_prob = 0  => 0.2554683785,
                      av_phn_prob = 1  => 0.3313418569,
                      av_phn_prob = 2  => 0.3527227723,
                                          0.4069373942);

source_tot_DS := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'DS', ',') > 0);

ssn_priordob := (((integer)rc_ssndobflag = 1) or ((integer)rc_pwssndobflag = 1));

ssn_deceased := (((integer)rc_decsflag = 1) or ((integer)source_tot_DS = 1));

ssn_adl_prob := ((ssns_per_adl >= 4) or (ssns_per_adl_c6 >= 2));

av_ssn_prob := (ssn_priordob or (ssn_deceased or ssn_adl_prob));

av_ssn_prob_m :=  map((integer)av_ssn_prob = 0 => 0.2878326105,
                                                  0.5002315887);

av_add1_ownership :=  map(add1_applicant_owned => 0,
                          add1_family_owned    => 1,
                          add1_occupant_owned  => 2,
                                                  3);

av_add1_ownership_m :=  map(av_add1_ownership = 0 => 0.0770040608,
                            av_add1_ownership = 1 => 0.1769583242,
                            av_add1_ownership = 2 => 0.35156072,
                                                     0.399004486);

add1_prop_level :=  map((add1_naprop = 4) and (property_owned_total > 0)                        => 3,
                        (add1_naprop = 4) or ((add1_naprop = 3) and (property_owned_total > 0)) => 2,
                        (add1_naprop = 3) or (property_owned_total > 0)                         => 1,
                                                                                                   0);

av_add1_prop_level :=  if(add1_address_score = 100, (add1_prop_level + 1), add1_prop_level);

av_add1_prop_level_m :=  map(av_add1_prop_level = 0 => 0.4724813041,
                             av_add1_prop_level = 1 => 0.3179981862,
                             av_add1_prop_level = 2 => 0.1821899137,
                             av_add1_prop_level = 3 => 0.0952380952,
                                                       0.0744003916);

source_tot_DA := ((integer)indexw(StringLib.StringToUpperCase(trim(rc_sources, ALL)), 'DA', ',') > 0);

av_crime_lvl :=  map(felony_count > 0                                     => 3,
                     criminal_count > 2                                   => 2,
                     (criminal_count > 0) or ((integer)source_tot_DA = 1) => 1,
                                                                             0);

av_crime_lvl_m :=  map(av_crime_lvl = 0 => 0.2866025304,
                       av_crime_lvl = 1 => 0.3469135802,
                       av_crime_lvl = 2 => 0.4654811715,
                                           0.6122807018);

av_liens_unrel :=  map((liens_recent_unreleased_count = 0) and (liens_historical_unreleased_ct = 0) => 0,
                       liens_recent_unreleased_count = 0                                            => 1,
                       liens_historical_unreleased_ct = 0                                           => 2,
                       liens_recent_unreleased_count < 4                                            => 3,
                                                                                                       4);

av_liens_unrel_m :=  map(av_liens_unrel = 0 => 0.2585590189,
                         av_liens_unrel = 1 => 0.3909255302,
                         av_liens_unrel = 2 => 0.4581967213,
                         av_liens_unrel = 3 => 0.5192118227,
                                               0.6243386243);

rel_incomeunder25_count_pct :=  if(rel_count > 0, (rel_incomeunder25_count / rel_count * 100), NULL);

rel_prop_owned_count_pct :=  if(rel_count > 0, (rel_prop_owned_count / rel_count * 100), NULL);

rich_rel := ((rel_incomeunder100_count > 0) or (rel_incomeover100_count > 0));

rel_nice_house := ((rel_homeunder300_count > 0) or ((rel_homeunder500_count > 0) or (boolean)rel_homeover500_count));

no_rel_crims := (rel_criminal_count = 0);

close_rels := (rel_within25miles_count > 0);

rel_prop := ((integer)rel_prop_owned_count_pct >= 75);

poor_rels := ((integer)rel_incomeunder25_count_pct >= 75);

av_rel_lvl :=  map(rel_nice_house and rel_prop     => 5,
                   rel_prop                        => 4,
                   rel_nice_house and rich_rel     => 3,
                   rel_nice_house or rich_rel      => 2,
                   close_rels                      => 1,
                   no_rel_crims                    => 0,
                   poor_rels and not(no_rel_crims) => -2,
                                                      -1);

av_rel_lvl_m :=  map(av_rel_lvl = -2 => 0.4941176471,
                     av_rel_lvl = -1 => 0.4641509434,
                     av_rel_lvl = 0  => 0.4368646939,
                     av_rel_lvl = 1  => 0.3059947146,
                     av_rel_lvl = 2  => 0.2538307795,
                     av_rel_lvl = 3  => 0.198860228,
                     av_rel_lvl = 4  => 0.1538956858,
                                        0.1241134752);

adlperssn_count_c :=  map(adlperssn_count = 1 => 0,
                          adlperssn_count = 2 => 1,
                          adlperssn_count = 3 => 2,
                                                 3);

adlperssn_count_c_m :=  map(adlperssn_count_c = 0 => 0.2757729123,
                            adlperssn_count_c = 1 => 0.311689607,
                            adlperssn_count_c = 2 => 0.3338748985,
                                                     0.3490652075);

adls_per_addr_c :=  map(adls_per_addr in [2, 3, 4, 5]                   => 0,
                        adls_per_addr in [6, 7]                         => 1,
                        adls_per_addr in [8, 9, 10]                     => 2,
                        adls_per_addr in [1, 11, 12, 13]                => 3,
                        (adls_per_addr >= 14) and (adls_per_addr <= 21) => 4,
                                                                           5);

adls_per_addr_c_m :=  map(adls_per_addr_c = 0 => 0.2022230643,
                          adls_per_addr_c = 1 => 0.2464454976,
                          adls_per_addr_c = 2 => 0.268081761,
                          adls_per_addr_c = 3 => 0.3146214099,
                          adls_per_addr_c = 4 => 0.3400277008,
                                                 0.3977745307);

ssns_per_addr_c6_c := min(if(ssns_per_addr_c6 = NULL, -NULL, ssns_per_addr_c6), 4);

ssns_per_addr_c6_c_m :=  map(ssns_per_addr_c6_c = 0 => 0.2668838743,
                             ssns_per_addr_c6_c = 1 => 0.3529921943,
                             ssns_per_addr_c6_c = 2 => 0.3906405576,
                             ssns_per_addr_c6_c = 3 => 0.3902439024,
                                                       0.5207100592);

phones_per_addr_c6_c := min(if(phones_per_addr_c6 = NULL, -NULL, phones_per_addr_c6), 3);

phones_per_addr_c6_c_m :=  map(phones_per_addr_c6_c = 0 => 0.271632722,
                               phones_per_addr_c6_c = 1 => 0.3512347516,
                               phones_per_addr_c6_c = 2 => 0.4657179819,
                                                           0.4276218612);

adls_per_phone_c6_c := min(if(adls_per_phone_c6 = NULL, -NULL, adls_per_phone_c6), 1);

adls_per_phone_c6_c_m :=  map(adls_per_phone_c6_c = 0 => 0.2946590696,
                                                         0.343238885);


// curr_date := (Lib_Date.DaysSince1900((integer)((string)archive_date)[1..4], (integer)((string)archive_date)[5..6], 1) - Lib_Date.DaysSince1900(1960, 1, 1));
curr_date := (Lib_Date.DaysSince1900((integer)((string)archive_date)[1..4], (integer)((string)archive_date)[5..6], (integer)(((string)archive_date)[7..8])) - Lib_Date.DaysSince1900(1960, 1, 1));

add1_date :=  if(length((string)add1_date_first_seen) = 6, (Lib_Date.DaysSince1900((integer)((string)add1_date_first_seen)[1..4], (integer)max((integer)((string)add1_date_first_seen)[5..6], 1), 1) - Lib_Date.DaysSince1900(1960, 1, 1)), NULL);

yrs_since_seen1 := truncate(((curr_date - add1_date) / 365.25));

av_yrs_since_seen1 := min(if((yrs_since_seen1 + 2) = NULL, -NULL, (yrs_since_seen1 + 2)), 35);

missing(unsigned val) := val=0;

av_yrs_since_seen1_2 :=  if(add1_date=null, 1, av_yrs_since_seen1);

av_yrs_since_seen1_rt := sqrt(av_yrs_since_seen1_2);

infer_date :=  Lib_Date.DaysSince1900((integer)((string)inferred_dob)[1..4], (integer)max((integer)((string)inferred_dob)[5..6], 1), (integer)(((string)inferred_dob)[7..8])) - Lib_Date.DaysSince1900(1960, 1, 1);

dob := Lib_Date.DaysSince1900((integer)in_dob[1..4], max((integer)in_dob[5..6], 1), (integer)in_dob[7..8]) - Lib_Date.DaysSince1900(1960, 1, 1);

calc_age := truncate(((curr_date - dob) / 365.25));

combo_age :=  map(not(missing((unsigned)in_dob)) and (calc_age > 0) => calc_age,
                  inferred_dob != 0               => truncate(((curr_date - infer_date) / 365.25)),
                                                               -1);

av_combo_age :=  map(not((boolean)(integer)truedid) => 30,
                     combo_age < 18                 => 65,
                                                       min(if(max(combo_age, 18) = NULL, -NULL, max(combo_age, 18)), 65));

av_c_med_rent := min(if(max((real)c_med_rent, 1) = NULL, -NULL, max((real)c_med_rent, 1)), 1200);

av_c_med_rent_2 :=  if((real)c_med_rent = 0, 1050, av_c_med_rent);

av_c_med_rent_3 :=  if(not(add1_census_full_match), 1200, av_c_med_rent_2);

av_c_med_rent_lg := ln(av_c_med_rent_3);

av_c_fammar_p := min(if(max((real)c_fammar_p, 10) = NULL, -NULL, max((real)c_fammar_p, 10)), 100);

av_c_fammar_p_2 :=  if(not(add1_census_full_match), 100, av_c_fammar_p);

av_c_child := min(if(max((real)c_child, 1) = NULL, -NULL, max((real)c_child, 1)), 50);

av_c_child_2 :=  if(not(add1_census_full_match), 1, av_c_child);

AV_log := -7.21372521 +
    (av_verx1_m * 1.8419985579) +
    (av_phn_prob_m * 1.7011184455) +
    (av_ssn_prob_m * 2.8343822862) +
    (av_add1_ownership_m * 1.5100200408) +
    (av_add1_prop_level_m * 0.8738490132) +
    (av_crime_lvl_m * 3.350056096) +
    (av_liens_unrel_m * 4.8806101361) +
    (av_rel_lvl_m * 0.9222638708) +
    (adlperssn_count_c_m * 2.8909910144) +
    (adls_per_addr_c_m * 1.8786881412) +
    (ssns_per_addr_c6_c_m * 2.6436755175) +
    (phones_per_addr_c6_c_m * 1.7321622336) +
    (adls_per_phone_c6_c_m * 5.8133922368) +
    (av_yrs_since_seen1_rt * -0.128037453) +
    (av_combo_age * -0.026588981) +
    (wealth_index * -0.210829747) +
    ((integer)prof_license_flag * -0.366192394) +
    (av_c_med_rent_lg * -0.244078405) +
    (av_c_fammar_p_2 * -0.010103505) +
    (av_c_child_2 * 0.0106423511);

base := 700;

point := -50;

// odds := NULL;
 odds  := .32579;
 
phat := (exp(AV_log) / (1 + exp(AV_log)));

AVON_CONTRACT_SSN := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));

AVON_CONTRACT_SSN_2 := max(250, min(999, if(AVON_CONTRACT_SSN = NULL, -NULL, AVON_CONTRACT_SSN)));

nossn_verx1 :=  map((combo_dobscore = 100) and (nas_summary in [2, 3, 5, 8]) => 3,
                    nas_summary in [2, 3, 5, 8]                              => 2,
                    nap_summary in [0, 1]                                    => 0,
                                                                                1);

nossn_verx1_m :=  map(nossn_verx1 = 0 => 0.4239785666,
                      nossn_verx1 = 1 => 0.2956810631,
                      nossn_verx1 = 2 => 0.3595197256,
                                         0.2523961661);

phn_disconnected_2 := ((integer)rc_hriskphoneflag = 5);

phn_inval_2 := (((integer)rc_phonevalflag = 0) or (((integer)rc_hphonevalflag = 0) or (rc_phonetype in ['5'])));

phn_zipmismatch_2 := (((integer)rc_phonezipflag = 1) or ((integer)rc_pwphonezipflag = 1));

nossn_phn_prob :=  map(not(hphnpop)                            => -1,
                       phn_disconnected_2 or phn_zipmismatch_2 => 2,
                       phn_inval_2                             => 1,
                                                                  0);

nossn_phn_prob_m :=  map(nossn_phn_prob = -1 => 0.5046875,
                         nossn_phn_prob = 0  => 0.3204122787,
                         nossn_phn_prob = 1  => 0.3797101449,
                                                0.4231536926);

comm_flag := (rc_addrcommflag in ['1', '2']);

add_highrisk := (((integer)rc_hriskaddrflag = 4) or ((integer)rc_addrcommflag = 2));

add_inval := (StringLib.StringToUpperCase(trim(rc_addrvalflag, LEFT, RIGHT)) != 'V');

add_ec1 := ((string)StringLib.StringToUpperCase(trim(out_addr_status, LEFT)))[1..1];

add_error := (add_ec1 = 'E');

nossn_addr_prob :=  map(add_highrisk or comm_flag => 3,
                        add_error or add_inval    => 2,
                        rc_addrcount = 0          => 1,
                                                     0);

nossn_addr_prob_m :=  map(nossn_addr_prob = 0 => 0.2238903394,
                          nossn_addr_prob = 1 => 0.3876801356,
                          nossn_addr_prob = 2 => 0.4244694132,
                                                 0.5324675325);

nossn_add1_census_education := min(if(max((integer)add1_census_education, 11) = NULL, -NULL, max((integer)add1_census_education, 11)), 15);

nossn_add1_census_education_m :=  map(nossn_add1_census_education = 11 => 0.3912922906,
                                      nossn_add1_census_education = 12 => 0.3141361257,
                                      nossn_add1_census_education = 13 => 0.2857142857,
                                      nossn_add1_census_education = 14 => 0.2789317507,
                                                                          0.2164179104);

own_prop := (property_owned_total > 0);

add100 := (add1_address_score = 100);

nossn_add1_naprop :=  map((add1_naprop = 0) and ((rc_dwelltype = ' ') and ((add1_lres = 0) and not(add100))) => 0,
                          (add1_naprop = 0) and not(add100)                                                  => 1,
                          (add1_naprop in [1, 2]) and not(add100)                                            => 2,
                          not(own_prop)                                                                      => 3,
                                                                                                                4);

nossn_add1_naprop_m :=  map(nossn_add1_naprop = 0 => 0.4264007597,
                            nossn_add1_naprop = 1 => 0.4130575307,
                            nossn_add1_naprop = 2 => 0.3714445064,
                            nossn_add1_naprop = 3 => 0.2429605792,
                                                     0.1277955272);

nossn_crime_lvl :=  map(felony_count > 0   => 2,
                        criminal_count > 0 => 1,
                                              0);

nossn_crime_lvl_m :=  map(nossn_crime_lvl = 0 => 0.3495179667,
                          nossn_crime_lvl = 1 => 0.3849765258,
                                                 0.6451612903);

nossn_poor_neighborhood2 := (((integer)add1_census_home_value < 50000) and (((integer)add1_census_income < 25000) and ((integer)add1_census_education < 12)));

nossn_phones_per_adl_c6 := min(if(phones_per_adl_c6 = NULL, -NULL, phones_per_adl_c6), 1);

liens_rec_unr_i := min(if(liens_recent_unreleased_count = NULL, -NULL, liens_recent_unreleased_count), 1);

liens_hist_unr_i := min(if(liens_historical_unreleased_ct = NULL, -NULL, liens_historical_unreleased_ct), 1);

nossn_liens_unr := ((boolean)liens_rec_unr_i or (boolean)liens_hist_unr_i);

nossn_c_med_rent := min(if(max((real)c_med_rent, 1) = NULL, -NULL, max((real)c_med_rent, 1)), 1200);

nossn_c_med_rent_2 :=  if((real)c_med_rent = 0, 1050, nossn_c_med_rent);

nossn_c_med_rent_3 :=  if(not(add1_census_full_match), 1200, nossn_c_med_rent_2);

nossn_c_med_rent_lg := ln(nossn_c_med_rent_3);

nossn_c_child := min(if(max((real)c_child, 1) = NULL, -NULL, max((real)c_child, 1)), 50);

nossn_c_child_2 :=  if(not(add1_census_full_match), 1, nossn_c_child);

nossn_combo_age := av_combo_age;

nossn_log := -4.362600719 +
    (nossn_verx1_m * 1.830506965) +
    (nossn_phn_prob_m * 2.7233673714) +
    (nossn_addr_prob_m * 1.8789816624) +
    (nossn_add1_census_education_m * 1.7235907237) +
    (nossn_add1_naprop_m * 2.4329199281) +
    (nossn_crime_lvl_m * 4.1458649146) +
    ((integer)nossn_poor_neighborhood2 * 0.3072847696) +
    (nossn_phones_per_adl_c6 * 0.5086021282) +
    ((integer)nossn_liens_unr * 0.4493412361) +
    (nossn_combo_age * -0.023098369) +
    (nossn_c_med_rent_lg * -0.201523613) +
    (nossn_c_child_2 * 0.0156416374);

base_2 := 700;

point_2 := -50;

// odds_2 := NULL;
odds_2  := .32579;
phat_2 := (exp(nossn_log) / (1 + exp(nossn_log)));

AVON_CONTRACT_NOSSN := round(((point_2 * ((ln((phat_2 / (1 - phat_2))) - ln(odds_2)) / ln(2))) + base_2));

AVON_CONTRACT_NOSSN_2 := max(250, min(999, if(AVON_CONTRACT_NOSSN = NULL, -NULL, AVON_CONTRACT_NOSSN)));

ssnpop := ((integer)ssnlength > 0);

avon_score :=  map(ssnpop => AVON_CONTRACT_SSN_2,
                             (AVON_CONTRACT_NOSSN_2 - 25));

ssnhighissue_yr :=  if((unsigned)rc_ssnhighissue<>0,
				(Lib_Date.DaysSince1900((integer)(rc_ssnhighissue)[1..4], (integer)((string)rc_ssnhighissue)[5..6], 1) - Lib_Date.DaysSince1900(1960, 1, 1)), 
				NULL);

dob_yr :=  if((integer)in_dob <> 0, 
				(Lib_Date.DaysSince1900((integer)((string)in_dob)[1..4], (integer)((string)in_dob)[5..6], 1) - Lib_Date.DaysSince1900(1960, 1, 1)), 
				NULL);

moderate_cutoff := 725;

severe_cutoff := 670;

verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

cap_phninval :=  if(((integer)verphn_p = 0) and (((integer)rc_phonevalflag = 0) or ((integer)rc_hphonevalflag = 0)), moderate_cutoff, NULL);
cap_hr_phn :=  if(((integer)rc_hriskphoneflag = 6) or (((integer)rc_hphonevalflag = 3) or ((integer)rc_hrisksicphone = 2225)), severe_cutoff, NULL);
cap_notdeliverable :=  if(rc_addrvalflag != 'V', moderate_cutoff, NULL);
cap_corrections :=  if((integer)rc_hrisksic = 2225, severe_cutoff, NULL);
cap_ssnprob :=  map(
			(integer)ssnlength > 0 and (integer)dobpop = 1 and 
			( (integer)rc_decsflag = 1 or 													
				rc_ssnvalflag not in ['0', '3'] or 								
				( (integer)rc_ssnvalflag = 2 and (integer)ssnlength = 4) or 	
				rc_pwssnvalflag in ['1', '2', '3'] or 
				(integer)rc_ssndobflag = 1 )  => moderate_cutoff,
				
			
			(integer)ssnlength > 0 and (integer)dobpop = 0 and 
			( (integer)rc_decsflag = 1 or 													
				rc_ssnvalflag not in ['0', '3'] or 								
				( (integer)rc_ssnvalflag = 2 and (integer)ssnlength = 4) or 	
				rc_pwssnvalflag in ['1', '2', '3'])  => moderate_cutoff,
				
			Null);
cap_adlperssn :=  if(adlperssn_count >= 6, moderate_cutoff, NULL);
cap_dobmismatch :=  if(((integer)(dob_yr - ssnhighissue_yr) > 0) and dob_yr<>null and ssnhighissue_yr<>null, severe_cutoff, NULL);

fp3905_1_0 := if(max(avon_score, cap_phninval, cap_hr_phn, cap_notdeliverable, cap_corrections, cap_ssnprob, cap_adlperssn, cap_dobmismatch) = NULL, 
NULL, min(if(avon_score = NULL, -NULL, avon_score), if(cap_phninval = NULL, -NULL, cap_phninval), 
if(cap_hr_phn = NULL, -NULL, cap_hr_phn), if(cap_notdeliverable = NULL, -NULL, cap_notdeliverable), 
if(cap_corrections = NULL, -NULL, cap_corrections), 
if(cap_ssnprob = NULL, -NULL, cap_ssnprob), 
if(cap_adlperssn = NULL, -NULL, cap_adlperssn), 
if(cap_dobmismatch = NULL, -NULL, cap_dobmismatch)));
		
		self.seq   := le.seq;
		
		blank_ip := dataset( [{0}], riskwise.Layout_IP2O )[1];
		nugen := true;
		num_reasons := 6;
		
		ritmp := riskwise.bdReasonCodesConsumer2( le, blank_ip, num_reasons, nugen );
		
		// If no reason codes are triggered and the score being returned is less than 800, return RC 34 - Per Bug 92594.
		reasons := Models.Common.checkFraudPointRC34(fp3905_1_0, ritmp, num_reasons);

		self.ri    := reasons;
		self.score := (string)fp3905_1_0;
		
#if(Risk_Indicators.iid_constants.validation_debug)	
		self.clam := le;
		self.ea := rt;
		self.ea := [];
		
		// intermediate variables
		self.add1_date := add1_date;
		self.phn_notpots := (real)phn_notpots;
		self.phn_cellpager := (real)phn_cellpager;
		self.phn_cell := (real)phn_cell;
		self.phn_highrisk2 := (real)phn_highrisk2;
		self.rel_count := rel_count;
		self.rel_prop_owned_count := rel_prop_owned_count;
		self.rel_prop_owned_count_pct := rel_prop_owned_count_pct;
		self.rel_prop := (real)rel_prop;
		self.prof_license_flag	:= 	(integer)prof_license_flag	;
		self.wealth_index 	:= 	wealth_index 	;
		self.av_verx1_m 	:= 	av_verx1_m 	;
		self.av_phn_prob_m 	:= 	av_phn_prob_m 	;
		self.av_ssn_prob_m 	:= 	av_ssn_prob_m 	;
		self.av_add1_ownership_m 	:= 	av_add1_ownership_m 	;
		self.av_add1_prop_level_m 	:= 	av_add1_prop_level_m 	;
		self.av_crime_lvl_m 	:= 	av_crime_lvl_m 	;
		self.av_liens_unrel_m 	:= 	av_liens_unrel_m 	;
		self.av_rel_lvl_m 	:= 	av_rel_lvl_m 	;
		self.adlperssn_count_c_m 	:= 	adlperssn_count_c_m 	;
		self.adls_per_addr_c_m 	:= 	adls_per_addr_c_m 	;
		self.ssns_per_addr_c6_c_m 	:= 	ssns_per_addr_c6_c_m 	;
		self.phones_per_addr_c6_c_m 	:= 	phones_per_addr_c6_c_m 	;
		self.adls_per_phone_c6_c_m	:= 	adls_per_phone_c6_c_m	;
		self.av_yrs_since_seen1_rt 	:= 	av_yrs_since_seen1_rt 	;
		self.av_combo_age 	:= 	av_combo_age 	;
		self.av_c_med_rent_lg 	:= 	av_c_med_rent_lg 	;
		self.av_c_fammar_p 	:= 	av_c_fammar_p 	;
		self.av_c_child 	:= 	av_c_child 	;
		self.nossn_verx1_m 	:= 	nossn_verx1_m 	;
		self.nossn_phn_prob_m 	:= 	nossn_phn_prob_m 	;
		self.nossn_addr_prob_m 	:= 	nossn_addr_prob_m 	;
		self.nossn_add1_census_education_m 	:= 	nossn_add1_census_education_m 	;
		self.nossn_add1_naprop_m 	:= 	nossn_add1_naprop_m 	;
		self.nossn_crime_lvl_m 	:= 	nossn_crime_lvl_m 	;
		self.nossn_poor_neighborhood2 	:= 	(integer)nossn_poor_neighborhood2 	;
		self.nossn_phones_per_adl_c6 	:= 	nossn_phones_per_adl_c6 	;
		self.nossn_liens_unr 	:= 	(integer)nossn_liens_unr 	;
		self.nossn_c_med_rent_lg 	:= 	nossn_c_med_rent_lg 	;
		self.nossn_c_child 	:= 	nossn_c_child 	;
		self.nossn_combo_age 	:= 	nossn_combo_age 	;
		self.cap_phninval 	:= 	cap_phninval 	;
		self.cap_hr_phn 	:= 	cap_hr_phn 	;
		self.cap_notdeliverable 	:= 	cap_notdeliverable 	;
		self.cap_corrections 	:= 	cap_corrections 	;
		self.cap_ssnprob 	:= 	cap_ssnprob 	;
		self.cap_adlperssn 	:= 	cap_adlperssn 	;
		self.cap_dobmismatch 	:= 	cap_dobmismatch 	;
		self.AV_log := av_log;
		self.nossn_log := nossn_log;
		self.fp3905_1_0 	:= 	fp3905_1_0 	;		
#end

	end;
	
	out := join(clam, easi.Key_Easi_Census,
				keyed(right.geolink=left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				doModel(left,right),
				left outer, keep(1));
				
				
	return out;

END;