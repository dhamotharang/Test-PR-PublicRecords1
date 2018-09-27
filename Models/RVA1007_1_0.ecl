IMPORT Risk_Indicators, RiskWise, RiskWiseFCRA, ut, std, riskview;
	
EXPORT RVA1007_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam, boolean isCalifornia) := FUNCTION

	Layout_ModelOut_ivars := record
		Layout_ModelOut;
		dataset(Models.Layout_Score) ivars;
	END;
	
RVA_DEBUG := FALSE;

#if(RVA_DEBUG)
layout_debug := RECORD
	UNSIGNED seq;
	STRING in_dob;
	INTEGER nap_summary;
	STRING rc_hriskphoneflag;
	STRING rc_hphonetypeflag;
	STRING rc_phonevalflag;
	STRING rc_hphonevalflag;
	STRING rc_addrvalflag;
	STRING rc_dwelltype;
	STRING rc_addrcommflag;
	STRING rc_phonetype;
	STRING rc_ziptypeflag;
	STRING rc_cityzipflag;
	BOOLEAN add1_isbestmatch;
	STRING add1_financing_type;
	INTEGER dist_a1toa2;
	BOOLEAN add2_isbestmatch;
	BOOLEAN add3_isbestmatch;
	BOOLEAN addrs_prison_history;
	STRING telcordia_type;
	STRING gong_did_first_seen;
	UNSIGNED gong_did_first_ct;
	UNSIGNED gong_did_last_ct;
	UNSIGNED ssns_per_adl;
	UNSIGNED ssns_per_adl_c6;
	UNSIGNED ssns_per_addr_c6;
	UNSIGNED infutor_first_seen;
	UNSIGNED infutor_nap;
	UNSIGNED impulse_count;
	UNSIGNED attr_num_purchase60;
	UNSIGNED attr_num_sold60;
	UNSIGNED attr_total_number_derogs;
	UNSIGNED attr_eviction_count;
	UNSIGNED attr_eviction_count90;
	UNSIGNED attr_eviction_count12;
	UNSIGNED attr_eviction_count36;
	UNSIGNED attr_num_nonderogs;
	STRING disposition;
	UNSIGNED bk_recent_count;
	UNSIGNED liens_unrel_cj_ct;
	UNSIGNED liens_unrel_cj_last_seen;
	UNSIGNED liens_unrel_lt_ct;
	UNSIGNED liens_unrel_lt_last_seen;
	UNSIGNED liens_rel_lt_ct;
	UNSIGNED liens_unrel_sc_ct;
	UNSIGNED liens_rel_sc_ct;
	UNSIGNED criminal_count;
	UNSIGNED criminal_last_date;
	UNSIGNED felony_count;
	BOOLEAN prof_license_flag;
	STRING input_dob_age;
	STRING addr_stability;
	INTEGER sysdate;
	BOOLEAN phn_pots;
	BOOLEAN phn_disconnected;
	BOOLEAN phn_inval;
	BOOLEAN phn_nonUs;
	BOOLEAN phn_highrisk;
	BOOLEAN phn_notpots;
	BOOLEAN phn_cellpager;
	BOOLEAN phn_business;
	BOOLEAN phn_residential;
	INTEGER mod1_phn_prob;
	REAL mod1_phn_prob_m;
	INTEGER gong_did_first_seen2;
	INTEGER yrs_since_gong_first_seen;
	INTEGER mod1_gong_first_seen_lvl;
	REAL mod1_gong_first_seen_lvl_m;
	INTEGER _criminal_last_date;
	INTEGER months_criminal_last_date;
	INTEGER mod1_crime_lvl;
	REAL mod1_crime_lvl_m;
	INTEGER mod1_bk_lvl;
	REAL mod1_bk_lvl_m;
	INTEGER mod1_ssns_per_adl_lvl;
	REAL mod1_ssns_per_adl_lvl_m;
	INTEGER mod1_eviction_lvl;
	REAL mod1_eviction_lvl_m;
	BOOLEAN invalid_addr;
	BOOLEAN not_reg_zip;
	BOOLEAN zip_city_mismatch;
	INTEGER mod1_addr_prob_lvl;
	REAL mod1_addr_prob_lvl_m;
	BOOLEAN mod1_gong_name_hi_counts;
	BOOLEAN mod1_impulse_flag;
	BOOLEAN mod1_prof_license;
	INTEGER _in_dob;
	INTEGER in_dob_age;
	INTEGER mod1_in_dob_age;
	REAL mod1_in_dob_age_lg;
	INTEGER mod1_dist_a1toa2;
	REAL mod1_dist_a1toa2_rt;
	INTEGER mod1_best_match_lvl;
	REAL mod1_best_match_lvl_m;
	BOOLEAN add_apt;
	INTEGER mod1_ssns_per_addr_lvl;
	REAL mod1_ssns_per_addr_lvl_m;
	BOOLEAN mod1_ADJ_loan;
	INTEGER _infutor_first_seen;
	INTEGER months_infutor_first_seen;
	BOOLEAN mod1_infutor_first_seen_6;
	INTEGER mod1_prop_turnover_lvl;
	REAL mod1_prop_turnover_lvl_m;
	INTEGER mod1_addr_stability;
	REAL mod1_addr_stability_m;
	INTEGER mod1_attr_num_nonderogs_6;
	REAL mod1_attr_num_nonderogs_6_m;
	INTEGER mod1_derog_ratio;
	REAL mod1_derog_ratio_m;
	BOOLEAN contrary_phn;
	BOOLEAN verfst_p;
	BOOLEAN verlst_p;
	BOOLEAN veradd_p;
	BOOLEAN verphn_p;
	BOOLEAN ver_nap6;
	INTEGER ver_phncount;
	INTEGER infutor_lvl;
	INTEGER nap_lvl;
	INTEGER mod1_ver_nap;
	REAL mod1_ver_nap_m;
	INTEGER mod1_lien_sc_lvl;
	REAL mod1_lien_sc_lvl_m;
	INTEGER CJ_last_seen;
	INTEGER mos_since_CJ_seen;
	INTEGER mod1_lien_cj_lvl;
	REAL mod1_lien_cj_lvl_m;
	INTEGER LT_last_seen;
	INTEGER mos_since_LT_seen;
	INTEGER mod1_lien_cj_lvl_2;
	INTEGER mod1_lien_lt_lvl;
	REAL mod1_lien_lt_lvl_m;
	REAL KGB_MODEL_LOG;
	INTEGER base;
	INTEGER point;
	REAL odds;
	REAL phat;
	INTEGER KGB_MODEL;
	INTEGER RVA1007_1_0;
	INTEGER var01;
	INTEGER var02;
	INTEGER var03;
	INTEGER var04;
	INTEGER var05;
	INTEGER var06;
	BOOLEAN var07;
	BOOLEAN var08;
	BOOLEAN var09;
	INTEGER var10;
	INTEGER var11;
	INTEGER var12;
	INTEGER var13;
	BOOLEAN var14;
	BOOLEAN var15;
	INTEGER var16;
	INTEGER var17;
	INTEGER var18;
	INTEGER var19;
	INTEGER var20;
	INTEGER var21;
	INTEGER var22;
	INTEGER var23;
	STRING Score;	
