IMPORT ut, EASI, RiskWise, RiskWiseFCRA, Risk_Indicators, std;

EXPORT rsn1105_3_0 (GROUPED DATASET(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;

			/* Model Input Variables */
			INTEGER adl_hphn;
			STRING c_span_lang;
			BOOLEAN replaced_with_cell;
			INTEGER nap_summary;
			STRING nap_status;
			STRING rc_hriskphoneflag;
			STRING rc_hphonetypeflag;
			INTEGER add1_avm_automated_valuation;
			INTEGER add1_source_count;
			INTEGER ssns_per_adl;
			INTEGER inq_collection_count;
			INTEGER inq_highriskcredit_count;
			INTEGER inq_communications_count;
			INTEGER attr_eviction_count12;
			INTEGER attr_eviction_count36;
			INTEGER attr_eviction_count60;
			STRING disposition;
			INTEGER liens_recent_unreleased_count;
			INTEGER liens_historical_unreleased_ct;
			INTEGER criminal_count;
			INTEGER felony_count;
			INTEGER rel_count;
			INTEGER rel_bankrupt_count;
			INTEGER rel_prop_owned_count;
			INTEGER rel_educationunder12_count;
			INTEGER rel_educationover12_count;
			STRING ams_age;
			STRING wealth_index;
			STRING input_dob_age;
			INTEGER inferred_age;
			INTEGER reported_dob;
			INTEGER archive_date;

			/* Model Intermediate Variables */
			INTEGER sysdate;
			INTEGER adl_hphn_lvl;
			INTEGER c_span_lang_lvl;
			INTEGER inq_coll_hrcred_comm_lvl;
			INTEGER criminal_lvl;
			INTEGER _reported_dob;
			INTEGER reported_age;
			INTEGER applicant_age;
			INTEGER applicant_age_lvl;
			STRING _disposition;
			INTEGER bk_level;
			INTEGER liens_unreleased_lvl;
			INTEGER add1_source_lvl;
			INTEGER rel_prop_own_pct;
			INTEGER rel_prop_own_pct_a;
			INTEGER rel_edover12_count_1;
			INTEGER rel_edover8_count_1;
			INTEGER rel_edover8_count;
			INTEGER rel_edover12_count;
			INTEGER rel_edover8_pct;
			INTEGER rel_edover12_pct;
			INTEGER rel_good_education;
			BOOLEAN phn_cell;
			INTEGER ssns_per_adl_lvl;
			BOOLEAN contrary_phn;
			BOOLEAN verlst_p;
			BOOLEAN veradd_p;
			BOOLEAN verphn_p;
			INTEGER ver_nap;
			INTEGER rel_bk_lvl;
			INTEGER last_eviction_lvl;
			INTEGER wealth_index_lvl;
			INTEGER add1_avm_automated_lvl;
			REAL subscore0;
			REAL subscore1;
			REAL subscore2;
			REAL subscore3;
			REAL subscore4;
			REAL subscore5;
			REAL subscore6;
			REAL subscore7;
			REAL subscore8;
			REAL subscore9;
			REAL subscore10;
			REAL subscore11;
			REAL subscore12;
			REAL subscore13;
			REAL subscore14;
			REAL subscore15;
			REAL subscore16;
			REAL subscore_total;
			INTEGER rsn1105_3_0;
		END;
		Layout_Debug doModel(clam le, EASI.Key_Easi_Census ri) := TRANSFORM
	#else
		Models.Layout_RecoverScore doModel(clam le, EASI.Key_Easi_Census ri) := TRANSFORM
	#end

	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	adl_hphn                         := le.adl_shell_flags.adl_hphn;
	c_span_lang                      := TRIM(ri.SPAN_LANG);
	nap_summary                      := le.iid.nap_summary;
	nap_status                       := le.iid.nap_status;
	rc_hriskphoneflag                := TRIM(le.iid.hriskphoneflag);
	rc_hphonetypeflag                := TRIM(le.iid.hphonetypeflag);
	replaced_with_cell               := (adl_hphn IN [0,3] AND (rc_hriskphoneflag IN ['1','3'] OR rc_hphonetypeflag IN ['1','3']));
	add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
	add1_source_count                := le.address_verification.input_address_information.source_count;
	ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
	inq_collection_count             := le.acc_logs.collection.counttotal;
	inq_highriskcredit_count         := le.acc_logs.highriskcredit.counttotal;
	inq_communications_count         := le.acc_logs.communications.counttotal;
	attr_eviction_count12            := le.bjl.eviction_count12;
	attr_eviction_count36            := le.bjl.eviction_count36;
	attr_eviction_count60            := le.bjl.eviction_count60;
	disposition                      := le.bjl.disposition;
	liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
	liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
	criminal_count                   := le.bjl.criminal_count;
	felony_count                     := le.bjl.felony_count;
	rel_count                        := le.relatives.relative_count;
	rel_bankrupt_count               := le.relatives.relative_bankrupt_count;
	rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
	rel_educationunder12_count       := le.relatives.relative_educationunder12_count;
	rel_educationover12_count        := le.relatives.relative_educationover12_count;
	ams_age                          := le.student.age;
	wealth_index                     := le.wealth_indicator;
	input_dob_age                    := le.shell_input.age;
	inferred_age                     := le.inferred_age;
	reported_dob                     := le.reported_dob;
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)(((STRING)le.historydate)[1..6]));

	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	sysdate := Common.SAS_Date((STRING)(string)(archive_date));
	
	adl_hphn_lvl := map(
	    adl_hphn = 1 => 0,
	    adl_hphn = 2 => 3,
	    adl_hphn = 3 => 2,
	                    1);
	
	c_span_lang_lvl := map(
			TRIM(C_SPAN_LANG) = ''						=> 1,
	    (INTEGER)TRIM(C_SPAN_LANG) >= 180 => 3,
	    (INTEGER)TRIM(C_SPAN_LANG) >= 140 => 2,
																					1);
	
	inq_coll_hrcred_comm_lvl := map(
	    (Inq_Collection_count > 0 or Inq_HighRiskCredit_count > 0) and Inq_Communications_count > 0 => 4,
	    Inq_HighRiskCredit_count > 0                                                                => 3,
	                                                                                                   min(if(Inq_Collection_count = NULL, -NULL, Inq_Collection_count), 2));
	
	criminal_lvl := map(
	    felony_count > 0   => 2,
	    criminal_count > 0 => 1,
	                          0);
	
	_reported_dob := Common.SAS_Date((STRING)(reported_dob)); 
	
	reported_age := IF(_reported_dob = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));
	
	applicant_age := map(
	    (INTEGER)input_dob_age > 0 => (INTEGER)input_dob_age,
	    (INTEGER)inferred_age > 0  => (INTEGER)inferred_age,
	    (INTEGER)reported_age > 0  => (INTEGER)reported_age,
	    (INTEGER)ams_age > 0       => (INTEGER)ams_age,
	                                 -1);
	
	applicant_age_lvl := map(
	    applicant_age <= 0  => 1,
	    applicant_age <= 30 => 2,
	    applicant_age <= 60 => 0,
	                           1);
	
	_disposition := map(
	    StringLib.StringToUpperCase(disposition) = 'DISMISSED' => 'DISMISSED',
	    disposition = ' '                                      => 'NONE',
	                                                              'DISCHARGE');
	
	bk_level := map(
	    _disposition = 'DISMISSED' => 2,
	    _disposition = 'DISCHARGE' => 0,
	                                  1);
	
	liens_unreleased_lvl := map(
	    liens_historical_unreleased_ct >= 2 and liens_recent_unreleased_count >= 2 => 3,
	    liens_recent_unreleased_count >= 2                                         => 2,
	                                                                                  min(if(liens_historical_unreleased_ct = NULL, -NULL, liens_historical_unreleased_ct), 2));
	
	add1_source_lvl := map(
	    add1_source_count > 8 => 3,
	    add1_source_count > 6 => 2,
	    add1_source_count > 4 => 1,
	                             0);
	
	rel_prop_own_pct := map(
	    rel_count = 0 => -1,
	                     truncate(rel_prop_owned_count * 100 / rel_count));
	
	rel_prop_own_pct_a := map(
	    rel_count = 0          => -1,
	    rel_prop_own_pct >= 20 => 1,
	                              0);
	
	rel_edover12_count_1 := rel_educationover12_count;
	
	rel_edover8_count_1 := if(max(rel_edover12_count_1, rel_educationunder12_count) = NULL, NULL, sum(if(rel_edover12_count_1 = NULL, 0, rel_edover12_count_1), if(rel_educationunder12_count = NULL, 0, rel_educationunder12_count)));
		
	rel_edover12_count := rel_edover12_count_1;
	
	rel_edover8_count := rel_edover8_count_1;
	
	rel_edover8_pct := if(rel_count > 0, truncate(rel_edover8_count * 100 / rel_count), -1);
	
	rel_edover12_pct := if(rel_count > 0, truncate(rel_edover12_count * 100 / rel_count), -1);
	
	rel_good_education := if(rel_edover12_pct >= 90 or rel_edover8_pct >= 100, 1, 0);
	
	phn_cell := (rc_hriskphoneflag in ['1', '3']) or (rc_hphonetypeflag in ['1', '3']);
	
	ssns_per_adl_lvl := map(
	    ssns_per_adl = 0 => 1,
	    ssns_per_adl = 1 => 0,
	    ssns_per_adl = 2 => 1,
	                        2);
	
	contrary_phn := (nap_summary in [1]);
	
	verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);
	
	veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);
	
	verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);
	
	ver_nap := map(
	    nap_status = 'D'                                         => 0,
	    not(contrary_phn) and verphn_p and veradd_p and verlst_p => 2,
	    not(contrary_phn)                                        => 1,
	                                                                0);
	
	rel_bk_lvl := map(
	    rel_bankrupt_count >= 6 => 3,
	    rel_bankrupt_count >= 3 => 2,
	    rel_bankrupt_count >= 1 => 1,
	                               0);
	
	last_eviction_lvl := map(
	    attr_eviction_count12 > 0 => 2,
	    attr_eviction_count36 > 0 => 1,
	    attr_eviction_count60 > 0 => 0,
	                                 -1);
	
	wealth_index_lvl := map(
	    (wealth_index in ['5', '6'])      => 3,
	    (wealth_index in ['2', '3', '4']) => 2,
	    wealth_index = (string)1          => 1,
	                                         0);
	
	add1_avm_automated_lvl := map(
	    add1_avm_automated_valuation = 0                                                 => -1,
	    0 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 50000       => 0,
	    50000 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 125000  => 1,
	    125000 < add1_avm_automated_valuation AND add1_avm_automated_valuation <= 225000 => 2,
	                                                                                        3);
	
	subscore0 := map(
	    (adl_hphn_lvl in [0]) => 12.337545,
	    (adl_hphn_lvl in [1]) => 20.635143,
	    (adl_hphn_lvl in [2]) => 50.247286,
	    (adl_hphn_lvl in [3]) => 57.368584,
	                             41.172527);
	
	subscore1 := map(
	    (c_span_lang_lvl in [1]) => 49.046940,
	    (c_span_lang_lvl in [2]) => 27.533510,
	    (c_span_lang_lvl in [3]) => 20.163878,
	                                41.172527);
	
	subscore2 := map(
	    (inq_coll_hrcred_comm_lvl in [0]) => 69.896032,
	    (inq_coll_hrcred_comm_lvl in [1]) => 50.414951,
	    (inq_coll_hrcred_comm_lvl in [2]) => 42.581542,
	    (inq_coll_hrcred_comm_lvl in [3]) => 34.473835,
	    (inq_coll_hrcred_comm_lvl in [4]) => 24.252868,
	                                         41.172527);
	
	subscore3 := map(
	    (criminal_lvl in [0]) => 44.513075,
	    (criminal_lvl in [1]) => 33.649695,
	    (criminal_lvl in [2]) => 14.244434,
	                             41.172527);
	
	subscore4 := map(
	    (applicant_age_lvl in [0]) => 33.177729,
	    (applicant_age_lvl in [1]) => 31.877993,
	    (applicant_age_lvl in [2]) => 61.295075,
	                                  41.172527);
	
	subscore5 := map(
	    (bk_level in [0]) => 55.921722,
	    (bk_level in [1]) => 37.453996,
	    (bk_level in [2]) => 31.998765,
	                         41.172527);
	
	subscore6 := map(
	    (liens_unreleased_lvl in [0]) => 47.297542,
	    (liens_unreleased_lvl in [1]) => 39.791054,
	    (liens_unreleased_lvl in [2]) => 30.796768,
	    (liens_unreleased_lvl in [3]) => 16.809706,
	                                     41.172527);
	
	subscore7 := map(
	    (add1_source_lvl in [0]) => 37.043192,
	    (add1_source_lvl in [1]) => 40.784311,
	    (add1_source_lvl in [2]) => 44.575146,
	    (add1_source_lvl in [3]) => 66.826566,
	                                41.172527);
	
	subscore8 := map(
	    (rel_prop_own_pct_a in [-1, 1]) => 56.061158,
	    (rel_prop_own_pct_a in [0])     => 35.211976,
	                                       41.172527);
	
	subscore9 := map(
	    (rel_good_education in [0]) => 36.926209,
	    (rel_good_education in [1]) => 49.127573,
	                                   41.172527);
	
	subscore10 := map(
	    (replaced_with_cell in [0]) => 38.152670,
	    (replaced_with_cell in [1]) => 69.430248,
	                                   41.172527);
	
	subscore11 := map(
	    (ssns_per_adl_lvl in [0]) => 45.078508,
	    (ssns_per_adl_lvl in [1]) => 36.063841,
	    (ssns_per_adl_lvl in [2]) => 29.848087,
	                                 41.172527);
	
	subscore12 := map(
	    (ver_nap in [0]) => 31.355818,
	    (ver_nap in [1]) => 39.631223,
	    (ver_nap in [2]) => 51.631262,
	                        41.172527);
	
	subscore13 := map(
	    (rel_bk_lvl in [0]) => 47.352354,
	    (rel_bk_lvl in [1]) => 39.540341,
	    (rel_bk_lvl in [2]) => 38.575190,
	    (rel_bk_lvl in [3]) => 22.197599,
	                           41.172527);
	
	subscore14 := map(
	    (last_eviction_lvl in [-1]) => 40.340050,
	    (last_eviction_lvl in [0])  => 60.407729,
	    (last_eviction_lvl in [1])  => 54.843114,
	    (last_eviction_lvl in [2])  => 27.555945,
	                                   41.172527);
	
	subscore15 := map(
	    (wealth_index_lvl in [1]) => 31.235897,
	    (wealth_index_lvl in [2]) => 41.982732,
	    (wealth_index_lvl in [3]) => 55.107674,
	                                 41.172527);
	
	subscore16 := map(
	    (add1_avm_automated_lvl in [-1]) => 40.796411,
	    (add1_avm_automated_lvl in [0])  => 20.857216,
	    (add1_avm_automated_lvl in [1])  => 39.791171,
	    (add1_avm_automated_lvl in [2])  => 46.754600,
	    (add1_avm_automated_lvl in [3])  => 51.884802,
	                                        41.172527);
	
	subscore_total := subscore0 +
	    subscore1 +
	    subscore2 +
	    subscore3 +
	    subscore4 +
	    subscore5 +
	    subscore6 +
	    subscore7 +
	    subscore8 +
	    subscore9 +
	    subscore10 +
	    subscore11 +
	    subscore12 +
	    subscore13 +
	    subscore14 +
	    subscore15 +
	    subscore16;
	
	rsn1105_3_0 := round(min(if(max(subscore_total, (real)301) = NULL, -NULL, max(subscore_total, (real)301)), 999));


	#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.adl_hphn := adl_hphn;
		SELF.c_span_lang := c_span_lang;
		SELF.replaced_with_cell := replaced_with_cell;
		SELF.nap_summary := nap_summary;
		SELF.nap_status := nap_status;
		SELF.rc_hriskphoneflag := rc_hriskphoneflag;
		SELF.rc_hphonetypeflag := rc_hphonetypeflag;
		SELF.add1_avm_automated_valuation := add1_avm_automated_valuation;
		SELF.add1_source_count := add1_source_count;
		SELF.ssns_per_adl := ssns_per_adl;
		SELF.inq_collection_count := inq_collection_count;
		SELF.inq_highriskcredit_count := inq_highriskcredit_count;
		SELF.inq_communications_count := inq_communications_count;
		SELF.attr_eviction_count12 := attr_eviction_count12;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.attr_eviction_count60 := attr_eviction_count60;
		SELF.disposition := disposition;
		SELF.liens_recent_unreleased_count := liens_recent_unreleased_count;
		SELF.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
		SELF.criminal_count := criminal_count;
		SELF.felony_count := felony_count;
		SELF.rel_count := rel_count;
		SELF.rel_bankrupt_count := rel_bankrupt_count;
		SELF.rel_prop_owned_count := rel_prop_owned_count;
		SELF.rel_educationunder12_count := rel_educationunder12_count;
		SELF.rel_educationover12_count := rel_educationover12_count;
		SELF.ams_age := ams_age;
		SELF.wealth_index := wealth_index;
		SELF.input_dob_age := input_dob_age;
		SELF.inferred_age := inferred_age;
		SELF.reported_dob := reported_dob;
		SELF.archive_date := archive_date;

		/* Model Intermediate Variables */
		SELF.sysdate := sysdate;
		SELF.adl_hphn_lvl := adl_hphn_lvl;
		SELF.c_span_lang_lvl := c_span_lang_lvl;
		SELF.inq_coll_hrcred_comm_lvl := inq_coll_hrcred_comm_lvl;
		SELF.criminal_lvl := criminal_lvl;
		SELF._reported_dob := _reported_dob;
		SELF.reported_age := reported_age;
		SELF.applicant_age := applicant_age;
		SELF.applicant_age_lvl := applicant_age_lvl;
		SELF._disposition := _disposition;
		SELF.bk_level := bk_level;
		SELF.liens_unreleased_lvl := liens_unreleased_lvl;
		SELF.add1_source_lvl := add1_source_lvl;
		SELF.rel_prop_own_pct := rel_prop_own_pct;
		SELF.rel_prop_own_pct_a := rel_prop_own_pct_a;
		SELF.rel_edover12_count_1 := rel_edover12_count_1;
		SELF.rel_edover8_count_1 := rel_edover8_count_1;
		SELF.rel_edover8_count := rel_edover8_count;
		SELF.rel_edover12_count := rel_edover12_count;
		SELF.rel_edover8_pct := rel_edover8_pct;
		SELF.rel_edover12_pct := rel_edover12_pct;
		SELF.rel_good_education := rel_good_education;
		SELF.phn_cell := phn_cell;
		SELF.ssns_per_adl_lvl := ssns_per_adl_lvl;
		SELF.contrary_phn := contrary_phn;
		SELF.verlst_p := verlst_p;
		SELF.veradd_p := veradd_p;
		SELF.verphn_p := verphn_p;
		SELF.ver_nap := ver_nap;
		SELF.rel_bk_lvl := rel_bk_lvl;
		SELF.last_eviction_lvl := last_eviction_lvl;
		SELF.wealth_index_lvl := wealth_index_lvl;
		SELF.add1_avm_automated_lvl := add1_avm_automated_lvl;
		SELF.subscore0 := subscore0;
		SELF.subscore1 := subscore1;
		SELF.subscore2 := subscore2;
		SELF.subscore3 := subscore3;
		SELF.subscore4 := subscore4;
		SELF.subscore5 := subscore5;
		SELF.subscore6 := subscore6;
		SELF.subscore7 := subscore7;
		SELF.subscore8 := subscore8;
		SELF.subscore9 := subscore9;
		SELF.subscore10 := subscore10;
		SELF.subscore11 := subscore11;
		SELF.subscore12 := subscore12;
		SELF.subscore13 := subscore13;
		SELF.subscore14 := subscore14;
		SELF.subscore15 := subscore15;
		SELF.subscore16 := subscore16;
		SELF.subscore_total := subscore_total;
		SELF.rsn1105_3_0 := rsn1105_3_0;

		SELF.clam := le;
	#else
		SELF.recover_score := (STRING3)rsn1105_3_0;
		SELF.seq := (STRING)le.seq;
	#end
	END;

	model := JOIN(clam, EASI.Key_Easi_Census, 
							KEYED(RIGHT.geolink = LEFT.shell_input.st + LEFT.shell_input.county + LEFT.shell_input.geo_blk),
							doModel(LEFT, RIGHT), LEFT OUTER, ATMOST(RiskWise.Max_Atmost), KEEP(1));

	RETURN(model);
END;
