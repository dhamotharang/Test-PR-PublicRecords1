IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT RVC1112_0_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia = FALSE, BOOLEAN xmlPreScreenOptOut = FALSE) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;

			/* Model Input Variables */
			INTEGER adl_addr;
			INTEGER adl_hphn;
			INTEGER in_hphnpop;
			BOOLEAN truedid;
			STRING out_st;
			STRING in_dob;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING rc_hriskphoneflag;
			STRING rc_decsflag;
			STRING rc_bansflag;
			INTEGER combo_dobscore;
			STRING ver_sources;
			STRING ver_sources_first_seen;
			BOOLEAN addrpop;
			STRING ssnlength;
			BOOLEAN dobpop;
			BOOLEAN hphnpop;
			BOOLEAN add1_isbestmatch;
			INTEGER add1_avm_automated_valuation;
			BOOLEAN add1_family_owned;
			INTEGER add1_naprop;
			INTEGER property_owned_total;
			INTEGER property_owned_assessed_total;
			INTEGER property_sold_total;
			INTEGER addrs_15yr;
			STRING gong_did_first_seen;
			STRING gong_did_last_seen;
			STRING inputssncharflag;
			INTEGER ssns_per_adl;
			INTEGER addrs_per_adl;
			INTEGER addrs_per_ssn;
			INTEGER ssns_per_addr;
			INTEGER ssns_per_adl_c6;
			INTEGER inq_count12;
			INTEGER paw_dead_business_count;
			INTEGER paw_active_phone_count;
			INTEGER impulse_count;
			INTEGER attr_num_purchase90;
			INTEGER attr_num_purchase180;
			INTEGER attr_num_purchase12;
			INTEGER attr_num_purchase24;
			INTEGER attr_num_purchase36;
			INTEGER attr_num_purchase60;
			INTEGER attr_num_sold90;
			INTEGER attr_num_sold180;
			INTEGER attr_num_sold12;
			INTEGER attr_num_sold24;
			INTEGER attr_num_sold36;
			INTEGER attr_num_sold60;
			INTEGER attr_num_aircraft;
			INTEGER attr_num_unrel_liens30;
			INTEGER attr_num_unrel_liens90;
			INTEGER attr_num_unrel_liens180;
			INTEGER attr_num_unrel_liens12;
			INTEGER attr_num_unrel_liens24;
			INTEGER attr_num_unrel_liens36;
			INTEGER attr_num_unrel_liens60;
			INTEGER attr_bankruptcy_count12;
			INTEGER attr_eviction_count;
			INTEGER attr_num_nonderogs90;
			BOOLEAN bankrupt;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER liens_unrel_cj_ct;
			INTEGER criminal_count;
			INTEGER felony_count;
			INTEGER watercraft_count;
			STRING ams_college_code;
			STRING ams_college_type;
			STRING ams_college_tier;
			BOOLEAN prof_license_flag;
			STRING wealth_index;
			STRING input_dob_match_level;
			INTEGER inferred_age;
			INTEGER estimated_income;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			INTEGER in_dob2;
			INTEGER yr_in_dob_2;
			INTEGER gong_did_first_seen2;
			INTEGER mth_gong_did_first_seen_2;
			INTEGER gong_did_last_seen2;
			INTEGER mth_gong_did_last_seen_2;
			INTEGER ver_src_ba_pos;
			BOOLEAN ver_src_ba_2;
			INTEGER ver_src_ds_pos;
			BOOLEAN ver_src_ds_2;
			INTEGER ver_src_eq_pos;
			STRING ver_src_fdate_eq;
			INTEGER ver_src_fdate_eq2;
			INTEGER mth_ver_src_fdate_eq_2;
			INTEGER ver_src_l2_pos;
			BOOLEAN ver_src_l2_2;
			INTEGER ver_src_li_pos;
			BOOLEAN ver_src_li_2;
			INTEGER ver_src_p_pos;
			BOOLEAN ver_src_p_2;
			BOOLEAN ssn_adl_prob_2;
			BOOLEAN crime_felony_flag_2;
			BOOLEAN attr_eviction_flag_2;
			BOOLEAN phn_disconnected_2;
			INTEGER combined_age_2;
			BOOLEAN ssnpop_2;
			STRING out_st_region_2;
			BOOLEAN bk_flag_2;
			BOOLEAN lien_rec_unrel_flag_2;
			BOOLEAN lien_hist_unrel_flag_2;
			BOOLEAN lien_flag_2;
			BOOLEAN ssn_deceased_2;
			STRING _ams_college_type_2;
			STRING _ams_college_tier_2;
			INTEGER add1_avm_automated_valuation_2;
			INTEGER ssns_per_addr_2;
			STRING out_st_region_1;
			INTEGER attr_num_unrel_liens30_2;
			INTEGER attr_num_unrel_liens90_2;
			INTEGER attr_num_unrel_liens180_2;
			INTEGER attr_num_unrel_liens12_2;
			INTEGER attr_num_unrel_liens24_2;
			INTEGER attr_num_unrel_liens36_2;
			INTEGER attr_num_unrel_liens60_2;
			INTEGER attr_bankruptcy_count12_2;
			INTEGER attr_eviction_count_2;
			INTEGER bankrupt_2;
			INTEGER liens_recent_unreleased_count_2;
			INTEGER liens_historical_unreleased_ct_2;
			INTEGER liens_unrel_cj_ct_2;
			INTEGER criminal_count_2;
			INTEGER inq_count12_2;
			INTEGER impulse_count_2;
			INTEGER addrs_15yr_2;
			INTEGER attr_num_purchase90_2;
			INTEGER attr_num_purchase180_2;
			INTEGER attr_num_purchase12_2;
			INTEGER attr_num_purchase24_2;
			INTEGER attr_num_purchase36_2;
			INTEGER attr_num_purchase60_2;
			INTEGER attr_num_sold90_2;
			INTEGER attr_num_sold180_2;
			INTEGER attr_num_sold12_2;
			INTEGER attr_num_sold24_2;
			INTEGER attr_num_sold36_2;
			INTEGER attr_num_sold60_2;
			INTEGER attr_num_aircraft_2;
			INTEGER watercraft_count_2;
			INTEGER ssns_per_adl_2;
			INTEGER addrs_per_adl_2;
			STRING _ams_college_tier_1;
			STRING _ams_college_type_1;
			INTEGER paw_dead_business_count_2;
			INTEGER paw_active_phone_count_2;
			STRING ams_college_code_2;
			INTEGER prof_license_flag_2;
			STRING wealth_index_2;
			INTEGER estimated_income_2;
			INTEGER add1_isbestmatch_2;
			INTEGER attr_num_nonderogs90_2;
			INTEGER attr_eviction_flag_1;
			INTEGER crime_felony_flag_1;
			INTEGER ssn_adl_prob_1;
			INTEGER mth_ver_src_fdate_eq_1;
			INTEGER ver_src_p_1;
			INTEGER mth_gong_did_first_seen_1;
			INTEGER mth_gong_did_last_seen_1;
			INTEGER add1_family_owned_2;
			INTEGER add1_naprop_2;
			INTEGER property_owned_total_2;
			INTEGER property_owned_assessed_total_2;
			INTEGER property_sold_total_2;
			INTEGER combined_age_1;
			INTEGER nas_summary_2;
			INTEGER nap_summary_2;
			INTEGER phn_disconnected_1;
			INTEGER addrs_per_ssn_2;
			STRING inputssncharflag_2;
			INTEGER ssn_deceased_1;
			INTEGER ssnpop_1;
			INTEGER combo_dobscore_2;
			INTEGER lien_flag_1;
			INTEGER bk_flag_1;
			INTEGER add1_avm_automated_valuation_1;
			STRING out_st_region;
			INTEGER ssns_per_addr_1;
			INTEGER attr_num_sold24_1;
			STRING wealth_index_1;
			INTEGER impulse_count_1;
			INTEGER attr_num_purchase60_1;
			INTEGER attr_num_unrel_liens24_1;
			INTEGER inq_count12_1;
			STRING _ams_college_type;
			STRING _ams_college_tier;
			BOOLEAN scored_222s;
			INTEGER attr_num_unrel_liens180_1;
			INTEGER attr_num_nonderogs90_1;
			INTEGER attr_bankruptcy_count12_1;
			INTEGER mth_ver_src_fdate_eq;
			INTEGER criminal_count_1;
			INTEGER estimated_income_1;
			INTEGER attr_num_unrel_liens12_1;
			INTEGER attr_num_unrel_liens30_1;
			INTEGER combo_dobscore_1;
			INTEGER attr_eviction_flag;
			INTEGER attr_num_purchase90_1;
			INTEGER attr_eviction_count_1;
			INTEGER add1_isbestmatch_1;
			INTEGER ssn_adl_prob;
			STRING ams_college_code_1;
			INTEGER paw_dead_business_count_1;
			INTEGER mth_gong_did_last_seen;
			INTEGER attr_num_aircraft_1;
			INTEGER crime_felony_flag;
			INTEGER watercraft_count_1;
			INTEGER attr_num_sold60_1;
			INTEGER addrs_per_adl_1;
			INTEGER attr_num_unrel_liens36_1;
			INTEGER liens_recent_unreleased_count_1;
			INTEGER addrs_15yr_1;
			INTEGER attr_num_purchase12_1;
			INTEGER lien_flag;
			INTEGER attr_num_sold90_1;
			INTEGER ver_src_p;
			INTEGER attr_num_purchase24_1;
			INTEGER attr_num_purchase180_1;
			INTEGER prof_license_flag_1;
			INTEGER attr_num_purchase36_1;
			INTEGER attr_num_sold180_1;
			INTEGER attr_num_unrel_liens90_1;
			INTEGER liens_unrel_cj_ct_1;
			INTEGER paw_active_phone_count_1;
			INTEGER liens_historical_unreleased_ct_1;
			INTEGER attr_num_unrel_liens60_1;
			INTEGER attr_num_sold36_1;
			INTEGER ssns_per_adl_1;
			INTEGER bk_flag;
			INTEGER mth_gong_did_first_seen;
			INTEGER bankrupt_1;
			INTEGER attr_num_sold12_1;
			INTEGER property_owned_assessed_total_1;
			INTEGER property_sold_total_1;
			INTEGER property_owned_total_1;
			INTEGER add1_family_owned_1;
			INTEGER add1_naprop_1;
			INTEGER combined_age;
			INTEGER nas_summary_1;
			INTEGER phn_disconnected;
			INTEGER nap_summary_1;
			INTEGER ssnpop;
			INTEGER ssn_deceased;
			INTEGER addrs_per_ssn_1;
			STRING inputssncharflag_1;
			STRING _segment;
			BOOLEAN boat_plane_flag;
			BOOLEAN college_flag;
			INTEGER unreleased_lien_recency;
			INTEGER sold_recency;
			INTEGER purchase_recency;
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
			REAL p_subscore20;
			REAL p_subscore21;
			REAL p_subscore22;
			REAL p_scaledscore;
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
			REAL np_subscore16;
			REAL np_subscore17;
			REAL np_subscore18;
			REAL np_subscore19;
			REAL np_subscore20;
			REAL np_subscore21;
			REAL np_subscore22;
			REAL np_subscore23;
			REAL np_scaledscore;
			REAL _p_scaledscore;
			REAL _np_scaledscore;
			INTEGER rvc1112;
			BOOLEAN glrc07;
			BOOLEAN glrc73;
			BOOLEAN glrc97;
			BOOLEAN glrc98;
			BOOLEAN glrc99;
			BOOLEAN glrc9a;
			BOOLEAN glrc9d;
			BOOLEAN glrc9e;
			BOOLEAN glrc9f;
			BOOLEAN glrc9h;
			BOOLEAN glrc9i;
			BOOLEAN glrc9m;
			BOOLEAN glrc9q;
			BOOLEAN glrc9r;
			BOOLEAN glrc9v;
			BOOLEAN glrc9w;
			BOOLEAN glrcev;
			BOOLEAN glrcms;
			INTEGER glrcpv;
			INTEGER glrcbl;
			INTEGER rcsegprop;
			INTEGER rcsegnon;
			REAL rcvalue9r_1;
			REAL rcvalue9r_2;
			REAL rcvalue9r_3;
			REAL rcvalue9r_4;
			REAL rcvalue9r;
			REAL rcvalue99_1;
			REAL rcvalue99_2;
			REAL rcvalue99;
			REAL rcvalue98_1;
			REAL rcvalue98_2;
			REAL rcvalue98_3;
			REAL rcvalue98_4;
			REAL rcvalue98;
			REAL rcvalue9f_1;
			REAL rcvalue9f_2;
			REAL rcvalue9f;
			REAL rcvalue9w_1;
			REAL rcvalue9w;
			REAL rcvalue9q_1;
			REAL rcvalue9q_2;
			REAL rcvalue9q;
			REAL rcvaluems_1;
			REAL rcvaluems_2;
			REAL rcvaluems;
			REAL rcvalue9d_1;
			REAL rcvalue9d_2;
			REAL rcvalue9d_3;
			REAL rcvalue9d;
			REAL rcvalue9i_1;
			REAL rcvalue9i_2;
			REAL rcvalue9i;
			REAL rcvalue9h_1;
			REAL rcvalue9h_2;
			REAL rcvalue9h;
			REAL rcvalue9v_1;
			REAL rcvalue9v;
			REAL rcvalueev_1;
			REAL rcvalueev_2;
			REAL rcvalueev;
			REAL rcvalue97_1;
			REAL rcvalue97_2;
			REAL rcvalue97;
			REAL rcvalue9m_1;
			REAL rcvalue9m_2;
			REAL rcvalue9m_3;
			REAL rcvalue9m_4;
			REAL rcvalue9m_5;
			REAL rcvalue9m_6;
			REAL rcvalue9m;
			REAL rcvaluepv_1;
			REAL rcvaluepv_2;
			REAL rcvaluepv_3;
			REAL rcvaluepv;
			REAL rcvalue73_1;
			REAL rcvalue73;
			REAL rcvalue9a_1;
			INTEGER rcvalue9a_2;
			REAL rcvalue9a_3;
			REAL rcvalue9a;
			REAL rcvalue9e_1;
			REAL rcvalue9e;
			INTEGER rcvalue07_1;
			INTEGER rcvalue07;
			REAL rcvaluebl_1;
			REAL rcvaluebl_2;
			REAL rcvaluebl_3;
			REAL rcvaluebl_4;
			REAL rcvaluebl_5;
			REAL rcvaluebl;
      
			STRING rc1;
			STRING rc2;
			STRING rc3;
			STRING rc4;
			STRING rc5;
		END;
		Layout_Debug doModel(clam le) := TRANSFORM
	#else
		Layout_ModelOut doModel(clam le) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	adl_addr                         := le.adl_shell_flags.adl_addr;
	adl_hphn                         := le.adl_shell_flags.adl_hphn;
	in_hphnpop                       := le.adl_shell_flags.in_hphnpop;
	truedid                          := le.truedid;
	out_st                           := le.shell_input.st;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_hriskphoneflag                := le.iid.hriskphoneflag;
	rc_decsflag                      := le.iid.decsflag;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_first_seen           := le.header_summary.ver_sources_first_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	dobpop                           := le.input_validation.dateofbirth;
	hphnpop                          := le.input_validation.homephone;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_sold_total              := le.address_verification.sold.property_total;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
	inq_count12                      := le.acc_logs.inquiries.count12;
	paw_dead_business_count          := le.employment.dead_business_ct;
	paw_active_phone_count           := le.employment.business_active_phone_ct;
	impulse_count                    := le.impulse.count;
	attr_num_purchase90              := le.other_address_info.num_purchase90;
	attr_num_purchase180             := le.other_address_info.num_purchase180;
	attr_num_purchase12              := le.other_address_info.num_purchase12;
	attr_num_purchase24              := le.other_address_info.num_purchase24;
	attr_num_purchase36              := le.other_address_info.num_purchase36;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	attr_num_sold90                  := le.other_address_info.num_sold90;
	attr_num_sold180                 := le.other_address_info.num_sold180;
	attr_num_sold12                  := le.other_address_info.num_sold12;
	attr_num_sold24                  := le.other_address_info.num_sold24;
	attr_num_sold36                  := le.other_address_info.num_sold36;
	attr_num_sold60                  := le.other_address_info.num_sold60;
	attr_num_aircraft                := le.aircraft.aircraft_count;
	attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
	attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
	attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
	attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
	attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
	attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
	attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
	attr_bankruptcy_count12          := le.bjl.bk_count12;
	attr_eviction_count              := le.bjl.eviction_count;
	attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	watercraft_count                 := le.watercraft.watercraft_count;
	ams_college_code                 := le.student.college_code;
	ams_college_type                 := le.student.college_type;
	ams_college_tier                 := le.student.college_tier;
	prof_license_flag                := le.professional_license.professional_license_flag;
	wealth_index                     := le.wealth_indicator;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	estimated_income                 := le.estimated_income;
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	INTEGER positiveRoundUp (REAL value) := IF(ROUNDUP(value) < 0, 0, ROUNDUP(value));
	
	INTEGER year(integer sas_date) :=
		if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));
	
	sysdate := map(
	    trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
	    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
	                                                           NULL);
	
	in_dob2 := Common.SAS_Date((STRING)(in_dob));
	
	yr_in_dob_2 := if(min(sysdate, in_dob2) = NULL, NULL, positiveRoundUp((sysdate - in_dob2) / 365.25));
	
	gong_did_first_seen2 := Common.SAS_Date((STRING)(gong_did_first_seen));
	
	mth_gong_did_first_seen_2 := if(min(sysdate, gong_did_first_seen2) = NULL, NULL, positiveRoundUp((sysdate - gong_did_first_seen2) / 30.5));
	
	gong_did_last_seen2 := Common.SAS_Date((STRING)(gong_did_last_seen));
	
	mth_gong_did_last_seen_2 := if(min(sysdate, gong_did_last_seen2) = NULL, NULL, positiveRoundUp((sysdate - gong_did_last_seen2) / 30.5));
	
	ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');
	
	ver_src_ba_2 := ver_src_ba_pos > 0;
	
	ver_src_ds_pos := Models.Common.findw_cpp(ver_sources, 'DS' , '  ,', 'ie');
	
	ver_src_ds_2 := ver_src_ds_pos > 0;
	
	ver_src_eq_pos := Models.Common.findw_cpp(ver_sources, 'EQ' , '  ,', 'ie');
	
	ver_src_fdate_eq := if(ver_src_eq_pos > 0, Models.Common.getw(ver_sources_first_seen, ver_src_eq_pos), '0');
	
	ver_src_fdate_eq2 := Common.SAS_Date((STRING)(ver_src_fdate_eq));
	
	mth_ver_src_fdate_eq_2 := if(min(sysdate, ver_src_fdate_eq2) = NULL, NULL, positiveRoundUp((sysdate - ver_src_fdate_eq2) / 30.5));
	
	ver_src_l2_pos := Models.Common.findw_cpp(ver_sources, 'L2' , '  ,', 'ie');
	
	ver_src_l2_2 := ver_src_l2_pos > 0;
	
	ver_src_li_pos := Models.Common.findw_cpp(ver_sources, 'LI' , '  ,', 'ie');
	
	ver_src_li_2 := ver_src_li_pos > 0;
	
	ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');
	
	ver_src_p_2 := ver_src_p_pos > 0;
	
	ssn_adl_prob_2 := ssns_per_adl = 0 or ssns_per_adl >= 3 or ssns_per_adl_c6 >= 2;
	
	crime_felony_flag_2 := felony_count > 0;
	
	attr_eviction_flag_2 := attr_eviction_count > 0;
	
	phn_disconnected_2 := TRIM(rc_hriskphoneflag) = '5';
	
	combined_age_2 := if(truncate(yr_in_dob_2) > 0, truncate(yr_in_dob_2), inferred_age);
	
	ssnpop_2 := (INTEGER)TRIM(ssnlength) > 0;
	
	out_st_region_2 := map(
	    (out_st in ['IL', 'IN', 'MI', 'OH', 'WI', 'IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD'])                               => '1-Midwest',
	    (out_st in ['NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT'])                                                 => '2-Northeast',
	    (out_st in ['AL', 'KY', 'MS', 'TN', 'DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV', 'AR', 'LA', 'OK', 'TX']) => '3-South',
	    (out_st in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY', 'AK', 'CA', 'HI', 'OR', 'WA'])                         => '4-West',
	    (out_st in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI'])                                                       => '5-Island',
	    (out_st in ['AA', 'AE', 'AP'])                                                                                     => '6-Armed Forces',
	                                                                                                                          'Other');
	
	bk_flag_2 := (TRIM(rc_bansflag) in ['1', '2']) or 
                ver_src_ba_2 = TRUE or 
                bankrupt = TRUE or 
                filing_count > 0 or 
                bk_recent_count > 0;
	
	lien_rec_unrel_flag_2 := liens_recent_unreleased_count > 0;
	
	lien_hist_unrel_flag_2 := liens_historical_unreleased_ct > 0;
	
	lien_flag_2 := ver_src_l2_2 = TRUE or ver_src_li_2 = TRUE or lien_rec_unrel_flag_2 or lien_hist_unrel_flag_2;
	
	ssn_deceased_2 := TRIM(rc_decsflag) = '1' or ver_src_ds_2 = TRUE;
		
	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), 
                                if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR 
                                (90 <= combo_dobscore AND 
                                combo_dobscore <= 100 or 
                                (INTEGER)input_dob_match_level >= 7 or 
                                (INTEGER)lien_flag_2 > 0 or 
                                criminal_count > 0 or 
                                (INTEGER)bk_flag_2 > 0 or 
                                (INTEGER)ssn_deceased_2 > 0 or 
                                truedid);
																
	_segment := map(
	    (INTEGER)ssn_deceased_2 > 0                                                              => '0- 200',
	    riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) => '1 - 222',
	    add1_naprop = 4 OR property_owned_total > 0                                     => '2 - Prop',
	                                                                                       '3 - Nonprop');
	
	_ams_college_type_2 := TRIM(ams_college_type);
	
	_ams_college_tier_2 := TRIM(ams_college_tier);
	
	add1_avm_automated_valuation_2 := if(add1_avm_automated_valuation = NULL, -999, add1_avm_automated_valuation);
	
	ssns_per_addr_2 := if(ssns_per_addr = NULL, -999, ssns_per_addr);
	
	out_st_region_1 := if((INTEGER)out_st_region_2 = NULL, '-999', out_st_region_2);
	
	attr_num_unrel_liens30_2 := if(attr_num_unrel_liens30 = NULL, -999, attr_num_unrel_liens30);
	
	attr_num_unrel_liens90_2 := if(attr_num_unrel_liens90 = NULL, -999, attr_num_unrel_liens90);
	
	attr_num_unrel_liens180_2 := if(attr_num_unrel_liens180 = NULL, -999, attr_num_unrel_liens180);
	
	attr_num_unrel_liens12_2 := if(attr_num_unrel_liens12 = NULL, -999, attr_num_unrel_liens12);
	
	attr_num_unrel_liens24_2 := if(attr_num_unrel_liens24 = NULL, -999, attr_num_unrel_liens24);
	
	attr_num_unrel_liens36_2 := if(attr_num_unrel_liens36 = NULL, -999, attr_num_unrel_liens36);
	
	attr_num_unrel_liens60_2 := if(attr_num_unrel_liens60 = NULL, -999, attr_num_unrel_liens60);
	
	attr_bankruptcy_count12_2 := if(attr_bankruptcy_count12 = NULL, -999, attr_bankruptcy_count12);
	
	attr_eviction_count_2 := if(attr_eviction_count = NULL, -999, attr_eviction_count);
	
	bankrupt_2 := if((INTEGER)bankrupt = NULL, -999, (INTEGER)bankrupt);
	
	liens_recent_unreleased_count_2 := if(liens_recent_unreleased_count = NULL, -999, liens_recent_unreleased_count);
	
	liens_historical_unreleased_ct_2 := if(liens_historical_unreleased_ct = NULL, -999, liens_historical_unreleased_ct);
	
	liens_unrel_cj_ct_2 := if(liens_unrel_cj_ct = NULL, -999, liens_unrel_cj_ct);
	
	criminal_count_2 := if(criminal_count = NULL, -999, criminal_count);
	
	inq_count12_2 := if(inq_count12 = NULL, -999, inq_count12);
	
	impulse_count_2 := if(impulse_count = NULL, -999, impulse_count);
	
	addrs_15yr_2 := if(addrs_15yr = NULL, -999, addrs_15yr);
	
	attr_num_purchase90_2 := if(attr_num_purchase90 = NULL, -999, attr_num_purchase90);
	
	attr_num_purchase180_2 := if(attr_num_purchase180 = NULL, -999, attr_num_purchase180);
	
	attr_num_purchase12_2 := if(attr_num_purchase12 = NULL, -999, attr_num_purchase12);
	
	attr_num_purchase24_2 := if(attr_num_purchase24 = NULL, -999, attr_num_purchase24);
	
	attr_num_purchase36_2 := if(attr_num_purchase36 = NULL, -999, attr_num_purchase36);
	
	attr_num_purchase60_2 := if(attr_num_purchase60 = NULL, -999, attr_num_purchase60);
	
	attr_num_sold90_2 := if(attr_num_sold90 = NULL, -999, attr_num_sold90);
	
	attr_num_sold180_2 := if(attr_num_sold180 = NULL, -999, attr_num_sold180);
	
	attr_num_sold12_2 := if(attr_num_sold12 = NULL, -999, attr_num_sold12);
	
	attr_num_sold24_2 := if(attr_num_sold24 = NULL, -999, attr_num_sold24);
	
	attr_num_sold36_2 := if(attr_num_sold36 = NULL, -999, attr_num_sold36);
	
	attr_num_sold60_2 := if(attr_num_sold60 = NULL, -999, attr_num_sold60);
	
	attr_num_aircraft_2 := if(attr_num_aircraft = NULL, -999, attr_num_aircraft);
	
	watercraft_count_2 := if(watercraft_count = NULL, -999, watercraft_count);
	
	ssns_per_adl_2 := if(ssns_per_adl = NULL, -999, ssns_per_adl);
	
	addrs_per_adl_2 := if(addrs_per_adl = NULL, -999, addrs_per_adl);
	
	_ams_college_tier_1 := if(TRIM(_ams_college_tier_2) = '', '-999', _ams_college_tier_2);
	
	_ams_college_type_1 := if(TRIM(_ams_college_type_2) = '', '-999', _ams_college_type_2);
	
	paw_dead_business_count_2 := if(paw_dead_business_count = NULL, -999, paw_dead_business_count);
	
	paw_active_phone_count_2 := if(paw_active_phone_count = NULL, -999, paw_active_phone_count);
	
	ams_college_code_2 := if(TRIM(ams_college_code) = '', '-999', ams_college_code);
	
	prof_license_flag_2 := if((INTEGER)prof_license_flag = NULL, -999, (INTEGER)prof_license_flag);
	
	wealth_index_2 := if(TRIM(wealth_index) = '', '-999', wealth_index);
	
	estimated_income_2 := if(estimated_income = NULL, -999, estimated_income);
	
	add1_isbestmatch_2 := if((INTEGER)add1_isbestmatch = NULL, -999, (INTEGER)add1_isbestmatch);
	
	attr_num_nonderogs90_2 := if(attr_num_nonderogs90 = NULL, -999, attr_num_nonderogs90);
	
	attr_eviction_flag_1 := if((INTEGER)attr_eviction_flag_2 = NULL, -999, (INTEGER)attr_eviction_flag_2);
	
	crime_felony_flag_1 := if((INTEGER)crime_felony_flag_2 = NULL, -999, (INTEGER)crime_felony_flag_2);
	
	ssn_adl_prob_1 := if((INTEGER)ssn_adl_prob_2 = NULL, -999, (INTEGER)ssn_adl_prob_2);
	
	mth_ver_src_fdate_eq_1 := if(mth_ver_src_fdate_eq_2 = NULL, -999, mth_ver_src_fdate_eq_2);
	
	ver_src_p_1 := if((INTEGER)ver_src_p_2 = NULL, -999, (INTEGER)ver_src_p_2);
	
	mth_gong_did_first_seen_1 := if(mth_gong_did_first_seen_2 = NULL, -999, mth_gong_did_first_seen_2);
	
	mth_gong_did_last_seen_1 := if(mth_gong_did_last_seen_2 = NULL, -999, mth_gong_did_last_seen_2);
	
	add1_family_owned_2 := if((INTEGER)add1_family_owned = NULL, -999, (INTEGER)add1_family_owned);
	
	add1_naprop_2 := if(add1_naprop = NULL, -999, add1_naprop);
	
	property_owned_total_2 := if(property_owned_total = NULL, -999, property_owned_total);
	
	property_owned_assessed_total_2 := if(property_owned_assessed_total = NULL, -999, property_owned_assessed_total);
	
	property_sold_total_2 := if(property_sold_total = NULL, -999, property_sold_total);
	
	combined_age_1 := if(combined_age_2 = NULL, -999, combined_age_2);
	
	nas_summary_2 := if(nas_summary = NULL, -999, nas_summary);
	
	nap_summary_2 := if(nap_summary = NULL, -999, nap_summary);
	
	phn_disconnected_1 := if((INTEGER)phn_disconnected_2 = NULL, -999, (INTEGER)phn_disconnected_2);
	
	addrs_per_ssn_2 := if(addrs_per_ssn = NULL, -999, addrs_per_ssn);
	
	inputssncharflag_2 := if(TRIM(inputssncharflag) = '', '-999', inputssncharflag);
	
	ssn_deceased_1 := if((INTEGER)ssn_deceased_2 = NULL, -999, (INTEGER)ssn_deceased_2);
	
	ssnpop_1 := if((INTEGER)ssnpop_2 = NULL, -999, (INTEGER)ssnpop_2);
	
	combo_dobscore_2 := if(combo_dobscore = NULL, -999, combo_dobscore);
	
	lien_flag_1 := if((INTEGER)lien_flag_2 = NULL, -999, (INTEGER)lien_flag_2);
	
	bk_flag_1 := if((INTEGER)bk_flag_2 = NULL, -999, (INTEGER)bk_flag_2);
	
	add1_avm_automated_valuation_1 := if(not(addrpop), NULL, add1_avm_automated_valuation_2);
	
	out_st_region := if(not(addrpop), (STRING)NULL, out_st_region_1);
	
	ssns_per_addr_1 := if(not(addrpop), NULL, ssns_per_addr_2);
	
	attr_num_sold24_1 := if(not(truedid), NULL, attr_num_sold24_2);
	
	wealth_index_1 := if(not(truedid), (STRING)NULL, wealth_index_2);
	
	impulse_count_1 := if(not(truedid), NULL, impulse_count_2);
	
	attr_num_purchase60_1 := if(not(truedid), NULL, attr_num_purchase60_2);
	
	attr_num_unrel_liens24_1 := if(not(truedid), NULL, attr_num_unrel_liens24_2);
	
	inq_count12_1 := if(not(truedid), NULL, inq_count12_2);
	
	_ams_college_type := if(not(truedid), (STRING)NULL, _ams_college_type_1);
	
	_ams_college_tier := if(not(truedid), (STRING)NULL, _ams_college_tier_1);
	
	attr_num_unrel_liens180_1 := if(not(truedid), NULL, attr_num_unrel_liens180_2);
	
	attr_num_nonderogs90_1 := if(not(truedid), NULL, attr_num_nonderogs90_2);
	
	attr_bankruptcy_count12_1 := if(not(truedid), NULL, attr_bankruptcy_count12_2);
	
	mth_ver_src_fdate_eq := if(not(truedid), NULL, mth_ver_src_fdate_eq_1);
	
	criminal_count_1 := if(not(truedid), NULL, criminal_count_2);
	
	estimated_income_1 := if(not(truedid), NULL, estimated_income_2);
	
	attr_num_unrel_liens12_1 := if(not(truedid), NULL, attr_num_unrel_liens12_2);
	
	attr_num_unrel_liens30_1 := if(not(truedid), NULL, attr_num_unrel_liens30_2);
	
	combo_dobscore_1 := if(not(truedid), NULL, combo_dobscore_2);
	
	attr_eviction_flag := if(not(truedid), NULL, attr_eviction_flag_1);
	
	attr_num_purchase90_1 := if(not(truedid), NULL, attr_num_purchase90_2);
	
	attr_eviction_count_1 := if(not(truedid), NULL, attr_eviction_count_2);
	
	add1_isbestmatch_1 := if(not(truedid), NULL, add1_isbestmatch_2);
	
	ssn_adl_prob := if(not(truedid), NULL, ssn_adl_prob_1);
	
	ams_college_code_1 := if(not(truedid), (STRING)NULL, ams_college_code_2);
	
	paw_dead_business_count_1 := if(not(truedid), NULL, paw_dead_business_count_2);
	
	mth_gong_did_last_seen := if(not(truedid), NULL, mth_gong_did_last_seen_1);
	
	attr_num_aircraft_1 := if(not(truedid), NULL, attr_num_aircraft_2);
	
	crime_felony_flag := if(not(truedid), NULL, crime_felony_flag_1);
	
	watercraft_count_1 := if(not(truedid), NULL, watercraft_count_2);
	
	attr_num_sold60_1 := if(not(truedid), NULL, attr_num_sold60_2);
	
	addrs_per_adl_1 := if(not(truedid), NULL, addrs_per_adl_2);
	
	attr_num_unrel_liens36_1 := if(not(truedid), NULL, attr_num_unrel_liens36_2);
	
	liens_recent_unreleased_count_1 := if(not(truedid), NULL, liens_recent_unreleased_count_2);
	
	addrs_15yr_1 := if(not(truedid), NULL, addrs_15yr_2);
	
	attr_num_purchase12_1 := if(not(truedid), NULL, attr_num_purchase12_2);
	
	lien_flag := if(not(truedid), NULL, lien_flag_1);
	
	attr_num_sold90_1 := if(not(truedid), NULL, attr_num_sold90_2);
	
	ver_src_p := if(not(truedid), NULL, ver_src_p_1);
	
	attr_num_purchase24_1 := if(not(truedid), NULL, attr_num_purchase24_2);
	
	attr_num_purchase180_1 := if(not(truedid), NULL, attr_num_purchase180_2);
	
	prof_license_flag_1 := if(not(truedid), NULL, prof_license_flag_2);
	
	attr_num_purchase36_1 := if(not(truedid), NULL, attr_num_purchase36_2);
	
	attr_num_sold180_1 := if(not(truedid), NULL, attr_num_sold180_2);
	
	attr_num_unrel_liens90_1 := if(not(truedid), NULL, attr_num_unrel_liens90_2);
	
	liens_unrel_cj_ct_1 := if(not(truedid), NULL, liens_unrel_cj_ct_2);
	
	paw_active_phone_count_1 := if(not(truedid), NULL, paw_active_phone_count_2);
	
	liens_historical_unreleased_ct_1 := if(not(truedid), NULL, liens_historical_unreleased_ct_2);
	
	attr_num_unrel_liens60_1 := if(not(truedid), NULL, attr_num_unrel_liens60_2);
	
	attr_num_sold36_1 := if(not(truedid), NULL, attr_num_sold36_2);
	
	ssns_per_adl_1 := if(not(truedid), NULL, ssns_per_adl_2);
	
	bk_flag := if(not(truedid), NULL, bk_flag_1);
	
	mth_gong_did_first_seen := if(not(truedid), NULL, mth_gong_did_first_seen_1);
	
	bankrupt_1 := if(not(truedid), NULL, bankrupt_2);
	
	attr_num_sold12_1 := if(not(truedid), NULL, attr_num_sold12_2);
	
	property_owned_assessed_total_1 := if(not(truedid or addrpop), NULL, property_owned_assessed_total_2);
	
	property_sold_total_1 := if(not(truedid or addrpop), NULL, property_sold_total_2);
	
	property_owned_total_1 := if(not(truedid or addrpop), NULL, property_owned_total_2);
	
	add1_family_owned_1 := if(not(truedid or addrpop), NULL, add1_family_owned_2);
	
	add1_naprop_1 := if(not(truedid or addrpop), NULL, add1_naprop_2);
	
	combined_age := if(not(truedid and dobpop), NULL, combined_age_1);
	
	nas_summary_1 := if(not(truedid or TRIM(ssnlength) = '9'), NULL, nas_summary_2);
	
	phn_disconnected := if(not(hphnpop or addrpop), NULL, phn_disconnected_1);
	
	nap_summary_1 := if(not(hphnpop or addrpop), NULL, nap_summary_2);
	
	ssnpop := if(not(TRIM(ssnlength) = '9'), NULL, ssnpop_1);
	
	ssn_deceased := if(not(TRIM(ssnlength) = '9'), NULL, ssn_deceased_1);
	
	addrs_per_ssn_1 := if(not(TRIM(ssnlength) = '9'), NULL, addrs_per_ssn_2);
		
	inputssncharflag_1 := if(not(TRIM(ssnlength) = '9'), (STRING)NULL, inputssncharflag_2);
		
	boat_plane_flag := attr_num_aircraft_1 > 0 OR watercraft_count_1 > 0;
	
	college_flag := ams_college_code_1 != '-999' OR _ams_college_tier != '-999' OR _ams_college_type != '-999';
	
	unreleased_lien_recency := map(
	    attr_num_unrel_liens30_1 > 0         => 30,
	    attr_num_unrel_liens90_1 > 0         => 90,
	    attr_num_unrel_liens180_1 > 0        => 180,
	    attr_num_unrel_liens12_1 > 0         => 12,
	    attr_num_unrel_liens24_1 > 0         => 24,
	    attr_num_unrel_liens36_1 > 0         => 36,
	    attr_num_unrel_liens60_1 > 0         => 60,
	    liens_historical_unreleased_ct_1 > 0 => 999,
	                                            0);
	
	sold_recency := map(
	    attr_num_sold90_1 > 0     => 90,
	    attr_num_sold180_1 > 0    => 180,
	    attr_num_sold12_1 > 0     => 12,
	    attr_num_sold24_1 > 0     => 24,
	    attr_num_sold36_1 > 0     => 36,
	    attr_num_sold60_1 > 0     => 60,
	    property_sold_total_1 > 0 => 999,
	                                 0);
	
	purchase_recency := map(
	    attr_num_purchase90_1 > 0  => 90,
	    attr_num_purchase180_1 > 0 => 180,
	    attr_num_purchase12_1 > 0  => 12,
	    attr_num_purchase24_1 > 0  => 24,
	    attr_num_purchase36_1 > 0  => 36,
	    attr_num_purchase60_1 > 0  => 60,
	    property_owned_total_1 > 0 => 999,
	                                  0);
	
	p_subscore0 := map(
	    NULL < mth_ver_src_fdate_eq AND mth_ver_src_fdate_eq < 0   => 33.315183,
	    0 <= mth_ver_src_fdate_eq AND mth_ver_src_fdate_eq < 208   => 21.277338,
	    208 <= mth_ver_src_fdate_eq AND mth_ver_src_fdate_eq < 265 => 31.356696,
	    265 <= mth_ver_src_fdate_eq AND mth_ver_src_fdate_eq < 319 => 39.769728,
	    319 <= mth_ver_src_fdate_eq                                => 47.178756,
	                                                                  33.315183);
	
	p_subscore1 := map(
	    NULL < paw_dead_business_count_1 AND paw_dead_business_count_1 < 1 => 35.588698,
	    1 <= paw_dead_business_count_1                                     => 6.441955,
	                                                                          33.315183);
	
	p_subscore2 := map(
	    (adl_addr in [0, 1, 3]) => 22.607798,
	    (adl_addr in [2])       => 38.220623,
	                               33.315183);
	
	p_subscore3 := map(
	    NULL < mth_gong_did_last_seen AND mth_gong_did_last_seen < 0 => 33.315183,
	    0 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 1   => 41.525604,
	    1 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 8   => 29.680816,
	    8 <= mth_gong_did_last_seen                                  => 21.373516,
	                                                                    33.315183);
	
	p_subscore4 := map(
	    (unreleased_lien_recency in [30, 90])      => -1.026939,
	    (unreleased_lien_recency in [12, 180])     => 23.316435,
	    (unreleased_lien_recency in [24])          => 35.024618,
	    (unreleased_lien_recency in [36, 60, 999]) => 35.082760,
	    (unreleased_lien_recency in [0])           => 35.572054,
	                                                  33.315183);
	
	p_subscore5 := map(
	    (sold_recency in [12, 24, 36, 90, 180]) => 22.980985,
	    (sold_recency in [60])                  => 26.822897,
	    (sold_recency in [0, 999])              => 34.892613,
	                                               33.315183);
	
	p_subscore6 := map(
	    NULL < attr_bankruptcy_count12_1 AND attr_bankruptcy_count12_1 < 1 => 34.798099,
	    1 <= attr_bankruptcy_count12_1                                     => -26.564142,
	                                                                          33.315183);
	
	p_subscore7 := map(
	    NULL < inq_count12_1 AND inq_count12_1 < 1 => 34.888942,
	    1 <= inq_count12_1                         => 9.209032,
	                                                  33.315183);
	
	p_subscore8 := map(
	    NULL < liens_unrel_cj_ct_1 AND liens_unrel_cj_ct_1 < 1 => 37.404255,
	    1 <= liens_unrel_cj_ct_1                               => 15.955246,
	                                                              33.315183);
	
	p_subscore9 := map(
	    ((INTEGER)ssn_adl_prob in [0]) => 34.906695,
	    ((INTEGER)ssn_adl_prob in [1]) => 20.546869,
	                             33.315183);
	
	p_subscore10 := map(
	    NULL < addrs_per_adl_1 AND addrs_per_adl_1 < 4 => 37.422127,
	    4 <= addrs_per_adl_1 AND addrs_per_adl_1 < 9   => 34.900777,
	    9 <= addrs_per_adl_1 AND addrs_per_adl_1 < 16  => 34.444631,
	    16 <= addrs_per_adl_1 AND addrs_per_adl_1 < 20 => 23.652048,
	    20 <= addrs_per_adl_1                          => 21.974231,
	                                                      33.315183);
	
	p_subscore11 := map(
	    (purchase_recency in [12, 90, 180])     => 56.220530,
	    (purchase_recency in [24, 36, 60, 999]) => 32.282238,
	    (purchase_recency in [0])               => 32.267109,
	                                               33.315183);
	
	p_subscore12 := map(
	    ((INTEGER)college_flag in [0]) => 32.234291,
	    ((INTEGER)college_flag in [1]) => 49.756576,
	                             33.315183);
	
	p_subscore13 := map(
	    NULL < impulse_count_1 AND impulse_count_1 < 1 => 33.938523,
	    1 <= impulse_count_1                           => 2.942166,
	                                                      33.315183);
	
	p_subscore14 := map(
	    (inputssncharflag_1 in ['0'])                     => 34.411240,
	    (inputssncharflag_1 in ['1', '2', '3', '4', '5']) => 21.402016,
	                                                         33.315183);
	
	p_subscore15 := map(
	    NULL < attr_eviction_count_1 AND attr_eviction_count_1 < 1 => 34.451541,
	    1 <= attr_eviction_count_1                                 => 14.563816,
	                                                                  33.315183);
	
	p_subscore16 := map(
	    ((INTEGER)crime_felony_flag in [0]) => 33.614201,
	    ((INTEGER)crime_felony_flag in [1]) => -15.788231,
	                                  33.315183);
	
	p_subscore17 := map(
	    ((INTEGER)boat_plane_flag in [0]) => 32.342663,
	    ((INTEGER)boat_plane_flag in [1]) => 52.931514,
	                                33.315183);
	
	p_subscore18 := map(
	    (wealth_index_1 in ['0'])      => 33.315183,
	    (wealth_index_1 in ['1', '2']) => 21.862916,
	    (wealth_index_1 in ['3'])      => 22.195370,
	    (wealth_index_1 in ['4'])      => 32.816999,
	    (wealth_index_1 in ['5', '6']) => 48.089161,
	                                      33.315183);
	
	p_subscore19 := map(
	    NULL < property_owned_assessed_total_1 AND property_owned_assessed_total_1 <= 0        => 33.315183,
	    0 < property_owned_assessed_total_1 AND property_owned_assessed_total_1 < 70230        => 22.302763,
	    70230 <= property_owned_assessed_total_1 AND property_owned_assessed_total_1 < 203357  => 33.788946,
	    203357 <= property_owned_assessed_total_1 AND property_owned_assessed_total_1 < 341590 => 34.485783,
	    341590 <= property_owned_assessed_total_1                                              => 43.446605,
	                                                                                              33.315183);
	
	p_subscore20 := map(
	    (prof_license_flag_1 in [0]) => 32.422742,
	    (prof_license_flag_1 in [1]) => 42.331088,
	                                    33.315183);
	
	p_subscore21 := map(
	    NULL < add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 <= 0        => 33.315183,
	    0 < add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 < 113307       => 31.021721,
	    113307 <= add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 < 208330 => 32.073581,
	    208330 <= add1_avm_automated_valuation_1                                             => 36.471282,
	                                                                                            33.315183);
	
	p_subscore22 := map(
	    NULL < estimated_income_1 AND estimated_income_1 <= 0      => 33.315183,
	    0 < estimated_income_1 AND estimated_income_1 < 27000      => 18.650544,
	    27000 <= estimated_income_1 AND estimated_income_1 < 30000 => 28.553867,
	    30000 <= estimated_income_1 AND estimated_income_1 < 38000 => 34.992437,
	    38000 <= estimated_income_1                                => 35.481581,
	                                                                  33.315183);
	
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
	    p_subscore19 +
	    p_subscore20 +
	    p_subscore21 +
	    p_subscore22;
	
	np_subscore0 := map(
	    (adl_hphn in [1]) => -20.535066,
	    (adl_hphn in [0]) => 30.220977,
	    (adl_hphn in [3]) => 42.683618,
	    (adl_hphn in [2]) => 43.010472,
	                         30.712973);
	
	np_subscore1 := map(
	    NULL < liens_unrel_cj_ct_1 AND liens_unrel_cj_ct_1 < 1 => 36.381208,
	    1 <= liens_unrel_cj_ct_1 AND liens_unrel_cj_ct_1 < 2   => 25.170806,
	    2 <= liens_unrel_cj_ct_1 AND liens_unrel_cj_ct_1 < 3   => 4.668856,
	    3 <= liens_unrel_cj_ct_1                               => -5.350317,
	                                                              30.712973);
	
	np_subscore2 := map(
	    ((INTEGER)college_flag in [0]) => 28.980246,
	    ((INTEGER)college_flag in [1]) => 51.805941,
	                             30.712973);
	
	np_subscore3 := map(
	    (out_st_region in ['Other'])               => 30.712973,
	    (out_st_region in ['2-Northeast'])         => 43.779091,
	    (out_st_region in ['1-Midwest'])           => 41.680513,
	    (out_st_region in ['4-West'])              => 33.240378,
	    (out_st_region in ['3-South', '5-Island']) => 25.926389,
	    (out_st_region in ['6-Armed Forces'])      => 30.712973,
	                                                  30.712973);
	
	np_subscore4 := map(
	    NULL < mth_gong_did_last_seen AND mth_gong_did_last_seen < 0 => 30.712973,
	    0 <= mth_gong_did_last_seen AND mth_gong_did_last_seen < 1   => 41.723101,
	    1 <= mth_gong_did_last_seen                                  => 23.579250,
	                                                                    30.712973);
	
	np_subscore5 := map(
	    (adl_addr in [0, 1, 3]) => 23.676100,
	    (adl_addr in [2])       => 36.326501,
	                               30.712973);
	
	np_subscore6 := map(
	    (unreleased_lien_recency in [30, 90, 180]) => 20.494681,
	    (unreleased_lien_recency in [12, 24])      => 20.742654,
	    (unreleased_lien_recency in [36, 60])      => 23.959798,
	    (unreleased_lien_recency in [999])         => 32.193933,
	    (unreleased_lien_recency in [0])           => 33.779732,
	                                                  30.712973);
	
	np_subscore7 := map(
	    NULL < addrs_per_ssn_1 AND addrs_per_ssn_1 < 3 => 40.532556,
	    3 <= addrs_per_ssn_1 AND addrs_per_ssn_1 < 4   => 31.830664,
	    4 <= addrs_per_ssn_1 AND addrs_per_ssn_1 < 5   => 31.366876,
	    5 <= addrs_per_ssn_1 AND addrs_per_ssn_1 < 6   => 30.886492,
	    6 <= addrs_per_ssn_1 AND addrs_per_ssn_1 < 9   => 30.536011,
	    9 <= addrs_per_ssn_1                           => 25.617553,
	                                                      30.712973);
	
	np_subscore8 := map(
	    NULL < ssns_per_adl_1 AND ssns_per_adl_1 < 1 => 30.712973,
	    1 <= ssns_per_adl_1 AND ssns_per_adl_1 < 2   => 33.448107,
	    2 <= ssns_per_adl_1                          => 24.110148,
	                                                    30.712973);
	
	np_subscore9 := map(
	    (add1_family_owned_1 in [0]) => 29.113480,
	    (add1_family_owned_1 in [1]) => 39.776780,
	                                    30.712973);
	
	np_subscore10 := map(
	    NULL < ssns_per_addr_1 AND ssns_per_addr_1 < 2 => 38.968745,
	    2 <= ssns_per_addr_1 AND ssns_per_addr_1 < 4   => 41.253804,
	    4 <= ssns_per_addr_1 AND ssns_per_addr_1 < 8   => 34.008861,
	    8 <= ssns_per_addr_1 AND ssns_per_addr_1 < 15  => 26.624311,
	    15 <= ssns_per_addr_1 AND ssns_per_addr_1 < 17 => 26.550309,
	    17 <= ssns_per_addr_1 AND ssns_per_addr_1 < 33 => 23.561598,
	    33 <= ssns_per_addr_1                          => 23.449098,
	                                                      30.712973);
	
	np_subscore11 := map(
	    NULL < attr_num_nonderogs90_1 AND attr_num_nonderogs90_1 < 1 => 12.910832,
	    1 <= attr_num_nonderogs90_1 AND attr_num_nonderogs90_1 < 2   => 28.642892,
	    2 <= attr_num_nonderogs90_1 AND attr_num_nonderogs90_1 < 3   => 34.465166,
	    3 <= attr_num_nonderogs90_1                                  => 35.454592,
	                                                                    30.712973);
	
	np_subscore12 := map(
	    ((INTEGER)ver_src_p in [0]) => 28.645856,
	    ((INTEGER)ver_src_p in [1]) => 42.038039,
	                          30.712973);
	
	np_subscore13 := map(
	    NULL < impulse_count_1 AND impulse_count_1 < 1 => 31.706679,
	    1 <= impulse_count_1                           => 11.886893,
	                                                      30.712973);
	
	np_subscore14 := map(
	    NULL < mth_gong_did_first_seen AND mth_gong_did_first_seen < 0 => 30.712973,
	    0 <= mth_gong_did_first_seen AND mth_gong_did_first_seen < 36  => 25.409761,
	    36 <= mth_gong_did_first_seen AND mth_gong_did_first_seen < 42 => 28.255035,
	    42 <= mth_gong_did_first_seen                                  => 34.251972,
	                                                                      30.712973);
	
	np_subscore15 := map(
	    NULL < addrs_15yr_1 AND addrs_15yr_1 < 2 => 40.953052,
	    2 <= addrs_15yr_1 AND addrs_15yr_1 < 3   => 30.450316,
	    3 <= addrs_15yr_1 AND addrs_15yr_1 < 4   => 30.275070,
	    4 <= addrs_15yr_1 AND addrs_15yr_1 < 8   => 29.591840,
	    8 <= addrs_15yr_1 AND addrs_15yr_1 < 12  => 28.748761,
	    12 <= addrs_15yr_1                       => 28.546375,
	                                                30.712973);
	
	np_subscore16 := map(
	    ((INTEGER)crime_felony_flag in [0]) => 30.953574,
	    ((INTEGER)crime_felony_flag in [1]) => 9.565615,
	                                  30.712973);
	
	np_subscore17 := map(
	    NULL < paw_active_phone_count_1 AND paw_active_phone_count_1 < 1 => 30.106554,
	    1 <= paw_active_phone_count_1                                    => 64.804436,
	                                                                        30.712973);
	
	np_subscore18 := map(
	    NULL < estimated_income_1 AND estimated_income_1 <= 0      => 30.712973,
	    0 < estimated_income_1 AND estimated_income_1 < 23000      => 20.378797,
	    23000 <= estimated_income_1 AND estimated_income_1 < 25000 => 28.684414,
	    25000 <= estimated_income_1 AND estimated_income_1 < 28000 => 28.939069,
	    28000 <= estimated_income_1 AND estimated_income_1 < 31000 => 33.397429,
	    31000 <= estimated_income_1 AND estimated_income_1 < 36000 => 34.190256,
	    36000 <= estimated_income_1                                => 37.677750,
	                                                                  30.712973);
	
	np_subscore19 := map(
	    NULL < inq_count12_1 AND inq_count12_1 < 1 => 31.420910,
	    1 <= inq_count12_1                         => 23.520234,
	                                                  30.712973);
	
	np_subscore20 := map(
	    (wealth_index_1 in ['0'])           => 30.712973,
	    (wealth_index_1 in ['1'])           => 15.868555,
	    (wealth_index_1 in ['2'])           => 29.906030,
	    (wealth_index_1 in ['3'])           => 32.938450,
	    (wealth_index_1 in ['4', '5', '6']) => 35.682679,
                                             30.712973);
	
	np_subscore21 := map(
	    NULL < add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 <= 0        => 30.712973,
	    0 < add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 < 63852        => 17.422567,
	    63852 <= add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 < 89320   => 29.701929,
	    89320 <= add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 < 189228  => 30.746462,
	    189228 <= add1_avm_automated_valuation_1 AND add1_avm_automated_valuation_1 < 233026 => 30.909035,
	    233026 <= add1_avm_automated_valuation_1                                             => 38.176983,
	                                                                                            30.712973);
	
	np_subscore22 := map(
	    ((INTEGER)attr_eviction_flag in [0]) => 31.464159,
	    ((INTEGER)attr_eviction_flag in [1]) => 25.416469,
	                                   30.712973);
	
	np_subscore23 := map(
	    ((INTEGER)boat_plane_flag in [0]) => 30.400419,
	    ((INTEGER)boat_plane_flag in [1]) => 50.912507,
	                                30.712973);
	
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
	    np_subscore15 +
	    np_subscore16 +
	    np_subscore17 +
	    np_subscore18 +
	    np_subscore19 +
	    np_subscore20 +
	    np_subscore21 +
	    np_subscore22 +
	    np_subscore23;
	
	_p_scaledscore := if(phn_disconnected > 0, p_scaledscore - 4, p_scaledscore);
	
	_np_scaledscore := if(phn_disconnected > 0, np_scaledscore - 4, np_scaledscore);
	
	rvc1112 := map(
	    _segment = '0- 200'   => 200,
	    _segment = '1 - 222'   => 222,
	    _segment = '2 - Prop'  => min(if(max(round(_p_scaledscore), 501) = NULL, -NULL, max(round(_p_scaledscore), 501)), 900),
	                              min(if(max(round(_np_scaledscore), 501) = NULL, -NULL, max(round(_np_scaledscore), 501)), 900));
	
	glrc07 := in_hphnpop > 0;
	
	glrc73 := in_hphnpop > 0 and adl_hphn = 0;
	
	glrc97 := criminal_count_1 > 0;
	
	glrc98 := liens_recent_unreleased_count_1 > 0 or liens_historical_unreleased_ct_1 > 0;
	
	glrc99 := add1_isbestmatch_1 = 0 OR (adl_addr in [0, 1, 3]);
	
	glrc9a := NOT(property_owned_total_1 > 0 OR (add1_naprop_1 = 4 or add1_family_owned_1 = 1));
	
	glrc9d := addrs_15yr_1 > 0;
	
	glrc9e := truedid = TRUE;
	
	glrc9f := truedid = TRUE;
	
	glrc9h := impulse_count_1 > 0;
	
	glrc9i := 18 <= combined_age AND combined_age <= 35;
	
	glrc9m := (INTEGER)wealth_index_1 < 6;
	
	glrc9q := inq_count12_1 > 0;
	
	glrc9r := truedid = TRUE;
	
	glrc9v := ssnpop > 0;
	
	glrc9w := bankrupt_1 > 0;
	
	glrcev := attr_eviction_count_1 > 0;
	
	glrcms := ssns_per_adl_1 >= 2;
	
	glrcpv := 1;
	
	glrcbl := 0;
	
	rcsegprop := if(_segment = '2 - Prop', 1, 0);
	
	rcsegnon := if(_segment = '3 - Nonprop', 1, 0);
	
	rcvalue9r_1 := rcsegprop * (47.178756 - p_subscore0);
	
	rcvalue9r_2 := rcsegprop * (35.588698 - p_subscore1);
	
	rcvalue9r_3 := rcsegnon * (34.251972 - np_subscore14);
	
	rcvalue9r_4 := rcsegnon * (64.804436 - np_subscore17);
	
	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1, rcvalue9r_2, rcvalue9r_3, rcvalue9r_4) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1), if(rcvalue9r_2 = NULL, 0, rcvalue9r_2), if(rcvalue9r_3 = NULL, 0, rcvalue9r_3), if(rcvalue9r_4 = NULL, 0, rcvalue9r_4)));
	
	rcvalue99_1 := rcsegprop * (38.220623 - p_subscore2);
	
	rcvalue99_2 := rcsegnon * (36.326501 - np_subscore5);
	
	rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1, rcvalue99_2) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1), if(rcvalue99_2 = NULL, 0, rcvalue99_2)));
	
	rcvalue98_1 := rcsegprop * (35.572054 - p_subscore4);
	
	rcvalue98_2 := rcsegprop * (37.404255 - p_subscore8);
	
	rcvalue98_3 := rcsegnon * (36.381208 - np_subscore1);
	
	rcvalue98_4 := rcsegnon * (33.779732 - np_subscore6);
	
	rcvalue98 := (integer)glrc98 * if(max(rcvalue98_1, rcvalue98_2, rcvalue98_3, rcvalue98_4) = NULL, NULL, sum(if(rcvalue98_1 = NULL, 0, rcvalue98_1), if(rcvalue98_2 = NULL, 0, rcvalue98_2), if(rcvalue98_3 = NULL, 0, rcvalue98_3), if(rcvalue98_4 = NULL, 0, rcvalue98_4)));
	
	rcvalue9f_1 := rcsegprop * (41.525604 - p_subscore3);
	
	rcvalue9f_2 := rcsegnon * (41.723101 - np_subscore4);
	
	rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1, rcvalue9f_2) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1), if(rcvalue9f_2 = NULL, 0, rcvalue9f_2)));
	
	rcvalue9w_1 := rcsegprop * (34.798099 - p_subscore6);
	
	rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1)));
	
	rcvalue9q_1 := rcsegprop * (34.888942 - p_subscore7);
	
	rcvalue9q_2 := rcsegnon * (31.420910 - np_subscore19);
	
	rcvalue9q := (integer)glrc9q * if(max(rcvalue9q_1, rcvalue9q_2) = NULL, NULL, sum(if(rcvalue9q_1 = NULL, 0, rcvalue9q_1), if(rcvalue9q_2 = NULL, 0, rcvalue9q_2)));
	
	rcvaluems_1 := rcsegprop * (34.906695 - p_subscore9);
	
	rcvaluems_2 := rcsegnon * (33.448107 - np_subscore8);
	
	rcvaluems := (integer)glrcms * if(max(rcvaluems_1, rcvaluems_2) = NULL, NULL, sum(if(rcvaluems_1 = NULL, 0, rcvaluems_1), if(rcvaluems_2 = NULL, 0, rcvaluems_2)));
	
	rcvalue9d_1 := rcsegprop * (37.422127 - p_subscore10);
	
	rcvalue9d_2 := rcsegnon * (40.532556 - np_subscore7);
	
	rcvalue9d_3 := rcsegnon * (40.953052 - np_subscore15);
	
	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2, rcvalue9d_3) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2), if(rcvalue9d_3 = NULL, 0, rcvalue9d_3)));
	
	rcvalue9i_1 := rcsegprop * (49.756576 - p_subscore12);
	
	rcvalue9i_2 := rcsegnon * (51.805941 - np_subscore2);
	
	rcvalue9i := (integer)glrc9i * if(max(rcvalue9i_1, rcvalue9i_2) = NULL, NULL, sum(if(rcvalue9i_1 = NULL, 0, rcvalue9i_1), if(rcvalue9i_2 = NULL, 0, rcvalue9i_2)));
	
	rcvalue9h_1 := rcsegprop * (33.938523 - p_subscore13);
	
	rcvalue9h_2 := rcsegnon * (31.706679 - np_subscore13);
	
	rcvalue9h := (integer)glrc9h * if(max(rcvalue9h_1, rcvalue9h_2) = NULL, NULL, sum(if(rcvalue9h_1 = NULL, 0, rcvalue9h_1), if(rcvalue9h_2 = NULL, 0, rcvalue9h_2)));
	
	rcvalue9v_1 := rcsegprop * (34.411240 - p_subscore14);
	
	rcvalue9v := (integer)glrc9v * if(max(rcvalue9v_1) = NULL, NULL, sum(if(rcvalue9v_1 = NULL, 0, rcvalue9v_1)));
	
	rcvalueev_1 := rcsegprop * (34.451541 - p_subscore15);
	
	rcvalueev_2 := rcsegnon * (31.464159 - np_subscore22);
	
	rcvalueev := (integer)glrcev * if(max(rcvalueev_1, rcvalueev_2) = NULL, NULL, sum(if(rcvalueev_1 = NULL, 0, rcvalueev_1), if(rcvalueev_2 = NULL, 0, rcvalueev_2)));
	
	rcvalue97_1 := rcsegprop * (33.614201 - p_subscore16);
	
	rcvalue97_2 := rcsegnon * (30.953574 - np_subscore16);
	
	rcvalue97 := (integer)glrc97 * if(max(rcvalue97_1, rcvalue97_2) = NULL, NULL, sum(if(rcvalue97_1 = NULL, 0, rcvalue97_1), if(rcvalue97_2 = NULL, 0, rcvalue97_2)));
	
	rcvalue9m_1 := rcsegprop * (52.931514 - p_subscore17);
	
	rcvalue9m_2 := rcsegprop * (48.089161 - p_subscore18);
	
	rcvalue9m_3 := rcsegprop * (35.481581 - p_subscore22);
	
	rcvalue9m_4 := rcsegnon * (37.677750 - np_subscore18);
	
	rcvalue9m_5 := rcsegnon * (35.682679 - np_subscore20);
	
	rcvalue9m_6 := rcsegnon * (50.912507 - np_subscore23);
	
	rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1, rcvalue9m_2, rcvalue9m_3, rcvalue9m_4, rcvalue9m_5, rcvalue9m_6) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1), if(rcvalue9m_2 = NULL, 0, rcvalue9m_2), if(rcvalue9m_3 = NULL, 0, rcvalue9m_3), if(rcvalue9m_4 = NULL, 0, rcvalue9m_4), if(rcvalue9m_5 = NULL, 0, rcvalue9m_5), if(rcvalue9m_6 = NULL, 0, rcvalue9m_6)));
	
	rcvaluepv_1 := rcsegprop * (43.446605 - p_subscore19);
	
	rcvaluepv_2 := rcsegprop * (36.471282 - p_subscore21);
	
	rcvaluepv_3 := rcsegnon * (38.176983 - np_subscore21);
	
	rcvaluepv := glrcpv * if(max(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2), if(rcvaluepv_3 = NULL, 0, rcvaluepv_3)));
	
	rcvalue73_1 := rcsegnon * (43.010472 - np_subscore0);
	
	rcvalue73 := (integer)glrc73 * if(max(rcvalue73_1) = NULL, NULL, sum(if(rcvalue73_1 = NULL, 0, rcvalue73_1)));
	
	rcvalue9a_1 := rcsegnon * (39.776780 - np_subscore9);
	
	rcvalue9a_2 := rcsegnon * 30;
	
	rcvalue9a_3 := rcsegnon * (42.038039 - np_subscore12);
	
	rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1, rcvalue9a_2, rcvalue9a_3) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2), if(rcvalue9a_3 = NULL, 0, rcvalue9a_3)));
	
	rcvalue9e_1 := rcsegnon * (35.454592 - np_subscore11);
	
	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1)));
	
	rcvalue07_1 := 4 * (integer)(phn_disconnected > 0);
	
	rcvalue07 := (integer)glrc07 * if(max(rcvalue07_1) = NULL, NULL, sum(if(rcvalue07_1 = NULL, 0, rcvalue07_1)));
	
	rcvaluebl_1 := rcsegprop * (34.892613 - p_subscore5);
	
	rcvaluebl_2 := rcsegprop * (56.220530 - p_subscore11);
	
	rcvaluebl_3 := rcsegprop * (42.331088 - p_subscore20);
	
	rcvaluebl_4 := rcsegnon * (43.779091 - np_subscore3);
	
	rcvaluebl_5 := rcsegnon * (41.253804 - np_subscore10);
	
	rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5)));

	ds_layout := RECORD
    STRING rc;
    REAL value;
  END;
	
	rc_dataset := DATASET([
		{'9R', rcvalue9r},
		{'99', rcvalue99},
		{'98', rcvalue98},
		{'9F', rcvalue9f},
		{'9W', rcvalue9w},
		{'9Q', rcvalue9q},
		{'MS', rcvaluems},
		{'9D', rcvalue9d},
		{'9I', rcvalue9i},
		{'9H', rcvalue9h},
		{'9V', rcvalue9v},
		{'EV', rcvalueev},
		{'97', rcvalue97},
		{'9M', rcvalue9m},
		{'PV', rcvaluepv},
		{'73', rcvalue73},
		{'9A', rcvalue9a},
		{'9E', rcvalue9e},
		{'07', rcvalue07},
		{'BL', rcvaluebl}
		], ds_layout)(value > 0); // Keep all the reason codes that actually have a value
		
	rcs_top4 := CHOOSEN(SORT(rc_dataset, -value), 4); // Take the top four reason codes

	rcs_9q := rcs_top4 &
		IF((INTEGER)GLRC9Q > 0 AND NOT EXISTS(rcs_top4 (rc = '9Q')) AND  // Check to see if RC 9Q is a part of the score, but not in the first 4 RC's
				(
				((BOOLEAN)(INTEGER)RCSegProp AND inq_count12 > 0) OR 
				((BOOLEAN)(INTEGER)RCSegNon AND inq_count12 > 0)
				),
			DATASET([{'9Q', NULL}], ds_layout)); // If so - make it the 5th reason code.

	rcs_override := MAP(
											rvc1112 = 200 => DATASET([{'02', NULL}], ds_layout),
											rvc1112 = 222 => DATASET([{'9X', NULL}], ds_layout),
											NOT EXISTS(rcs_9q) => DATASET([{'36', NULL}], ds_layout),
											rcs_9q
										);
	
	riTemp := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
	
	rcs_final := PROJECT(rcs_override, TRANSFORM(Risk_Indicators.Layout_Desc,
				SELF.hri := LEFT.rc,
				SELF.desc := Risk_Indicators.getHRIDesc(LEFT.rc)
			));

	inCalif := isCalifornia AND (
				(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
				+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
				+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;
			
	PrescreenOptOut := xmlPrescreenOptOut or Risk_Indicators.iid_constants.CheckFlag(Risk_Indicators.iid_constants.IIDFlag.IsPreScreen, le.iid.iid_flags);
	
	ri := MAP(
						riTemp[1].hri <> '00' => riTemp,
						Risk_Indicators.rcSet.isCode95(PreScreenOptOut) => DATASET([{'95', Risk_Indicators.getHRIDesc('95')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						inCalif => DATASET([{'35', Risk_Indicators.getHRIDesc('35')}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc),
						rcs_final
						);
						
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	reasons := CHOOSEN(ri & zeros, 5); // Keep up to 5 reason codes
	
	final_score := MAP(
											riTemp[1].hri IN ['91','92','93','94'] => (STRING3)((INTEGER)riTemp[1].hri + 10),
											Risk_Indicators.rcSet.isCode95(PreScreenOptOut) => '222',
											reasons[1].hri='35' => '100',
											(STRING3)rvc1112
										);


	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.adl_addr := adl_addr;
		SELF.adl_hphn := adl_hphn;
		SELF.in_hphnpop := in_hphnpop;
		SELF.truedid := truedid;
		SELF.out_st := out_st;
		SELF.in_dob := in_dob;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_decsflag := rc_decsflag;
		SELF.rc_bansflag := rc_bansflag;
		SELF.combo_dobscore := combo_dobscore;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_first_seen := ver_sources_first_seen;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.dobpop := dobpop;
		SELF.hphnpop := hphnpop;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_avm_automated_valuation := add1_avm_automated_valuation;
		SELF.add1_family_owned := add1_family_owned;
		SELF.add1_naprop := add1_naprop;
		SELF.property_owned_total := property_owned_total;
		SELF.property_owned_assessed_total := property_owned_assessed_total;
		SELF.property_sold_total := property_sold_total;
		SELF.addrs_15yr := addrs_15yr;
		SELF.gong_did_first_seen := gong_did_first_seen;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.inputssncharflag := inputssncharflag;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.addrs_per_adl := addrs_per_adl;
		SELF.addrs_per_ssn := addrs_per_ssn;
		SELF.ssns_per_addr := ssns_per_addr;
		SELF.ssns_per_adl_c6 := ssns_per_adl_c6;
		SELF.inq_count12 := inq_count12;
		SELF.paw_dead_business_count := paw_dead_business_count;
		SELF.paw_active_phone_count := paw_active_phone_count;
		SELF.impulse_count := impulse_count;
		SELF.attr_num_purchase90 := attr_num_purchase90;
		SELF.attr_num_purchase180 := attr_num_purchase180;
		SELF.attr_num_purchase12 := attr_num_purchase12;
		SELF.attr_num_purchase24 := attr_num_purchase24;
		SELF.attr_num_purchase36 := attr_num_purchase36;
		SELF.attr_num_purchase60 := attr_num_purchase60;
		SELF.attr_num_sold90 := attr_num_sold90;
		SELF.attr_num_sold180 := attr_num_sold180;
		SELF.attr_num_sold12 := attr_num_sold12;
		SELF.attr_num_sold24 := attr_num_sold24;
		SELF.attr_num_sold36 := attr_num_sold36;
		SELF.attr_num_sold60 := attr_num_sold60;
		SELF.attr_num_aircraft := attr_num_aircraft;
		SELF.attr_num_unrel_liens30 := attr_num_unrel_liens30;
		SELF.attr_num_unrel_liens90 := attr_num_unrel_liens90;
		SELF.attr_num_unrel_liens180 := attr_num_unrel_liens180;
		SELF.attr_num_unrel_liens12 := attr_num_unrel_liens12;
		SELF.attr_num_unrel_liens24 := attr_num_unrel_liens24;
		SELF.attr_num_unrel_liens36 := attr_num_unrel_liens36;
		SELF.attr_num_unrel_liens60 := attr_num_unrel_liens60;
		SELF.attr_bankruptcy_count12 := attr_bankruptcy_count12;
		SELF.attr_eviction_count := attr_eviction_count;
		SELF.attr_num_nonderogs90 := attr_num_nonderogs90;
		SELF.bankrupt := bankrupt;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.liens_unrel_cj_ct := liens_unrel_cj_ct;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.watercraft_count := watercraft_count;
		SELF.ams_college_code := ams_college_code;
		SELF.ams_college_type := ams_college_type;
		SELF.ams_college_tier := ams_college_tier;
		SELF.prof_license_flag := prof_license_flag;
		SELF.wealth_index := wealth_index;
		SELF.input_dob_match_level := input_dob_match_level;
		SELF.inferred_age := inferred_age;
		SELF.estimated_income := estimated_income;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.in_dob2 := in_dob2;
		SELF.yr_in_dob_2 := yr_in_dob_2;
		SELF.gong_did_first_seen2 := gong_did_first_seen2;
		SELF.mth_gong_did_first_seen_2 := mth_gong_did_first_seen_2;
		SELF.gong_did_last_seen2 := gong_did_last_seen2;
		SELF.mth_gong_did_last_seen_2 := mth_gong_did_last_seen_2;
		SELF.ver_src_ba_pos := ver_src_ba_pos;
		SELF.ver_src_ba_2 := ver_src_ba_2;
		SELF.ver_src_ds_pos := ver_src_ds_pos;
		SELF.ver_src_ds_2 := ver_src_ds_2;
		SELF.ver_src_eq_pos := ver_src_eq_pos;
		SELF.ver_src_fdate_eq := ver_src_fdate_eq;
		SELF.ver_src_fdate_eq2 := ver_src_fdate_eq2;
		SELF.mth_ver_src_fdate_eq_2 := mth_ver_src_fdate_eq_2;
		SELF.ver_src_l2_pos := ver_src_l2_pos;
		SELF.ver_src_l2_2 := ver_src_l2_2;
		SELF.ver_src_li_pos := ver_src_li_pos;
		SELF.ver_src_li_2 := ver_src_li_2;
		SELF.ver_src_p_pos := ver_src_p_pos;
		SELF.ver_src_p_2 := ver_src_p_2;
		SELF.ssn_adl_prob_2 := ssn_adl_prob_2;
		SELF.crime_felony_flag_2 := crime_felony_flag_2;
		SELF.attr_eviction_flag_2 := attr_eviction_flag_2;
		SELF.phn_disconnected_2 := phn_disconnected_2;
		SELF.combined_age_2 := combined_age_2;
		SELF.ssnpop_2 := ssnpop_2;
		SELF.out_st_region_2 := out_st_region_2;
		SELF.bk_flag_2 := bk_flag_2;
		SELF.lien_rec_unrel_flag_2 := lien_rec_unrel_flag_2;
		SELF.lien_hist_unrel_flag_2 := lien_hist_unrel_flag_2;
		SELF.lien_flag_2 := lien_flag_2;
		SELF.ssn_deceased_2 := ssn_deceased_2;
		SELF._ams_college_type_2 := _ams_college_type_2;
		SELF._ams_college_tier_2 := _ams_college_tier_2;
		SELF.add1_avm_automated_valuation_2 := add1_avm_automated_valuation_2;
		SELF.ssns_per_addr_2 := ssns_per_addr_2;
		SELF.out_st_region_1 := out_st_region_1;
		SELF.attr_num_unrel_liens30_2 := attr_num_unrel_liens30_2;
		SELF.attr_num_unrel_liens90_2 := attr_num_unrel_liens90_2;
		SELF.attr_num_unrel_liens180_2 := attr_num_unrel_liens180_2;
		SELF.attr_num_unrel_liens12_2 := attr_num_unrel_liens12_2;
		SELF.attr_num_unrel_liens24_2 := attr_num_unrel_liens24_2;
		SELF.attr_num_unrel_liens36_2 := attr_num_unrel_liens36_2;
		SELF.attr_num_unrel_liens60_2 := attr_num_unrel_liens60_2;
		SELF.attr_bankruptcy_count12_2 := attr_bankruptcy_count12_2;
		SELF.attr_eviction_count_2 := attr_eviction_count_2;
		SELF.bankrupt_2 := bankrupt_2;
		SELF.liens_recent_unreleased_count_2 := liens_recent_unreleased_count_2;
		SELF.liens_historical_unreleased_ct_2 := liens_historical_unreleased_ct_2;
		SELF.liens_unrel_cj_ct_2 := liens_unrel_cj_ct_2;
		SELF.criminal_count_2 := criminal_count_2;
		SELF.inq_count12_2 := inq_count12_2;
		SELF.impulse_count_2 := impulse_count_2;
		SELF.addrs_15yr_2 := addrs_15yr_2;
		SELF.attr_num_purchase90_2 := attr_num_purchase90_2;
		SELF.attr_num_purchase180_2 := attr_num_purchase180_2;
		SELF.attr_num_purchase12_2 := attr_num_purchase12_2;
		SELF.attr_num_purchase24_2 := attr_num_purchase24_2;
		SELF.attr_num_purchase36_2 := attr_num_purchase36_2;
		SELF.attr_num_purchase60_2 := attr_num_purchase60_2;
		SELF.attr_num_sold90_2 := attr_num_sold90_2;
		SELF.attr_num_sold180_2 := attr_num_sold180_2;
		SELF.attr_num_sold12_2 := attr_num_sold12_2;
		SELF.attr_num_sold24_2 := attr_num_sold24_2;
		SELF.attr_num_sold36_2 := attr_num_sold36_2;
		SELF.attr_num_sold60_2 := attr_num_sold60_2;
		SELF.attr_num_aircraft_2 := attr_num_aircraft_2;
		SELF.watercraft_count_2 := watercraft_count_2;
		SELF.ssns_per_adl_2 := ssns_per_adl_2;
		SELF.addrs_per_adl_2 := addrs_per_adl_2;
		SELF._ams_college_tier_1 := _ams_college_tier_1;
		SELF._ams_college_type_1 := _ams_college_type_1;
		SELF.paw_dead_business_count_2 := paw_dead_business_count_2;
		SELF.paw_active_phone_count_2 := paw_active_phone_count_2;
		SELF.ams_college_code_2 := ams_college_code_2;
		SELF.prof_license_flag_2 := prof_license_flag_2;
		SELF.wealth_index_2 := wealth_index_2;
		SELF.estimated_income_2 := estimated_income_2;
		SELF.add1_isbestmatch_2 := add1_isbestmatch_2;
		SELF.attr_num_nonderogs90_2 := attr_num_nonderogs90_2;
		SELF.attr_eviction_flag_1 := attr_eviction_flag_1;
		SELF.crime_felony_flag_1 := crime_felony_flag_1;
		SELF.ssn_adl_prob_1 := ssn_adl_prob_1;
		SELF.mth_ver_src_fdate_eq_1 := mth_ver_src_fdate_eq_1;
		SELF.ver_src_p_1 := ver_src_p_1;
		SELF.mth_gong_did_first_seen_1 := mth_gong_did_first_seen_1;
		SELF.mth_gong_did_last_seen_1 := mth_gong_did_last_seen_1;
		SELF.add1_family_owned_2 := add1_family_owned_2;
		SELF.add1_naprop_2 := add1_naprop_2;
		SELF.property_owned_total_2 := property_owned_total_2;
		SELF.property_owned_assessed_total_2 := property_owned_assessed_total_2;
		SELF.property_sold_total_2 := property_sold_total_2;
		SELF.combined_age_1 := combined_age_1;
		SELF.nas_summary_2 := nas_summary_2;
		SELF.nap_summary_2 := nap_summary_2;
		SELF.phn_disconnected_1 := phn_disconnected_1;
		SELF.addrs_per_ssn_2 := addrs_per_ssn_2;
		SELF.inputssncharflag_2 := inputssncharflag_2;
		SELF.ssn_deceased_1 := ssn_deceased_1;
		SELF.ssnpop_1 := ssnpop_1;
		SELF.combo_dobscore_2 := combo_dobscore_2;
		SELF.lien_flag_1 := lien_flag_1;
		SELF.bk_flag_1 := bk_flag_1;
		SELF.add1_avm_automated_valuation_1 := add1_avm_automated_valuation_1;
		SELF.out_st_region := out_st_region;
		SELF.ssns_per_addr_1 := ssns_per_addr_1;
		SELF.attr_num_sold24_1 := attr_num_sold24_1;
		SELF.wealth_index_1 := wealth_index_1;
		SELF.impulse_count_1 := impulse_count_1;
		SELF.attr_num_purchase60_1 := attr_num_purchase60_1;
		SELF.attr_num_unrel_liens24_1 := attr_num_unrel_liens24_1;
		SELF.inq_count12_1 := inq_count12_1;
		SELF._ams_college_type := _ams_college_type;
		SELF._ams_college_tier := _ams_college_tier;
		SELF.attr_num_unrel_liens180_1 := attr_num_unrel_liens180_1;
		SELF.attr_num_nonderogs90_1 := attr_num_nonderogs90_1;
		SELF.attr_bankruptcy_count12_1 := attr_bankruptcy_count12_1;
		SELF.mth_ver_src_fdate_eq := mth_ver_src_fdate_eq;
		SELF.criminal_count_1 := criminal_count_1;
		SELF.estimated_income_1 := estimated_income_1;
		SELF.attr_num_unrel_liens12_1 := attr_num_unrel_liens12_1;
		SELF.attr_num_unrel_liens30_1 := attr_num_unrel_liens30_1;
		SELF.combo_dobscore_1 := combo_dobscore_1;
		SELF.attr_eviction_flag := attr_eviction_flag;
		SELF.attr_num_purchase90_1 := attr_num_purchase90_1;
		SELF.attr_eviction_count_1 := attr_eviction_count_1;
		SELF.add1_isbestmatch_1 := add1_isbestmatch_1;
		SELF.ssn_adl_prob := ssn_adl_prob;
		SELF.ams_college_code_1 := ams_college_code_1;
		SELF.paw_dead_business_count_1 := paw_dead_business_count_1;
		SELF.mth_gong_did_last_seen := mth_gong_did_last_seen;
		SELF.attr_num_aircraft_1 := attr_num_aircraft_1;
		SELF.crime_felony_flag := crime_felony_flag;
		SELF.watercraft_count_1 := watercraft_count_1;
		SELF.attr_num_sold60_1 := attr_num_sold60_1;
		SELF.addrs_per_adl_1 := addrs_per_adl_1;
		SELF.attr_num_unrel_liens36_1 := attr_num_unrel_liens36_1;
		SELF.liens_recent_unreleased_count_1 := liens_recent_unreleased_count_1;
		SELF.addrs_15yr_1 := addrs_15yr_1;
		SELF.attr_num_purchase12_1 := attr_num_purchase12_1;
		SELF.lien_flag := lien_flag;
		SELF.attr_num_sold90_1 := attr_num_sold90_1;
		SELF.ver_src_p := ver_src_p;
		SELF.attr_num_purchase24_1 := attr_num_purchase24_1;
		SELF.attr_num_purchase180_1 := attr_num_purchase180_1;
		SELF.prof_license_flag_1 := prof_license_flag_1;
		SELF.attr_num_purchase36_1 := attr_num_purchase36_1;
		SELF.attr_num_sold180_1 := attr_num_sold180_1;
		SELF.attr_num_unrel_liens90_1 := attr_num_unrel_liens90_1;
		SELF.liens_unrel_cj_ct_1 := liens_unrel_cj_ct_1;
		SELF.paw_active_phone_count_1 := paw_active_phone_count_1;
		SELF.liens_historical_unreleased_ct_1 := liens_historical_unreleased_ct_1;
		SELF.attr_num_unrel_liens60_1 := attr_num_unrel_liens60_1;
		SELF.attr_num_sold36_1 := attr_num_sold36_1;
		SELF.ssns_per_adl_1 := ssns_per_adl_1;
		SELF.bk_flag := bk_flag;
		SELF.mth_gong_did_first_seen := mth_gong_did_first_seen;
		SELF.bankrupt_1 := bankrupt_1;
		SELF.attr_num_sold12_1 := attr_num_sold12_1;
		SELF.property_owned_assessed_total_1 := property_owned_assessed_total_1;
		SELF.property_sold_total_1 := property_sold_total_1;
		SELF.property_owned_total_1 := property_owned_total_1;
		SELF.add1_family_owned_1 := add1_family_owned_1;
		SELF.add1_naprop_1 := add1_naprop_1;
		SELF.combined_age := combined_age;
		SELF.nas_summary_1 := nas_summary_1;
		SELF.phn_disconnected := phn_disconnected;
		SELF.nap_summary_1 := nap_summary_1;
		SELF.ssnpop := ssnpop;
		SELF.ssn_deceased := ssn_deceased;
		SELF.addrs_per_ssn_1 := addrs_per_ssn_1;
		// SELF.rc_hriskphoneflag_1 := rc_hriskphoneflag_1;
		// SELF.rc_descflag_1 := rc_descflag_1;
		// SELF.rc_bansflag_1 := rc_bansflag_1;
		SELF.inputssncharflag_1 := inputssncharflag_1;
		// SELF.input_dob_match_level_1 := input_dob_match_level_1;
		// SELF.filing_count_1 := filing_count_1;
		// SELF.bk_recent_count_1 := bk_recent_count_1;
		// SELF.felony_count_1 := felony_count_1;
		// SELF.ssns_per_adl_c6_1 := ssns_per_adl_c6_1;
		// SELF.inferred_age_1 := inferred_age_1;
		SELF.scored_222s := scored_222s;
		SELF._segment := _segment;
		SELF.boat_plane_flag := boat_plane_flag;
		SELF.college_flag := college_flag;
		SELF.unreleased_lien_recency := unreleased_lien_recency;
		SELF.sold_recency := sold_recency;
		SELF.purchase_recency := purchase_recency;
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
		SELF.p_subscore20 := p_subscore20;
		SELF.p_subscore21 := p_subscore21;
		SELF.p_subscore22 := p_subscore22;
		SELF.p_scaledscore := p_scaledscore;
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
		SELF.np_subscore16 := np_subscore16;
		SELF.np_subscore17 := np_subscore17;
		SELF.np_subscore18 := np_subscore18;
		SELF.np_subscore19 := np_subscore19;
		SELF.np_subscore20 := np_subscore20;
		SELF.np_subscore21 := np_subscore21;
		SELF.np_subscore22 := np_subscore22;
		SELF.np_subscore23 := np_subscore23;
		SELF.np_scaledscore := np_scaledscore;
		SELF._p_scaledscore := _p_scaledscore;
		SELF._np_scaledscore := _np_scaledscore;
		SELF.rvc1112 := rvc1112;
		SELF.glrc07 := glrc07;
		SELF.glrc73 := glrc73;
		SELF.glrc97 := glrc97;
		SELF.glrc98 := glrc98;
		SELF.glrc99 := glrc99;
		SELF.glrc9a := glrc9a;
		SELF.glrc9d := glrc9d;
		SELF.glrc9e := glrc9e;
		SELF.glrc9f := glrc9f;
		SELF.glrc9h := glrc9h;
		SELF.glrc9i := glrc9i;
		SELF.glrc9m := glrc9m;
		SELF.glrc9q := glrc9q;
		SELF.glrc9r := glrc9r;
		SELF.glrc9v := glrc9v;
		SELF.glrc9w := glrc9w;
		SELF.glrcev := glrcev;
		SELF.glrcms := glrcms;
		SELF.glrcpv := glrcpv;
		SELF.glrcbl := glrcbl;
		SELF.rcsegprop := rcsegprop;
		SELF.rcsegnon := rcsegnon;
		SELF.rcvalue9r_1 := rcvalue9r_1;
		SELF.rcvalue9r_2 := rcvalue9r_2;
		SELF.rcvalue9r_3 := rcvalue9r_3;
		SELF.rcvalue9r_4 := rcvalue9r_4;
		SELF.rcvalue9r := rcvalue9r;
		SELF.rcvalue99_1 := rcvalue99_1;
		SELF.rcvalue99_2 := rcvalue99_2;
		SELF.rcvalue99 := rcvalue99;
		SELF.rcvalue98_1 := rcvalue98_1;
		SELF.rcvalue98_2 := rcvalue98_2;
		SELF.rcvalue98_3 := rcvalue98_3;
		SELF.rcvalue98_4 := rcvalue98_4;
		SELF.rcvalue98 := rcvalue98;
		SELF.rcvalue9f_1 := rcvalue9f_1;
		SELF.rcvalue9f_2 := rcvalue9f_2;
		SELF.rcvalue9f := rcvalue9f;
		SELF.rcvalue9w_1 := rcvalue9w_1;
		SELF.rcvalue9w := rcvalue9w;
		SELF.rcvalue9q_1 := rcvalue9q_1;
		SELF.rcvalue9q_2 := rcvalue9q_2;
		SELF.rcvalue9q := rcvalue9q;
		SELF.rcvaluems_1 := rcvaluems_1;
		SELF.rcvaluems_2 := rcvaluems_2;
		SELF.rcvaluems := rcvaluems;
		SELF.rcvalue9d_1 := rcvalue9d_1;
		SELF.rcvalue9d_2 := rcvalue9d_2;
		SELF.rcvalue9d_3 := rcvalue9d_3;
		SELF.rcvalue9d := rcvalue9d;
		SELF.rcvalue9i_1 := rcvalue9i_1;
		SELF.rcvalue9i_2 := rcvalue9i_2;
		SELF.rcvalue9i := rcvalue9i;
		SELF.rcvalue9h_1 := rcvalue9h_1;
		SELF.rcvalue9h_2 := rcvalue9h_2;
		SELF.rcvalue9h := rcvalue9h;
		SELF.rcvalue9v_1 := rcvalue9v_1;
		SELF.rcvalue9v := rcvalue9v;
		SELF.rcvalueev_1 := rcvalueev_1;
		SELF.rcvalueev_2 := rcvalueev_2;
		SELF.rcvalueev := rcvalueev;
		SELF.rcvalue97_1 := rcvalue97_1;
		SELF.rcvalue97_2 := rcvalue97_2;
		SELF.rcvalue97 := rcvalue97;
		SELF.rcvalue9m_1 := rcvalue9m_1;
		SELF.rcvalue9m_2 := rcvalue9m_2;
		SELF.rcvalue9m_3 := rcvalue9m_3;
		SELF.rcvalue9m_4 := rcvalue9m_4;
		SELF.rcvalue9m_5 := rcvalue9m_5;
		SELF.rcvalue9m_6 := rcvalue9m_6;
		SELF.rcvalue9m := rcvalue9m;
		SELF.rcvaluepv_1 := rcvaluepv_1;
		SELF.rcvaluepv_2 := rcvaluepv_2;
		SELF.rcvaluepv_3 := rcvaluepv_3;
		SELF.rcvaluepv := rcvaluepv;
		SELF.rcvalue73_1 := rcvalue73_1;
		SELF.rcvalue73 := rcvalue73;
		SELF.rcvalue9a_1 := rcvalue9a_1;
		SELF.rcvalue9a_2 := rcvalue9a_2;
		SELF.rcvalue9a_3 := rcvalue9a_3;
		SELF.rcvalue9a := rcvalue9a;
		SELF.rcvalue9e_1 := rcvalue9e_1;
		SELF.rcvalue9e := rcvalue9e;
		SELF.rcvalue07_1 := rcvalue07_1;
		SELF.rcvalue07 := rcvalue07;
		SELF.rcvaluebl_1 := rcvaluebl_1;
		SELF.rcvaluebl_2 := rcvaluebl_2;
		SELF.rcvaluebl_3 := rcvaluebl_3;
		SELF.rcvaluebl_4 := rcvaluebl_4;
		SELF.rcvaluebl_5 := rcvaluebl_5;
		SELF.rcvaluebl := rcvaluebl;
    
		SELF.rc1 := rcs_override[1].rc;
		SELF.rc2 := rcs_override[2].rc;
		SELF.rc3 := rcs_override[3].rc;
		SELF.rc4 := rcs_override[4].rc;
		SELF.rc5 := rcs_override[5].rc;

		SELF.clam := le;
	#else
		SELF.ri := reasons;

		SELF.score := final_score;
		
		SELF.seq := le.seq;
	#end
	END;

	model := PROJECT(clam, doModel(LEFT));

	RETURN(model);
END;