END;
	layout_debug doModel( clam le ) := TRANSFORM
#else
	Layout_ModelOut_ivars doModel( clam le ) := TRANSFORM 
#end
	
/* ***********************************************************
	*                 Input Variables                          *
	************************************************************ */
	in_dob                      := le.shell_input.dob;
	nap_summary                 := le.iid.nap_summary;
	rc_hriskphoneflag           := le.iid.hriskphoneflag;
	rc_hphonetypeflag           := le.iid.hphonetypeflag;
	rc_phonevalflag             := le.iid.phonevalflag;
	rc_hphonevalflag            := le.iid.hphonevalflag;
	rc_addrvalflag              := le.iid.addrvalflag;
	rc_dwelltype                := le.iid.dwelltype;
	rc_addrcommflag             := le.iid.addrcommflag;
	rc_phonetype                := le.iid.phonetype;
	rc_ziptypeflag              := le.iid.ziptypeflag;
	rc_cityzipflag              := le.iid.cityzipflag;
	add1_isbestmatch            := le.address_verification.input_address_information.isbestmatch;
	add1_financing_type         := le.address_verification.input_address_information.type_financing;
	dist_a1toa2                 := le.address_verification.distance_in_2_h1;
	add2_isbestmatch            := le.address_verification.address_history_1.isbestmatch;
	add3_isbestmatch            := le.address_verification.address_history_2.isbestmatch;
	addrs_prison_history        := le.other_address_info.isprison;
	telcordia_type              := le.phone_verification.telcordia_type;
	gong_did_first_seen         := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_first_ct           := le.phone_verification.gong_did.gong_did_first_ct;
	gong_did_last_ct            := le.phone_verification.gong_did.gong_did_last_ct;
	ssns_per_adl                := le.velocity_counters.ssns_per_adl;
	ssns_per_adl_c6             := le.velocity_counters.ssns_per_adl_created_6months;
	ssns_per_addr_c6            := le.velocity_counters.ssns_per_addr_created_6months;
	infutor_first_seen          := le.infutor_phone.infutor_date_first_seen;
	infutor_nap                 := le.infutor_phone.infutor_nap;
	impulse_count               := le.impulse.count;
	attr_num_purchase60         := le.other_address_info.num_purchase60;
	attr_num_sold60             := le.other_address_info.num_sold60;
	attr_total_number_derogs    := le.total_number_derogs;
	attr_eviction_count         := le.bjl.eviction_count;
	attr_eviction_count90       := le.bjl.eviction_count90;
	attr_eviction_count12       := le.bjl.eviction_count12;
	attr_eviction_count36       := le.bjl.eviction_count36;
	attr_num_nonderogs          := le.source_verification.num_nonderogs;
	disposition                 := le.bjl.disposition;
	bk_recent_count             := le.bjl.bk_recent_count;
	liens_unrel_cj_ct           := le.liens.liens_unreleased_civil_judgment.count;
	liens_unrel_cj_last_seen    := le.liens.liens_unreleased_civil_judgment.most_recent_filing_date;
	liens_unrel_lt_ct           := le.liens.liens_unreleased_landlord_tenant.count;
	liens_unrel_lt_last_seen    := le.liens.liens_unreleased_landlord_tenant.most_recent_filing_date;
	liens_rel_lt_ct             := le.liens.liens_released_landlord_tenant.count;
	liens_unrel_sc_ct           := le.liens.liens_unreleased_small_claims.count;
	liens_rel_sc_ct             := le.liens.liens_released_small_claims.count;
	criminal_count              := le.bjl.criminal_count;
	criminal_last_date          := le.bjl.last_criminal_date;
	felony_count                := le.bjl.felony_count;
	prof_license_flag           := le.professional_license.professional_license_flag;
	input_dob_age               := le.shell_input.age;
	addr_stability              := le.mobility_indicator;

	seq													:= le.seq;

