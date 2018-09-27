IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT rvc1110_1_0 (DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia, BOOLEAN xmlPreScreenOptOut) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;

			/* Model Input Variables */
			BOOLEAN truedid;
			STRING adl_category;
			STRING in_dob;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING nap_status;
			INTEGER cvi;
			BOOLEAN rc_input_addr_not_most_recent;
			STRING rc_decsflag;
			STRING rc_addrvalflag;
			STRING rc_bansflag;
			STRING rc_statezipflag;
			STRING rc_cityzipflag;
			INTEGER combo_dobscore;
			STRING ver_sources;
			STRING ver_sources_nas;
			STRING ver_sources_first_seen;
			STRING ver_sources_last_seen;
			BOOLEAN lnamepop;
			BOOLEAN addrpop;
			STRING ssnlength;
			BOOLEAN hphnpop;
			INTEGER age;
			BOOLEAN add1_house_number_match;
			STRING add1_advo_address_vacancy;
			STRING add1_advo_drop;
			STRING add1_avm_sales_price;
			STRING add1_avm_assessed_total_value;
			STRING add1_avm_market_total_value;
			INTEGER add1_avm_tax_assessed_valuation;
			INTEGER add1_avm_price_index_valuation;
			INTEGER add1_avm_hedonic_valuation;
			INTEGER add1_avm_automated_valuation;
			INTEGER add1_avm_med_fips;
			INTEGER add1_naprop;
			INTEGER add1_date_first_seen;
			INTEGER property_owned_total;
			INTEGER property_owned_assessed_total;
			INTEGER property_sold_total;
			INTEGER property_ambig_total;
			INTEGER add2_naprop;
			INTEGER add2_date_first_seen;
			INTEGER add3_naprop;
			INTEGER add3_date_first_seen;
			INTEGER max_lres;
			INTEGER unique_addr_count;
			INTEGER avg_mo_per_addr;
			STRING gong_did_last_seen;
			INTEGER addrs_per_adl;
			INTEGER addrs_per_ssn;
			INTEGER adls_per_addr_c6;
			INTEGER ssns_per_addr_c6;
			INTEGER invalid_ssns_per_adl;
			INTEGER invalid_ssns_per_adl_c6;
			INTEGER infutor_nap;
			INTEGER attr_num_aircraft;
			INTEGER attr_total_number_derogs;
			BOOLEAN bankrupt;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_unrel_cj_ct;
			INTEGER liens_rel_cj_ct;
			INTEGER criminal_count;
			INTEGER watercraft_count;
			STRING prof_license_category;
			STRING wealth_index;
			STRING input_dob_age;
			STRING input_dob_match_level;
			INTEGER inferred_age;
			INTEGER estimated_income_2;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			INTEGER ver_src_ar_pos;
			BOOLEAN ver_src_ar;
			INTEGER ver_src_ba_pos;
			STRING ver_src_fdate_ba;
			INTEGER ver_src_fdate_ba2;
			REAL mth_ver_src_fdate_ba;
			STRING ver_src_ldate_ba;
			INTEGER ver_src_ldate_ba2;
			REAL mth_ver_src_ldate_ba;
			INTEGER ver_src_ds_pos;
			BOOLEAN ver_src_ds;
			INTEGER ver_src_de_pos;
			BOOLEAN ver_src_de;
			STRING ver_src_ldate_de;
			INTEGER ver_src_ldate_de2;
			REAL mth_ver_src_ldate_de;
			INTEGER ver_src_l2_pos;
			STRING ver_src_fdate_l2;
			INTEGER ver_src_fdate_l22;
			REAL mth_ver_src_fdate_l2;
			STRING ver_src_ldate_l2;
			INTEGER ver_src_ldate_l22;
			REAL mth_ver_src_ldate_l2;
			INTEGER ver_src_p_pos;
			BOOLEAN ver_src_p;
			REAL ver_src_nas_p;
			STRING ver_src_ldate_p;
			INTEGER ver_src_ldate_p2;
			REAL mth_ver_src_ldate_p;
			INTEGER ver_src_w_pos;
			BOOLEAN ver_src_w;
			INTEGER gong_did_last_seen2;
			REAL mth_gong_did_last_seen;
			INTEGER max_value;
			INTEGER lb_age;
			INTEGER derog_src_hit;
			BOOLEAN i_nap_connected;
			INTEGER i_ldate_deathmaster;
			BOOLEAN i_ever_invalid_ssn;
			REAL i_subscore0;
			REAL i_subscore1;
			REAL i_subscore2;
			REAL i_subscore3;
			REAL i_subscore4;
			REAL i_subscore5;
			REAL i_subscore6;
			REAL i_subscore7;
			REAL i_subscore8;
			REAL i_subscore9;
			REAL i_subscore10;
			INTEGER d_input_addr_probs;
			INTEGER prop_owner_1;
			INTEGER add_naprop_level;
			BOOLEAN ba_last10yrs;
			INTEGER d_nap_lvl;
			BOOLEAN cj_lien_flag;
			BOOLEAN boat_plane_flag;
			REAL nd_subscore0;
			REAL nd_subscore1;
			REAL nd_subscore2;
			REAL nd_subscore3;
			REAL nd_subscore4;
			REAL nd_subscore5;
			REAL nd_subscore6;
			REAL nd_subscore7;
			REAL nd_subscore8;
			REAL nd_subscore9;
			INTEGER np_nap_lvl;
			INTEGER np_cvi;
			INTEGER np_infutor;
			INTEGER np_boat_plane;
			BOOLEAN np_hi_end_pl;
			INTEGER np_input_addr_probs;
			INTEGER np_derog_src_hit;
			REAL np_subscore0;
			REAL np_subscore1;
			REAL np_subscore2;
			REAL np_subscore3;
			REAL np_subscore4;
			REAL np_subscore5;
			REAL np_subscore6;
			REAL np_subscore7;
			REAL np_subscore8;
			REAL np_subscore9;
			REAL np_subscore10;
			REAL np_subscore11;
			REAL np_subscore12;
			REAL np_subscore13;
			REAL np_subscore14;
			REAL np_subscore15;
			INTEGER p_cvi;
			INTEGER p_derog_src_hit;
			INTEGER p_nap_lvl;
			INTEGER p_infutor_lvl;
			INTEGER avm_index_fips;
			INTEGER add1_date_first_seen2;
			REAL mth_add1_date_first_seen;
			INTEGER add2_date_first_seen2;
			REAL mth_add2_date_first_seen;
			INTEGER add3_date_first_seen2;
			REAL mth_add3_date_first_seen;
			REAL add_lres_mth_avg;
			BOOLEAN p_prop_name_addr_match;
			INTEGER p_input_addr_probs;
			INTEGER p_new_person_c6_3;
			REAL p_subscore0;
			REAL p_subscore1;
			REAL p_subscore2;
			REAL p_subscore3;
			REAL p_subscore4;
			REAL p_subscore5;
			REAL p_subscore6;
			REAL p_subscore7;
			REAL p_subscore8;
			REAL p_subscore9;
			REAL p_subscore10;
			REAL p_subscore11;
			REAL p_subscore12;
			REAL p_subscore13;
			REAL p_subscore14;
			REAL p_subscore15;
			REAL p_subscore16;
			REAL p_subscore17;
			REAL p_subscore18;
			REAL p_subscore19;
			BOOLEAN ln_dead;
			BOOLEAN prop_owner;
			INTEGER _segment;
			REAL i_scaledscore;
			REAL nd_scaledscore;
			REAL p_scaledscore;
			REAL np_scaledscore;
			REAL _in;
			INTEGER rvc1110_1_1;
			BOOLEAN lien_flag;
			BOOLEAN bk_flag;
			BOOLEAN scored_222s;
			INTEGER rvc1110_1;
			BOOLEAN ver_name;
			BOOLEAN ver_ssn;
			BOOLEAN ver_addr;
			BOOLEAN glrc07;
			BOOLEAN glrc25;
			BOOLEAN glrc36;
			BOOLEAN glrc78;
			BOOLEAN glrc80;
			BOOLEAN glrc97;
			BOOLEAN glrc98;
			BOOLEAN glrc99;
			BOOLEAN glrc9a;
			BOOLEAN glrc9b;
			BOOLEAN glrc9c;
			BOOLEAN glrc9d;
			BOOLEAN glrc9e;
			BOOLEAN glrc9f;
			BOOLEAN glrc9g;
			BOOLEAN glrc9m;
			BOOLEAN glrc9u;
			BOOLEAN glrc9w;
			INTEGER glrcpv;
			INTEGER glrcbl;
			STRING rc1_2;
			STRING rc2_1;
			STRING rc3_1;
			STRING rc4_1;
			STRING rc5_1;
			BOOLEAN rcseginputs;
			BOOLEAN rcsegnondead;
			BOOLEAN rcsegprop;
			BOOLEAN rcsegnon;
			REAL rcvalue07_1;
			REAL rcvalue07;
			REAL rcvalue25_1;
			REAL rcvalue25_2;
			REAL rcvalue25;
			REAL rcvalue36_1;
			REAL rcvalue36_2;
			REAL rcvalue36_3;
			REAL rcvalue36_4;
			REAL rcvalue36_5;
			REAL rcvalue36_6;
			REAL rcvalue36_7;
			REAL rcvalue36;
			INTEGER rcvalue78_1;
			INTEGER rcvalue78;
			INTEGER rcvalue80_1;
			INTEGER rcvalue80;
			REAL rcvalue97_1;
			REAL rcvalue97_2;
			REAL rcvalue97_3;
			REAL rcvalue97_4;
			REAL rcvalue97;
			REAL rcvalue98_1;
			REAL rcvalue98_2;
			REAL rcvalue98_3;
			REAL rcvalue98_4;
			REAL rcvalue98_5;
			REAL rcvalue98_6;
			REAL rcvalue98_7;
			REAL rcvalue98_8;
			REAL rcvalue98_9;
			REAL rcvalue98;
			REAL rcvalue99_1;
			REAL rcvalue99_2;
			REAL rcvalue99_3;
			REAL rcvalue99;
			REAL rcvalue9a_1;
			REAL rcvalue9a_2;
			REAL rcvalue9a_3;
			INTEGER rcvalue9a_4;
			REAL rcvalue9a;
			REAL rcvalue9b_1;
			REAL rcvalue9b;
			REAL rcvalue9c_1;
			REAL rcvalue9c_2;
			REAL rcvalue9c_3;
			REAL rcvalue9c_4;
			REAL rcvalue9c;
			REAL rcvalue9d_1;
			REAL rcvalue9d_2;
			REAL rcvalue9d_3;
			REAL rcvalue9d_4;
			REAL rcvalue9d;
			REAL rcvalue9e_1;
			INTEGER rcvalue9e_2;
			REAL rcvalue9e;
			REAL rcvalue9f_1;
			REAL rcvalue9f_2;
			REAL rcvalue9f_3;
			REAL rcvalue9f_4;
			REAL rcvalue9f_5;
			REAL rcvalue9f_6;
			REAL rcvalue9f_7;
			REAL rcvalue9f;
			REAL rcvalue9g_1;
			REAL rcvalue9g_2;
			REAL rcvalue9g;
			REAL rcvalue9m_1;
			REAL rcvalue9m_2;
			REAL rcvalue9m_3;
			REAL rcvalue9m_4;
			REAL rcvalue9m_5;
			REAL rcvalue9m_6;
			REAL rcvalue9m;
			REAL rcvalue9u_1;
			REAL rcvalue9u_2;
			REAL rcvalue9u;
			REAL rcvalue9w_1;
			REAL rcvalue9w_2;
			REAL rcvalue9w_3;
			REAL rcvalue9w_4;
			REAL rcvalue9w_5;
			REAL rcvalue9w_6;
			REAL rcvalue9w_7;
			REAL rcvalue9w_8;
			REAL rcvalue9w;
			REAL rcvaluepv_1;
			REAL rcvaluepv_2;
			REAL rcvaluepv_3;
			REAL rcvaluepv_4;
			REAL rcvaluepv;
			REAL rcvaluebl_1;
			REAL rcvaluebl_2;
			REAL rcvaluebl_3;
			REAL rcvaluebl_4;
			REAL rcvaluebl;

			STRING4 rc1;
			STRING4 rc2;
			STRING4 rc3;
			STRING4 rc4;
			STRING4 rc5;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	truedid                          := le.truedid;
	adl_category                     := le.adlcategory;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	cvi                              := le.iid.cvi;
	rc_input_addr_not_most_recent    := le.iid.inputaddrnotmostrecent;
	rc_decsflag                      := le.iid.decsflag;
	rc_addrvalflag                   := le.iid.addrvalflag;
	rc_bansflag                      := le.iid.bansflag;
	rc_statezipflag                  := le.iid.statezipflag;
	rc_cityzipflag                   := le.iid.cityzipflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_nas                  := le.header_summary.ver_sources_nas;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	lnamepop                         := le.input_validation.lastname;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
	add1_advo_address_vacancy        := le.advo_input_addr.address_vacancy_indicator;
	add1_advo_drop                   := le.advo_input_addr.drop_indicator;
	add1_avm_sales_price             := le.avm.input_address_information.avm_sales_price;
	add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
	add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
	add1_avm_tax_assessed_valuation  := le.avm.input_address_information.avm_tax_assessment_valuation;
	add1_avm_price_index_valuation   := le.avm.input_address_information.avm_price_index_valuation;
	add1_avm_hedonic_valuation       := le.avm.input_address_information.avm_hedonic_valuation;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	add1_date_first_seen             := le.address_verification.input_address_information.date_first_seen;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_sold_total              := le.address_verification.sold.property_total;
	property_ambig_total             := le.address_verification.ambiguous.property_total;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	add2_date_first_seen             := le.address_verification.address_history_1.date_first_seen;
	add3_naprop                      := le.address_verification.address_history_2.naprop;
	add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
	max_lres                         := le.other_address_info.max_lres;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
	ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
	invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
	invalid_ssns_per_adl_c6          := le.velocity_counters.invalid_ssns_per_adl_created_6months;
	infutor_nap                      := le.infutor_phone.infutor_nap;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_total_number_derogs         := le.total_number_derogs;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
	criminal_count                   := le.bjl.criminal_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	prof_license_category            := le.professional_license.plcategory;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	estimated_income_2                 := le.estimated_income;
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	BOOLEAN indexw(string source, string target, string delim) :=
		(source = target) OR
		(StringLib.StringFind(source, delim + target + delim, 1) > 0) OR
		(source[1..length(target)+1] = target + delim) OR
		(StringLib.StringReverse(source)[1..length(target)+1] = StringLib.StringReverse(target) + delim);
	
	INTEGER year(integer sas_date) :=
		if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));
	
	
	sysdate := map(
	    trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
	    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
	                                                           NULL);
	
	ver_src_ar_pos := Models.Common.findw_cpp(ver_sources, 'AR' , '  ,', 'ie');
	
	ver_src_ar := ver_src_ar_pos > 0;
	
	ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');
	
	ver_src_fdate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_ba_pos), '0');
	
	ver_src_fdate_ba2 := Common.SAS_Date((STRING)(ver_src_fdate_ba));
	
	mth_ver_src_fdate_ba_tmp := ROUNDUP((sysdate - ver_src_fdate_ba2) / 30.5);
	
	mth_ver_src_fdate_ba := if(min(sysdate, ver_src_fdate_ba2) = NULL, NULL, IF(mth_ver_src_fdate_ba_tmp < 0, 0, mth_ver_src_fdate_ba_tmp));
	
	ver_src_ldate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ba_pos), '0');
	
	ver_src_ldate_ba2 := Common.SAS_Date((STRING)(ver_src_ldate_ba));
	
	mth_ver_src_ldate_ba_tmp := ROUNDUP((sysdate - ver_src_ldate_ba2) / 30.5);
	
	mth_ver_src_ldate_ba := if(min(sysdate, ver_src_ldate_ba2) = NULL, NULL, IF(mth_ver_src_ldate_ba_tmp < 0, 0, mth_ver_src_ldate_ba_tmp));
	
	ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');
	
	ver_src_ds := ver_src_ds_pos > 0;
	
	ver_src_de_pos := Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie');
	
	ver_src_de := ver_src_de_pos > 0;
	
	ver_src_ldate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_de_pos), '0');
	
	ver_src_ldate_de2 := Common.SAS_Date((STRING)(ver_src_ldate_de));
	
	mth_ver_src_ldate_de_tmp := ROUNDUP((sysdate - ver_src_ldate_de2) / 30.5);
	
	mth_ver_src_ldate_de := if(min(sysdate, ver_src_ldate_de2) = NULL, NULL, IF(mth_ver_src_ldate_de_tmp < 0, 0, mth_ver_src_ldate_de_tmp));
	
	ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');
	
	ver_src_fdate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_l2_pos), '0');
	
	ver_src_fdate_l22 := Common.SAS_Date((STRING)(ver_src_fdate_l2));
	
	mth_ver_src_fdate_l2_tmp := ROUNDUP((sysdate - ver_src_fdate_l22) / 30.5);
	
	mth_ver_src_fdate_l2 := if(min(sysdate, ver_src_fdate_l22) = NULL, NULL, IF(mth_ver_src_fdate_l2_tmp < 0, 0, mth_ver_src_fdate_l2_tmp));
	
	ver_src_ldate_l2 := if(ver_src_l2_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_l2_pos), '0');
	
	ver_src_ldate_l22 := Common.SAS_Date((STRING)(ver_src_ldate_l2));
	
	mth_ver_src_ldate_l2_tmp := ROUNDUP((sysdate - ver_src_ldate_l22) / 30.5);
	
	mth_ver_src_ldate_l2 := if(min(sysdate, ver_src_ldate_l22) = NULL, NULL, IF(mth_ver_src_ldate_l2_tmp < 0, 0, mth_ver_src_ldate_l2_tmp));
	
	ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');
	
	ver_src_p := ver_src_p_pos > 0;
	
	ver_src_nas_p := if(ver_src_p_pos > 0, (real)Models.Common.getw(ver_sources_NAS, ver_src_p_pos), 0);
	
	ver_src_ldate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_p_pos), '0');
	
	ver_src_ldate_p2 := Common.SAS_Date((STRING)(ver_src_ldate_p));
	
	mth_ver_src_ldate_p_tmp := ROUNDUP((sysdate - ver_src_ldate_p2) / 30.5);
	
	mth_ver_src_ldate_p := if(min(sysdate, ver_src_ldate_p2) = NULL, NULL, IF(mth_ver_src_ldate_p_tmp < 0, 0, mth_ver_src_ldate_p_tmp));
	
	ver_src_w_pos := Models.Common.findw_cpp(ver_sources, 'W' , '  ,', 'ie');
	
	ver_src_w := ver_src_w_pos > 0;
	
	gong_did_last_seen2 := Common.SAS_Date((STRING)(gong_did_last_seen));
	
	mth_gong_did_last_seen_tmp := ROUNDUP((sysdate - gong_did_last_seen2) / 30.5);
	
	mth_gong_did_last_seen := if(min(sysdate, gong_did_last_seen2) = NULL, NULL, IF(mth_gong_did_last_seen_tmp < 0, 0, mth_gong_did_last_seen_tmp));
	
	max_value := max((integer)add1_avm_sales_price, (integer)add1_avm_assessed_total_value, (integer)add1_avm_market_total_value, add1_avm_tax_assessed_valuation, add1_avm_price_index_valuation, add1_avm_hedonic_valuation, add1_avm_automated_valuation);
	
	lb_age := map(
	    (INTEGER)age > 0                                                                                                           => (INTEGER)age,
	    (INTEGER)input_dob_age > 0 AND trim((STRING)in_dob, LEFT, RIGHT) != '19000101 ' AND (INTEGER)Models.Common.contains(trim((STRING)in_dob), '-') = 0 => (INTEGER)input_dob_age,
	    (INTEGER)inferred_age > 0                                                                                                  => (INTEGER)inferred_age,
	                                                                                                                         -1);
	
	derog_src_hit := map(
	    mth_ver_src_ldate_ba != NULL AND mth_ver_src_ldate_ba <= 120 AND mth_ver_src_ldate_l2 != NULL AND mth_ver_src_ldate_l2 <= 84 => 2,
	    mth_ver_src_ldate_ba != NULL AND mth_ver_src_ldate_ba <= 120 OR mth_ver_src_ldate_l2 != NULL AND mth_ver_src_ldate_l2 <= 84  => 1,
	                                                                                                                                    0);
	
	i_nap_connected := nap_status = 'C';
	
	i_ldate_deathmaster := map(
	    mth_ver_src_ldate_de <= 6  => 6,
	    mth_ver_src_ldate_de <= 12 => 12,
	                                  99);
	
	i_ever_invalid_ssn := invalid_ssns_per_adl > 0 OR invalid_ssns_per_adl_c6 > 0;
	
	i_subscore0 := map(
	    NULL < estimated_income_2 AND estimated_income_2 < 1       => 56.485117,
	    1 <= estimated_income_2 AND estimated_income_2 < 20000     => 30.537163,
	    20000 <= estimated_income_2 AND estimated_income_2 < 23000 => 44.717882,
	    23000 <= estimated_income_2 AND estimated_income_2 < 25000 => 60.698527,
	    25000 <= estimated_income_2 AND estimated_income_2 < 27000 => 72.401734,
	    27000 <= estimated_income_2 AND estimated_income_2 < 29000 => 74.962535,
	    29000 <= estimated_income_2 AND estimated_income_2 < 32000 => 75.122691,
	    32000 <= estimated_income_2                              => 89.932265,
	                                                              56.485117);
	
	i_subscore1 := map(
	    (derog_src_hit in [0]) => 67.322451,
	    (derog_src_hit in [1]) => 23.201276,
	    (derog_src_hit in [2]) => 5.443543,
	                              56.485117);
	
	i_subscore2 := map(
	    NULL < addrs_per_ssn AND addrs_per_ssn < 1 => 56.485117,
	    1 <= addrs_per_ssn AND addrs_per_ssn < 2   => 84.406866,
	    2 <= addrs_per_ssn AND addrs_per_ssn < 3   => 73.083067,
	    3 <= addrs_per_ssn AND addrs_per_ssn < 4   => 63.965818,
	    4 <= addrs_per_ssn AND addrs_per_ssn < 5   => 63.950595,
	    5 <= addrs_per_ssn AND addrs_per_ssn < 6   => 63.686245,
	    6 <= addrs_per_ssn AND addrs_per_ssn < 7   => 58.128598,
	    7 <= addrs_per_ssn AND addrs_per_ssn < 8   => 57.992269,
	    8 <= addrs_per_ssn AND addrs_per_ssn < 9   => 47.340235,
	    9 <= addrs_per_ssn AND addrs_per_ssn < 12  => 37.819322,
	    12 <= addrs_per_ssn                        => 26.913658,
	                                                  56.485117);
	
	i_subscore3 := map(
	    NULL < mth_ver_src_ldate_p AND mth_ver_src_ldate_p < 0 => 41.715591,
	    0 <= mth_ver_src_ldate_p AND mth_ver_src_ldate_p < 9   => 84.336434,
	    9 <= mth_ver_src_ldate_p AND mth_ver_src_ldate_p < 20  => 74.165609,
	    20 <= mth_ver_src_ldate_p                              => 61.637868,
	                                                              56.485117);
	
	i_subscore4 := map(
	    (i_nap_connected in [0]) => 45.389016,
	    (i_nap_connected in [1]) => 71.510093,
	                                56.485117);
	
	i_subscore5 := map(
	    NULL < mth_gong_did_last_seen AND mth_gong_did_last_seen < 0 => 56.485117,
	    0 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 3   => 69.699844,
	    3 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 7   => 46.826537,
	    7 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 32  => 39.159539,
	    32 <= mth_gong_did_last_seen                                 => 37.955261,
	                                                                    56.485117);
	
	i_subscore6 := map(
	    (i_ldate_deathmaster in [6])  => 62.000319,
	    (i_ldate_deathmaster in [12]) => 46.160101,
	    (i_ldate_deathmaster in [99]) => 16.653247,
	                                     56.485117);
	
	i_subscore7 := map(
	    NULL < max_lres AND max_lres < 1   => 56.485117,
	    1 <= max_lres AND max_lres < 103   => 40.802663,
	    103 <= max_lres AND max_lres < 151 => 51.134473,
	    151 <= max_lres AND max_lres < 239 => 53.888436,
	    239 <= max_lres AND max_lres < 282 => 62.365011,
	    282 <= max_lres AND max_lres < 328 => 69.203010,
	    328 <= max_lres                    => 69.229140,
	                                          56.485117);
	
	i_subscore8 := map(
	    NULL < property_owned_total AND property_owned_total < 1 => 52.261660,
	    1 <= property_owned_total AND property_owned_total < 2   => 60.059214,
	    2 <= property_owned_total                                => 68.723803,
	                                                                56.485117);
	
	i_subscore9 := map(
	    NULL < attr_total_number_derogs AND attr_total_number_derogs < 1 => 54.038150,
	    1 <= attr_total_number_derogs                                    => 65.684503,
	                                                                        56.485117);
	
	i_subscore10 := map(
	    (i_ever_invalid_ssn in [0]) => 56.819014,
	    (i_ever_invalid_ssn in [1]) => 18.853129,
	                                   56.485117);
	
	d_input_addr_probs := map(
	    rc_addrvalflag != 'V' OR (INTEGER)rc_cityzipflag > 0 OR (INTEGER)rc_statezipflag > 0 => 4,
	    (INTEGER)add1_house_number_match = 0 AND (INTEGER)rc_input_addr_not_most_recent > 0  => 3,
	    (INTEGER)rc_input_addr_not_most_recent > 0                                  => 2,
	                                                                          0);
	
	prop_owner_1 := map(
	    add1_naprop = 4 or add2_naprop = 4 or add3_naprop = 4                           => 2,
	    property_owned_total > 0 or property_sold_total > 0 or property_ambig_total > 0 => 1,
	                                                                                       0);
	
	add_naprop_level := map(
	    add1_naprop = 4                      => 2,
	    add1_naprop = 3 or prop_owner_1 >= 1 => 1,
	                                            0);
	
	ba_last10yrs := mth_ver_src_fdate_ba != NULL AND mth_ver_src_fdate_ba <= 120;
	
	d_nap_lvl := map(
	    nap_summary = 12        => 0,
	    nap_summary = 11        => 1,
	    nap_summary = 8         => 2,
	    (nap_summary in [9, 7]) => 3,
	    (nap_summary in [5, 3]) => 4,
	    nap_summary = 0         => 5,
	                               6);
	
	cj_lien_flag := liens_unrel_cj_ct > 0 OR liens_rel_cj_ct > 0;
	
	boat_plane_flag := (INTEGER)watercraft_count > 0 OR (INTEGER)attr_num_aircraft > 0 OR (INTEGER)ver_src_ar > 0 OR (INTEGER)ver_src_w > 0;
	
	nd_subscore0 := map(
	    (d_input_addr_probs in [0]) => 78.800401,
	    (d_input_addr_probs in [2]) => 78.651849,
	    (d_input_addr_probs in [3]) => 48.611036,
	    (d_input_addr_probs in [4]) => -12.806435,
	                                   71.309402);
	
	nd_subscore1 := map(
	    (wealth_index in ['0'])      => 71.309402,
	    (wealth_index in ['1'])      => 27.342655,
	    (wealth_index in ['2'])      => 54.681041,
	    (wealth_index in ['3'])      => 69.311673,
	    (wealth_index in ['4'])      => 69.496649,
	    (wealth_index in ['5', '6']) => 94.559706,
	                                    71.309402);
	
	nd_subscore2 := map(
	    (add_naprop_level in [0]) => 54.972865,
	    (add_naprop_level in [1]) => 74.804817,
	    (add_naprop_level in [2]) => 82.627658,
	                                 71.309402);
	
	nd_subscore3 := map(
	    (ba_last10yrs in [0]) => 73.713137,
	    (ba_last10yrs in [1]) => 21.879448,
	                             71.309402);
	
	nd_subscore4 := map(
	    (d_nap_lvl in [0]) => 81.658280,
	    (d_nap_lvl in [1]) => 81.587657,
	    (d_nap_lvl in [2]) => 74.647734,
	    (d_nap_lvl in [3]) => 70.577306,
	    (d_nap_lvl in [4]) => 66.877543,
	    (d_nap_lvl in [5]) => 66.774536,
	    (d_nap_lvl in [6]) => 45.787989,
	                          71.309402);
	
	nd_subscore5 := map(
	    NULL < addrs_per_adl AND addrs_per_adl < 1 => 71.309402,
	    1 <= addrs_per_adl AND addrs_per_adl < 3   => 86.189694,
	    3 <= addrs_per_adl AND addrs_per_adl < 4   => 70.726105,
	    4 <= addrs_per_adl AND addrs_per_adl < 9   => 70.709128,
	    9 <= addrs_per_adl AND addrs_per_adl < 10  => 70.666800,
	    10 <= addrs_per_adl AND addrs_per_adl < 12 => 67.824310,
	    12 <= addrs_per_adl AND addrs_per_adl < 15 => 63.390414,
	    15 <= addrs_per_adl                        => 54.079032,
	                                                  71.309402);
	
	nd_subscore6 := map(
	    NULL < mth_gong_did_last_seen AND mth_gong_did_last_seen < 0 => 71.309402,
	    0 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 2   => 78.412884,
	    2 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 20  => 68.918666,
	    20 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 48 => 55.316642,
	    48 <= mth_gong_did_last_seen                                 => 55.162846,
	                                                                    71.309402);
	
	nd_subscore7 := map(
	    (cj_lien_flag in [0]) => 73.409594,
	    (cj_lien_flag in [1]) => 45.699332,
	                             71.309402);
	
	nd_subscore8 := map(
	    NULL < attr_total_number_derogs AND attr_total_number_derogs < 1 => 74.087924,
	    1 <= attr_total_number_derogs                                    => 56.700968,
	                                                                        71.309402);
	
	nd_subscore9 := map(
	    (boat_plane_flag in [0]) => 70.938981,
	    (boat_plane_flag in [1]) => 78.892711,
	                                71.309402);
	
	np_nap_lvl := map(
	    (nap_summary in [9, 11, 12]) => 0,
	    nap_summary = 7              => 1,
	    (nap_summary in [3, 5, 8])   => 2,
	                                    3);
	
	np_cvi := map(
	    cvi < 30 => 0,
	    cvi < 50 => 30,
	                cvi);
	
	np_infutor := if(infutor_nap > 1, 2, infutor_nap);
	
	np_boat_plane := map(
	    attr_num_aircraft > 0 OR watercraft_count > 0 => 2,
	    (INTEGER)ver_src_ar > 0 OR (INTEGER)ver_src_w > 0               => 1,
	                                                     0);
	
	np_hi_end_pl := (prof_license_category in ['4', '5']);
	
	np_input_addr_probs := map(
	    (INTEGER)add1_house_number_match = 0 AND (INTEGER)rc_input_addr_not_most_recent > 0 => 0,
	    (INTEGER)rc_input_addr_not_most_recent > 0                                 => 1,
	    (INTEGER)add1_house_number_match = 0                                       => 2,
	                                                                         3);
	
	np_derog_src_hit := map(
	    mth_ver_src_ldate_ba != NULL AND mth_ver_src_ldate_ba <= 120 => 2,
	    mth_ver_src_ldate_l2 != NULL AND mth_ver_src_ldate_l2 <= 84  => 1,
	                                                                    0);
	
	np_subscore0 := map(
	    (np_derog_src_hit in [0]) => 50.633625,
	    (np_derog_src_hit in [1]) => 12.717807,
	    (np_derog_src_hit in [2]) => 2.977481,
	                                 42.974302);
	
	np_subscore1 := map(
	    (ver_src_p in [0]) => 32.983569,
	    (ver_src_p in [1]) => 63.383709,
	                          42.974302);
	
	np_subscore2 := map(
	    NULL < addrs_per_ssn AND addrs_per_ssn < 1 => 42.974302,
	    1 <= addrs_per_ssn AND addrs_per_ssn < 2   => 62.447589,
	    2 <= addrs_per_ssn AND addrs_per_ssn < 4   => 51.197587,
	    4 <= addrs_per_ssn AND addrs_per_ssn < 6   => 45.058001,
	    6 <= addrs_per_ssn AND addrs_per_ssn < 10  => 35.896992,
	    10 <= addrs_per_ssn AND addrs_per_ssn < 12 => 34.873005,
	    12 <= addrs_per_ssn AND addrs_per_ssn < 14 => 27.871368,
	    14 <= addrs_per_ssn                        => 3.735887,
	                                                  42.974302);
	
	np_subscore3 := map(
	    (np_nap_lvl in [0]) => 52.106950,
	    (np_nap_lvl in [1]) => 51.943068,
	    (np_nap_lvl in [2]) => 41.015960,
	    (np_nap_lvl in [3]) => 31.822448,
	                           42.974302);
	
	np_subscore4 := map(
	    NULL < max_value AND max_value < 1         => 42.974302,
	    1 <= max_value AND max_value < 53739       => 13.504858,
	    53739 <= max_value AND max_value < 128499  => 37.461491,
	    128499 <= max_value AND max_value < 206243 => 37.882785,
	    206243 <= max_value AND max_value < 251509 => 43.834169,
	    251509 <= max_value AND max_value < 452000 => 44.064958,
	    452000 <= max_value AND max_value < 644000 => 71.624931,
	    644000 <= max_value                        => 92.108704,
	                                                  42.974302);
	
	np_subscore5 := map(
	    (np_cvi in [0])  => 40.228347,
	    (np_cvi in [30]) => 68.800676,
	    (np_cvi in [50]) => 69.063245,
	                        42.974302);
	
	np_subscore6 := map(
	    NULL < mth_gong_did_last_seen AND mth_gong_did_last_seen < 0 => 42.974302,
	    0 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 2   => 51.700595,
	    2 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 3   => 35.479629,
	    3 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 4   => 35.470857,
	    4 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 5   => 35.223662,
	    5 <= mth_gong_did_last_seen                                  => 33.422300,
	                                                                    42.974302);
	
	np_subscore7 := map(
	    (np_infutor in [0]) => 50.298129,
	    (np_infutor in [2]) => 38.249025,
	    (np_infutor in [1]) => 33.146827,
	                           42.974302);
	
	np_subscore8 := map(
	    (np_boat_plane in [0]) => 41.599021,
	    (np_boat_plane in [1]) => 62.506384,
	    (np_boat_plane in [2]) => 82.044157,
	                              42.974302);
	
	np_subscore9 := map(
	    NULL < mth_ver_src_ldate_p AND mth_ver_src_ldate_p < 0 => 44.124599,
	    0 <= mth_ver_src_ldate_p AND mth_ver_src_ldate_p < 2   => 79.939925,
	    2 <= mth_ver_src_ldate_p AND mth_ver_src_ldate_p < 60  => 44.801059,
	    60 <= mth_ver_src_ldate_p                              => 29.246036,
	                                                              42.974302);
	
	np_subscore10 := map(
	    (wealth_index in ['0'])      => 42.974302,
	    (wealth_index in ['1'])      => 28.407113,
	    (wealth_index in ['2'])      => 31.789737,
	    (wealth_index in ['3'])      => 49.935659,
	    (wealth_index in ['4'])      => 50.957779,
	    (wealth_index in ['5', '6']) => 51.219377,
	                                    42.974302);
	
	np_subscore11 := map(
	    (np_hi_end_pl in [0]) => 42.236663,
	    (np_hi_end_pl in [1]) => 86.708319,
	                             42.974302);
	
	np_subscore12 := map(
	    NULL < attr_total_number_derogs AND attr_total_number_derogs < 1 => 45.473543,
	    1 <= attr_total_number_derogs AND attr_total_number_derogs < 2   => 33.620855,
	    2 <= attr_total_number_derogs                                    => 21.333161,
	                                                                        42.974302);
	
	np_subscore13 := map(
	    NULL < avg_mo_per_addr AND avg_mo_per_addr < 1  => 42.974302,
	    1 <= avg_mo_per_addr AND avg_mo_per_addr < 13   => 33.791770,
	    13 <= avg_mo_per_addr AND avg_mo_per_addr < 31  => 33.973352,
	    31 <= avg_mo_per_addr AND avg_mo_per_addr < 38  => 34.002613,
	    38 <= avg_mo_per_addr AND avg_mo_per_addr < 57  => 39.932604,
	    57 <= avg_mo_per_addr AND avg_mo_per_addr < 92  => 45.514855,
	    92 <= avg_mo_per_addr AND avg_mo_per_addr < 294 => 47.552396,
	    294 <= avg_mo_per_addr                          => 58.729797,
	                                                       42.974302);
	
	np_subscore14 := map(
	    (np_input_addr_probs in [0]) => 29.428470,
	    (np_input_addr_probs in [1]) => 37.285845,
	    (np_input_addr_probs in [2]) => 44.859706,
	    (np_input_addr_probs in [3]) => 44.904140,
	                                    42.974302);
	
	np_subscore15 := map(
	    NULL < lb_age AND lb_age < 18 => 42.974302,
	    18 <= lb_age AND lb_age < 36  => 37.791741,
	    36 <= lb_age AND lb_age < 47  => 37.977932,
	    47 <= lb_age AND lb_age < 55  => 39.868952,
	    55 <= lb_age AND lb_age < 67  => 41.541786,
	    67 <= lb_age AND lb_age < 79  => 41.594381,
	    79 <= lb_age AND lb_age < 85  => 44.786124,
	    85 <= lb_age                  => 50.888327,
	                                     42.974302);
	
	p_cvi := map(
	    (cvi in [30, 40]) => 40,
	    cvi < 30          => 0,
	                         cvi);
	
	p_derog_src_hit := map(
	    mth_ver_src_fdate_ba != NULL AND mth_ver_src_fdate_ba <= 120 => 2,
	    mth_ver_src_fdate_l2 != NULL AND mth_ver_src_fdate_l2 <= 84  => 1,
	                                                                    0);
	
	p_nap_lvl := map(
	    nap_summary = 12 => 1,
	    nap_summary = 9  => 2,
	    nap_summary = 11 => 3,
	    nap_summary = 7  => 4,
	    nap_summary = 8  => 5,
	                        6);
	
	p_infutor_lvl := map(
	    infutor_nap > 1 => 2,
	    infutor_nap > 0 => 1,
	                       0);
	
	avm_index_fips := if(add1_avm_med_fips = 0 or add1_avm_automated_valuation = 0, -1, truncate((REAL8)add1_avm_automated_valuation / (REAL8)add1_avm_med_fips * (REAL8)100));
	
	add1_date_first_seen2 := Common.SAS_Date((STRING)(add1_date_first_seen));
	
	mth_add1_date_first_seen_tmp := ROUNDUP((sysdate - add1_date_first_seen2) / 30.5);
	
	mth_add1_date_first_seen := if(min(sysdate, add1_date_first_seen2) = NULL, NULL, IF(mth_add1_date_first_seen_tmp < 0, 0, mth_add1_date_first_seen_tmp));
	
	add2_date_first_seen2 := Common.SAS_Date((STRING)(add2_date_first_seen));
	
	mth_add2_date_first_seen_tmp := ROUNDUP((sysdate - add2_date_first_seen2) / 30.5);
	
	mth_add2_date_first_seen := if(min(sysdate, add2_date_first_seen2) = NULL, NULL, IF(mth_add2_date_first_seen_tmp < 0, 0, mth_add2_date_first_seen_tmp));
	
	add3_date_first_seen2 := Common.SAS_Date((STRING)(add3_date_first_seen));
	
	mth_add3_date_first_seen_tmp := ROUNDUP((sysdate - add3_date_first_seen2) / 30.5);
	
	mth_add3_date_first_seen := if(min(sysdate, add3_date_first_seen2) = NULL, NULL, IF(mth_add3_date_first_seen_tmp < 0, 0, mth_add3_date_first_seen_tmp));
	
	add_lres_mth_avg := if(max(mth_add1_date_first_seen, mth_add2_date_first_seen, mth_add3_date_first_seen) = NULL, NULL, (if(max(mth_add1_date_first_seen, mth_add2_date_first_seen, mth_add3_date_first_seen) = NULL, NULL, SUM(if(mth_add1_date_first_seen = NULL, 0, mth_add1_date_first_seen), if(mth_add2_date_first_seen = NULL, 0, mth_add2_date_first_seen), if(mth_add3_date_first_seen = NULL, 0, mth_add3_date_first_seen)))/sum(if(mth_add1_date_first_seen = NULL, 0, 1), if(mth_add2_date_first_seen = NULL, 0, 1), if(mth_add3_date_first_seen = NULL, 0, 1))));
	
	p_prop_name_addr_match := (ver_src_nas_p in [8, 12]);
	
	p_input_addr_probs := map(
	    TRIM(add1_advo_drop) = 'Y' OR TRIM(add1_advo_address_vacancy) = 'Y'    => 0,
	    (INTEGER)rc_input_addr_not_most_recent > 0 OR TRIM(rc_addrvalflag) != 'V' => 1,
	                                                                  2);
	
	p_new_person_c6_3 := min(if(max(adls_per_addr_c6, ssns_per_addr_c6) = NULL, -NULL, max(adls_per_addr_c6, ssns_per_addr_c6)), 3);
	
	p_subscore0 := map(
	    NULL < attr_total_number_derogs AND attr_total_number_derogs < 1 => 40.172358,
	    1 <= attr_total_number_derogs AND attr_total_number_derogs < 2   => 16.757406,
	    2 <= attr_total_number_derogs                                    => 1.594389,
	                                                                        36.312651);
	
	p_subscore1 := map(
	    NULL < addrs_per_ssn AND addrs_per_ssn < 1 => 36.312651,
	    1 <= addrs_per_ssn AND addrs_per_ssn < 3   => 46.187879,
	    3 <= addrs_per_ssn AND addrs_per_ssn < 4   => 42.264782,
	    4 <= addrs_per_ssn AND addrs_per_ssn < 5   => 39.087431,
	    5 <= addrs_per_ssn AND addrs_per_ssn < 10  => 33.235364,
	    10 <= addrs_per_ssn AND addrs_per_ssn < 11 => 22.261078,
	    11 <= addrs_per_ssn AND addrs_per_ssn < 14 => 16.229063,
	    14 <= addrs_per_ssn                        => 5.686630,
	                                                  36.312651);
	
	p_subscore2 := map(
	    NULL < property_owned_assessed_total AND property_owned_assessed_total < 1         => 36.312651,
	    1 <= property_owned_assessed_total AND property_owned_assessed_total < 47092       => 12.762662,
	    47092 <= property_owned_assessed_total AND property_owned_assessed_total < 56700   => 29.482806,
	    56700 <= property_owned_assessed_total AND property_owned_assessed_total < 66529   => 29.711803,
	    66529 <= property_owned_assessed_total AND property_owned_assessed_total < 116104  => 35.904591,
	    116104 <= property_owned_assessed_total AND property_owned_assessed_total < 170966 => 43.310180,
	    170966 <= property_owned_assessed_total                                            => 46.077834,
	                                                                                          36.312651);
	
	p_subscore3 := map(
	    (p_cvi in [0])  => 33.340238,
	    (p_cvi in [40]) => 60.777678,
	    (p_cvi in [50]) => 60.794436,
	                       36.312651);
	
	p_subscore4 := map(
	    (p_derog_src_hit in [0]) => 38.799912,
	    (p_derog_src_hit in [1]) => 32.460459,
	    (p_derog_src_hit in [2]) => -3.322542,
	                                36.312651);
	
	p_subscore5 := map(
	    NULL < property_owned_total AND property_owned_total < 1 => 12.908351,
	    1 <= property_owned_total AND property_owned_total < 2   => 36.782981,
	    2 <= property_owned_total AND property_owned_total < 4   => 40.362304,
	    4 <= property_owned_total                                => 58.073869,
	                                                                36.312651);
	
	p_subscore6 := map(
	    (p_nap_lvl in [1]) => 45.073337,
	    (p_nap_lvl in [2]) => 44.888673,
	    (p_nap_lvl in [3]) => 35.543658,
	    (p_nap_lvl in [4]) => 30.137611,
	    (p_nap_lvl in [5]) => 28.421415,
	    (p_nap_lvl in [6]) => 28.365459,
	                          36.312651);
	
	p_subscore7 := map(
	    NULL < estimated_income_2 AND estimated_income_2 < 1       => 36.312651,
	    1 <= estimated_income_2 AND estimated_income_2 < 20000     => 25.397849,
	    20000 <= estimated_income_2 AND estimated_income_2 < 21000 => 25.686234,
	    21000 <= estimated_income_2 AND estimated_income_2 < 27000 => 29.649775,
	    27000 <= estimated_income_2 AND estimated_income_2 < 34000 => 37.368280,
	    34000 <= estimated_income_2 AND estimated_income_2 < 41000 => 45.079559,
	    41000 <= estimated_income_2                              => 46.836493,
	                                                              36.312651);
	
	p_subscore8 := map(
	    NULL < mth_gong_did_last_seen AND mth_gong_did_last_seen < 2 => 42.375481,
	    2 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 3   => 26.084269,
	    3 <= mth_gong_did_last_seen                                  => 25.425939,
	                                                                    36.312651);
	
	p_subscore9 := map(
	    (p_infutor_lvl in [0]) => 43.242012,
	    (p_infutor_lvl in [2]) => 30.620608,
	    (p_infutor_lvl in [1]) => 30.448341,
	                              36.312651);
	
	p_subscore10 := map(
	    NULL < avm_index_fips AND avm_index_fips < 0   => 36.312651,
	    0 <= avm_index_fips AND avm_index_fips < 50    => 20.231960,
	    50 <= avm_index_fips AND avm_index_fips < 60   => 27.111709,
	    60 <= avm_index_fips AND avm_index_fips < 90   => 37.244782,
	    90 <= avm_index_fips AND avm_index_fips < 100  => 38.896296,
	    100 <= avm_index_fips AND avm_index_fips < 110 => 41.710543,
	    110 <= avm_index_fips AND avm_index_fips < 140 => 41.712515,
	    140 <= avm_index_fips AND avm_index_fips < 150 => 41.919524,
	    150 <= avm_index_fips                          => 41.994713,
	                                                      36.312651);
	
	p_subscore11 := map(
	    NULL < add_lres_mth_avg AND add_lres_mth_avg < 90  => 31.470503,
	    90 <= add_lres_mth_avg AND add_lres_mth_avg < 122  => 33.209936,
	    122 <= add_lres_mth_avg AND add_lres_mth_avg < 185 => 33.389819,
	    185 <= add_lres_mth_avg AND add_lres_mth_avg < 199 => 33.655158,
	    199 <= add_lres_mth_avg AND add_lres_mth_avg < 262 => 38.393323,
	    262 <= add_lres_mth_avg AND add_lres_mth_avg < 296 => 39.129483,
	    296 <= add_lres_mth_avg AND add_lres_mth_avg < 386 => 46.034706,
	    386 <= add_lres_mth_avg                            => 68.714111,
	                                                          36.312651);
	
	p_subscore12 := map(
	    NULL < max_value AND max_value < 1         => 36.312651,
	    1 <= max_value AND max_value < 64600       => 28.918811,
	    64600 <= max_value AND max_value < 93401   => 29.560706,
	    93401 <= max_value AND max_value < 152360  => 30.350084,
	    152360 <= max_value AND max_value < 327998 => 38.174209,
	    327998 <= max_value AND max_value < 413000 => 41.450301,
	    413000 <= max_value AND max_value < 595600 => 47.132493,
	    595600 <= max_value                        => 57.304008,
	                                                  36.312651);
	
	p_subscore13 := map(
	    (p_prop_name_addr_match in [0]) => 33.636749,
	    (p_prop_name_addr_match in [1]) => 44.229167,
	                                       36.312651);
	
	p_subscore14 := map(
	    (p_input_addr_probs in [0]) => 10.588714,
	    (p_input_addr_probs in [1]) => 35.230746,
	    (p_input_addr_probs in [2]) => 37.524112,
	                                   36.312651);
	
	p_subscore15 := map(
	    NULL < liens_recent_unreleased_count AND liens_recent_unreleased_count < 1 => 37.362845,
	    1 <= liens_recent_unreleased_count                                         => 14.376731,
	                                                                                  36.312651);
	
	p_subscore16 := map(
	    NULL < property_sold_total AND property_sold_total < 1 => 34.503252,
	    1 <= property_sold_total AND property_sold_total < 2   => 39.500992,
	    2 <= property_sold_total AND property_sold_total < 3   => 41.495673,
	    3 <= property_sold_total                               => 58.183677,
	                                                              36.312651);
	
	p_subscore17 := map(
	    NULL < avg_mo_per_addr AND avg_mo_per_addr < 1  => 36.312651,
	    1 <= avg_mo_per_addr AND avg_mo_per_addr < 23   => 14.529168,
	    23 <= avg_mo_per_addr AND avg_mo_per_addr < 46  => 32.422725,
	    46 <= avg_mo_per_addr AND avg_mo_per_addr < 69  => 34.962229,
	    69 <= avg_mo_per_addr AND avg_mo_per_addr < 140 => 37.235661,
	    140 <= avg_mo_per_addr                          => 41.309373,
	                                                       36.312651);
	
	p_subscore18 := map(
	    NULL < p_new_person_c6_3 AND p_new_person_c6_3 < 1 => 39.045292,
	    1 <= p_new_person_c6_3 AND p_new_person_c6_3 < 2   => 31.077460,
	    2 <= p_new_person_c6_3                             => 29.945352,
	                                                          36.312651);
	
	p_subscore19 := map(
	    NULL < lb_age AND lb_age < 18 => 36.312651,
	    18 <= lb_age AND lb_age < 41  => 26.615544,
	    41 <= lb_age AND lb_age < 65  => 33.981630,
	    65 <= lb_age AND lb_age < 77  => 35.177861,
	    77 <= lb_age AND lb_age < 83  => 35.742919,
	    83 <= lb_age                  => 43.727280,
	                                     36.312651);
	
	ln_dead := (INTEGER)rc_decsflag = 1 OR TRIM(adl_category) = '1 DEAD' OR (INTEGER)ver_src_ds > 0 OR (INTEGER)ver_src_de > 0;
	
	prop_owner := add1_naprop = 4 or property_owned_total > 0;
	
	_segment := map(
	    (INTEGER)addrpop = 0 OR (INTEGER)hphnpop = 0 => 0,
	    NOT(ln_dead)               => 1,
	    prop_owner                 => 2,
	                                  3);
	
	i_scaledscore := i_subscore0 +
	    i_subscore1 +
	    i_subscore2 +
	    i_subscore3 +
	    i_subscore4 +
	    i_subscore5 +
	    i_subscore6 +
	    i_subscore7 +
	    i_subscore8 +
	    i_subscore9 +
	    i_subscore10;
	
	nd_scaledscore := nd_subscore0 +
	    nd_subscore1 +
	    nd_subscore2 +
	    nd_subscore3 +
	    nd_subscore4 +
	    nd_subscore5 +
	    nd_subscore6 +
	    nd_subscore7 +
	    nd_subscore8 +
	    nd_subscore9;
	
	p_scaledscore := p_subscore0 +
	    p_subscore1 +
	    p_subscore2 +
	    p_subscore3 +
	    p_subscore4 +
	    p_subscore5 +
	    p_subscore6 +
	    p_subscore7 +
	    p_subscore8 +
	    p_subscore9 +
	    p_subscore10 +
	    p_subscore11 +
	    p_subscore12 +
	    p_subscore13 +
	    p_subscore14 +
	    p_subscore15 +
	    p_subscore16 +
	    p_subscore17 +
	    p_subscore18 +
	    p_subscore19;
	
	np_scaledscore := np_subscore0 +
	    np_subscore1 +
	    np_subscore2 +
	    np_subscore3 +
	    np_subscore4 +
	    np_subscore5 +
	    np_subscore6 +
	    np_subscore7 +
	    np_subscore8 +
	    np_subscore9 +
	    np_subscore10 +
	    np_subscore11 +
	    np_subscore12 +
	    np_subscore13 +
	    np_subscore14 +
	    np_subscore15;
	
	_in := map(
	    _segment = 0 => i_scaledscore,
	    _segment = 1 => nd_scaledscore,
	    _segment = 2 => p_scaledscore,
	    _segment = 3 => np_scaledscore,
	                    NULL);
	
	rvc1110_1_1 := round(min(if(max(_in, (real)501) = NULL, -NULL, max(_in, (real)501)), 900));
	
	lien_flag := (INTEGER)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') > 0 or (INTEGER)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') > 0 or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;
	
	bk_flag := (rc_bansflag in ['1', '2']) or (INTEGER)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') > 0 or (INTEGER)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;
	
	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, 
															NULL, 
															sum(if(property_owned_total = NULL, 
																				0, 
																				property_owned_total), 
																	if(property_sold_total = NULL, 
																				0, 
																				property_sold_total))) > 0 
									OR (90 <= combo_dobscore AND combo_dobscore <= 100 or 
															(INTEGER)input_dob_match_level >= 7 or 
															(INTEGER)lien_flag > 0 or 
															criminal_count > 0 or 
															(INTEGER)bk_flag > 0 or 
															truedid);
	
	rvc1110_1 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvc1110_1_1);
	
	ver_name := (nas_summary in [2, 5, 7, 8, 9, 11, 12]) OR (nap_summary in [2, 5, 7, 8, 9, 11, 12]);
	
	ver_ssn := (nas_summary in [4, 6, 7, 9, 10, 11, 12]);
	
	ver_addr := (nas_summary in [3, 5, 6, 8, 10, 11, 12]) OR (nap_summary in [3, 5, 6, 8, 10, 11, 12]);
	
	glrc07 := (INTEGER)hphnpop > 0;
	
	glrc25 := (INTEGER)add1_house_number_match = 0;
	
	glrc36 := (INTEGER)lnamepop > 0 and (INTEGER)ver_name = 0 OR (INTEGER)addrpop > 0 and (INTEGER)ver_addr = 0 OR (ssnlength in ['4', '9']) and (INTEGER)ver_ssn = 0;
	
	glrc78 := (INTEGER)addrpop = 0;
	
	glrc80 := (INTEGER)hphnpop = 0;
	
	glrc97 := criminal_count > 0;
	
	glrc98 := liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;
	
	glrc99 := (INTEGER)rc_input_addr_not_most_recent > 0;
	
	glrc9a := NOT(property_owned_total > 0 OR add1_naprop = 4);
	
	glrc9b := (INTEGER)ver_src_p > 0 AND NOT(property_owned_total > 0 OR add1_naprop = 4);
	
	glrc9c := unique_addr_count > 0;
	
	glrc9d := unique_addr_count > 0;
	
	glrc9e := (INTEGER)truedid = 1;
	
	glrc9f := (INTEGER)truedid = 1;
	
	glrc9g := 17 < lb_age AND lb_age < 36;
	
	glrc9m := (INTEGER)wealth_index < 5;
	
	glrc9u := add1_advo_address_vacancy = 'Y' OR rc_addrvalflag != 'V' OR (INTEGER)rc_cityzipflag > 0 OR (INTEGER)rc_statezipflag > 0;
	
	glrc9w := (INTEGER)bankrupt > 0;
	
	glrcpv := 1;
	
	glrcbl := 0;
	
	rc1_2 := '';
	
	rc2_1 := '';
	
	rc3_1 := '';
	
	rc4_1 := '';
	
	rc5_1 := '';
	
	rcseginputs := _segment = 0;
	
	rcsegnondead := _segment = 1;
	
	rcsegprop := _segment = 2;
	
	rcsegnon := _segment = 3;
	
	rcvalue07_1 := (integer)rcseginputs * (71.510093 - i_subscore4);
	
	rcvalue07 := (integer)glrc07 * if(max(rcvalue07_1) = NULL, NULL, sum(if(rcvalue07_1 = NULL, 0, rcvalue07_1)));
	
	rcvalue25_1 := (integer)rcsegnondead * (78.800401 - nd_subscore0);
	
	rcvalue25_2 := (integer)rcsegnon * (44.90414 - np_subscore14);
	
	rcvalue25 := (integer)glrc25 * if(max(rcvalue25_1, rcvalue25_2) = NULL, NULL, sum(if(rcvalue25_1 = NULL, 0, rcvalue25_1), if(rcvalue25_2 = NULL, 0, rcvalue25_2)));
	
	rcvalue36_1 := (integer)rcsegnondead * (81.65828 - nd_subscore4);
	
	rcvalue36_2 := (integer)rcsegnon * (52.10695 - np_subscore3);
	
	rcvalue36_3 := (integer)rcsegnon * (69.063245 - np_subscore5);
	
	rcvalue36_4 := (integer)rcsegnon * (50.298129 - np_subscore7);
	
	rcvalue36_5 := (integer)rcsegprop * (60.794436 - p_subscore3);
	
	rcvalue36_6 := (integer)rcsegprop * (45.073337 - p_subscore6);
	
	rcvalue36_7 := (integer)rcsegprop * (43.242012 - p_subscore9);
	
	rcvalue36 := (integer)glrc36 * if(max(rcvalue36_1, rcvalue36_2, rcvalue36_3, rcvalue36_4, rcvalue36_5, rcvalue36_6, rcvalue36_7) = NULL, NULL, sum(if(rcvalue36_1 = NULL, 0, rcvalue36_1), if(rcvalue36_2 = NULL, 0, rcvalue36_2), if(rcvalue36_3 = NULL, 0, rcvalue36_3), if(rcvalue36_4 = NULL, 0, rcvalue36_4), if(rcvalue36_5 = NULL, 0, rcvalue36_5), if(rcvalue36_6 = NULL, 0, rcvalue36_6), if(rcvalue36_7 = NULL, 0, rcvalue36_7)));
	
	rcvalue78_1 := (integer)rcseginputs * 109;
	
	rcvalue78 := (integer)glrc78 * if(max(rcvalue78_1) = NULL, NULL, sum(if(rcvalue78_1 = NULL, 0, rcvalue78_1)));
	
	rcvalue80_1 := (integer)rcseginputs * 109;
	
	rcvalue80 := (integer)glrc80 * if(max(rcvalue80_1) = NULL, NULL, sum(if(rcvalue80_1 = NULL, 0, rcvalue80_1)));
	
	rcvalue97_1 := 0 * (integer)rcseginputs * (65.684503 - i_subscore9);
	
	rcvalue97_2 := (integer)rcsegnondead * (74.087924 - nd_subscore8);
	
	rcvalue97_3 := (integer)rcsegnon * (45.473543 - np_subscore12);
	
	rcvalue97_4 := (integer)rcsegprop * (40.172358 - p_subscore0);
	
	rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2, rcvalue97_3, rcvalue97_4) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2), if(rcvalue97_3 = NULL, 0, rcvalue97_3), if(rcvalue97_4 = NULL, 0, rcvalue97_4)));
	
	rcvalue98_1 := (integer)rcseginputs * (67.322451 - i_subscore1);
	
	rcvalue98_2 := (integer)rcsegnondead * (73.409594 - nd_subscore7);
	
	rcvalue98_3 := (integer)rcsegnon * (50.633625 - np_subscore0);
	
	rcvalue98_4 := (integer)rcsegprop * (38.799912 - p_subscore4);
	
	rcvalue98_5 := (integer)rcsegprop * (37.362845 - p_subscore15);
	
	rcvalue98_6 := 0 * (integer)rcseginputs * (65.684503 - i_subscore9);
	
	rcvalue98_7 := (integer)rcsegnondead * (74.087924 - nd_subscore8);
	
	rcvalue98_8 := (integer)rcsegnon * (45.473543 - np_subscore12);
	
	rcvalue98_9 := (integer)rcsegprop * (40.172358 - p_subscore0);
	
	rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1, rcvalue98_2, rcvalue98_3, rcvalue98_4, rcvalue98_5, rcvalue98_6, rcvalue98_7, rcvalue98_8, rcvalue98_9) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2), if(rcvalue98_3 = NULL, 0, rcvalue98_3), if(rcvalue98_4 = NULL, 0, rcvalue98_4), if(rcvalue98_5 = NULL, 0, rcvalue98_5), if(rcvalue98_6 = NULL, 0, rcvalue98_6), if(rcvalue98_7 = NULL, 0, rcvalue98_7), if(rcvalue98_8 = NULL, 0, rcvalue98_8), if(rcvalue98_9 = NULL, 0, rcvalue98_9)));
	
	rcvalue99_1 := (integer)rcsegnondead * (78.800401 - nd_subscore0);
	
	rcvalue99_2 := (integer)rcsegnon * (44.90414 - np_subscore14);
	
	rcvalue99_3 := (integer)rcsegprop * (37.524112 - p_subscore14);
	
	rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1, rcvalue99_2, rcvalue99_3) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1), if(rcvalue99_2 = NULL, 0, rcvalue99_2), if(rcvalue99_3 = NULL, 0, rcvalue99_3)));
	
	rcvalue9a_1 := (integer)rcseginputs * (68.723803 - i_subscore8);
	
	rcvalue9a_2 := (integer)rcsegnondead * (82.627658 - nd_subscore2);
	
	rcvalue9a_3 := (integer)rcsegprop * (58.073869 - p_subscore5);
	
	rcvalue9a_4 := (integer)rcsegnon * 42;
	
	rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1, rcvalue9a_2, rcvalue9a_3, rcvalue9a_4) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2), if(rcvalue9a_3 = NULL, 0, rcvalue9a_3), if(rcvalue9a_4 = NULL, 0, rcvalue9a_4)));
	
	rcvalue9b_1 := (integer)rcsegnon * (63.383709 - np_subscore1);
	
	rcvalue9b := (integer)glrc9b * if(max(rcvalue9b_1) = NULL, NULL, sum(if(rcvalue9b_1 = NULL, 0, rcvalue9b_1)));
	
	rcvalue9c_1 := (integer)rcseginputs * (69.22914 - i_subscore7);
	
	rcvalue9c_2 := (integer)rcsegnon * (58.729797 - np_subscore13);
	
	rcvalue9c_3 := (integer)rcsegprop * (68.714111 - p_subscore11);
	
	rcvalue9c_4 := (integer)rcsegprop * (41.309373 - p_subscore17);
	
	rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1, rcvalue9c_2, rcvalue9c_3, rcvalue9c_4) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1), if(rcvalue9c_2 = NULL, 0, rcvalue9c_2), if(rcvalue9c_3 = NULL, 0, rcvalue9c_3), if(rcvalue9c_4 = NULL, 0, rcvalue9c_4)));
	
	rcvalue9d_1 := (integer)rcseginputs * (84.406866 - i_subscore2);
	
	rcvalue9d_2 := (integer)rcsegnondead * (86.189694 - nd_subscore5);
	
	rcvalue9d_3 := (integer)rcsegnon * (62.447589 - np_subscore2);
	
	rcvalue9d_4 := (integer)rcsegprop * (46.187879 - p_subscore1);
	
	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2, rcvalue9d_3, rcvalue9d_4) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2), if(rcvalue9d_3 = NULL, 0, rcvalue9d_3), if(rcvalue9d_4 = NULL, 0, rcvalue9d_4)));
	
	rcvalue9e_1 := (integer)rcsegprop * (44.229167 - p_subscore13);
	
	rcvalue9e_2 := (integer)rcsegnondead * 7;
	
	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1, rcvalue9e_2) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2)));
	
	rcvalue9f_1 := (integer)rcseginputs * (84.336434 - i_subscore3);
	
	rcvalue9f_2 := (integer)rcseginputs * (69.699844 - i_subscore5);
	
	rcvalue9f_3 := (integer)rcseginputs * (62.000319 - i_subscore6);
	
	rcvalue9f_4 := (integer)rcsegnondead * (78.412884 - nd_subscore6);
	
	rcvalue9f_5 := (integer)rcsegnon * (51.700595 - np_subscore6);
	
	rcvalue9f_6 := (integer)rcsegnon * (79.939925 - np_subscore9);
	
	rcvalue9f_7 := (integer)rcsegprop * (42.375481 - p_subscore8);
	
	rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1, rcvalue9f_2, rcvalue9f_3, rcvalue9f_4, rcvalue9f_5, rcvalue9f_6, rcvalue9f_7) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1), if(rcvalue9f_2 = NULL, 0, rcvalue9f_2), if(rcvalue9f_3 = NULL, 0, rcvalue9f_3), if(rcvalue9f_4 = NULL, 0, rcvalue9f_4), if(rcvalue9f_5 = NULL, 0, rcvalue9f_5), if(rcvalue9f_6 = NULL, 0, rcvalue9f_6), if(rcvalue9f_7 = NULL, 0, rcvalue9f_7)));
	
	rcvalue9g_1 := (integer)rcsegnon * (50.888327 - np_subscore15);
	
	rcvalue9g_2 := (integer)rcsegprop * (43.72728 - p_subscore19);
	
	rcvalue9g := (integer)glrc9g * if(max(rcvalue9g_1, rcvalue9g_2) = NULL, NULL, sum(if(rcvalue9g_1 = NULL, 0, rcvalue9g_1), if(rcvalue9g_2 = NULL, 0, rcvalue9g_2)));
	
	rcvalue9m_1 := (integer)rcseginputs * (89.932265 - i_subscore0);
	
	rcvalue9m_2 := (integer)rcsegnondead * (94.559706 - nd_subscore1);
	
	rcvalue9m_3 := (integer)rcsegnondead * (78.892711 - nd_subscore9);
	
	rcvalue9m_4 := (integer)rcsegnon * (82.044157 - np_subscore8);
	
	rcvalue9m_5 := (integer)rcsegnon * (51.219377 - np_subscore10);
	
	rcvalue9m_6 := (integer)rcsegprop * (46.836493 - p_subscore7);
	
	rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1, rcvalue9m_2, rcvalue9m_3, rcvalue9m_4, rcvalue9m_5, rcvalue9m_6) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1), if(rcvalue9m_2 = NULL, 0, rcvalue9m_2), if(rcvalue9m_3 = NULL, 0, rcvalue9m_3), if(rcvalue9m_4 = NULL, 0, rcvalue9m_4), if(rcvalue9m_5 = NULL, 0, rcvalue9m_5), if(rcvalue9m_6 = NULL, 0, rcvalue9m_6)));
	
	rcvalue9u_1 := (integer)rcsegnondead * (78.800401 - nd_subscore0);
	
	rcvalue9u_2 := (integer)rcsegprop * (37.524112 - p_subscore14);
	
	rcvalue9u := (integer)glrc9u * if(max(rcvalue9u_1, rcvalue9u_2) = NULL, NULL, sum(if(rcvalue9u_1 = NULL, 0, rcvalue9u_1), if(rcvalue9u_2 = NULL, 0, rcvalue9u_2)));
	
	rcvalue9w_1 := (integer)rcseginputs * (67.322451 - i_subscore1);
	
	rcvalue9w_2 := (integer)rcsegnondead * (73.713137 - nd_subscore3);
	
	rcvalue9w_3 := (integer)rcsegnon * (50.633625 - np_subscore0);
	
	rcvalue9w_4 := (integer)rcsegprop * (38.799912 - p_subscore4);
	
	rcvalue9w_5 := 0 * (integer)rcseginputs * (65.684503 - i_subscore9);
	
	rcvalue9w_6 := (integer)rcsegnondead * (74.087924 - nd_subscore8);
	
	rcvalue9w_7 := (integer)rcsegnon * (45.473543 - np_subscore12);
	
	rcvalue9w_8 := (integer)rcsegprop * (40.172358 - p_subscore0);
	
	rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1, rcvalue9w_2, rcvalue9w_3, rcvalue9w_4, rcvalue9w_5, rcvalue9w_6, rcvalue9w_7, rcvalue9w_8) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2), if(rcvalue9w_3 = NULL, 0, rcvalue9w_3), if(rcvalue9w_4 = NULL, 0, rcvalue9w_4), if(rcvalue9w_5 = NULL, 0, rcvalue9w_5), if(rcvalue9w_6 = NULL, 0, rcvalue9w_6), if(rcvalue9w_7 = NULL, 0, rcvalue9w_7), if(rcvalue9w_8 = NULL, 0, rcvalue9w_8)));
	
	rcvaluepv_1 := (integer)rcsegnon * (92.108704 - np_subscore4);
	
	rcvaluepv_2 := (integer)rcsegprop * (46.077834 - p_subscore2);
	
	rcvaluepv_3 := (integer)rcsegprop * (41.994713 - p_subscore10);
	
	rcvaluepv_4 := (integer)rcsegprop * (57.304008 - p_subscore12);
	
	rcvaluepv := glrcpv * if(max(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3, rcvaluepv_4) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2), if(rcvaluepv_3 = NULL, 0, rcvaluepv_3), if(rcvaluepv_4 = NULL, 0, rcvaluepv_4)));
	
	rcvaluebl_1 := (integer)rcseginputs * (56.819014 - i_subscore10);
	
	rcvaluebl_2 := (integer)rcsegnon * (86.708319 - np_subscore11);
	
	rcvaluebl_3 := (integer)rcsegprop * (58.183677 - p_subscore16);
	
	rcvaluebl_4 := (integer)rcsegprop * (39.045292 - p_subscore18);
	
	rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4)));
		
	ds_layout := {STRING rc, REAL value};
	rc_dataset := DATASET([
		{'07',	RCValue07},
		{'25',	RCValue25},
		{'36',	RCValue36},
		{'78',	RCValue78},
		{'80',	RCValue80},
		{'97',	RCValue97},
		{'98',	RCValue98},
		{'99',	RCValue99},
		{'9A',	RCValue9A},
		{'9B',	RCValue9B},
		{'9C',	RCValue9C},
		{'9D',	RCValue9D},
		{'9E',	RCValue9E},
		{'9F',	RCValue9F},
		{'9G',	RCValue9G},
		{'9M',	RCValue9M},
		{'9U',	RCValue9U},
		{'9W',	RCValue9W},
		{'PV',	RCValuePV},
		{'BL',	RCValueBL}
	    ], ds_layout)(value > 0);
			
	rcs_top4 := choosen(sort(rc_dataset, -value), 4);
	
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	rcTemp := map(
																	rvc1110_1 = 222 => dataset([{'9X', NULL}], ds_layout),
													  0 = count( rcs_top4 ) => dataset([{'36', NULL}], ds_layout),
																										 rcs_top4
												);
												
	reasonsTemp := PROJECT(rcTemp, TRANSFORM(Risk_Indicators.Layout_Desc,
																																SELF.hri := LEFT.rc,
																																SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)));
																																
	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);

	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
			
	PrescreenOptOut := xmlPrescreenOptOut or Risk_Indicators.iid_constants.CheckFlag(Risk_Indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags);		
	
	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						Risk_Indicators.rcSet.isCode95(PreScreenOptOut) => DATASET([{'95', Risk_Indicators.getHRIDesc('95')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						reasonsTemp
						);
						
	reasons := CHOOSEN(ri & zeros, 5);
	
	final_score := MAP(
											riTemp[1].hri IN ['91','92','93','94'] => (STRING3)((INTEGER)riTemp[1].hri + 10),
											Risk_Indicators.rcSet.isCode95(PreScreenOptOut) => '222',
											reasons[1].hri='35' => '100',
											(STRING3)rvc1110_1
										);

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.adl_category := adl_category;
		SELF.in_dob := in_dob;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.nap_status := nap_status;
		SELF.cvi := cvi;
		SELF.rc_input_addr_not_most_recent := rc_input_addr_not_most_recent;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_addrvalflag := rc_addrvalflag;
		SELF.rc_bansflag := rc_bansflag;
		SELF.rc_statezipflag := rc_statezipflag;
		SELF.rc_cityzipflag := rc_cityzipflag;
		SELF.combo_dobscore := combo_dobscore;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_nas := ver_sources_nas;
		SELF.ver_sources_first_seen := ver_sources_first_seen;
		SELF.ver_sources_last_seen := ver_sources_last_seen;
		SELF.lnamepop := lnamepop;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.hphnpop := hphnpop;
		SELF.age := age;
		SELF.add1_house_number_match := add1_house_number_match;
		SELF.add1_advo_address_vacancy := add1_advo_address_vacancy;
		SELF.add1_advo_drop := add1_advo_drop;
		SELF.add1_avm_sales_price := add1_avm_sales_price;
		SELF.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
		SELF.add1_avm_market_total_value := add1_avm_market_total_value;
		SELF.add1_avm_tax_assessed_valuation := add1_avm_tax_assessed_valuation;
		SELF.add1_avm_price_index_valuation := add1_avm_price_index_valuation;
		SELF.add1_avm_hedonic_valuation := add1_avm_hedonic_valuation;
		SELF.add1_avm_automated_valuation := add1_avm_automated_valuation;
		SELF.add1_avm_med_fips := add1_avm_med_fips;
		SELF.add1_naprop := add1_naprop;
		SELF.add1_date_first_seen := add1_date_first_seen;
		SELF.property_owned_total := property_owned_total;
		SELF.property_owned_assessed_total := property_owned_assessed_total;
		SELF.property_sold_total := property_sold_total;
		SELF.property_ambig_total := property_ambig_total;
		SELF.add2_naprop := add2_naprop;
		SELF.add2_date_first_seen := add2_date_first_seen;
		SELF.add3_naprop := add3_naprop;
		SELF.add3_date_first_seen := add3_date_first_seen;
		SELF.max_lres := max_lres;
		SELF.unique_addr_count := unique_addr_count;
		SELF.avg_mo_per_addr := avg_mo_per_addr;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.addrs_per_ssn := addrs_per_ssn;
		SELF.adls_per_addr_c6 := adls_per_addr_c6;
		SELF.ssns_per_addr_c6 := ssns_per_addr_c6;
		SELF.invalid_ssns_per_adl := invalid_ssns_per_adl;
		SELF.invalid_ssns_per_adl_c6 := invalid_ssns_per_adl_c6;
		SELF.infutor_nap := infutor_nap;
		SELF.attr_num_aircraft := attr_num_aircraft;
		SELF.attr_total_number_derogs := attr_total_number_derogs;
		SELF.bankrupt := bankrupt;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_unrel_cj_ct := liens_unrel_cj_ct;
		SELF.liens_rel_cj_ct := liens_rel_cj_ct;
		SELF.criminal_count := criminal_count;
		SELF.watercraft_count := watercraft_count;
		SELF.prof_license_category := prof_license_category;
		SELF.wealth_index := wealth_index;
		SELF.input_dob_age := input_dob_age;
		SELF.input_dob_match_level := input_dob_match_level;
		SELF.inferred_age := inferred_age;
		SELF.estimated_income_2 := estimated_income_2;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.ver_src_ar_pos := ver_src_ar_pos;
		SELF.ver_src_ar := ver_src_ar;
		SELF.ver_src_ba_pos := ver_src_ba_pos;
		SELF.ver_src_fdate_ba := ver_src_fdate_ba;
		SELF.ver_src_fdate_ba2 := ver_src_fdate_ba2;
		SELF.mth_ver_src_fdate_ba := mth_ver_src_fdate_ba;
		SELF.ver_src_ldate_ba := ver_src_ldate_ba;
		SELF.ver_src_ldate_ba2 := ver_src_ldate_ba2;
		SELF.mth_ver_src_ldate_ba := mth_ver_src_ldate_ba;
		SELF.ver_src_ds_pos := ver_src_ds_pos;
		SELF.ver_src_ds := ver_src_ds;
		SELF.ver_src_de_pos := ver_src_de_pos;
		SELF.ver_src_de := ver_src_de;
		SELF.ver_src_ldate_de := ver_src_ldate_de;
		SELF.ver_src_ldate_de2 := ver_src_ldate_de2;
		SELF.mth_ver_src_ldate_de := mth_ver_src_ldate_de;
		SELF.ver_src_l2_pos := ver_src_l2_pos;
		SELF.ver_src_fdate_l2 := ver_src_fdate_l2;
		SELF.ver_src_fdate_l22 := ver_src_fdate_l22;
		SELF.mth_ver_src_fdate_l2 := mth_ver_src_fdate_l2;
		SELF.ver_src_ldate_l2 := ver_src_ldate_l2;
		SELF.ver_src_ldate_l22 := ver_src_ldate_l22;
		SELF.mth_ver_src_ldate_l2 := mth_ver_src_ldate_l2;
		SELF.ver_src_p_pos := ver_src_p_pos;
		SELF.ver_src_p := ver_src_p;
		SELF.ver_src_nas_p := ver_src_nas_p;
		SELF.ver_src_ldate_p := ver_src_ldate_p;
		SELF.ver_src_ldate_p2 := ver_src_ldate_p2;
		SELF.mth_ver_src_ldate_p := mth_ver_src_ldate_p;
		SELF.ver_src_w_pos := ver_src_w_pos;
		SELF.ver_src_w := ver_src_w;
		SELF.gong_did_last_seen2 := gong_did_last_seen2;
		SELF.mth_gong_did_last_seen := mth_gong_did_last_seen;
		SELF.max_value := max_value;
		SELF.lb_age := lb_age;
		SELF.derog_src_hit := derog_src_hit;
		SELF.i_nap_connected := i_nap_connected;
		SELF.i_ldate_deathmaster := i_ldate_deathmaster;
		SELF.i_ever_invalid_ssn := i_ever_invalid_ssn;
		SELF.i_subscore0 := i_subscore0;
		SELF.i_subscore1 := i_subscore1;
		SELF.i_subscore2 := i_subscore2;
		SELF.i_subscore3 := i_subscore3;
		SELF.i_subscore4 := i_subscore4;
		SELF.i_subscore5 := i_subscore5;
		SELF.i_subscore6 := i_subscore6;
		SELF.i_subscore7 := i_subscore7;
		SELF.i_subscore8 := i_subscore8;
		SELF.i_subscore9 := i_subscore9;
		SELF.i_subscore10 := i_subscore10;
		SELF.d_input_addr_probs := d_input_addr_probs;
		SELF.prop_owner_1 := prop_owner_1;
		SELF.add_naprop_level := add_naprop_level;
		SELF.ba_last10yrs := ba_last10yrs;
		SELF.d_nap_lvl := d_nap_lvl;
		SELF.cj_lien_flag := cj_lien_flag;
		SELF.boat_plane_flag := boat_plane_flag;
		SELF.nd_subscore0 := nd_subscore0;
		SELF.nd_subscore1 := nd_subscore1;
		SELF.nd_subscore2 := nd_subscore2;
		SELF.nd_subscore3 := nd_subscore3;
		SELF.nd_subscore4 := nd_subscore4;
		SELF.nd_subscore5 := nd_subscore5;
		SELF.nd_subscore6 := nd_subscore6;
		SELF.nd_subscore7 := nd_subscore7;
		SELF.nd_subscore8 := nd_subscore8;
		SELF.nd_subscore9 := nd_subscore9;
		SELF.np_nap_lvl := np_nap_lvl;
		SELF.np_cvi := np_cvi;
		SELF.np_infutor := np_infutor;
		SELF.np_boat_plane := np_boat_plane;
		SELF.np_hi_end_pl := np_hi_end_pl;
		SELF.np_input_addr_probs := np_input_addr_probs;
		SELF.np_derog_src_hit := np_derog_src_hit;
		SELF.np_subscore0 := np_subscore0;
		SELF.np_subscore1 := np_subscore1;
		SELF.np_subscore2 := np_subscore2;
		SELF.np_subscore3 := np_subscore3;
		SELF.np_subscore4 := np_subscore4;
		SELF.np_subscore5 := np_subscore5;
		SELF.np_subscore6 := np_subscore6;
		SELF.np_subscore7 := np_subscore7;
		SELF.np_subscore8 := np_subscore8;
		SELF.np_subscore9 := np_subscore9;
		SELF.np_subscore10 := np_subscore10;
		SELF.np_subscore11 := np_subscore11;
		SELF.np_subscore12 := np_subscore12;
		SELF.np_subscore13 := np_subscore13;
		SELF.np_subscore14 := np_subscore14;
		SELF.np_subscore15 := np_subscore15;
		SELF.p_cvi := p_cvi;
		SELF.p_derog_src_hit := p_derog_src_hit;
		SELF.p_nap_lvl := p_nap_lvl;
		SELF.p_infutor_lvl := p_infutor_lvl;
		SELF.avm_index_fips := avm_index_fips;
		SELF.add1_date_first_seen2 := add1_date_first_seen2;
		SELF.mth_add1_date_first_seen := mth_add1_date_first_seen;
		SELF.add2_date_first_seen2 := add2_date_first_seen2;
		SELF.mth_add2_date_first_seen := mth_add2_date_first_seen;
		SELF.add3_date_first_seen2 := add3_date_first_seen2;
		SELF.mth_add3_date_first_seen := mth_add3_date_first_seen;
		SELF.add_lres_mth_avg := add_lres_mth_avg;
		SELF.p_prop_name_addr_match := p_prop_name_addr_match;
		SELF.p_input_addr_probs := p_input_addr_probs;
		SELF.p_new_person_c6_3 := p_new_person_c6_3;
		SELF.p_subscore0 := p_subscore0;
		SELF.p_subscore1 := p_subscore1;
		SELF.p_subscore2 := p_subscore2;
		SELF.p_subscore3 := p_subscore3;
		SELF.p_subscore4 := p_subscore4;
		SELF.p_subscore5 := p_subscore5;
		SELF.p_subscore6 := p_subscore6;
		SELF.p_subscore7 := p_subscore7;
		SELF.p_subscore8 := p_subscore8;
		SELF.p_subscore9 := p_subscore9;
		SELF.p_subscore10 := p_subscore10;
		SELF.p_subscore11 := p_subscore11;
		SELF.p_subscore12 := p_subscore12;
		SELF.p_subscore13 := p_subscore13;
		SELF.p_subscore14 := p_subscore14;
		SELF.p_subscore15 := p_subscore15;
		SELF.p_subscore16 := p_subscore16;
		SELF.p_subscore17 := p_subscore17;
		SELF.p_subscore18 := p_subscore18;
		SELF.p_subscore19 := p_subscore19;
		SELF.ln_dead := ln_dead;
		SELF.prop_owner := prop_owner;
		SELF._segment := _segment;
		SELF.i_scaledscore := i_scaledscore;
		SELF.nd_scaledscore := nd_scaledscore;
		SELF.p_scaledscore := p_scaledscore;
		SELF.np_scaledscore := np_scaledscore;
		SELF._in := _in;
		SELF.rvc1110_1_1 := rvc1110_1_1;
		SELF.lien_flag := lien_flag;
		SELF.bk_flag := bk_flag;
		SELF.scored_222s := scored_222s;
		SELF.rvc1110_1 := rvc1110_1;
		SELF.ver_name := ver_name;
		SELF.ver_ssn := ver_ssn;
		SELF.ver_addr := ver_addr;
		SELF.glrc07 := glrc07;
		SELF.glrc25 := glrc25;
		SELF.glrc36 := glrc36;
		SELF.glrc78 := glrc78;
		SELF.glrc80 := glrc80;
		SELF.glrc97 := glrc97;
		SELF.glrc98 := glrc98;
		SELF.glrc99 := glrc99;
		SELF.glrc9a := glrc9a;
		SELF.glrc9b := glrc9b;
		SELF.glrc9c := glrc9c;
		SELF.glrc9d := glrc9d;
		SELF.glrc9e := glrc9e;
		SELF.glrc9f := glrc9f;
		SELF.glrc9g := glrc9g;
		SELF.glrc9m := glrc9m;
		SELF.glrc9u := glrc9u;
		SELF.glrc9w := glrc9w;
		SELF.glrcpv := glrcpv;
		SELF.glrcbl := glrcbl;
		SELF.rc1_2 := rc1_2;
		SELF.rc2_1 := rc2_1;
		SELF.rc3_1 := rc3_1;
		SELF.rc4_1 := rc4_1;
		SELF.rc5_1 := rc5_1;
		SELF.rcseginputs := rcseginputs;
		SELF.rcsegnondead := rcsegnondead;
		SELF.rcsegprop := rcsegprop;
		SELF.rcsegnon := rcsegnon;
		SELF.rcvalue07_1 := rcvalue07_1;
		SELF.rcvalue07 := rcvalue07;
		SELF.rcvalue25_1 := rcvalue25_1;
		SELF.rcvalue25_2 := rcvalue25_2;
		SELF.rcvalue25 := rcvalue25;
		SELF.rcvalue36_1 := rcvalue36_1;
		SELF.rcvalue36_2 := rcvalue36_2;
		SELF.rcvalue36_3 := rcvalue36_3;
		SELF.rcvalue36_4 := rcvalue36_4;
		SELF.rcvalue36_5 := rcvalue36_5;
		SELF.rcvalue36_6 := rcvalue36_6;
		SELF.rcvalue36_7 := rcvalue36_7;
		SELF.rcvalue36 := rcvalue36;
		SELF.rcvalue78_1 := rcvalue78_1;
		SELF.rcvalue78 := rcvalue78;
		SELF.rcvalue80_1 := rcvalue80_1;
		SELF.rcvalue80 := rcvalue80;
		SELF.rcvalue97_1 := rcvalue97_1;
		SELF.rcvalue97_2 := rcvalue97_2;
		SELF.rcvalue97_3 := rcvalue97_3;
		SELF.rcvalue97_4 := rcvalue97_4;
		SELF.rcvalue97 := rcvalue97;
		SELF.rcvalue98_1 := rcvalue98_1;
		SELF.rcvalue98_2 := rcvalue98_2;
		SELF.rcvalue98_3 := rcvalue98_3;
		SELF.rcvalue98_4 := rcvalue98_4;
		SELF.rcvalue98_5 := rcvalue98_5;
		SELF.rcvalue98_6 := rcvalue98_6;
		SELF.rcvalue98_7 := rcvalue98_7;
		SELF.rcvalue98_8 := rcvalue98_8;
		SELF.rcvalue98_9 := rcvalue98_9;
		SELF.rcvalue98 := rcvalue98;
		SELF.rcvalue99_1 := rcvalue99_1;
		SELF.rcvalue99_2 := rcvalue99_2;
		SELF.rcvalue99_3 := rcvalue99_3;
		SELF.rcvalue99 := rcvalue99;
		SELF.rcvalue9a_1 := rcvalue9a_1;
		SELF.rcvalue9a_2 := rcvalue9a_2;
		SELF.rcvalue9a_3 := rcvalue9a_3;
		SELF.rcvalue9a_4 := rcvalue9a_4;
		SELF.rcvalue9a := rcvalue9a;
		SELF.rcvalue9b_1 := rcvalue9b_1;
		SELF.rcvalue9b := rcvalue9b;
		SELF.rcvalue9c_1 := rcvalue9c_1;
		SELF.rcvalue9c_2 := rcvalue9c_2;
		SELF.rcvalue9c_3 := rcvalue9c_3;
		SELF.rcvalue9c_4 := rcvalue9c_4;
		SELF.rcvalue9c := rcvalue9c;
		SELF.rcvalue9d_1 := rcvalue9d_1;
		SELF.rcvalue9d_2 := rcvalue9d_2;
		SELF.rcvalue9d_3 := rcvalue9d_3;
		SELF.rcvalue9d_4 := rcvalue9d_4;
		SELF.rcvalue9d := rcvalue9d;
		SELF.rcvalue9e_1 := rcvalue9e_1;
		SELF.rcvalue9e_2 := rcvalue9e_2;
		SELF.rcvalue9e := rcvalue9e;
		SELF.rcvalue9f_1 := rcvalue9f_1;
		SELF.rcvalue9f_2 := rcvalue9f_2;
		SELF.rcvalue9f_3 := rcvalue9f_3;
		SELF.rcvalue9f_4 := rcvalue9f_4;
		SELF.rcvalue9f_5 := rcvalue9f_5;
		SELF.rcvalue9f_6 := rcvalue9f_6;
		SELF.rcvalue9f_7 := rcvalue9f_7;
		SELF.rcvalue9f := rcvalue9f;
		SELF.rcvalue9g_1 := rcvalue9g_1;
		SELF.rcvalue9g_2 := rcvalue9g_2;
		SELF.rcvalue9g := rcvalue9g;
		SELF.rcvalue9m_1 := rcvalue9m_1;
		SELF.rcvalue9m_2 := rcvalue9m_2;
		SELF.rcvalue9m_3 := rcvalue9m_3;
		SELF.rcvalue9m_4 := rcvalue9m_4;
		SELF.rcvalue9m_5 := rcvalue9m_5;
		SELF.rcvalue9m_6 := rcvalue9m_6;
		SELF.rcvalue9m := rcvalue9m;
		SELF.rcvalue9u_1 := rcvalue9u_1;
		SELF.rcvalue9u_2 := rcvalue9u_2;
		SELF.rcvalue9u := rcvalue9u;
		SELF.rcvalue9w_1 := rcvalue9w_1;
		SELF.rcvalue9w_2 := rcvalue9w_2;
		SELF.rcvalue9w_3 := rcvalue9w_3;
		SELF.rcvalue9w_4 := rcvalue9w_4;
		SELF.rcvalue9w_5 := rcvalue9w_5;
		SELF.rcvalue9w_6 := rcvalue9w_6;
		SELF.rcvalue9w_7 := rcvalue9w_7;
		SELF.rcvalue9w_8 := rcvalue9w_8;
		SELF.rcvalue9w := rcvalue9w;
		SELF.rcvaluepv_1 := rcvaluepv_1;
		SELF.rcvaluepv_2 := rcvaluepv_2;
		SELF.rcvaluepv_3 := rcvaluepv_3;
		SELF.rcvaluepv_4 := rcvaluepv_4;
		SELF.rcvaluepv := rcvaluepv;
		SELF.rcvaluebl_1 := rcvaluebl_1;
		SELF.rcvaluebl_2 := rcvaluebl_2;
		SELF.rcvaluebl_3 := rcvaluebl_3;
		SELF.rcvaluebl_4 := rcvaluebl_4;
		SELF.rcvaluebl := rcvaluebl;

		SELF.rc1 := reasons[1].hri;
		SELF.rc2 := reasons[2].hri;
		SELF.rc3 := reasons[3].hri;
		SELF.rc4 := reasons[4].hri;
		SELF.rc5 := reasons[5].hri;

		SELF.clam := le;
	#else
		SELF.ri := PROJECT(reasons, TRANSFORM(Risk_Indicators.Layout_Desc,
																							SELF.hri := LEFT.hri,
																							SELF.desc := Risk_Indicators.getHRIDesc(LEFT.hri)
																					));
		SELF.score := (STRING3)final_score;
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
