IMPORT ut, RiskWise, RiskWiseFCRA, Risk_Indicators, std, riskview;

EXPORT rvc1110_2_0 (DATASET(Risk_Indicators.Layout_Boca_Shell) clam, BOOLEAN isCalifornia, BOOLEAN xmlPreScreenOptOut) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;

			BOOLEAN truedid;
			STRING out_unit_desig;
			STRING out_sec_range;
			STRING out_st;
			STRING out_addr_type;
			STRING in_dob;
			INTEGER nas_summary;
			INTEGER nap_summary;
			STRING rc_dwelltype;
			STRING rc_bansflag;
			INTEGER combo_dobscore;
			STRING ver_sources;
			STRING ver_sources_last_seen;
			BOOLEAN addrpop;
			STRING ssnlength;
			BOOLEAN hphnpop;
			INTEGER age;
			BOOLEAN add1_isbestmatch;
			BOOLEAN add1_applicant_owned;
			BOOLEAN add1_occupant_owned;
			BOOLEAN add1_family_owned;
			INTEGER add1_naprop;
			INTEGER property_owned_total;
			INTEGER property_owned_assessed_total;
			INTEGER property_sold_total;
			INTEGER dist_a1toa2;
			INTEGER dist_a1toa3;
			INTEGER dist_a2toa3;
			BOOLEAN add2_isbestmatch;
			STRING add2_addr_type;
			STRING add2_sources;
			BOOLEAN add2_applicant_owned;
			BOOLEAN add2_occupant_owned;
			BOOLEAN add2_family_owned;
			STRING add2_st;
			INTEGER addrs_5yr;
			INTEGER addrs_10yr;
			INTEGER addrs_15yr;
			INTEGER unique_addr_count;
			STRING gong_did_last_seen;
			INTEGER header_first_seen;
			STRING inputssncharflag;
			INTEGER attr_addrs_last30;
			INTEGER attr_addrs_last90;
			INTEGER attr_addrs_last12;
			INTEGER attr_addrs_last24;
			INTEGER attr_addrs_last36;
			INTEGER attr_num_purchase90;
			INTEGER attr_num_purchase180;
			INTEGER attr_num_purchase12;
			INTEGER attr_num_purchase24;
			INTEGER attr_num_purchase36;
			INTEGER attr_num_purchase60;
			BOOLEAN bankrupt;
			INTEGER filing_count;
			INTEGER bk_recent_count;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER criminal_count;
			STRING wealth_index;
			STRING input_dob_age;
			STRING input_dob_match_level;
			INTEGER inferred_age;
			INTEGER addrs_per_ssn;
			INTEGER estimated_income_2;
			INTEGER attr_num_nonderogs;
			INTEGER phones_per_adl;
			STRING addr_stability_v2;
			INTEGER avg_lres;
			INTEGER attr_num_nonderogs24;
			INTEGER add1_assessed_total_value;
			INTEGER add2_market_total_value;
			INTEGER ssns_per_addr;
			INTEGER avg_mo_per_addr;
			STRING rc_phonezipflag;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			INTEGER _segment;
			INTEGER sysdate;
			INTEGER ver_src_ba_pos;
			STRING ver_src_ldate_ba;
			INTEGER ver_src_ldate_ba2;
			REAL mth_ver_src_ldate_ba;
			INTEGER ver_src_de_pos;
			BOOLEAN ver_src_de_1;
			STRING ver_src_ldate_de;
			INTEGER ver_src_ldate_de2;
			REAL mth_ver_src_ldate_de_1;
			INTEGER ver_src_p_pos;
			BOOLEAN ver_src_p;
			STRING ver_src_ldate_p;
			INTEGER ver_src_ldate_p2;
			REAL mth_ver_src_ldate_p;
			INTEGER lb_age;
			INTEGER property_owned_value_1;
			STRING out_st_region;
			INTEGER address_change_recency;
			BOOLEAN any_bankruptcy;
			INTEGER dist2_a1toa2;
			INTEGER dist2_a1toa3;
			INTEGER dist2_a2toa3;
			INTEGER distance_max_1;
			STRING add2_region;
			INTEGER header_first_seen2;
			REAL mth_header_first_seen_1;
			BOOLEAN add2_apt;
			INTEGER add2_src_cnt_1;
			INTEGER addrs_per_ssn_1;
			REAL mth_header_first_seen;
			INTEGER estimated_income_1;
			INTEGER add2_src_cnt;
			INTEGER attr_num_nonderogs_1;
			INTEGER ver_src_de;
			INTEGER bankrupt_1;
			INTEGER phones_per_adl_1;
			INTEGER dist_a2toa3_1;
			INTEGER addr_stability_v2_1;
			INTEGER property_owned_value;
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
			REAL i_subscore11;
			REAL i_subscore12;
			REAL i_subscore13;
			REAL i_subscore14;
			REAL i_subscore15;
			INTEGER add1_ownership_1;
			INTEGER add2_ownership;
			INTEGER gong_did_last_seen2;
			REAL mth_gong_did_last_seen_1;
			BOOLEAN gong_last_7mo;
			INTEGER add_bestmatch_level_1;
			INTEGER purchase_recency;
			INTEGER avg_lres_1;
			INTEGER attr_num_nonderogs24_1;
			INTEGER add2_market_total_value_1;
			INTEGER distance_max;
			INTEGER add_bestmatch_level;
			INTEGER add1_assessed_total_value_1;
			INTEGER add1_ownership;
			INTEGER ssns_per_addr_1;
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
			INTEGER last_seen_p;
			BOOLEAN add_apt_1;
			INTEGER avg_mo_per_addr_1;
			REAL mth_ver_src_ldate_de;
			INTEGER add1_naprop_1;
			INTEGER add_apt;
			INTEGER rc_phonezipflag_1;
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
			REAL i_scaledscore;
			REAL p_scaledscore;
			REAL np_scaledscore;
			REAL _in;
			INTEGER rvc1110_2_1;
			BOOLEAN lien_flag;
			BOOLEAN bk_flag;
			BOOLEAN scored_222s;
			INTEGER rvc1110_2;
			BOOLEAN glrc16;
			BOOLEAN glrc78;
			BOOLEAN glrc99;
			BOOLEAN glrc9a;
			BOOLEAN glrc9c;
			BOOLEAN glrc9d;
			BOOLEAN glrc9e;
			BOOLEAN glrc9f;
			BOOLEAN glrc9k;
			BOOLEAN glrc9l;
			BOOLEAN glrc9m;
			BOOLEAN glrc9r;
			BOOLEAN glrc9v;
			BOOLEAN glrc9w;
			INTEGER glrcpv;
			INTEGER glrcbl;
			BOOLEAN rcseginputs;
			BOOLEAN rcsegprop;
			BOOLEAN rcsegnon;
			REAL rcvalue16_1;
			REAL rcvalue16;
			INTEGER rcvalue78_1;
			INTEGER rcvalue78;
			REAL rcvalue99_1;
			REAL rcvalue99;
			REAL rcvalue9a_1;
			REAL rcvalue9a_2;
			INTEGER rcvalue9a_3;
			REAL rcvalue9a;
			REAL rcvalue9c_1;
			REAL rcvalue9c_2;
			REAL rcvalue9c_3;
			REAL rcvalue9c;
			REAL rcvalue9d_1;
			REAL rcvalue9d_2;
			REAL rcvalue9d;
			REAL rcvalue9e_1;
			REAL rcvalue9e_2;
			REAL rcvalue9e_3;
			REAL rcvalue9e_4;
			REAL rcvalue9e_5;
			REAL rcvalue9e;
			REAL rcvalue9f_1;
			REAL rcvalue9f_2;
			REAL rcvalue9f_3;
			REAL rcvalue9f;
			REAL rcvalue9k_1;
			REAL rcvalue9k_2;
			REAL rcvalue9k;
			REAL rcvalue9l_1;
			REAL rcvalue9l;
			REAL rcvalue9m_1;
			REAL rcvalue9m_2;
			REAL rcvalue9m;
			REAL rcvalue9r_1;
			REAL rcvalue9r;
			REAL rcvalue9v_1;
			REAL rcvalue9v_2;
			REAL rcvalue9v_3;
			REAL rcvalue9v;
			REAL rcvalue9w_1;
			REAL rcvalue9w_2;
			REAL rcvalue9w_3;
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
			REAL rcvaluebl_5;
			REAL rcvaluebl_6;
			REAL rcvaluebl_7;
			REAL rcvaluebl_8;
			REAL rcvaluebl_9;
			REAL rcvaluebl_10;
			REAL rcvaluebl_11;
			REAL rcvaluebl_12;
			REAL rcvaluebl_13;
			REAL rcvaluebl_14;
			REAL rcvaluebl_15;
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
	out_unit_desig                   := le.shell_input.unit_desig;
	out_sec_range                    := le.shell_input.sec_range;
	out_st                           := le.shell_input.st;
	out_addr_type                    := le.shell_input.addr_type;
	in_dob                           := le.shell_input.dob;
	nas_summary                      := le.iid.nas_summary;
	nap_summary                      := le.iid.nap_summary;
	rc_dwelltype                     := le.iid.dwelltype;
	rc_bansflag                      := le.iid.bansflag;
	combo_dobscore                   := le.iid.combo_dobscore;
	ver_sources                      := le.header_summary.ver_sources;
	ver_sources_last_seen            := le.header_summary.ver_sources_last_seen_date;
	addrpop                          := le.input_validation.address;
	ssnlength                        := le.input_validation.ssn_length;
	hphnpop                          := le.input_validation.homephone;
	age                              := le.name_verification.age;
	add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
	add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
	add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	property_owned_total             := le.address_verification.owned.property_total;
	property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
	property_sold_total              := le.address_verification.sold.property_total;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	add2_isbestmatch                 := le.address_verification.address_history_1.isbestmatch;
	add2_addr_type                   := le.address_verification.addr_type2;
	add2_sources                     := le.address_verification.address_history_1.sources;
	add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
	add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
	add2_family_owned                := le.address_verification.address_history_1.family_owned;
	add2_st                          := le.address_verification.address_history_1.st;
	addrs_5yr                        := le.other_address_info.addrs_last_5years;
	addrs_10yr                       := le.other_address_info.addrs_last_10years;
	addrs_15yr                       := le.other_address_info.addrs_last_15years;
	unique_addr_count                := le.address_history_summary.unique_addr_cnt;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	header_first_seen                := le.ssn_verification.header_first_seen;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	attr_addrs_last30                := le.other_address_info.addrs_last30;
	attr_addrs_last90                := le.other_address_info.addrs_last90;
	attr_addrs_last12                := le.other_address_info.addrs_last12;
	attr_addrs_last24                := le.other_address_info.addrs_last24;
	attr_addrs_last36                := le.other_address_info.addrs_last36;
	attr_num_purchase90              := le.other_address_info.num_purchase90;
	attr_num_purchase180             := le.other_address_info.num_purchase180;
	attr_num_purchase12              := le.other_address_info.num_purchase12;
	attr_num_purchase24              := le.other_address_info.num_purchase24;
	attr_num_purchase36              := le.other_address_info.num_purchase36;
	attr_num_purchase60              := le.other_address_info.num_purchase60;
	bankrupt                         := le.bjl.bankrupt;
	filing_count                     := le.bjl.filing_count;
	bk_recent_count                  := le.bjl.bk_recent_count;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := le.shell_input.age;
	input_dob_match_level            := le.dobmatchlevel;
	inferred_age                     := le.inferred_age;
	addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
	estimated_income_2                 := le.estimated_income;
	attr_num_nonderogs               := le.source_verification.num_nonderogs;
	phones_per_adl                   := le.velocity_counters.phones_per_adl;
	addr_stability_v2                := le.addr_stability;
	avg_lres                         := le.other_address_info.avg_lres;
	attr_num_nonderogs24             := le.source_verification.num_nonderogs24;
	add1_assessed_total_value        := __common__(le.address_verification.input_address_information.assessed_total_value);
	add2_market_total_value          := __common__(le.address_verification.address_history_1.assessed_amount);
	ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
	avg_mo_per_addr                  := le.address_history_summary.avg_mo_per_addr;
	rc_phonezipflag                  := le.iid.phonezipflag;
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
	
	_segment := map(
	    NOT(addrpop)                                => 0,
	    add1_naprop = 4 or property_owned_total > 0 => 1,
	                                                   2);
	
	sysdate := map(
	    trim((string)archive_date, LEFT, RIGHT) = '999999'  => common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
	    length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
	                                                           NULL);
	
	ver_src_ba_pos := Models.Common.findw_cpp(ver_sources, 'BA' , '  ,', 'ie');
	
	ver_src_ldate_ba := if(ver_src_ba_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_ba_pos), '0');
	
	ver_src_ldate_ba2 := Common.SAS_Date((STRING)(ver_src_ldate_ba));
	
	mth_ver_src_ldate_ba_tmp := ROUNDUP((sysdate - ver_src_ldate_ba2) / 30.5);
	
	mth_ver_src_ldate_ba := if(min(sysdate, ver_src_ldate_ba2) = NULL, NULL, IF(mth_ver_src_ldate_ba_tmp < 0, 0, mth_ver_src_ldate_ba_tmp));
	
	ver_src_de_pos := Models.Common.findw_cpp(ver_sources, 'DE' , '  ,', 'ie');
	
	ver_src_de_1 := ver_src_de_pos > 0;
	
	ver_src_ldate_de := if(ver_src_de_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_de_pos), '0');
	
	ver_src_ldate_de2 := Common.SAS_Date((STRING)(ver_src_ldate_de));
	
	mth_ver_src_ldate_de_1_tmp := ROUNDUP((sysdate - ver_src_ldate_de2) / 30.5);
	
	mth_ver_src_ldate_de_1 := if(min(sysdate, ver_src_ldate_de2) = NULL, NULL, IF(mth_ver_src_ldate_de_1_tmp < 0, 0, mth_ver_src_ldate_de_1_tmp));
	
	ver_src_p_pos := Models.Common.findw_cpp(ver_sources, 'P' , '  ,', 'ie');
	
	ver_src_p := ver_src_p_pos > 0;
	
	ver_src_ldate_p := if(ver_src_p_pos > 0, Models.Common.getw(ver_sources_last_seen, ver_src_p_pos), '0');
	
	ver_src_ldate_p2 := Common.SAS_Date((STRING)(ver_src_ldate_p));
	
	mth_ver_src_ldate_p_tmp := ROUNDUP((sysdate - ver_src_ldate_p2) / 30.5);
	
	mth_ver_src_ldate_p := if(min(sysdate, ver_src_ldate_p2) = NULL, NULL, IF(mth_ver_src_ldate_p_tmp < 0, 0, mth_ver_src_ldate_p_tmp));
	
	lb_age := map(
	    age > 0                                                                                 => (INTEGER)age,
	    (INTEGER)input_dob_age > 0 AND trim(in_dob) != '19000101' /*AND StringLib.StringContains(trim(in_dob), '-', TRUE)*/ => (INTEGER)input_dob_age,
	    inferred_age > 0                                                                        => (INTEGER)inferred_age,
	                                                                                               -1);
	
	property_owned_value_1 := if(property_owned_total > 0 AND property_owned_assessed_total = 0, -1, property_owned_assessed_total);
	
	out_st_region := map(
	    (out_st in ['IL', 'IN', 'MI', 'OH', 'WI', 'IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD'])                               => '1-Midwest',
	    (out_st in ['NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT'])                                                 => '2-Northeast',
	    (out_st in ['AL', 'KY', 'MS', 'TN', 'DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV', 'AR', 'LA', 'OK', 'TX']) => '3-South',
	    (out_st in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY', 'AK', 'CA', 'HI', 'OR', 'WA'])                         => '4-West',
	    (out_st in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI'])                                                       => '5-Island',
	    (out_st in ['AA', 'AE', 'AP'])                                                                                     => '6-Armed Forces',
	                                                                                                                          'other');
	
	address_change_recency := map(
	    attr_addrs_last30 > 0 => 30,
	    attr_addrs_last90 > 0 => 90,
	    attr_addrs_last12 > 0 => 12,
	    attr_addrs_last24 > 0 => 24,
	    attr_addrs_last36 > 0 => 36,
	    addrs_5yr > 0         => 60,
	    addrs_10yr > 0        => 120,
	    addrs_15yr > 0        => 180,
	                             999);
	
	any_bankruptcy := mth_ver_src_ldate_ba != NULL AND mth_ver_src_ldate_ba <= 120 OR (INTEGER)bankrupt > 0;
	
	dist2_a1toa2 := if(dist_a1toa2 = 9999, -9999, dist_a1toa2);
	
	dist2_a1toa3 := if(dist_a1toa3 = 9999, -9999, dist_a1toa3);
	
	dist2_a2toa3 := if(dist_a2toa3 = 9999, -9999, dist_a2toa3);
	
	distance_max_1 := max(dist2_a1toa2, dist2_a1toa3, dist2_a2toa3);
	
	add2_region := map(
	    (add2_st in ['IL', 'IN', 'MI', 'OH', 'WI', 'IA', 'KS', 'MN', 'MO', 'ND', 'NE', 'SD'])                               => '1-Midwest',
	    (add2_st in ['NJ', 'NY', 'PA', 'CT', 'MA', 'ME', 'NH', 'RI', 'VT'])                                                 => '2-Northeast',
	    (add2_st in ['AL', 'KY', 'MS', 'TN', 'DC', 'DE', 'FL', 'GA', 'MD', 'NC', 'SC', 'VA', 'WV', 'AR', 'LA', 'OK', 'TX']) => '3-South',
	    (add2_st in ['AZ', 'CO', 'ID', 'MT', 'NM', 'NV', 'UT', 'WY', 'AK', 'CA', 'HI', 'OR', 'WA'])                         => '4-West',
	    (add2_st in ['AS', 'FM', 'GU', 'MH', 'MP', 'PR', 'PW', 'VI'])                                                       => '5-Island',
	    (add2_st in ['AA', 'AE', 'AP'])                                                                                     => '6-Armed Forces',
	                                                                                                                           'other');
	
	header_first_seen2 := Common.SAS_Date((STRING)(header_first_seen));
	
	mth_header_first_seen_1_tmp := ROUNDUP((sysdate - header_first_seen2) / 30.5);
	
	mth_header_first_seen_1 := if(min(sysdate, header_first_seen2) = NULL, NULL, IF(mth_header_first_seen_1_tmp < 0, 0, mth_header_first_seen_1_tmp));
	
	add2_apt := add2_addr_type = 'H';
	
	add2_src_cnt_1 := Models.Common.countw((string)(add2_sources), ' !$%&()*+,-./;<^|');
	
	addrs_per_ssn_1 := if(NOT((INTEGER)ssnlength = 9), NULL, (INTEGER)addrs_per_ssn);
	
	mth_header_first_seen := if(NOT(truedid), NULL, mth_header_first_seen_1);
	
	estimated_income_1 := if(NOT(truedid), NULL, estimated_income_2);
	
	add2_src_cnt := if(NOT(truedid), NULL, add2_src_cnt_1);
	
	attr_num_nonderogs_1 := if(NOT(truedid), NULL, attr_num_nonderogs);
	
	ver_src_de := if(NOT(truedid), NULL, (INTEGER)ver_src_de_1);
	
	bankrupt_1 := if(NOT(truedid), NULL, (INTEGER)bankrupt);
	
	phones_per_adl_1 := if(NOT(truedid), NULL, phones_per_adl);
	
	dist_a2toa3_1 := if(NOT(truedid), NULL, dist_a2toa3);
	
	addr_stability_v2_1 := if(NOT(truedid), NULL, (INTEGER)addr_stability_v2);
	
	property_owned_value := if(NOT(truedid or addrpop), NULL, property_owned_value_1);
	
	i_subscore0 := map(
	    (add2_region in ['2-Northeast'])                         => 71.245806,
	    (add2_region in ['3-South'])                             => 48.148072,
	    (add2_region in ['1-Midwest'])                           => 44.064865,
	    (add2_region in ['4-West'])                              => -10.268455,
	    (add2_region in ['5-Island', '6-Armed Forces', 'other']) => 41.197526,
	                                                                41.197526);
	
	i_subscore1 := map(
	    NULL < addrs_per_ssn_1 AND addrs_per_ssn_1 < 3 => 66.571486,
	    3 <= addrs_per_ssn_1 AND addrs_per_ssn_1 < 6   => 43.273053,
	    6 <= addrs_per_ssn_1 AND addrs_per_ssn_1 < 9   => 42.338360,
	    9 <= addrs_per_ssn_1                           => 24.105685,
	                                                      41.197526);
	
	i_subscore2 := map(
	    NULL < lb_age AND lb_age < 18 => 41.197526,
	    18 <= lb_age AND lb_age < 65  => 53.213909,
	    65 <= lb_age AND lb_age < 84  => 36.048605,
	    84 <= lb_age                  => 14.812385,
	                                     41.197526);
	
	i_subscore3 := map(
	    0 <= mth_header_first_seen AND mth_header_first_seen < 276   => 24.965597,
	    276 <= mth_header_first_seen AND mth_header_first_seen < 327 => 41.940634,
	    327 <= mth_header_first_seen                                 => 55.038368,
	                                                                    41.197526);
	
	i_subscore4 := map(
	    NULL < estimated_income_1 AND estimated_income_1 < 1       => 41.197526,
	    1 <= estimated_income_1 AND estimated_income_1 < 20000     => 32.275644,
	    20000 <= estimated_income_1 AND estimated_income_1 < 23000 => 37.035634,
	    23000 <= estimated_income_1 AND estimated_income_1 < 27000 => 51.197541,
	    27000 <= estimated_income_1                                => 57.951495,
	                                                                  41.197526);
	
	i_subscore5 := map(
	    (inputssncharflag in ['0', '4'])           => 44.978384,
	    (inputssncharflag in ['1', '2', '3', '5']) => 22.528467,
	                                                  41.197526);
	
	i_subscore6 := map(
	    NULL < add2_src_cnt AND add2_src_cnt < 2 => 37.216467,
	    2 <= add2_src_cnt AND add2_src_cnt < 4   => 37.346576,
	    4 <= add2_src_cnt AND add2_src_cnt < 5   => 37.450591,
	    5 <= add2_src_cnt                        => 57.766021,
	                                                41.197526);
	
	i_subscore7 := map(
	    NULL < attr_num_nonderogs_1 AND attr_num_nonderogs_1 < 4 => 29.070707,
	    4 <= attr_num_nonderogs_1 AND attr_num_nonderogs_1 < 5   => 39.044466,
	    5 <= attr_num_nonderogs_1 AND attr_num_nonderogs_1 < 6   => 40.663236,
	    6 <= attr_num_nonderogs_1                                => 50.912449,
	                                                                41.197526);
	
	i_subscore8 := map(
	    (ver_src_de in [0]) => 18.613075,
	    (ver_src_de in [1]) => 43.521601,
	                           41.197526);
	
	i_subscore9 := map(
	    (address_change_recency in [30])                            => 60.439097,
	    (address_change_recency in [90])                            => 46.702887,
	    (address_change_recency in [12, 24, 36, 60, 120, 180, 999]) => 37.948208,
	                                                                   41.197526);
	
	i_subscore10 := map(
	    (bankrupt_1 in [0]) => 42.881287,
	    (bankrupt_1 in [1]) => 15.459513,
	                           41.197526);
	
	i_subscore11 := map(
	    NULL < phones_per_adl_1 AND phones_per_adl_1 < 1 => 35.871034,
	    1 <= phones_per_adl_1                            => 47.173476,
	                                                        41.197526);
	
	i_subscore12 := map(
	    NULL < dist_a2toa3_1 AND dist_a2toa3_1 < 1  => 49.413207,
	    1 <= dist_a2toa3_1 AND dist_a2toa3_1 < 9999 => 36.994182,
	    9999 <= dist_a2toa3_1                       => 41.197526,
	                                                   41.197526);
	
	i_subscore13 := map(
	    NULL < property_owned_value AND property_owned_value < 0        => 41.197526,
	    0 <= property_owned_value AND property_owned_value < 1          => 39.334436,
	    1 <= property_owned_value AND property_owned_value < 53040      => 39.533200,
	    53040 <= property_owned_value AND property_owned_value < 135960 => 39.687131,
	    135960 <= property_owned_value                                  => 59.962257,
	                                                                       41.197526);
	
	i_subscore14 := map(
	    ((INTEGER)addr_stability_v2_1 in [0])             => 41.197526,
	    ((INTEGER)addr_stability_v2_1 in [1, 2, 3, 4, 5]) => 35.493644,
	    ((INTEGER)addr_stability_v2_1 in [6])             => 45.417157,
	                                                41.197526);
	
	i_subscore15 := map(
	    (add2_apt in [0]) => 43.782453,
	    (add2_apt in [1]) => 34.648167,
	                         41.197526);
	
	add1_ownership_1 := map(
	    add1_applicant_owned and add1_family_owned => 4,
	    add1_applicant_owned                       => 3,
	    add1_family_owned                          => 2,
	    add1_occupant_owned                        => 1,
	                                                  0);
	
	add2_ownership := map(
	    add2_applicant_owned and add2_family_owned => 4,
	    add2_applicant_owned                       => 3,
	    add2_family_owned                          => 2,
	    add2_occupant_owned                        => 1,
	                                                  0);
	
	gong_did_last_seen2 := Common.SAS_Date((STRING)(gong_did_last_seen));
	
	mth_gong_did_last_seen_1_tmp := ROUNDUP((sysdate - gong_did_last_seen2) / 30.5);
	
	mth_gong_did_last_seen_1 := if(min(sysdate, gong_did_last_seen2) = NULL, NULL, IF(mth_gong_did_last_seen_1_tmp < 0, 0, mth_gong_did_last_seen_1_tmp));
	
	gong_last_7mo := 0 < mth_gong_did_last_seen_1 AND mth_gong_did_last_seen_1 < 7;
	
	add_bestmatch_level_1 := map(
	    add1_isbestmatch => 0,
	    add2_isbestmatch => 2,
	                        1);
	
	purchase_recency := map(
	    attr_num_purchase90 > 0  => 90,
	    attr_num_purchase180 > 0 => 180,
	    attr_num_purchase12 > 0  => 12,
	    attr_num_purchase24 > 0  => 24,
	    attr_num_purchase36 > 0  => 36,
	    attr_num_purchase60 > 0  => 60,
	    property_owned_total > 0 => 999,
	                                0);
	
	avg_lres_1 := if(NOT(truedid), NULL, avg_lres);
	
	attr_num_nonderogs24_1 := if(NOT(truedid), NULL, attr_num_nonderogs24);
	
	add2_market_total_value_1 := if(NOT(truedid), NULL, add2_market_total_value);
	
	distance_max := if(NOT(truedid), NULL, distance_max_1);
	
	add_bestmatch_level := if(NOT(truedid), NULL, add_bestmatch_level_1);
	
	add1_assessed_total_value_1 := if(NOT(truedid or addrpop), NULL, add1_assessed_total_value);
	
	add1_ownership := if(NOT(truedid or addrpop), NULL, add1_ownership_1);
	
	ssns_per_addr_1 := if(NOT(addrpop), NULL, ssns_per_addr);
	
	p_subscore0 := map(
	    (out_st_region in ['2-Northeast'])                         => 74.883732,
	    (out_st_region in ['3-South'])                             => 49.312540,
	    (out_st_region in ['1-Midwest'])                           => 47.818002,
	    (out_st_region in ['4-West'])                              => 0.619672,
	    (out_st_region in ['5-Island', '6-Armed Forces', 'other']) => 45.814817,
	                                                                  45.814817);
	
	p_subscore1 := map(
	    (add1_ownership in [2, 4]) => 30.059127,
	    (add1_ownership in [0, 1]) => 43.767432,
	    (add1_ownership in [3])    => 74.085793,
	                                  45.814817);
	
	p_subscore2 := map(
	    NULL < avg_lres_1 AND avg_lres_1 < 1   => 45.814817,
	    1 <= avg_lres_1 AND avg_lres_1 < 46    => 20.139638,
	    46 <= avg_lres_1 AND avg_lres_1 < 141  => 37.278407,
	    141 <= avg_lres_1 AND avg_lres_1 < 225 => 47.409992,
	    225 <= avg_lres_1 AND avg_lres_1 < 330 => 54.001586,
	    330 <= avg_lres_1                      => 66.103533,
	                                              45.814817);
	
	p_subscore3 := map(
	    NULL < property_owned_value AND property_owned_value < 0         => 45.814817,
	    0 <= property_owned_value AND property_owned_value < 1           => 29.646428,
	    1 <= property_owned_value AND property_owned_value < 46384       => 30.944710,
	    46384 <= property_owned_value AND property_owned_value < 75753   => 46.741691,
	    75753 <= property_owned_value AND property_owned_value < 171025  => 46.892926,
	    171025 <= property_owned_value AND property_owned_value < 242589 => 55.661631,
	    242589 <= property_owned_value AND property_owned_value < 646800 => 60.260583,
	    646800 <= property_owned_value                                   => 68.413910,
	                                                                        45.814817);
	
	p_subscore4 := map(
	    (add2_ownership in [0, 1, 2, 4]) => 42.455623,
	    (add2_ownership in [3])          => 66.802398,
	                                        45.814817);
	
	p_subscore5 := map(
	    NULL < add1_assessed_total_value_1 AND add1_assessed_total_value_1 < 1         => 45.814817,
	    1 <= add1_assessed_total_value_1 AND add1_assessed_total_value_1 < 16740       => 33.833472,
	    16740 <= add1_assessed_total_value_1 AND add1_assessed_total_value_1 < 97700   => 42.404469,
	    97700 <= add1_assessed_total_value_1 AND add1_assessed_total_value_1 < 178950  => 50.565840,
	    178950 <= add1_assessed_total_value_1 AND add1_assessed_total_value_1 < 302800 => 61.132178,
	    302800 <= add1_assessed_total_value_1                                          => 65.131158,
	                                                                                      45.814817);
	
	p_subscore6 := map(
	    (inputssncharflag in ['0', '4'])           => 49.190540,
	    (inputssncharflag in ['1', '2', '3', '5']) => 28.247863,
	                                                  45.814817);
	
	p_subscore7 := map(
	    NULL < estimated_income_1 AND estimated_income_1 < 1       => 45.814817,
	    1 <= estimated_income_1 AND estimated_income_1 < 21000     => 31.288918,
	    21000 <= estimated_income_1 AND estimated_income_1 < 23000 => 40.150052,
	    23000 <= estimated_income_1 AND estimated_income_1 < 30000 => 47.865342,
	    30000 <= estimated_income_1 AND estimated_income_1 < 47000 => 48.082546,
	    47000 <= estimated_income_1 AND estimated_income_1 < 67000 => 48.109796,
	    67000 <= estimated_income_1 AND estimated_income_1 < 93000 => 50.446042,
	    93000 <= estimated_income_1                                => 73.844853,
	                                                                  45.814817);
	
	p_subscore8 := map(
	    NULL < attr_num_nonderogs24_1 AND attr_num_nonderogs24_1 < 3 => 33.016157,
	    3 <= attr_num_nonderogs24_1 AND attr_num_nonderogs24_1 < 4   => 43.226929,
	    4 <= attr_num_nonderogs24_1 AND attr_num_nonderogs24_1 < 5   => 49.992797,
	    5 <= attr_num_nonderogs24_1 AND attr_num_nonderogs24_1 < 6   => 50.021894,
	    6 <= attr_num_nonderogs24_1                                  => 65.700719,
	                                                                    45.814817);
	
	p_subscore9 := map(
	    NULL < add2_market_total_value_1 AND add2_market_total_value_1 < 1         => 45.814817,
	    1 <= add2_market_total_value_1 AND add2_market_total_value_1 < 33500       => 26.243644,
	    33500 <= add2_market_total_value_1 AND add2_market_total_value_1 < 72053   => 37.971601,
	    72053 <= add2_market_total_value_1 AND add2_market_total_value_1 < 120400  => 42.422676,
	    120400 <= add2_market_total_value_1 AND add2_market_total_value_1 < 229420 => 54.457258,
	    229420 <= add2_market_total_value_1                                        => 61.144884,
	                                                                                  45.814817);
	
	p_subscore10 := map(
	    (gong_last_7mo in [0]) => 43.062712,
	    (gong_last_7mo in [1]) => 61.166267,
	                              45.814817);
	
	p_subscore11 := map(
	    NULL < ssns_per_addr_1 AND ssns_per_addr_1 < 1 => 45.814817,
	    1 <= ssns_per_addr_1 AND ssns_per_addr_1 < 2   => 54.604375,
	    2 <= ssns_per_addr_1 AND ssns_per_addr_1 < 5   => 54.569927,
	    5 <= ssns_per_addr_1 AND ssns_per_addr_1 < 11  => 46.304907,
	    11 <= ssns_per_addr_1 AND ssns_per_addr_1 < 16 => 41.086656,
	    16 <= ssns_per_addr_1                          => 32.530311,
	                                                      45.814817);
	
	p_subscore12 := map(
	    NULL < distance_max AND distance_max < 0 => 45.814817,
	    0 <= distance_max AND distance_max < 1   => 57.620734,
	    1 <= distance_max                        => 42.421656,
	                                                45.814817);
	
	p_subscore13 := map(
	    (add_bestmatch_level in [0]) => 42.076748,
	    (add_bestmatch_level in [1]) => 49.148362,
	    (add_bestmatch_level in [2]) => 54.656745,
	                                    45.814817);
	
	p_subscore14 := map(
	    (purchase_recency in [12, 24, 36, 90, 180]) => 56.618713,
	    (purchase_recency in [60, 999])             => 44.907009,
	    (purchase_recency in [0])                   => 37.641402,
	                                                   45.814817);
	
	p_subscore15 := map(
	    (any_bankruptcy in [0]) => 46.852888,
	    (any_bankruptcy in [1]) => 32.877685,
	                               45.814817);
	
	last_seen_p := map(
	    (INTEGER)ver_src_p = 0              => 0,
	    mth_ver_src_ldate_p = NULL => 1,
	    mth_ver_src_ldate_p >= 34  => 2,
	                                  3);
	
	add_apt_1 := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';
	
	avg_mo_per_addr_1 := if(NOT(truedid), NULL, avg_mo_per_addr);
	
	mth_ver_src_ldate_de := if(NOT(truedid), NULL, mth_ver_src_ldate_de_1);
	
	add1_naprop_1 := if(NOT(truedid or addrpop), NULL, add1_naprop);
	
	add_apt := if(NOT(truedid or addrpop), NULL, (INTEGER)add_apt_1);
	
	rc_phonezipflag_1 := if(NOT(hphnpop), NULL, (INTEGER)rc_phonezipflag);
	
	np_subscore0 := map(
	    (out_st_region in ['2-Northeast'])                         => 70.578201,
	    (out_st_region in ['3-South'])                             => 52.030588,
	    (out_st_region in ['1-Midwest'])                           => 36.168407,
	    (out_st_region in ['4-West'])                              => -4.402332,
	    (out_st_region in ['5-Island', '6-Armed Forces', 'other']) => 43.513156,
	                                                                  43.513156);
	
	np_subscore1 := map(
	    (last_seen_p in [0])    => 36.546013,
	    (last_seen_p in [2])    => 49.981355,
	    (last_seen_p in [1, 3]) => 67.114602,
	                               43.513156);
	
	np_subscore2 := map(
	    NULL < lb_age AND lb_age < 18 => 43.513156,
	    18 <= lb_age AND lb_age < 70  => 51.789241,
	    70 <= lb_age AND lb_age < 82  => 38.659527,
	    82 <= lb_age                  => 23.577256,
	                                     43.513156);
	
	np_subscore3 := map(
	    (add1_naprop_1 in [0])    => 52.316243,
	    (add1_naprop_1 in [2, 3]) => 35.211538,
	    (add1_naprop_1 in [1])    => 35.014695,
	                                 43.513156);
	
	np_subscore4 := map(
	    NULL < ssns_per_addr_1 AND ssns_per_addr_1 < 1 => 43.513156,
	    1 <= ssns_per_addr_1 AND ssns_per_addr_1 < 2   => 69.466418,
	    2 <= ssns_per_addr_1 AND ssns_per_addr_1 < 6   => 51.867268,
	    6 <= ssns_per_addr_1 AND ssns_per_addr_1 < 7   => 47.173863,
	    7 <= ssns_per_addr_1 AND ssns_per_addr_1 < 8   => 46.881360,
	    8 <= ssns_per_addr_1 AND ssns_per_addr_1 < 9   => 36.554948,
	    9 <= ssns_per_addr_1 AND ssns_per_addr_1 < 18  => 36.517321,
	    18 <= ssns_per_addr_1                          => 29.204695,
	                                                      43.513156);
	
	np_subscore5 := map(
	    (address_change_recency in [30])                            => 62.407195,
	    (address_change_recency in [90])                            => 56.404245,
	    (address_change_recency in [12, 24, 36, 60, 120, 180, 999]) => 39.313113,
	                                                                   43.513156);
	
	np_subscore6 := map(
	    NULL < avg_mo_per_addr_1 AND avg_mo_per_addr_1 < 1 => 43.513156,
	    1 <= avg_mo_per_addr_1 AND avg_mo_per_addr_1 < 34  => 34.389752,
	    34 <= avg_mo_per_addr_1 AND avg_mo_per_addr_1 < 50 => 37.028229,
	    50 <= avg_mo_per_addr_1 AND avg_mo_per_addr_1 < 82 => 42.584200,
	    82 <= avg_mo_per_addr_1                            => 53.391193,
	                                                          43.513156);
	
	np_subscore7 := map(
	    NULL < phones_per_adl_1 AND phones_per_adl_1 < 1 => 38.173661,
	    1 <= phones_per_adl_1                            => 51.106297,
	                                                        43.513156);
	
	np_subscore8 := map(
	    (add_apt in [0]) => 46.142502,
	    (add_apt in [1]) => 30.495134,
	                        43.513156);
	
	np_subscore9 := map(
	    (inputssncharflag in ['0', '4'])           => 46.192406,
	    (inputssncharflag in ['1', '2', '3', '5']) => 31.719738,
	                                                  43.513156);
	
	np_subscore10 := map(
	    NULL < avg_lres_1 AND avg_lres_1 < 52  => 33.627943,
	    52 <= avg_lres_1 AND avg_lres_1 < 107  => 42.921466,
	    107 <= avg_lres_1 AND avg_lres_1 < 212 => 42.979484,
	    212 <= avg_lres_1                      => 51.186465,
	                                              43.513156);
	
	np_subscore11 := map(
	    ver_src_de = 0                                         => 39.564184,
	    0 <= mth_ver_src_ldate_de AND mth_ver_src_ldate_de < 2 => 39.950624,
	    2 <= mth_ver_src_ldate_de AND mth_ver_src_ldate_de < 3 => 40.066927,
	    3 <= mth_ver_src_ldate_de AND mth_ver_src_ldate_de < 4 => 41.504550,
	    4 <= mth_ver_src_ldate_de                              => 48.222729,
	                                                              43.513156);
	
	np_subscore12 := map(
	    NULL < distance_max AND distance_max < 0 => 43.513156,
	    0 <= distance_max AND distance_max < 1   => 50.255855,
	    1 <= distance_max                        => 41.330011,
	                                                43.513156);
	
	np_subscore13 := map(
	    (any_bankruptcy in [0]) => 44.629421,
	    (any_bankruptcy in [1]) => 31.139696,
	                               43.513156);
	
	np_subscore14 := map(
	    NULL < attr_num_nonderogs_1 AND attr_num_nonderogs_1 < 3 => 35.532568,
	    3 <= attr_num_nonderogs_1 AND attr_num_nonderogs_1 < 4   => 39.848666,
	    4 <= attr_num_nonderogs_1 AND attr_num_nonderogs_1 < 5   => 42.118460,
	    5 <= attr_num_nonderogs_1 AND attr_num_nonderogs_1 < 6   => 46.435812,
	    6 <= attr_num_nonderogs_1                                => 47.958921,
	                                                                43.513156);
	
	np_subscore15 := map(
	    ((INTEGER)rc_phonezipflag_1 in [0]) => 45.187094,
	    ((INTEGER)rc_phonezipflag_1 in [1]) => 36.431740,
	    ((INTEGER)rc_phonezipflag_1 in [2]) => 43.513156,
	                                  43.513156);
	
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
	    i_subscore10 +
	    i_subscore11 +
	    i_subscore12 +
	    i_subscore13 +
	    i_subscore14 +
	    i_subscore15;
	
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
	    p_subscore15;
	
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
	    _segment = 1 => p_scaledscore,
	    _segment = 2 => np_scaledscore,
	                    NULL);
	
	rvc1110_2_1 := round(min(if(max(_in, (real)501) = NULL, -NULL, max(_in, (real)501)), 900));
	
	lien_flag := (INTEGER)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'L2', ',') > 0 or (INTEGER)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'LI', ',') > 0 or liens_recent_unreleased_count > 0 or liens_historical_unreleased_ct > 0;
	
	bk_flag := (rc_bansflag in ['1', '2']) or (INTEGER)indexw(StringLib.StringToUpperCase(trim(ver_sources, ALL)), 'BA', ',') > 0 or bankrupt_1 = 1 or filing_count > 0 or bk_recent_count > 0;
	
	scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or (INTEGER)input_dob_match_level >= 7 or (INTEGER)lien_flag > 0 or criminal_count > 0 or (INTEGER)bk_flag > 0 or truedid);
	
	rvc1110_2 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid), 222, rvc1110_2_1);
	
	glrc16 := (INTEGER)hphnpop > 0 and (INTEGER)addrpop > 0;
	
	glrc78 := (INTEGER)addrpop = 0;
	
	glrc99 := (INTEGER)add1_isbestmatch = 0;
	
	glrc9a := NOT(property_owned_total > 0 OR add1_naprop_1 = 4);
	
	glrc9c := unique_addr_count > 0;
	
	glrc9d := unique_addr_count > 0;
	
	glrc9e := (INTEGER)truedid = 1;
	
	glrc9f := (INTEGER)truedid = 1;
	
	glrc9k := (INTEGER)addrpop > 0;
	
	glrc9l := (INTEGER)addrpop = 0 AND dist_a2toa3_1 >= 5 AND dist_a2toa3_1 != 9999;
	
	glrc9m := (INTEGER)wealth_index < 5;
	
	glrc9r := (INTEGER)truedid = 1;
	
	glrc9v := (ssnlength in ['4', '9']);
	
	glrc9w := bankrupt_1 > 0;
	
	glrcpv := 1;
	
	glrcbl := 0;
	
	rcseginputs := _segment = 0;
	
	rcsegprop := _segment = 1;
	
	rcsegnon := _segment = 2;
	
	rcvalue16_1 := (integer)rcsegnon * (45.187094 - np_subscore15);
	
	rcvalue16 := (integer)glrc16 * if(max(rcvalue16_1) = NULL, NULL, sum(if(rcvalue16_1 = NULL, 0, rcvalue16_1)));
	
	rcvalue78_1 := (integer)rcseginputs * 81;
	
	rcvalue78 := (integer)glrc78 * if(max(rcvalue78_1) = NULL, NULL, sum(if(rcvalue78_1 = NULL, 0, rcvalue78_1)));
	
	rcvalue99_1 := (integer)rcsegprop * (54.656745 - p_subscore13);
	
	rcvalue99 := (integer)glrc99 * if(max(rcvalue99_1) = NULL, NULL, sum(if(rcvalue99_1 = NULL, 0, rcvalue99_1)));
	
	rcvalue9a_1 := (integer)rcsegprop * (74.085793 - p_subscore1);
	
	rcvalue9a_2 := (integer)rcsegnon * (52.316243 - np_subscore3);
	
	rcvalue9a_3 := (integer)rcsegnon * 39;
	
	rcvalue9a := (integer)glrc9a * if(max(rcvalue9a_1, rcvalue9a_2, rcvalue9a_3) = NULL, NULL, sum(if(rcvalue9a_1 = NULL, 0, rcvalue9a_1), if(rcvalue9a_2 = NULL, 0, rcvalue9a_2), if(rcvalue9a_3 = NULL, 0, rcvalue9a_3)));
	
	rcvalue9c_1 := (integer)rcsegprop * (66.103533 - p_subscore2);
	
	rcvalue9c_2 := (integer)rcsegnon * (53.391193 - np_subscore6);
	
	rcvalue9c_3 := (integer)rcsegnon * (51.186465 - np_subscore10);
	
	rcvalue9c := (integer)glrc9c * if(max(rcvalue9c_1, rcvalue9c_2, rcvalue9c_3) = NULL, NULL, sum(if(rcvalue9c_1 = NULL, 0, rcvalue9c_1), if(rcvalue9c_2 = NULL, 0, rcvalue9c_2), if(rcvalue9c_3 = NULL, 0, rcvalue9c_3)));
	
	rcvalue9d_1 := (integer)rcseginputs * (66.571486 - i_subscore1);
	
	rcvalue9d_2 := (integer)rcseginputs * (45.417157 - i_subscore14);
	
	rcvalue9d := (integer)glrc9d * if(max(rcvalue9d_1, rcvalue9d_2) = NULL, NULL, sum(if(rcvalue9d_1 = NULL, 0, rcvalue9d_1), if(rcvalue9d_2 = NULL, 0, rcvalue9d_2)));
	
	rcvalue9e_1 := (integer)rcseginputs * (57.766021 - i_subscore6);
	
	rcvalue9e_2 := (integer)rcseginputs * (50.912449 - i_subscore7);
	
	rcvalue9e_3 := (integer)rcseginputs * (43.521601 - i_subscore8);
	
	rcvalue9e_4 := (integer)rcsegprop * (65.700719 - p_subscore8);
	
	rcvalue9e_5 := (integer)rcsegnon * (47.958921 - np_subscore14);
	
	rcvalue9e := (integer)glrc9e * if(max(rcvalue9e_1, rcvalue9e_2, rcvalue9e_3, rcvalue9e_4, rcvalue9e_5) = NULL, NULL, sum(if(rcvalue9e_1 = NULL, 0, rcvalue9e_1), if(rcvalue9e_2 = NULL, 0, rcvalue9e_2), if(rcvalue9e_3 = NULL, 0, rcvalue9e_3), if(rcvalue9e_4 = NULL, 0, rcvalue9e_4), if(rcvalue9e_5 = NULL, 0, rcvalue9e_5)));
	
	rcvalue9f_1 := (integer)rcsegprop * (61.166267 - p_subscore10);
	
	rcvalue9f_2 := (integer)rcsegnon * (67.114602 - np_subscore1);
	
	rcvalue9f_3 := (integer)rcsegnon * (48.222729 - np_subscore11);
	
	rcvalue9f := (integer)glrc9f * if(max(rcvalue9f_1, rcvalue9f_2, rcvalue9f_3) = NULL, NULL, sum(if(rcvalue9f_1 = NULL, 0, rcvalue9f_1), if(rcvalue9f_2 = NULL, 0, rcvalue9f_2), if(rcvalue9f_3 = NULL, 0, rcvalue9f_3)));
	
	rcvalue9k_1 := (integer)rcseginputs * (43.782453 - i_subscore15);
	
	rcvalue9k_2 := (integer)rcsegnon * (46.142502 - np_subscore8);
	
	rcvalue9k := (integer)glrc9k * if(max(rcvalue9k_1, rcvalue9k_2) = NULL, NULL, sum(if(rcvalue9k_1 = NULL, 0, rcvalue9k_1), if(rcvalue9k_2 = NULL, 0, rcvalue9k_2)));
	
	rcvalue9l_1 := (integer)rcseginputs * (49.413207 - i_subscore12);
	
	rcvalue9l := (integer)glrc9l * if(max(rcvalue9l_1) = NULL, NULL, sum(if(rcvalue9l_1 = NULL, 0, rcvalue9l_1)));
	
	rcvalue9m_1 := (integer)rcseginputs * (57.951495 - i_subscore4);
	
	rcvalue9m_2 := (integer)rcsegprop * (73.844853 - p_subscore7);
	
	rcvalue9m := (integer)glrc9m * if(max(rcvalue9m_1, rcvalue9m_2) = NULL, NULL, sum(if(rcvalue9m_1 = NULL, 0, rcvalue9m_1), if(rcvalue9m_2 = NULL, 0, rcvalue9m_2)));
	
	rcvalue9r_1 := (integer)rcseginputs * (55.038368 - i_subscore3);
	
	rcvalue9r := (integer)glrc9r * if(max(rcvalue9r_1) = NULL, NULL, sum(if(rcvalue9r_1 = NULL, 0, rcvalue9r_1)));
	
	rcvalue9v_1 := (integer)rcseginputs * (44.978384 - i_subscore5);
	
	rcvalue9v_2 := (integer)rcsegprop * (49.19054 - p_subscore6);
	
	rcvalue9v_3 := (integer)rcsegnon * (46.192406 - np_subscore9);
	
	rcvalue9v := (integer)glrc9v * if(max(rcvalue9v_1, rcvalue9v_2, rcvalue9v_3) = NULL, NULL, sum(if(rcvalue9v_1 = NULL, 0, rcvalue9v_1), if(rcvalue9v_2 = NULL, 0, rcvalue9v_2), if(rcvalue9v_3 = NULL, 0, rcvalue9v_3)));
	
	rcvalue9w_1 := (integer)rcsegprop * (46.852888 - p_subscore15);
	
	rcvalue9w_2 := (integer)rcsegnon * (44.629421 - np_subscore13);
	
	rcvalue9w_3 := (integer)rcseginputs * (42.881287 - i_subscore10);
	
	rcvalue9w := (integer)glrc9w * if(max(rcvalue9w_1, rcvalue9w_2, rcvalue9w_3) = NULL, NULL, sum(if(rcvalue9w_1 = NULL, 0, rcvalue9w_1), if(rcvalue9w_2 = NULL, 0, rcvalue9w_2), if(rcvalue9w_3 = NULL, 0, rcvalue9w_3)));
	
	rcvaluepv_1 := (integer)rcseginputs * (59.962257 - i_subscore13);
	
	rcvaluepv_2 := (integer)rcsegprop * (68.41391 - p_subscore3);
	
	rcvaluepv_3 := (integer)rcsegprop * (65.131158 - p_subscore5);
	
	rcvaluepv_4 := (integer)rcsegprop * (61.144884 - p_subscore9);
	
	rcvaluepv := glrcpv * if(max(rcvaluepv_1, rcvaluepv_2, rcvaluepv_3, rcvaluepv_4) = NULL, NULL, sum(if(rcvaluepv_1 = NULL, 0, rcvaluepv_1), if(rcvaluepv_2 = NULL, 0, rcvaluepv_2), if(rcvaluepv_3 = NULL, 0, rcvaluepv_3), if(rcvaluepv_4 = NULL, 0, rcvaluepv_4)));
	
	rcvaluebl_1 := (integer)rcseginputs * (71.245806 - i_subscore0);
	
	rcvaluebl_2 := (integer)rcseginputs * (60.439097 - i_subscore9);
	
	rcvaluebl_3 := (integer)rcsegprop * (74.883732 - p_subscore0);
	
	rcvaluebl_4 := (integer)rcsegprop * (54.604375 - p_subscore11);
	
	rcvaluebl_5 := (integer)rcsegprop * (56.618713 - p_subscore14);
	
	rcvaluebl_6 := (integer)rcsegnon * (70.578201 - np_subscore0);
	
	rcvaluebl_7 := (integer)rcsegnon * (69.466418 - np_subscore4);
	
	rcvaluebl_8 := (integer)rcsegnon * (62.407195 - np_subscore5);
	
	rcvaluebl_9 := (integer)rcseginputs * (47.173476 - i_subscore11);
	
	rcvaluebl_10 := (integer)rcsegnon * (51.106297 - np_subscore7);
	
	rcvaluebl_11 := (integer)rcseginputs * (53.213909 - i_subscore2);
	
	rcvaluebl_12 := (integer)rcsegnon * (51.789241 - np_subscore2);
	
	rcvaluebl_13 := (integer)rcsegprop * (57.620734 - p_subscore12);
	
	rcvaluebl_14 := (integer)rcsegnon * (50.255855 - np_subscore12);
	
	rcvaluebl_15 := (integer)rcsegprop * (66.802398 - p_subscore4);
	
	rcvaluebl := glrcbl * if(max(rcvaluebl_1, rcvaluebl_2, rcvaluebl_3, rcvaluebl_4, rcvaluebl_5, rcvaluebl_6, rcvaluebl_7, rcvaluebl_8, rcvaluebl_9, rcvaluebl_10, rcvaluebl_11, rcvaluebl_12, rcvaluebl_13, rcvaluebl_14, rcvaluebl_15) = NULL, NULL, sum(if(rcvaluebl_1 = NULL, 0, rcvaluebl_1), if(rcvaluebl_2 = NULL, 0, rcvaluebl_2), if(rcvaluebl_3 = NULL, 0, rcvaluebl_3), if(rcvaluebl_4 = NULL, 0, rcvaluebl_4), if(rcvaluebl_5 = NULL, 0, rcvaluebl_5), if(rcvaluebl_6 = NULL, 0, rcvaluebl_6), if(rcvaluebl_7 = NULL, 0, rcvaluebl_7), if(rcvaluebl_8 = NULL, 0, rcvaluebl_8), if(rcvaluebl_9 = NULL, 0, rcvaluebl_9), if(rcvaluebl_10 = NULL, 0, rcvaluebl_10), if(rcvaluebl_11 = NULL, 0, rcvaluebl_11), if(rcvaluebl_12 = NULL, 0, rcvaluebl_12), if(rcvaluebl_13 = NULL, 0, rcvaluebl_13), if(rcvaluebl_14 = NULL, 0, rcvaluebl_14), if(rcvaluebl_15 = NULL, 0, rcvaluebl_15)));
	
	//*************************************************************************************//
	// I have no idea how the reason code logic gets implemented in ECL, so everything below 
	// probably needs to get changed or replaced.  The methodology for creating the reason codes is
	// very similar to the logic used by the RiskView 4.0 scores, so you might want to consult
	// that model code for guidance on implementing reason codes. 
	//*************************************************************************************//
	
	ds_layout := {STRING rc, REAL value};
	rc_dataset := DATASET([
		{'16',	RCValue16},
		{'78',	RCValue78},
		{'99',	RCValue99},
		{'9A',	RCValue9A},
		{'9C',	RCValue9C},
		{'9D',	RCValue9D},
		{'9E',	RCValue9E},
		{'9F',	RCValue9F},
		{'9K',	RCValue9K},
		{'9L',	RCValue9L},
		{'9M',	RCValue9M},
		{'9R',	RCValue9R},
		{'9V',	RCValue9V},
		{'9W',	RCValue9W},
		{'PV',	RCValuePV},
		{'BL',	RCValueBL}
	    ], ds_layout)(value > 0);
	
	rcs_top4 := choosen(sort(rc_dataset, -value), 4);
	
	zeros := DATASET([{'00',''}, {'00',''}, {'00',''}, {'00',''}, {'00',''}], Risk_Indicators.Layout_Desc);
	
	rcTemp := map(
																	rvc1110_2 = 222 => dataset([{'9X', NULL}], ds_layout),
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
											(STRING3)rvc1110_2
										);

	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.truedid := truedid;
		SELF.out_unit_desig := out_unit_desig;
		SELF.out_sec_range := out_sec_range;
		SELF.out_st := out_st;
		SELF.out_addr_type := out_addr_type;
		SELF.in_dob := in_dob;
		SELF.nas_summary := nas_summary;
		SELF.nap_summary := nap_summary;
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.rc_bansflag := rc_bansflag;
		SELF.combo_dobscore := combo_dobscore;
		SELF.ver_sources := ver_sources;
		SELF.ver_sources_last_seen := ver_sources_last_seen;
		SELF.addrpop := addrpop;
		SELF.ssnlength := ssnlength;
		SELF.hphnpop := hphnpop;
		SELF.age := age;
		SELF.add1_isbestmatch := add1_isbestmatch;
		SELF.add1_applicant_owned := add1_applicant_owned;
		SELF.add1_occupant_owned := add1_occupant_owned;
		SELF.add1_family_owned := add1_family_owned;
		SELF.add1_naprop := add1_naprop;
		SELF.property_owned_total := property_owned_total;
		SELF.property_owned_assessed_total := property_owned_assessed_total;
		SELF.property_sold_total := property_sold_total;
		SELF.dist_a1toa2 := dist_a1toa2;
		SELF.dist_a1toa3 := dist_a1toa3;
		SELF.dist_a2toa3 := dist_a2toa3;
		SELF.add2_isbestmatch := add2_isbestmatch;
		SELF.add2_addr_type := add2_addr_type;
		SELF.add2_sources := add2_sources;
		SELF.add2_applicant_owned := add2_applicant_owned;
		SELF.add2_occupant_owned := add2_occupant_owned;
		SELF.add2_family_owned := add2_family_owned;
		SELF.add2_st := add2_st;
		SELF.addrs_5yr := addrs_5yr;
		SELF.addrs_10yr := addrs_10yr;
		SELF.addrs_15yr := addrs_15yr;
		SELF.unique_addr_count := unique_addr_count;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.header_first_seen := header_first_seen;
		SELF.inputssncharflag := inputssncharflag;
		SELF.attr_addrs_last30 := attr_addrs_last30;
		SELF.attr_addrs_last90 := attr_addrs_last90;
		SELF.attr_addrs_last12 := attr_addrs_last12;
		SELF.attr_addrs_last24 := attr_addrs_last24;
		SELF.attr_addrs_last36 := attr_addrs_last36;
		SELF.attr_num_purchase90 := attr_num_purchase90;
		SELF.attr_num_purchase180 := attr_num_purchase180;
		SELF.attr_num_purchase12 := attr_num_purchase12;
		SELF.attr_num_purchase24 := attr_num_purchase24;
		SELF.attr_num_purchase36 := attr_num_purchase36;
		SELF.attr_num_purchase60 := attr_num_purchase60;
		SELF.bankrupt := bankrupt;
		SELF.filing_count := filing_count;
		SELF.bk_recent_count := bk_recent_count;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.criminal_count := criminal_count;
		SELF.wealth_index := wealth_index;
		SELF.input_dob_age := input_dob_age;
		SELF.input_dob_match_level := input_dob_match_level;
		SELF.inferred_age := inferred_age;
		SELF.addrs_per_ssn := addrs_per_ssn;
		SELF.estimated_income_2 := estimated_income_2;
		SELF.attr_num_nonderogs := attr_num_nonderogs;
		SELF.phones_per_adl := phones_per_adl;
		SELF.addr_stability_v2 := addr_stability_v2;
		SELF.avg_lres := avg_lres;
		SELF.attr_num_nonderogs24 := attr_num_nonderogs24;
		SELF.add1_assessed_total_value := add1_assessed_total_value;
		SELF.add2_market_total_value := add2_market_total_value;
		SELF.ssns_per_addr := ssns_per_addr;
		SELF.avg_mo_per_addr := avg_mo_per_addr;
		SELF.rc_phonezipflag := rc_phonezipflag;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF._segment := _segment;
		SELF.sysdate := sysdate;
		SELF.ver_src_ba_pos := ver_src_ba_pos;
		SELF.ver_src_ldate_ba := ver_src_ldate_ba;
		SELF.ver_src_ldate_ba2 := ver_src_ldate_ba2;
		SELF.mth_ver_src_ldate_ba := mth_ver_src_ldate_ba;
		SELF.ver_src_de_pos := ver_src_de_pos;
		SELF.ver_src_de_1 := ver_src_de_1;
		SELF.ver_src_ldate_de := ver_src_ldate_de;
		SELF.ver_src_ldate_de2 := ver_src_ldate_de2;
		SELF.mth_ver_src_ldate_de_1 := mth_ver_src_ldate_de_1;
		SELF.ver_src_p_pos := ver_src_p_pos;
		SELF.ver_src_p := ver_src_p;
		SELF.ver_src_ldate_p := ver_src_ldate_p;
		SELF.ver_src_ldate_p2 := ver_src_ldate_p2;
		SELF.mth_ver_src_ldate_p := mth_ver_src_ldate_p;
		SELF.lb_age := lb_age;
		SELF.property_owned_value_1 := property_owned_value_1;
		SELF.out_st_region := out_st_region;
		SELF.address_change_recency := address_change_recency;
		SELF.any_bankruptcy := any_bankruptcy;
		SELF.dist2_a1toa2 := dist2_a1toa2;
		SELF.dist2_a1toa3 := dist2_a1toa3;
		SELF.dist2_a2toa3 := dist2_a2toa3;
		SELF.distance_max_1 := distance_max_1;
		SELF.add2_region := add2_region;
		SELF.header_first_seen2 := header_first_seen2;
		SELF.mth_header_first_seen_1 := mth_header_first_seen_1;
		SELF.add2_apt := add2_apt;
		SELF.add2_src_cnt_1 := add2_src_cnt_1;
		SELF.addrs_per_ssn_1 := addrs_per_ssn_1;
		SELF.mth_header_first_seen := mth_header_first_seen;
		SELF.estimated_income_1 := estimated_income_1;
		SELF.add2_src_cnt := add2_src_cnt;
		SELF.attr_num_nonderogs_1 := attr_num_nonderogs_1;
		SELF.ver_src_de := ver_src_de;
		SELF.bankrupt_1 := bankrupt_1;
		SELF.phones_per_adl_1 := phones_per_adl_1;
		SELF.dist_a2toa3_1 := dist_a2toa3_1;
		SELF.addr_stability_v2_1 := addr_stability_v2_1;
		SELF.property_owned_value := property_owned_value;
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
		SELF.i_subscore11 := i_subscore11;
		SELF.i_subscore12 := i_subscore12;
		SELF.i_subscore13 := i_subscore13;
		SELF.i_subscore14 := i_subscore14;
		SELF.i_subscore15 := i_subscore15;
		SELF.add1_ownership_1 := add1_ownership_1;
		SELF.add2_ownership := add2_ownership;
		SELF.gong_did_last_seen2 := gong_did_last_seen2;
		SELF.mth_gong_did_last_seen_1 := mth_gong_did_last_seen_1;
		SELF.gong_last_7mo := gong_last_7mo;
		SELF.add_bestmatch_level_1 := add_bestmatch_level_1;
		SELF.purchase_recency := purchase_recency;
		SELF.avg_lres_1 := avg_lres_1;
		SELF.attr_num_nonderogs24_1 := attr_num_nonderogs24_1;
		SELF.add2_market_total_value_1 := add2_market_total_value_1;
		SELF.distance_max := distance_max;
		SELF.add_bestmatch_level := add_bestmatch_level;
		SELF.add1_assessed_total_value_1 := add1_assessed_total_value_1;
		SELF.add1_ownership := add1_ownership;
		SELF.ssns_per_addr_1 := ssns_per_addr_1;
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
		SELF.last_seen_p := last_seen_p;
		SELF.add_apt_1 := add_apt_1;
		SELF.avg_mo_per_addr_1 := avg_mo_per_addr_1;
		SELF.mth_ver_src_ldate_de := mth_ver_src_ldate_de;
		SELF.add1_naprop_1 := add1_naprop_1;
		SELF.add_apt := add_apt;
		SELF.rc_phonezipflag_1 := rc_phonezipflag_1;
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
		SELF.i_scaledscore := i_scaledscore;
		SELF.p_scaledscore := p_scaledscore;
		SELF.np_scaledscore := np_scaledscore;
		SELF._in := _in;
		SELF.rvc1110_2_1 := rvc1110_2_1;
		SELF.lien_flag := lien_flag;
		SELF.bk_flag := bk_flag;
		SELF.scored_222s := scored_222s;
		SELF.rvc1110_2 := rvc1110_2;
		SELF.glrc16 := glrc16;
		SELF.glrc78 := glrc78;
		SELF.glrc99 := glrc99;
		SELF.glrc9a := glrc9a;
		SELF.glrc9c := glrc9c;
		SELF.glrc9d := glrc9d;
		SELF.glrc9e := glrc9e;
		SELF.glrc9f := glrc9f;
		SELF.glrc9k := glrc9k;
		SELF.glrc9l := glrc9l;
		SELF.glrc9m := glrc9m;
		SELF.glrc9r := glrc9r;
		SELF.glrc9v := glrc9v;
		SELF.glrc9w := glrc9w;
		SELF.glrcpv := glrcpv;
		SELF.glrcbl := glrcbl;
		SELF.rcseginputs := rcseginputs;
		SELF.rcsegprop := rcsegprop;
		SELF.rcsegnon := rcsegnon;
		SELF.rcvalue16_1 := rcvalue16_1;
		SELF.rcvalue16 := rcvalue16;
		SELF.rcvalue78_1 := rcvalue78_1;
		SELF.rcvalue78 := rcvalue78;
		SELF.rcvalue99_1 := rcvalue99_1;
		SELF.rcvalue99 := rcvalue99;
		SELF.rcvalue9a_1 := rcvalue9a_1;
		SELF.rcvalue9a_2 := rcvalue9a_2;
		SELF.rcvalue9a_3 := rcvalue9a_3;
		SELF.rcvalue9a := rcvalue9a;
		SELF.rcvalue9c_1 := rcvalue9c_1;
		SELF.rcvalue9c_2 := rcvalue9c_2;
		SELF.rcvalue9c_3 := rcvalue9c_3;
		SELF.rcvalue9c := rcvalue9c;
		SELF.rcvalue9d_1 := rcvalue9d_1;
		SELF.rcvalue9d_2 := rcvalue9d_2;
		SELF.rcvalue9d := rcvalue9d;
		SELF.rcvalue9e_1 := rcvalue9e_1;
		SELF.rcvalue9e_2 := rcvalue9e_2;
		SELF.rcvalue9e_3 := rcvalue9e_3;
		SELF.rcvalue9e_4 := rcvalue9e_4;
		SELF.rcvalue9e_5 := rcvalue9e_5;
		SELF.rcvalue9e := rcvalue9e;
		SELF.rcvalue9f_1 := rcvalue9f_1;
		SELF.rcvalue9f_2 := rcvalue9f_2;
		SELF.rcvalue9f_3 := rcvalue9f_3;
		SELF.rcvalue9f := rcvalue9f;
		SELF.rcvalue9k_1 := rcvalue9k_1;
		SELF.rcvalue9k_2 := rcvalue9k_2;
		SELF.rcvalue9k := rcvalue9k;
		SELF.rcvalue9l_1 := rcvalue9l_1;
		SELF.rcvalue9l := rcvalue9l;
		SELF.rcvalue9m_1 := rcvalue9m_1;
		SELF.rcvalue9m_2 := rcvalue9m_2;
		SELF.rcvalue9m := rcvalue9m;
		SELF.rcvalue9r_1 := rcvalue9r_1;
		SELF.rcvalue9r := rcvalue9r;
		SELF.rcvalue9v_1 := rcvalue9v_1;
		SELF.rcvalue9v_2 := rcvalue9v_2;
		SELF.rcvalue9v_3 := rcvalue9v_3;
		SELF.rcvalue9v := rcvalue9v;
		SELF.rcvalue9w_1 := rcvalue9w_1;
		SELF.rcvalue9w_2 := rcvalue9w_2;
		SELF.rcvalue9w_3 := rcvalue9w_3;
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
		SELF.rcvaluebl_5 := rcvaluebl_5;
		SELF.rcvaluebl_6 := rcvaluebl_6;
		SELF.rcvaluebl_7 := rcvaluebl_7;
		SELF.rcvaluebl_8 := rcvaluebl_8;
		SELF.rcvaluebl_9 := rcvaluebl_9;
		SELF.rcvaluebl_10 := rcvaluebl_10;
		SELF.rcvaluebl_11 := rcvaluebl_11;
		SELF.rcvaluebl_12 := rcvaluebl_12;
		SELF.rcvaluebl_13 := rcvaluebl_13;
		SELF.rcvaluebl_14 := rcvaluebl_14;
		SELF.rcvaluebl_15 := rcvaluebl_15;
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