/* ***********************************************************
	*                   Generated ECL                          *
	************************************************************ */
NULL := -999999999;

sysdate := common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01'));

phn_pots := (telcordia_type in ['00', '50', '51', '52', '54']);

phn_disconnected := ((integer)rc_hriskphoneflag = 5);

phn_inval := (((integer)rc_phonevalflag = 0) or (((integer)rc_hphonevalflag = 0) or (rc_phonetype in ['5'])));

phn_nonUs := (rc_phonetype in ['3', '4']);

phn_highrisk := (((integer)rc_hriskphoneflag = 6) or ((rc_hphonetypeflag = '5') or (((integer)rc_hphonevalflag = 3) or ((integer)rc_addrcommflag = 1))));

phn_notpots := (telcordia_type not in ['00', '50', '51', '52', '54']);

phn_cellpager := ((rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']));

phn_business := ((integer)rc_hphonevalflag = 1);

phn_residential := ((integer)rc_hphonevalflag = 2);

mod1_phn_prob :=  map(phn_nonUs or (phn_highrisk or (phn_disconnected or (phn_inval or (phn_notpots and not(phn_cellpager))))) => 4,
                      (phn_notpots and (infutor_nap = 0)) or ((phn_pots and (infutor_nap in [1, 2])) or phn_business)          => 3,
                      phn_residential and (infutor_nap = 0)                                                                    => 0,
                      phn_residential                                                                                          => 2,
                                                                                                                                  1);

mod1_phn_prob_m :=  map(mod1_phn_prob = 0 => 0.2153571868,
                        mod1_phn_prob = 1 => 0.2608695652,
                        mod1_phn_prob = 2 => 0.2843869732,
                        mod1_phn_prob = 3 => 0.3039980134,
                                             0.3190717912);

gong_did_first_seen2 := IF(TRIM(gong_did_first_seen)='', -NULL,common.sas_date(gong_did_first_seen));

yrs_since_gong_first_seen := truncate(((sysdate - gong_did_first_seen2) / 365.25));

mod1_gong_first_seen_lvl :=  map(yrs_since_gong_first_seen > 7  => 3,
                                 yrs_since_gong_first_seen > 4  => 2,
                                 yrs_since_gong_first_seen > 1  => 1,
                                 yrs_since_gong_first_seen >= 0 => 0,
                                                                   2);

mod1_gong_first_seen_lvl_m :=  map(mod1_gong_first_seen_lvl = 0 => 0.3090699018,
                                   mod1_gong_first_seen_lvl = 1 => 0.2785703329,
                                   mod1_gong_first_seen_lvl = 2 => 0.2693120504,
                                                                   0.2240611802);

_criminal_last_date := IF(criminal_last_date=0, -NULL,common.sas_date((STRING)criminal_last_date));

months_criminal_last_date := truncate(((sysdate - _criminal_last_date) / (365.25 / 12)));

mod1_crime_lvl :=  map(criminal_count = 0                                                     => 0,
                       (0 <= months_criminal_last_date) AND (months_criminal_last_date <= 12) => 3,
                       (criminal_count = 1) and (felony_count = 0)                            => 1,
                                                                                                 2);

mod1_crime_lvl_m :=  map(mod1_crime_lvl = 0 => 0.2646904206,
                         mod1_crime_lvl = 1 => 0.3192675159,
                         mod1_crime_lvl = 2 => 0.3553585818,
                                               0.4262626263);

mod1_bk_lvl :=  map(bk_recent_count > 0                       => 0,
                    StringLib.StringToUpperCase((string)disposition) = 'DISMISSED' => 2,
                                                                 1);

mod1_bk_lvl_m :=  map(mod1_bk_lvl = 0 => 0.1494252874,
                      mod1_bk_lvl = 1 => 0.2664017418,
                                         0.3123752495);

mod1_ssns_per_adl_lvl :=  map((ssns_per_adl_c6 = 0) and (ssns_per_adl in [1, 2, 3]) => 4,
                              ssns_per_adl < 2                                      => 3,
                              (ssns_per_adl = 2) and (ssns_per_adl_c6 = 1)          => 2,
                              (ssns_per_adl + ssns_per_adl_c6) = 4                  => 1,
                                                                                       0);

mod1_ssns_per_adl_lvl_m :=  map(mod1_ssns_per_adl_lvl = 0 => 0.3578832515,
                                mod1_ssns_per_adl_lvl = 1 => 0.3075953356,
                                mod1_ssns_per_adl_lvl = 2 => 0.2994777598,
                                mod1_ssns_per_adl_lvl = 3 => 0.2737628791,
                                                             0.2569646305);

mod1_eviction_lvl :=  map(attr_eviction_count90 > 0 => 4,
                          attr_eviction_count12 > 0 => 3,
                          attr_eviction_count36 > 0 => 2,
                          attr_eviction_count > 0   => 1,
                                                       0);

mod1_eviction_lvl_m :=  map(mod1_eviction_lvl = 0 => 0.2580881208,
                            mod1_eviction_lvl = 1 => 0.3390986602,
                            mod1_eviction_lvl = 2 => 0.3707865169,
                            mod1_eviction_lvl = 3 => 0.3824940048,
                                                     0.4562211982);

invalid_addr := (rc_addrvalflag in ['M', 'N']);

not_reg_zip := ((integer)rc_ziptypeflag != 0);

zip_city_mismatch := ((integer)rc_cityzipflag = 1);

mod1_addr_prob_lvl :=  map(((invalid_addr and not_reg_zip)) or (not_reg_zip or addrs_prison_history) => 3,
                           ((integer)rc_ziptypeflag = 0) and ((rc_addrvalflag = 'V') and zip_city_mismatch) => 2,
                           invalid_addr                                                                     => 1,
                                                                                                               0);

mod1_addr_prob_lvl_m :=  map(mod1_addr_prob_lvl = 0 => 0.2646297336,
                             mod1_addr_prob_lvl = 1 => 0.290444092,
                             mod1_addr_prob_lvl = 2 => 0.3138151876,
                                                       0.3314191961);

mod1_gong_name_hi_counts := ((gong_did_first_ct > 2) or (gong_did_last_ct > 2));

mod1_impulse_flag := (impulse_count > 0);

mod1_prof_license := prof_license_flag;

_in_dob := IF(TRIM(in_dob)='' OR in_dob='0' OR (unsigned)in_dob[1..4] < 1900, -NULL, common.sas_date(in_dob));

in_dob_age := truncate(((sysdate - _in_dob) / 365.25));

mod1_in_dob_age := min(if(max(in_dob_age, 18) = NULL, 18, max(in_dob_age, 18)), 75);

mod1_in_dob_age_lg := ln(mod1_in_dob_age);

mod1_dist_a1toa2 :=  map(dist_a1toa2 = 0    => 100,
                         dist_a1toa2 > 5000 => 1,
                                               min(if(max((dist_a1toa2 + 1), 1) = NULL, -NULL, max((dist_a1toa2 + 1), 1)), 5000));

mod1_dist_a1toa2_rt := sqrt(mod1_dist_a1toa2);

mod1_best_match_lvl :=  map(add1_isbestmatch => 2,
                            add2_isbestmatch => 1,
                            add3_isbestmatch => 0,
                                                -1);

mod1_best_match_lvl_m :=  map(mod1_best_match_lvl = -1 => 0.32145305,
                              mod1_best_match_lvl = 0  => 0.3034274194,
                              mod1_best_match_lvl = 1  => 0.30496129,
                                                          0.2490252585);

add_apt := (rc_dwelltype = 'A');

mod1_ssns_per_addr_lvl :=  map(ssns_per_addr_c6 > 4                                           => 4,
                               ssns_per_addr_c6 > 2                                           => 3,
                               (ssns_per_addr_c6 = 2) or ((ssns_per_addr_c6 = 1) and add_apt) => 2,
                               ssns_per_addr_c6 = 1                                           => 1,
                                                                                                 0);

mod1_ssns_per_addr_lvl_m :=  map(mod1_ssns_per_addr_lvl = 0 => 0.2574438375,
                                 mod1_ssns_per_addr_lvl = 1 => 0.2766458872,
                                 mod1_ssns_per_addr_lvl = 2 => 0.2979446991,
                                 mod1_ssns_per_addr_lvl = 3 => 0.3416536661,
                                                               0.3822525597);

mod1_ADJ_loan := (add1_financing_type = 'ADJ');

_infutor_first_seen := IF(infutor_first_seen=0, -NULL, common.sas_date((STRING)infutor_first_seen));

months_infutor_first_seen := truncate(((sysdate - _infutor_first_seen) / (365.25 / 12)));

mod1_infutor_first_seen_6 := ((0 <= months_infutor_first_seen) AND (months_infutor_first_seen <= 6));

mod1_prop_turnover_lvl :=  map((attr_num_purchase60 = 0) and (attr_num_sold60 > 0) => 2,
                               (attr_num_purchase60 < 2) and (attr_num_sold60 = 0) => 1,
                                                                                      0);

mod1_prop_turnover_lvl_m :=  map(mod1_prop_turnover_lvl = 0 => 0.2377940804,
                                 mod1_prop_turnover_lvl = 1 => 0.2684557318,
                                                               0.2911240232);

mod1_addr_stability :=  map((integer)addr_stability > 5 => 4,
                            (integer)addr_stability > 4 => 3,
                            (integer)addr_stability > 3 => 2,
                            (integer)addr_stability > 1 => 1,
                            (integer)addr_stability = 1 => 0,
                                                           1);

mod1_addr_stability_m :=  map(mod1_addr_stability = 0 => 0.3326621023,
                              mod1_addr_stability = 1 => 0.2797640838,
                              mod1_addr_stability = 2 => 0.244460501,
                              mod1_addr_stability = 3 => 0.2336153123,
                                                         0.2);

mod1_attr_num_nonderogs_6 := min(if(attr_num_nonderogs = NULL, -NULL, attr_num_nonderogs), 6);

mod1_attr_num_nonderogs_6_m :=  map(mod1_attr_num_nonderogs_6 = 0 => 0.3155555556,
                                    mod1_attr_num_nonderogs_6 = 1 => 0.3089076282,
                                    mod1_attr_num_nonderogs_6 = 2 => 0.278227111,
                                    mod1_attr_num_nonderogs_6 = 3 => 0.261310306,
                                    mod1_attr_num_nonderogs_6 = 4 => 0.2497354497,
                                    mod1_attr_num_nonderogs_6 = 5 => 0.2437919159,
                                                                     0.2225433526);

mod1_derog_ratio :=  if(attr_total_number_derogs > 0, truncate(min(if((attr_num_nonderogs / attr_total_number_derogs) = NULL, -NULL, (attr_num_nonderogs / attr_total_number_derogs)), 6)), -1);

mod1_derog_ratio_m :=  map(mod1_derog_ratio = -1 => 0.2526543453,
                           mod1_derog_ratio = 0  => 0.3503264691,
                           mod1_derog_ratio = 1  => 0.2921039725,
                           mod1_derog_ratio = 2  => 0.267815759,
                           mod1_derog_ratio = 3  => 0.2494914,
                           mod1_derog_ratio = 4  => 0.2329769274,
                           mod1_derog_ratio = 5  => 0.2175102599,
                                                    0.1875);

contrary_phn := (nap_summary in [1]);

verfst_p := (nap_summary in [2, 3, 4, 8, 9, 10, 12]);

verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);

veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);

verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);

ver_nap6 := (nap_summary in [6]);

ver_phncount := if(max((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p) = NULL, NULL, sum((integer)verfst_p, (integer)verlst_p, (integer)veradd_p, (integer)verphn_p));

infutor_lvl :=  map(infutor_nap = 0 => 0,
                    infutor_nap = 1 => 1,
                                       2);

nap_lvl :=  map(nap_summary = 12                   => 12,
                verphn_p                           => 3,
                veradd_p or (verlst_p or verfst_p) => 2,
                contrary_phn                       => 1,
                                                      0);

mod1_ver_nap :=  map((infutor_lvl = 0) and (nap_lvl = 12) => 5,
                     (infutor_lvl = 0) and (nap_lvl = 3)  => 4,
                     (infutor_lvl = 2) and (nap_lvl = 2)  => 4,
                     (infutor_lvl = 2) and (nap_lvl = 0)  => 3,
                     (infutor_lvl = 0) and (nap_lvl < 2)  => 1,
                     (infutor_lvl = 2) and (nap_lvl = 3)  => 1,
                     (infutor_lvl > 0) and (nap_lvl = 1)  => 0,
                     (infutor_lvl = 1) and (nap_lvl = 3)  => 0,
                                                             2);

mod1_ver_nap_m :=  map(mod1_ver_nap = 0 => 0.3489932886,
                       mod1_ver_nap = 1 => 0.3022810044,
                       mod1_ver_nap = 2 => 0.2855481392,
                       mod1_ver_nap = 3 => 0.2566588655,
                       mod1_ver_nap = 4 => 0.2310144928,
                                           0.1884122729);

mod1_lien_sc_lvl :=  map((liens_unrel_sc_ct = 0) and (liens_rel_sc_ct = 0) => 0,
                         liens_unrel_sc_ct < 2                             => 1,
                         liens_unrel_sc_ct < 3                             => 2,
                                                                              3);

mod1_lien_sc_lvl_m :=  map(mod1_lien_sc_lvl = 0 => 0.262800306,
                           mod1_lien_sc_lvl = 1 => 0.3107119095,
                           mod1_lien_sc_lvl = 2 => 0.3578629032,
                                                   0.4009661836);

CJ_last_seen := IF(liens_unrel_cj_last_seen=0, -NULL, common.sas_date((STRING)liens_unrel_cj_last_seen));

mos_since_CJ_seen := truncate(((sysdate - CJ_last_seen) / (365.25 / 12)));

mod1_lien_cj_lvl :=  map(mos_since_CJ_seen = 0 => 4,
                         liens_unrel_cj_ct = 0 => 0,
                         liens_unrel_cj_ct = 1 => 1,
                         liens_unrel_cj_ct = 2 => 2,
                         liens_unrel_cj_ct < 5 => 3,
                                                  4);

mod1_lien_cj_lvl_m :=  map(mod1_lien_cj_lvl = 0 => 0.2539859837,
                           mod1_lien_cj_lvl = 1 => 0.29597831,
                           mod1_lien_cj_lvl = 2 => 0.3138622493,
                           mod1_lien_cj_lvl = 3 => 0.3539697543,
                                                   0.4061696658);

LT_last_seen := IF(liens_unrel_lt_last_seen=0, -NULL, common.sas_date((STRING)liens_unrel_lt_last_seen));

mos_since_LT_seen := truncate(((sysdate - LT_last_seen) / (365.25 / 12)));

mod1_lien_cj_lvl_2 :=  map(mos_since_CJ_seen = 0 => 4,
                           liens_unrel_cj_ct = 0 => 0,
                           liens_unrel_cj_ct = 1 => 1,
                           liens_unrel_cj_ct = 2 => 2,
                           liens_unrel_cj_ct < 5 => 3,
                                                    4);

mod1_lien_lt_lvl :=  map(mos_since_LT_seen > 48                           => 1,
                         (liens_unrel_lt_ct > 0) or (liens_rel_lt_ct > 0) => 2,
                                                                             0);

mod1_lien_lt_lvl_m :=  map(mod1_lien_lt_lvl = 0 => 0.264511634,
                           mod1_lien_lt_lvl = 1 => 0.3081312411,
                                                   0.3940362087);

KGB_MODEL_LOG := -11.41484691 +
    (mod1_phn_prob_m * 2.1324951403) +
    (mod1_gong_first_seen_lvl_m * 3.2163235397) +
    (mod1_crime_lvl_m * 3.1969044495) +
    (mod1_bk_lvl_m * 4.4553220259) +
    (mod1_ssns_per_adl_lvl_m * 2.0005826102) +
    (mod1_eviction_lvl_m * 1.1967860732) +
    (mod1_addr_prob_lvl_m * 3.3821239143) +
    ((integer)mod1_gong_name_hi_counts * 0.125511018) +
    ((integer)mod1_impulse_flag * 0.5760146725) +
    ((integer)mod1_prof_license * -0.142979504) +
    (mod1_in_dob_age_lg * -0.297712834) +
    (mod1_dist_a1toa2_rt * -0.006376247) +
    (mod1_best_match_lvl_m * 2.2571026492) +
    (mod1_ssns_per_addr_lvl_m * 2.0567364433) +
    ((integer)mod1_ADJ_loan * 0.1210962976) +
    ((integer)mod1_infutor_first_seen_6 * 0.14099727) +
    (mod1_prop_turnover_lvl_m * 3.5286398412) +
    (mod1_addr_stability_m * 2.7113478138) +
    (mod1_attr_num_nonderogs_6_m * 3.1394567216) +
    (mod1_derog_ratio_m * 0.2418848107) +
    (mod1_ver_nap_m * 2.2803532004) +
    (mod1_lien_sc_lvl_m * 3.1078472408) +
    (mod1_lien_cj_lvl_m * 2.7730534219) +
    (mod1_lien_lt_lvl_m * 1.2098615896);

base := 715;

point := -45;

odds := (1 / 21);

phat := (exp(KGB_MODEL_LOG) / (1 + exp(KGB_MODEL_LOG)));

KGB_MODEL := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));

RVA1007_1_0 := max(501, min(900, if(KGB_MODEL = NULL, -NULL, KGB_MODEL)));

var01 := mod1_gong_first_seen_lvl;

var02 := mod1_crime_lvl;

var03 := mod1_bk_lvl;

var04 := mod1_ssns_per_adl_lvl;

var05 := mod1_eviction_lvl;

var06 := mod1_addr_prob_lvl;

var07 := IF(mod1_gong_name_hi_counts, '1', '0');

var08 := IF(mod1_impulse_flag, '1', '0');

var09 := IF(mod1_prof_license, '1', '0');

var10 :=  map((integer)input_dob_age <= 0  => 0,
              (integer)input_dob_age <= 18 => 18,
              (integer)input_dob_age <= 25 => 25,
              (integer)input_dob_age <= 35 => 35,
              (integer)input_dob_age <= 45 => 45,
              (integer)input_dob_age <= 55 => 55,
              (integer)input_dob_age <= 65 => 65,
                                              100);

var11 :=  map(dist_a1toa2 = 0    => 100,
              dist_a1toa2 > 5000 => 0,
                                    min(if((if ((dist_a1toa2 / 500) >= 0, roundup((dist_a1toa2 / 500)), truncate((dist_a1toa2 / 500))) * 500) = NULL, -NULL, (if ((dist_a1toa2 / 500) >= 0, roundup((dist_a1toa2 / 500)), truncate((dist_a1toa2 / 500))) * 500)), 5000));

var12 := mod1_best_match_lvl;

var13 := mod1_ssns_per_addr_lvl;

var14 := IF(mod1_ADJ_loan, '1', '0');

var15 := IF(mod1_infutor_first_seen_6, '1', '0');

var16 := mod1_prop_turnover_lvl;

var17 := mod1_addr_stability;

var18 := mod1_attr_num_nonderogs_6;

var19 := mod1_derog_ratio;

var20 := mod1_ver_nap;

var21 := mod1_lien_sc_lvl;

var22 := mod1_lien_cj_lvl_2;

var23 := mod1_lien_lt_lvl;

temp_ivars := dataset( [
			{var01,                    		'AutoRVA10071_IV01', '-1', [] },
			{var02,                    		'AutoRVA10071_IV02', '-1', [] },
			{var03,                    		'AutoRVA10071_IV03', '-1', [] },
			{var04,                    		'AutoRVA10071_IV04', '-1', [] },
			{var05,                    		'AutoRVA10071_IV05', '-1', [] },
			{var06,                    		'AutoRVA10071_IV06', '-1', [] },
			{var07,                    		'AutoRVA10071_IV07', '-1', [] },
			{var08,                    		'AutoRVA10071_IV08', '-1', [] },
			{var09,                    		'AutoRVA10071_IV09', '-1', [] },
			{var10,                    		'AutoRVA10071_IV10', '-1', [] },
			{var11,                    		'AutoRVA10071_IV11', '-1', [] },
			{var12,                    		'AutoRVA10071_IV12', '-1', [] },
			{var13,                    		'AutoRVA10071_IV13', '-1', [] },
			{var14,                    		'AutoRVA10071_IV14', '-1', [] },
			{var15,                    		'AutoRVA10071_IV15', '-1', [] },
			{var16,                    		'AutoRVA10071_IV16', '-1', [] },
			{var17,                    		'AutoRVA10071_IV17', '-1', [] },
			{var18,                    		'AutoRVA10071_IV18', '-1', [] },
			{var19,                    		'AutoRVA10071_IV19', '-1', [] },
			{var20,                    		'AutoRVA10071_IV20', '-1', [] },
			{var21,                    		'AutoRVA10071_IV21', '-1', [] },
			{var22,                    		'AutoRVA10071_IV22', '-1', [] },
			{var23,                    		'AutoRVA10071_IV23', '-1', [] }
			], Models.Layout_Score
);

/* ***********************************************************
	*                      Reason Codes                        *
	************************************************************ */
riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
inCalif := isCalifornia and ((integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount+
								(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount+
								(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

boolean PreScreenOptOut := FALSE;
temp_ri := map(
	riTemp[1].hri <> '00' => riTemp,
	RiskWise.rv3autoReasonCodes(le, 4, inCalif, PreScreenOptOut)
);

temp_score := map
(
	riTemp[1].hri in ['91','92','93','94','95'] => (string3)((integer)riTemp[1].hri + 10),
	le.rhode_island_insufficient_verification or 
  riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid)
  => '222',
	temp_ri[1].hri='35' => '000',
	intformat(rva1007_1_0,3,1)
);


#if(RVA_DEBUG)
	self.seq												:= seq;
	self.in_dob                     := in_dob;
	self.nap_summary                := nap_summary;
	self.rc_hriskphoneflag          := rc_hriskphoneflag;
	self.rc_hphonetypeflag          := rc_hphonetypeflag;
	self.rc_phonevalflag            := rc_phonevalflag;
	self.rc_hphonevalflag           := rc_hphonevalflag;
	self.rc_addrvalflag             := rc_addrvalflag;
	self.rc_dwelltype               := rc_dwelltype;
	self.rc_addrcommflag            := rc_addrcommflag;
	self.rc_phonetype               := rc_phonetype;
	self.rc_ziptypeflag             := rc_ziptypeflag;
	self.rc_cityzipflag             := rc_cityzipflag;
	self.add1_isbestmatch           := add1_isbestmatch;
	self.add1_financing_type        := add1_financing_type;
	self.dist_a1toa2                := dist_a1toa2;
	self.add2_isbestmatch           := add2_isbestmatch;
	self.add3_isbestmatch           := add3_isbestmatch;
	self.addrs_prison_history       := addrs_prison_history;
	self.telcordia_type             := telcordia_type;
	self.gong_did_first_seen        := gong_did_first_seen;
	self.gong_did_first_ct          := gong_did_first_ct;
	self.gong_did_last_ct           := gong_did_last_ct;
	self.ssns_per_adl               := ssns_per_adl;
	self.ssns_per_adl_c6            := ssns_per_adl_c6;
	self.ssns_per_addr_c6           := ssns_per_addr_c6;
	self.infutor_first_seen         := infutor_first_seen;
	self.infutor_nap                := infutor_nap;
	self.impulse_count              := impulse_count;
	self.attr_num_purchase60        := attr_num_purchase60;
	self.attr_num_sold60            := attr_num_sold60;
	self.attr_total_number_derogs   := attr_total_number_derogs;
	self.attr_eviction_count        := attr_eviction_count;
	self.attr_eviction_count90      := attr_eviction_count90;
	self.attr_eviction_count12      := attr_eviction_count12;
	self.attr_eviction_count36      := attr_eviction_count36;
	self.attr_num_nonderogs         := attr_num_nonderogs;
	self.disposition                := disposition;
	self.bk_recent_count            := bk_recent_count;
	self.liens_unrel_cj_ct          := liens_unrel_cj_ct;
	self.liens_unrel_cj_last_seen   := liens_unrel_cj_last_seen;
	self.liens_unrel_lt_ct          := liens_unrel_lt_ct;
	self.liens_unrel_lt_last_seen   := liens_unrel_lt_last_seen;
	self.liens_rel_lt_ct            := liens_rel_lt_ct;
	self.liens_unrel_sc_ct          := liens_unrel_sc_ct;
	self.liens_rel_sc_ct            := liens_rel_sc_ct;
	self.criminal_count             := criminal_count;
	self.criminal_last_date         := criminal_last_date;
	self.felony_count               := felony_count;
	self.prof_license_flag          := prof_license_flag;
	self.input_dob_age              := input_dob_age;
	self.addr_stability             := addr_stability;
	self.sysdate                   	:= sysdate;
	self.phn_pots                   := phn_pots;
	self.phn_disconnected           := phn_disconnected;
	self.phn_inval                  := phn_inval;
	self.phn_nonUs                  := phn_nonUs;
	self.phn_highrisk               := phn_highrisk;
	self.phn_notpots                := phn_notpots;
	self.phn_cellpager              := phn_cellpager;
	self.phn_business               := phn_business;
	self.phn_residential            := phn_residential;
	self.mod1_phn_prob              := mod1_phn_prob;
	self.mod1_phn_prob_m            := mod1_phn_prob_m;
	self.gong_did_first_seen2       := gong_did_first_seen2;
	self.yrs_since_gong_first_seen  := yrs_since_gong_first_seen;
	self.mod1_gong_first_seen_lvl   := mod1_gong_first_seen_lvl;
	self.mod1_gong_first_seen_lvl_m := mod1_gong_first_seen_lvl_m;
	self._criminal_last_date        := _criminal_last_date;
	self.months_criminal_last_date  := months_criminal_last_date;
	self.mod1_crime_lvl             := mod1_crime_lvl;
	self.mod1_crime_lvl_m           := mod1_crime_lvl_m;
	self.mod1_bk_lvl                := mod1_bk_lvl;
	self.mod1_bk_lvl_m              := mod1_bk_lvl_m;
	self.mod1_ssns_per_adl_lvl      := mod1_ssns_per_adl_lvl;
	self.mod1_ssns_per_adl_lvl_m    := mod1_ssns_per_adl_lvl_m;
	self.mod1_eviction_lvl          := mod1_eviction_lvl;
	self.mod1_eviction_lvl_m        := mod1_eviction_lvl_m;
	self.invalid_addr               := invalid_addr;
	self.not_reg_zip                := not_reg_zip;
	self.zip_city_mismatch          := zip_city_mismatch;
	self.mod1_addr_prob_lvl         := mod1_addr_prob_lvl;
	self.mod1_addr_prob_lvl_m       := mod1_addr_prob_lvl_m;
	self.mod1_gong_name_hi_counts   := mod1_gong_name_hi_counts;
	self.mod1_impulse_flag          := mod1_impulse_flag;
	self.mod1_prof_license          := mod1_prof_license;
	self._in_dob                   	:= _in_dob;
	self.in_dob_age                 := in_dob_age;
	self.mod1_in_dob_age            := mod1_in_dob_age;
	self.mod1_in_dob_age_lg         := mod1_in_dob_age_lg;
	self.mod1_dist_a1toa2           := mod1_dist_a1toa2;
	self.mod1_dist_a1toa2_rt        := mod1_dist_a1toa2_rt;
	self.mod1_best_match_lvl        := mod1_best_match_lvl;
	self.mod1_best_match_lvl_m      := mod1_best_match_lvl_m;
	self.add_apt                   	:= add_apt;
	self.mod1_ssns_per_addr_lvl     := mod1_ssns_per_addr_lvl;
	self.mod1_ssns_per_addr_lvl_m   := mod1_ssns_per_addr_lvl_m;
	self.mod1_ADJ_loan              := mod1_ADJ_loan;
	self._infutor_first_seen        := _infutor_first_seen;
	self.months_infutor_first_seen  := months_infutor_first_seen;
	self.mod1_infutor_first_seen_6  := mod1_infutor_first_seen_6;
	self.mod1_prop_turnover_lvl     := mod1_prop_turnover_lvl;
	self.mod1_prop_turnover_lvl_m   := mod1_prop_turnover_lvl_m;
	self.mod1_addr_stability        := mod1_addr_stability;
	self.mod1_addr_stability_m      := mod1_addr_stability_m;
	self.mod1_attr_num_nonderogs_6  := mod1_attr_num_nonderogs_6;
	self.mod1_attr_num_nonderogs_6_m:= mod1_attr_num_nonderogs_6_m;
	self.mod1_derog_ratio           := mod1_derog_ratio;
	self.mod1_derog_ratio_m         := mod1_derog_ratio_m;
	self.contrary_phn               := contrary_phn;
	self.verfst_p                   := verfst_p;
	self.verlst_p                   := verlst_p;
	self.veradd_p                   := veradd_p;
	self.verphn_p                   := verphn_p;
	self.ver_nap6                   := ver_nap6;
	self.ver_phncount               := ver_phncount;
	self.infutor_lvl                := infutor_lvl;
	self.nap_lvl                   	:= nap_lvl;
	self.mod1_ver_nap               := mod1_ver_nap;
	self.mod1_ver_nap_m             := mod1_ver_nap_m;
	self.mod1_lien_sc_lvl           := mod1_lien_sc_lvl;
	self.mod1_lien_sc_lvl_m         := mod1_lien_sc_lvl_m;
	self.CJ_last_seen               := CJ_last_seen;
	self.mos_since_CJ_seen          := mos_since_CJ_seen;
	self.mod1_lien_cj_lvl           := mod1_lien_cj_lvl;
	self.mod1_lien_cj_lvl_m         := mod1_lien_cj_lvl_m;
	self.LT_last_seen               := LT_last_seen;
	self.mos_since_LT_seen          := mos_since_LT_seen;
	self.mod1_lien_cj_lvl_2         := mod1_lien_cj_lvl_2;
	self.mod1_lien_lt_lvl           := mod1_lien_lt_lvl;
	self.mod1_lien_lt_lvl_m         := mod1_lien_lt_lvl_m;
	self.KGB_MODEL_LOG              := KGB_MODEL_LOG;
	self.base                   		:= base;
	self.point                   		:= point;
	self.odds                   		:= odds;
	self.phat                   		:= phat;
	self.KGB_MODEL                	:= KGB_MODEL;
	self.RVA1007_1_0              	:= RVA1007_1_0;
	self.var01                   		:= var01;
	self.var02                   		:= var02;
	self.var03                   		:= var03;
	self.var04                   		:= var04;
	self.var05                   		:= var05;
	self.var06                   		:= var06;
	self.var07                   		:= var07;
	self.var08                   		:= var08;
	self.var09                   		:= var09;
	self.var10                   		:= var10;
	self.var11                   		:= var11;
	self.var12                   		:= var12;
	self.var13                   		:= var13;
	self.var14                   		:= var14;
	self.var15                   		:= var15;
	self.var16                   		:= var16;
	self.var17                   		:= var17;
	self.var18                   		:= var18;
	self.var19                   		:= var19;
	self.var20                   		:= var20;
	self.var21                   		:= var21;
	self.var22                   		:= var22;
	self.var23                   		:= var23;
	self.score 											:= temp_score;
	self 														:= le;
	self 														:= [];
#else
	self.seq 												:= seq;
	self.score 											:= temp_score;
	self.ri 												:= temp_ri;
	self.ivars 											:= temp_ivars;
	self 														:= le;
	self 														:= [];
#end

END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN model;

END;