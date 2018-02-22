IMPORT Risk_Indicators, UT, RiskWise, std;

EXPORT MNC21106_0_0 (DATASET(Risk_Indicators.Layout_Boca_Shell) clam, UNSIGNED3 history_date = 999999) := FUNCTION

	MODEL_DEBUG := FALSE;
	
	/* ***********************************************************
	 *            Grab RiskView Scores Used In Model             *
	 ************************************************************* 
	 * Since it is possible for these scores to shift based on   *
   * the date the model was run, the resulting DHDB score      *
   * might also shift.                                         *
	 ************************************************************* */
	// Insurance does not need to honor CA In-Person or Prescreen
	isCalifornia := FALSE;
	preScreenOptOut := FALSE;
	
	gClam := GROUP(clam, seq);
	
	rvRetail := Models.RVR611_0_0(gClam, isCalifornia);
	rvRetail2 := Models.RVR711_0_0(gClam, isCalifornia);
	rvPrescreen2 := Models.RVP804_0_0(gClam);
	rvAuto3 := Models.RVA1003_0_0(gClam, isCalifornia, preScreenOptOut);
	rvRetail3 := Models.RVR1003_0_0(gClam, isCalifornia, preScreenOptOut);
	
	Risk_Indicators.Layout_Boca_Shell doModels(Risk_Indicators.Layout_Boca_Shell le, Models.Layout_ModelOut ri, INTEGER i) := TRANSFORM
		SELF.rv_scores.retail				:= IF(i = 1, ri.score, le.rv_scores.retail);
		SELF.rv_scores.retailv2			:= IF(i = 2, ri.score, le.rv_scores.retailv2);
		SELF.rv_scores.prescreenv2	:= IF(i = 3, ri.score, le.rv_scores.prescreenv2);
		SELF.rv_scores.autoV3				:= IF(i = 4, ri.score, le.rv_scores.autoV3);
		SELF.rv_scores.retailV3			:= IF(i = 5, ri.score, le.rv_scores.retailV3);
		
		SELF := le;
	END;
	
	wRetail := JOIN(clam, rvRetail, LEFT.seq = RIGHT.seq, doModels(LEFT, RIGHT, 1), LEFT OUTER);
	wRetail2 := JOIN(wRetail, rvRetail2, LEFT.seq = RIGHT.seq, doModels(LEFT, RIGHT, 2), LEFT OUTER);
	wPrescreen2 := join(wRetail2, rvPrescreen2, LEFT.seq = RIGHT.seq, doModels(LEFT, RIGHT, 3), LEFT OUTER);
	wAuto3 := join(wPrescreen2, rvAuto3, LEFT.seq = RIGHT.seq, doModels(LEFT, RIGHT, 4), LEFT OUTER);
	scoredClam := join(wAuto3, rvRetail3, LEFT.seq = RIGHT.seq, doModels(LEFT, RIGHT, 5), LEFT OUTER);
	
	MVRLayout := RECORD
		INTEGER seq;
		REAL4 score;
	END;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			Risk_Indicators.Layout_Boca_Shell clam;
			
			/* Model Input Variables */
			INTEGER add1_date_last_seen;
			INTEGER add2_date_last_seen;
			INTEGER add3_date_last_seen;
			INTEGER criminal_last_date;
			STRING gong_did_last_seen;
			STRING add2_mortgage_due_date;
			INTEGER attr_date_last_purchase;
			INTEGER add3_date_first_seen;
			STRING gong_did_first_seen;
			INTEGER adl_vo_first_seen;
			STRING add1_assessed_value_year;
			INTEGER attr_date_last_eviction;
			INTEGER adl_w_first_seen;
			INTEGER adl_vo_last_seen;
			INTEGER liens_unrel_o_first_seen;
			INTEGER did3_liens_recent_unrel_count;
			INTEGER dist_a1toa2;
			INTEGER dist_a1toa3;
			INTEGER dist_a2toa3;
			INTEGER max_lres;
			INTEGER add1_assessed_amount;
			INTEGER add2_assessed_amount;
			INTEGER add3_assessed_amount;
			STRING rc_dwelltype;
			STRING ams_class;
			STRING ams_college_type;
			STRING prof_license_category;
			INTEGER add1_avm_med_fips;
			BOOLEAN dl_avail;
			INTEGER attr_eviction_count36;
			INTEGER LienJudgmentFiledTotal;
			INTEGER addrs_per_adl_c6;
			INTEGER em_only_count;
			INTEGER LienFederalTaxFiledTotal;
			INTEGER vo_addrs_per_adl;
			INTEGER attr_num_proflic180;
			INTEGER impulse_count180;
			INTEGER addrs_per_ssn_c6;
			INTEGER liens_rel_sc_ct;
			INTEGER liens_rel_ot_total_amount;
			INTEGER liens_hist_unrel_ct;
			BOOLEAN bankrupt;
			STRING inputssncharflag;
			INTEGER add2_avm_med_fips;
			STRING disposition;
			INTEGER pr_count;
			INTEGER gong_did_first_ct;
			INTEGER gong_did_phone_ct;
			INTEGER liens_unrel_o_ct;
			STRING rc_bansflag;
			INTEGER liens_unrel_ft_total_amount;
			BOOLEAN rc_altlname1_flag;
			INTEGER phones_per_addr;
			INTEGER add2_naprop;
			STRING ams_college_tier;
			BOOLEAN add1_eda_sourced;
			BOOLEAN add2_eda_sourced;
			BOOLEAN add3_eda_sourced;
			INTEGER watercraft_count;
			BOOLEAN add1_family_owned;
			INTEGER liens_unrel_cj_total_amount;
			INTEGER attr_num_purchase12;
			BOOLEAN add2_family_owned;
			INTEGER add1_naprop;
			INTEGER did_count;
			INTEGER impulse_annual_income;
			INTEGER source_count;
			BOOLEAN add1_family_sold;
			INTEGER liens_unrel_sc_ct;
			INTEGER liens_unrel_ot_total_amount;
			INTEGER did2_criminal_count;
			INTEGER liens_unrel_ft_ct;
			INTEGER attr_num_rel_liens12;
			STRING rc_hrisksic;
			INTEGER did2_liens_recent_unrel_count;
			BOOLEAN add3_applicant_sold;
			BOOLEAN add3_family_owned;
		
			/* RiskView v3 Attributes */
			STRING InputCurrAddrStateDiff;
			STRING EducationInstitutionRating;
			INTEGER LienCount;
			STRING SSN3Years;
			REAL CurrAddrCountyIndex;
			STRING StatusMostRecent;
			INTEGER SubjectAddrCount;
			INTEGER NonDerogCount06;
			INTEGER SubjectSSNCount;
			STRING ProfLicAge;

			INTEGER archive_date;
			INTEGER rv_r;
			
			/* Model Intermediate Variables */
			INTEGER rv2_r;
			INTEGER rv3_a;
			INTEGER rv3_r;
			INTEGER rv2_p;
			
			INTEGER cuyr;
			INTEGER cumn;
			INTEGER lg_1;
			STRING oldyr_1_c1_b1;
			STRING oldmn_1_c1_b1;
			REAL add1_date_last_seen_mn_c2;
			REAL add1_date_last_seen_mn;
			INTEGER lg_2;
			STRING oldyr_2_c3_b1;
			STRING oldmn_2_c3_b1;
			REAL add2_date_last_seen_mn_c4;
			REAL add2_date_last_seen_mn;
			INTEGER lg_3;
			STRING oldyr_3_c5_b1;
			STRING oldmn_3_c5_b1;
			REAL add3_date_last_seen_mn_c6;
			REAL add3_date_last_seen_mn;
			INTEGER lg_4;
			STRING oldyr_4_c7_b1;
			STRING oldmn_4_c7_b1;
			REAL criminal_last_date_mn_c8;
			REAL criminal_last_date_mn;
			INTEGER lg_5;
			STRING oldyr_5_c9_b1;
			STRING oldmn_5_c9_b1;
			REAL gong_did_last_seen_mn_c10;
			REAL gong_did_last_seen_mn;
			INTEGER lg_6;
			STRING oldyr_6_c11_b1;
			STRING oldmn_6_c11_b1;
			REAL add2_mortgage_due_date_mn_c12;
			REAL add2_mortgage_due_date_mn_2;
			INTEGER lg_7;
			STRING oldyr_7_c13_b1;
			STRING oldmn_7_c13_b1;
			INTEGER lg_8;
			STRING oldyr_8_c15_b1;
			STRING oldmn_8_c15_b1;
			INTEGER lg_9;
			STRING oldyr_9_c17_b1;
			STRING oldmn_9_c17_b1;
			INTEGER lg_10;
			STRING oldyr_10_c19_b1;
			STRING oldmn_10_c19_b1;
			INTEGER lg_11;
			STRING oldyr_11_c21_b1;
			STRING oldmn_11_c21_b1;
			INTEGER lg_12;
			STRING oldyr_12_c23_b1;
			STRING oldmn_12_c23_b1;
			INTEGER lg_13;
			STRING oldyr_13_c25_b1;
			STRING oldmn_13_c25_b1;
			INTEGER lg_14;
			STRING oldyr_14_c27_b1;
			STRING oldmn_14_c27_b1;
			INTEGER lg_15;
			STRING oldyr_15_c29_b1;
			STRING oldmn_15_c29_b1;
			REAL add2_mortgage_due_date_mn_1;
			INTEGER lg_16;
			STRING oldyr_16_c32_b1;
			STRING oldmn_16_c32_b1;
			INTEGER dist_a1toa2_1;
			INTEGER dist_a1toa3_1;
			INTEGER dist_a2toa3_1;
			INTEGER max_lres_1;
			INTEGER add1_assessed_amount_1;
			INTEGER add2_assessed_amount_1;
			INTEGER add3_assessed_amount_1;
			INTEGER dist_a1toa2_2;
			INTEGER avg_avm_value;
			BOOLEAN rc_dwelltype_a;
			BOOLEAN rc_dwelltype_e;
			BOOLEAN rc_dwelltype_r;
			BOOLEAN rc_dwelltype_s;
			BOOLEAN ams_class_fr;
			BOOLEAN ams_class_gr;
			BOOLEAN ams_class_jr;
			BOOLEAN ams_class_so;
			BOOLEAN ams_class_sr;
			BOOLEAN ams_class_un;
			BOOLEAN ams_class_num;
			BOOLEAN ams_college_type_p;
			BOOLEAN ams_college_type_r;
			BOOLEAN ams_college_type_s;
			BOOLEAN prof_license_category_0;
			BOOLEAN prof_license_category_1;
			BOOLEAN prof_license_category_2;
			BOOLEAN prof_license_category_3;
			BOOLEAN prof_license_category_4;
			BOOLEAN prof_license_category_5;
			INTEGER avg_add_last_seen;
			INTEGER add1_avm_med_fips_1;
			REAL attr_date_last_purchase_mn_c14;
			REAL attr_date_last_purchase_mn_1;
			REAL add2_mortgage_due_date_mn;
			REAL attr_date_last_purchase_mn_c33;
			REAL attr_date_last_purchase_mn;
			INTEGER rv2_r_1;
			INTEGER rv3_a_1;
			REAL criminal_last_date_mn_w;
			BOOLEAN dl_avail_3;
			REAL add1_avm_med_fips_w;
			REAL rv3_a_w;
			REAL inputcurraddrstatediff_w;
			REAL rv2_r_w;
			REAL attr_eviction_count36_w;
			REAL dist_a1toa2_w;
			REAL lienjudgmentfiledtotal_w;
			BOOLEAN ams_class_sr_3;
			BOOLEAN addrs_per_adl_c6_3;
			REAL em_only_count_w;
			REAL gong_did_last_seen_mn_w;
			REAL lienfederaltaxfiledtotal_w;
			REAL vo_addrs_per_adl_w;
			BOOLEAN attr_num_proflic180_3;
			REAL add2_mortgage_due_date_mn_w;
			REAL impulse_count180_w;
			REAL addrs_per_ssn_c6_w;
			REAL attr_date_last_purchase_mn_w;
			REAL liens_rel_sc_ct_w;
			REAL liens_rel_ot_total_amount_w;
			REAL liens_hist_unrel_ct_w;
			REAL educationinstitutionrating_w;
			BOOLEAN bankrupt_3;
			INTEGER inputssncharflag_5_3;
			REAL score1;
			REAL add3_date_first_seen_mn_c16;
			REAL add3_date_first_seen_mn;
			REAL gong_did_first_seen_mn_c18;
			REAL gong_did_first_seen_mn;
			REAL adl_vo_first_seen_mn_c20;
			REAL adl_vo_first_seen_mn;
			REAL add1_assessed_value_year_mn_c22;
			REAL add1_assessed_value_year_mn;
			INTEGER rv3_r_1;
			INTEGER add2_avm_med_fips_1;
			INTEGER dist_a2toa3_2;
			INTEGER max_lres_2;
			REAL rv3_r_w;
			REAL criminal_last_date_mn_w_s2;
			REAL add2_avm_med_fips_w;
			BOOLEAN dl_avail_3_s2;
			REAL liencount_w;
			REAL gong_did_last_seen_mn_w_s2;
			BOOLEAN disposition_dc_3;
			REAL dist_a1toa2_w_s2;
			REAL pr_count_w;
			REAL ssn3years_w;
			REAL educationinstitutionrating_w_s2;
			REAL add3_date_first_seen_mn_w;
			BOOLEAN rc_dwelltype_e_3;
			REAL em_only_count_w_s2;
			REAL gong_did_first_ct_w;
			REAL gong_did_first_seen_mn_w;
			REAL dist_a2toa3_w;
			REAL gong_did_phone_ct_w;
			BOOLEAN did3_liens_recent_unrel_count_3;
			REAL adl_vo_first_seen_mn_w;
			BOOLEAN liens_unrel_o_ct_3;
			REAL add1_assessed_value_year_mn_w;
			BOOLEAN rc_bansflag_2;
			REAL liens_unrel_ft_total_amount_w;
			BOOLEAN rc_altlname1_flag_3;
			REAL phones_per_addr_w;
			REAL max_lres_w;
			REAL add2_naprop_w;
			BOOLEAN ams_college_tier_2_3;
			REAL curraddrcountyindex_w;
			BOOLEAN add1_eda_sourced_3;
			BOOLEAN statusmostrecent_o_3;
			BOOLEAN add2_eda_sourced_3;
			BOOLEAN add3_eda_sourced_3;
			BOOLEAN watercraft_count_3;
			BOOLEAN prof_license_category_1_3;
			BOOLEAN ams_college_tier_1_3;
			REAL score2;
			REAL attr_date_last_eviction_mn_c24;
			REAL attr_date_last_eviction_mn;
			REAL adl_w_first_seen_mn_c26;
			REAL adl_w_first_seen_mn;
			REAL adl_vo_last_seen_mn_c28;
			REAL adl_vo_last_seen_mn;
			REAL liens_unrel_o_first_seen_mn_c30;
			REAL liens_unrel_o_first_seen_mn;
			INTEGER rv2_p_1;
			REAL rv2_p_w;
			REAL add1_avm_med_fips_w_s3;
			BOOLEAN dl_avail_3_s3;
			BOOLEAN add1_family_owned_2;
			REAL avg_avm_value_w;
			REAL subjectaddrcount_w;
			REAL avg_add_last_seen_w;
			REAL liens_unrel_cj_total_amount_w;
			BOOLEAN attr_num_purchase12_3;
			BOOLEAN add2_family_owned_3;
			REAL gong_did_first_seen_mn_w_s3;
			REAL add1_naprop_w;
			REAL did_count_w;
			REAL gong_did_phone_ct_w_s3;
			REAL impulse_annual_income_w;
			REAL dist_a1toa2_w_s3;
			REAL nonderogcount06_w;
			REAL source_count_w;
			BOOLEAN add1_family_sold_3;
			REAL inputcurraddrstatediff_w_s3;
			REAL liens_unrel_sc_ct_w;
			REAL liens_unrel_ot_total_amount_w;
			REAL attr_date_last_eviction_mn_w;
			BOOLEAN did2_criminal_count_3;
			REAL subjectssncount_w;
			REAL adl_w_first_seen_mn_w;
			REAL proflicage_w;
			REAL adl_vo_last_seen_mn_w;
			BOOLEAN liens_unrel_o_first_seen_mn_2;
			REAL liens_unrel_ft_ct_w;
			BOOLEAN attr_num_rel_liens12_3;
			REAL rc_hrisksic_w;
			BOOLEAN did2_liens_recent_unrel_count_3;
			BOOLEAN add3_applicant_sold_3;
			BOOLEAN add3_family_owned_3;
			REAL score3;
			REAL finalScore;
			REAL score;
		END;
		
		Layout_Debug doModel(scoredClam le) := TRANSFORM
	#else
		MVRLayout doModel(scoredClam le) := TRANSFORM
	#end
	
	/* ***********************************************************
	 *             Model Input Variable Assignments              *
	 ************************************************************* */
	
	add1_date_last_seen              := le.address_verification.input_address_information.date_last_seen;
	add2_date_last_seen              := le.address_verification.address_history_1.date_last_seen;
	add3_date_last_seen              := le.address_verification.address_history_2.date_last_seen;
	criminal_last_date               := le.bjl.last_criminal_date;
	gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
	add2_mortgage_due_date           := le.address_verification.address_history_1.first_td_due_date;
	attr_date_last_purchase          := le.other_address_info.date_most_recent_purchase;
	add3_date_first_seen             := le.address_verification.address_history_2.date_first_seen;
	gong_did_first_seen              := le.phone_verification.gong_did.gong_adl_dt_first_seen_full;
	adl_vo_first_seen                := le.source_verification.adl_vo_first_seen;
	add1_assessed_value_year         := le.address_verification.input_address_information.assessed_value_year;
	attr_date_last_eviction          := le.bjl.last_eviction_date;
	adl_w_first_seen                 := le.source_verification.adl_w_first_seen;
	adl_vo_last_seen                 := le.Source_Verification.adl_vo_last_seen;
	liens_unrel_o_first_seen         := le.liens.liens_unreleased_other_lj.earliest_filing_date;
	did3_liens_recent_unrel_count    := le.iid.did3_liens_recent_unreleased_count;
	dist_a1toa2                      := le.address_verification.distance_in_2_h1;
	dist_a1toa3                      := le.address_verification.distance_in_2_h2;
	dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
	// Modeler Allen Li requested that this field be cap'd at 255
	max_lres                         := IF(le.other_address_info.max_lres > 255, 255, le.other_address_info.max_lres);
	add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
	add2_assessed_amount             := le.address_verification.address_history_1.assessed_amount;
	add3_assessed_amount             := le.address_verification.address_history_2.assessed_amount;
	rc_dwelltype                     := le.iid.dwelltype;
	ams_class                        := le.student.class;
	ams_college_type                 := le.student.college_type;
	prof_license_category            := le.professional_license.plcategory;
	add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
	dl_avail                         := le.available_sources.dl;
	attr_eviction_count36            := le.bjl.eviction_count36;
	LienJudgmentFiledTotal           := le.liens.liens_unreleased_civil_judgment.total_amount;
	addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
	em_only_count                    := le.source_verification.em_only_count;
	LienFederalTaxFiledTotal         := le.liens.liens_unreleased_federal_tax.total_amount;
	vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
	attr_num_proflic180              := le.professional_license.proflic_count180;
	impulse_count180                 := le.impulse.count180;
	addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
	liens_rel_sc_ct                  := le.liens.liens_released_small_claims.count;
	liens_rel_ot_total_amount        := le.liens.liens_released_other_tax.total_amount;
	liens_hist_unrel_ct              := le.bjl.liens_historical_unreleased_count;
	bankrupt                         := le.bjl.bankrupt;
	inputssncharflag                 := le.ssn_verification.validation.inputsocscharflag;
	add2_avm_med_fips                := le.avm.address_history_1.avm_median_fips_level;
	disposition                      := le.bjl.disposition;
	pr_count                         := le.source_verification.pr_count;
	gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
	gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
	liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
	rc_bansflag                      := le.iid.bansflag;
	liens_unrel_ft_total_amount      := le.liens.liens_unreleased_federal_tax.total_amount;
	rc_altlname1_flag                := le.iid.altlastpop;
	phones_per_addr                  := le.velocity_counters.phones_per_addr;
	add2_naprop                      := le.address_verification.address_history_1.naprop;
	ams_college_tier                 := le.student.college_tier;
	add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
	add2_eda_sourced                 := le.address_verification.Address_History_1.eda_sourced;
	add3_eda_sourced                 := le.address_verification.Address_History_2.eda_sourced;
	watercraft_count 	 	             := le.watercraft.watercraft_count;	
	add1_family_owned                := le.address_verification.input_address_information.family_owned;
	liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
	attr_num_purchase12              := le.other_address_info.num_purchase12;
	add2_family_owned                := le.address_verification.address_history_1.family_owned;
	add1_naprop                      := le.address_verification.input_address_information.naprop;
	did_count                        := le.iid.didcount;
	impulse_annual_income            := le.impulse.annual_income;
	source_count                     := le.name_verification.source_count;
	add1_family_sold                 := le.address_verification.input_address_information.family_sold;
	liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
	liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
	did2_criminal_count              := le.iid.did2_criminal_count;
	liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
	attr_num_rel_liens12             := le.bjl.liens_released_count12;
	rc_hrisksic                      := le.iid.hrisksic;
	did2_liens_recent_unrel_count    := le.iid.did2_liens_recent_unreleased_count;
	add3_applicant_sold              := le.address_verification.address_history_2.applicant_sold;
	add3_family_owned                := le.address_verification.address_history_2.family_owned;
	
	archive_date                     := IF(le.historydate = 999999, (INTEGER)((STRING)Std.Date.Today())[1..6], (INTEGER)((STRING)le.historydate)[1..6]);
	
	/* ***********************************************************
	 *  RiskView Attributes - Taken from Models.getRVAttributes  *
	 ************************************************************* 
	 *          Variables used in Attribute Calculation          *
	 ************************************************************* */
	checkBoolean(boolean x) := if(x, '1', '0');
	CAaddrChooser := map(le.address_verification.input_address_information.isbestmatch => 1, // input is current
											 le.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
											 le.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
											 4);	// don't know what the current address is	
	currAddrSt := map(CAaddrChooser=1 => le.address_verification.input_address_information.st,
										CAaddrChooser=2 => le.address_verification.address_history_1.st,
										CAaddrChooser=3 => le.address_verification.address_history_2.st,
										'');
	attendedCollege := map(	le.student.file_type='H' => '1', 
													le.student.file_type='C' => '1',
													le.student.file_type='M' and (le.student.college_code<>'' or le.student.college_type<>'' or
																												le.student.college_name<>'') => '1',
													'0');
	randomizedSocial := Risk_Indicators.rcSet.isCodeRS(le.shell_input.ssn, le.iid.socsvalflag, le.iid.socllowissue, le.iid.socsRCISflag);
	currAddrAVMValue := map(CAaddrChooser=1 => le.avm.input_address_information.avm_automated_valuation,
													CAaddrChooser=2 => le.avm.address_history_1.avm_automated_valuation,
													CAaddrChooser=3 => le.avm.address_history_2.avm_automated_valuation,
													0);	
	currAddrFips :=  map( CAaddrChooser=1 => le.avm.input_address_information.avm_median_fips_level,
												CAaddrChooser=2 => le.avm.address_history_1.avm_median_fips_level,
												CAaddrChooser=3 => le.avm.address_history_2.avm_median_fips_level,
												0);		
  fulldate := (unsigned4)((STRING6)le.historyDate+'01');
	plmrd := if(le.professional_license.date_most_recent>fullDate, 0, le.professional_license.date_most_recent);
	
	statusAddr1 := map(le.address_verification.input_address_information.applicant_owned or 
														le.address_verification.input_address_information.applicant_sold or
														le.address_verification.input_address_information.family_owned or 
														le.address_verification.input_address_information.family_sold => 'O',// owned
										 ~le.address_verification.input_address_information.occupant_owned and
														le.iid.dwelltype not in ['','S'] => 'R',// rent,
										 'U');// unknown
	statusAddr2 := map(le.address_verification.address_history_1.applicant_owned or 
														le.address_verification.address_history_1.applicant_sold or
														le.address_verification.address_history_1.family_owned or 
														le.address_verification.address_history_1.family_sold => 'O',// owned
										 ~le.address_verification.address_history_1.occupant_owned and 
														le.address_verification.addr_type2 not in ['','S'] => 'R',// rent,
										 'U');// unknown;
	statusAddr3 := map(le.address_verification.address_history_2.applicant_owned or 
														le.address_verification.address_history_2.applicant_sold or
														le.address_verification.address_history_2.family_owned or 
														le.address_verification.address_history_2.family_sold => 'O',// owned
										 ~le.address_verification.address_history_2.occupant_owned and 
														le.address_verification.addr_type3 not in ['','S'] => 'R',// rent,
										 'U');// unknown;
									
	/* ***********************************************************
	 *  RiskView Attributes - Taken from Models.getRVAttributes  *
	 ************************************************************* 
	 *         Version 3 Attributes used in the model            *
	 ************************************************************* */
	InputCurrAddrStateDiff           := if(currAddrSt='' OR le.shell_input.in_state='', '', checkBoolean(~(currAddrSt = (StringLib.StringToUpperCase(le.shell_input.in_state)))));
	EducationInstitutionRating       := if(attendedCollege='1', le.student.college_tier, '');
	LienCount                        := le.bjl.liens_historical_unreleased_count + le.bjl.liens_recent_unreleased_count + le.bjl.liens_historical_released_count + le.bjl.liens_recent_released_count;
	SSN3Years                        := if(TRIM(le.shell_input.ssn) = '', '', checkBoolean(// If it is not a randomized social and only issued within the last 36 months
																														(~randomizedSocial AND (archive_date - (INTEGER)(le.iid.socllowissue[1..6])) < 300) OR 
																														// Or it was possibly randomized and the date is prior to June 25th, 2014
																														(randomizedSocial AND archive_date <= Risk_Indicators.iid_constants.randomSSN3Years)));
	CurrAddrCountyIndex              := ((REAL)currAddrAVMValue / (REAL)currAddrFips);
	StatusMostRecent                 := map(CAaddrChooser=1 => statusAddr1,
																					CAaddrChooser=2 => statusAddr2,
																					CAaddrChooser=3 => statusAddr3,
																														'U');
	SubjectAddrCount                 := le.velocity_counters.addrs_per_adl;
	NonDerogCount06                  := le.source_verification.num_nonderogs180;
	SubjectSSNCount                  := le.velocity_counters.ssns_per_adl;
	ProfLicAge                       := if(plmrd=0, '', (string)round((ut.DaysApart((string)le.professional_license.date_most_recent, (string)archive_date)) / 30));

	/* ***********************************************************
	 *                 RiskView Model Scores                     *
	 ************************************************************* */
		rv_r := (INTEGER)le.rv_scores.retail;
		rv2_r := (INTEGER)le.rv_scores.retailv2;
		rv2_p := (INTEGER)le.rv_scores.prescreenv2;
		rv3_a := (INTEGER)le.rv_scores.autoV3;
		rv3_r := (INTEGER)le.rv_scores.retailV3;
		
	/* ***********************************************************
	 *                    Generated ECL                          *
	 ************************************************************* */

	NULL := -999999999;
	
	nsc := 999; // Non-scorable
	
	cuyr := (INTEGER)TRIM((STRING)archive_date)[1..4];

	cumn := (INTEGER)TRIM((STRING)archive_date)[5..6];
	
	lg_1 := length(trim((string)add1_date_last_seen, LEFT, RIGHT));
	
	oldyr_1_c1_b1 := TRIM((STRING)add1_date_last_seen)[1..4];
	
	oldmn_1_c1_b1 := TRIM((STRING)add1_date_last_seen)[5..6];
	
	add1_date_last_seen_mn_c2 := if(lg_1 = 4, cuyr - (real)oldyr_1_c1_b1, (cuyr - (real)oldyr_1_c1_b1) * 12 + cumn - (real)oldmn_1_c1_b1);
	
	add1_date_last_seen_mn := if(not((trim((string)add1_date_last_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_1 >= 4, add1_date_last_seen_mn_c2, NULL);
	
	lg_2 := length(trim((string)add2_date_last_seen, LEFT, RIGHT));
	
	oldyr_2_c3_b1 := TRIM((STRING)add2_date_last_seen)[1..4];
	
	oldmn_2_c3_b1 := TRIM((STRING)add2_date_last_seen)[5..6];
	
	add2_date_last_seen_mn_c4 := if(lg_2 = 4, cuyr - (real)oldyr_2_c3_b1, (cuyr - (real)oldyr_2_c3_b1) * 12 + cumn - (real)oldmn_2_c3_b1);
	
	add2_date_last_seen_mn := if(not((trim((string)add2_date_last_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_2 >= 4, add2_date_last_seen_mn_c4, NULL);
	
	lg_3 := length(trim((string)add3_date_last_seen, LEFT, RIGHT));
	
	oldyr_3_c5_b1 := TRIM((STRING)add3_date_last_seen)[1..4];
	
	oldmn_3_c5_b1 := TRIM((STRING)add3_date_last_seen)[5..6];
	
	add3_date_last_seen_mn_c6 := if(lg_3 = 4, cuyr - (real)oldyr_3_c5_b1, (cuyr - (real)oldyr_3_c5_b1) * 12 + cumn - (real)oldmn_3_c5_b1);
	
	add3_date_last_seen_mn := if(not((trim((string)add3_date_last_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_3 >= 4, add3_date_last_seen_mn_c6, NULL);
	
	lg_4 := length(trim((string)criminal_last_date, LEFT, RIGHT));
	
	oldyr_4_c7_b1 := TRIM((STRING)criminal_last_date)[1..4];
	
	oldmn_4_c7_b1 := TRIM((STRING)criminal_last_date)[5..6];
	
	criminal_last_date_mn_c8 := if(lg_4 = 4, cuyr - (real)oldyr_4_c7_b1, (cuyr - (real)oldyr_4_c7_b1) * 12 + cumn - (real)oldmn_4_c7_b1);
	
	criminal_last_date_mn := if(not((trim((string)criminal_last_date, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_4 >= 4, criminal_last_date_mn_c8, NULL);
	
	lg_5 := length(trim(gong_did_last_seen, LEFT, RIGHT));
	
	oldyr_5_c9_b1 := TRIM((STRING)gong_did_last_seen)[1..4];
	
	oldmn_5_c9_b1 := TRIM((STRING)gong_did_last_seen)[5..6];
	
	gong_did_last_seen_mn_c10 := if(lg_5 = 4, cuyr - (real)oldyr_5_c9_b1, (cuyr - (real)oldyr_5_c9_b1) * 12 + cumn - (real)oldmn_5_c9_b1);
	
	gong_did_last_seen_mn := if(not((trim(gong_did_last_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_5 >= 4, gong_did_last_seen_mn_c10, NULL);
	
	lg_6 := length(trim(add2_mortgage_due_date, LEFT, RIGHT));
	
	oldyr_6_c11_b1 := TRIM((STRING)add2_mortgage_due_date)[1..4];
	
	oldmn_6_c11_b1 := TRIM((STRING)add2_mortgage_due_date)[5..6];
	
	add2_mortgage_due_date_mn_c12 := if(lg_6 = 4, cuyr - (real)oldyr_6_c11_b1, (cuyr - (real)oldyr_6_c11_b1) * 12 + cumn - (real)oldmn_6_c11_b1);
	
	add2_mortgage_due_date_mn_2 := if(not((trim(add2_mortgage_due_date, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_6 >= 4, add2_mortgage_due_date_mn_c12, NULL);
	
	lg_7 := length(trim((string)attr_date_last_purchase, LEFT, RIGHT));
	
	oldyr_7_c13_b1 := TRIM((STRING)attr_date_last_purchase)[1..4];
	
	oldmn_7_c13_b1 := TRIM((STRING)attr_date_last_purchase)[5..6];
	
	lg_8 := length(trim((string)add3_date_first_seen, LEFT, RIGHT));
	
	oldyr_8_c15_b1 := TRIM((STRING)add3_date_first_seen)[1..4];
	
	oldmn_8_c15_b1 := TRIM((STRING)add3_date_first_seen)[5..6];
	
	lg_9 := length(trim(gong_did_first_seen, LEFT, RIGHT));
	
	oldyr_9_c17_b1 := TRIM((STRING)gong_did_first_seen)[1..4];
	
	oldmn_9_c17_b1 := TRIM((STRING)gong_did_first_seen)[5..6];
	
	lg_10 := length(trim((string)adl_vo_first_seen, LEFT, RIGHT));
	
	oldyr_10_c19_b1 := TRIM((STRING)adl_vo_first_seen)[1..4];
	
	oldmn_10_c19_b1 := TRIM((STRING)adl_vo_first_seen)[5..6];
	
	lg_11 := length(trim(add1_assessed_value_year, LEFT, RIGHT));
	
	oldyr_11_c21_b1 := TRIM((STRING)add1_assessed_value_year)[1..4];
	
	oldmn_11_c21_b1 := TRIM((STRING)add1_assessed_value_year)[5..6];
	
	lg_12 := length(trim((string)attr_date_last_eviction, LEFT, RIGHT));
	
	oldyr_12_c23_b1 := TRIM((STRING)attr_date_last_eviction)[1..4];
	
	oldmn_12_c23_b1 := TRIM((STRING)attr_date_last_eviction)[5..6];
	
	lg_13 := length(trim((string)adl_w_first_seen, LEFT, RIGHT));
	
	oldyr_13_c25_b1 := TRIM((STRING)adl_w_first_seen)[1..4];
	
	oldmn_13_c25_b1 := TRIM((STRING)adl_w_first_seen)[5..6];
	
	lg_14 := length(trim((string)adl_vo_last_seen, LEFT, RIGHT));
	
	oldyr_14_c27_b1 := TRIM((STRING)adl_vo_last_seen)[1..4];
	
	oldmn_14_c27_b1 := TRIM((STRING)adl_vo_last_seen)[5..6];
	
	lg_15 := length(trim((string)liens_unrel_o_first_seen, LEFT, RIGHT));
	
	oldyr_15_c29_b1 := TRIM((STRING)liens_unrel_o_first_seen)[1..4];
	
	oldmn_15_c29_b1 := TRIM((STRING)liens_unrel_o_first_seen)[5..6];
	
	add2_mortgage_due_date_mn_1 := add2_mortgage_due_date_mn_2 + 1000;
	
	lg_16 := length(trim((string)attr_date_last_purchase, LEFT, RIGHT));
	
	oldyr_16_c32_b1 := TRIM((STRING)attr_date_last_purchase)[1..4];
	
	oldmn_16_c32_b1 := TRIM((STRING)attr_date_last_purchase)[5..6];
	
	dist_a1toa2_1 := if(dist_a1toa2 = 9999, NULL, dist_a1toa2);
	
	dist_a1toa3_1 := if(dist_a1toa3 = 9999, NULL, dist_a1toa3);
	
	dist_a2toa3_1 := if(dist_a2toa3 = 9999, NULL, dist_a2toa3);
	
	max_lres_1 := if(max_lres = 255, NULL, max_lres);
	
	add1_assessed_amount_1 := if(add1_assessed_amount = 999999999, NULL, add1_assessed_amount);
	
	add2_assessed_amount_1 := if(add2_assessed_amount = 999999999, NULL, add2_assessed_amount);
	
	add3_assessed_amount_1 := if(add3_assessed_amount = 999999999, NULL, add3_assessed_amount);
	
	dist_a1toa2_2 := if(dist_a1toa2_1 = 999999999, NULL, dist_a1toa2_1);
	
	avg_avm_value := round(
													if(max(add1_assessed_amount_1, add2_assessed_amount_1, add3_assessed_amount_1) = NULL, 
															NULL, 
															(if(max(add1_assessed_amount_1, add2_assessed_amount_1, add3_assessed_amount_1) = NULL, 
																	NULL, 
																	SUM(if(add1_assessed_amount_1 = NULL, 
																			0, 
																			add1_assessed_amount_1), 
																			if(add2_assessed_amount_1 = NULL, 
																			0, 
																			add2_assessed_amount_1), 
																			if(add3_assessed_amount_1 = NULL, 
																			0, 
																			add3_assessed_amount_1)))
																	/
																	SUM(if(add1_assessed_amount_1 = NULL, 
																			0, 
																			1), 
																			if(add2_assessed_amount_1 = NULL, 
																			0, 
																			1), 
																			if(add3_assessed_amount_1 = NULL, 
																			0, 
																			1))
																)
															)
													);
	
	rc_dwelltype_a := rc_dwelltype = 'A';
	
	rc_dwelltype_e := rc_dwelltype = 'E';
	
	rc_dwelltype_r := rc_dwelltype = 'R';
	
	rc_dwelltype_s := rc_dwelltype = 'S';
	
	ams_class_fr := ams_class = 'FR';
	
	ams_class_gr := ams_class = 'GR';
	
	ams_class_jr := ams_class = 'JR';
	
	ams_class_so := ams_class = 'SO';
	
	ams_class_sr := ams_class = 'SR';
	
	ams_class_un := ams_class = 'UN';
	
	ams_class_num := '00' <= ams_class AND ams_class < 'FR';
	
	ams_college_type_p := ams_college_type = 'P';
	
	ams_college_type_r := ams_college_type = 'R';
	
	ams_college_type_s := ams_college_type = 'S';
	
	prof_license_category_0 := prof_license_category = '0';
	
	prof_license_category_1 := prof_license_category = '1';
	
	prof_license_category_2 := prof_license_category = '2';
	
	prof_license_category_3 := prof_license_category = '3';
	
	prof_license_category_4 := prof_license_category = '4';
	
	prof_license_category_5 := prof_license_category = '5';
	
	avg_add_last_seen := round(
															if(max(add1_date_last_seen_mn, add2_date_last_seen_mn, add3_date_last_seen_mn) = NULL, 
																	NULL, 
																	(if(max(add1_date_last_seen_mn, add2_date_last_seen_mn, add3_date_last_seen_mn) = NULL, 
																			NULL, 
																			SUM(if(add1_date_last_seen_mn = NULL, 
																			0, 
																			add1_date_last_seen_mn), 
																			if(add2_date_last_seen_mn = NULL, 
																			0, 
																			add2_date_last_seen_mn), 
																			if(add3_date_last_seen_mn = NULL, 
																			0, 
																			add3_date_last_seen_mn)))
																			/
																			SUM(if(add1_date_last_seen_mn = NULL, 
																			0, 
																			1), 
																			if(add2_date_last_seen_mn = NULL, 
																			0, 
																			1), 
																			if(add3_date_last_seen_mn = NULL, 
																			0, 
																			1))
																		)
																	)
															);
	
	add1_avm_med_fips_1 := if(add1_avm_med_fips = 999999999, NULL, add1_avm_med_fips);
	
	/* ***********************************************************
	 *     Score 1 --> 0 <= RV_R <= 650 AND RV_R <> 222          *
	 ************************************************************* */
	
	attr_date_last_purchase_mn_c14 := if(lg_7 = 4, cuyr - (real)oldyr_7_c13_b1, (cuyr - (real)oldyr_7_c13_b1) * 12 + cumn - (real)oldmn_7_c13_b1);
	
	attr_date_last_purchase_mn_1 := if(not((trim((string)attr_date_last_purchase, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_7 >= 4, attr_date_last_purchase_mn_c14, NULL);
	
	add2_mortgage_due_date_mn := if(add2_mortgage_due_date_mn_1 < 0, NULL, add2_mortgage_due_date_mn_1);
	
	attr_date_last_purchase_mn_c33 := if(lg_16 = 4, cuyr - (real)oldyr_16_c32_b1, (cuyr - (real)oldyr_16_c32_b1) * 12 + cumn - (real)oldmn_16_c32_b1);
	
	attr_date_last_purchase_mn := if(not((trim((string)attr_date_last_purchase, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_16 >= 4, attr_date_last_purchase_mn_c33, NULL);
	
	rv2_r_1 := if(rv2_r = 222, NULL, rv2_r);
	
	rv3_a_1 := if(rv3_a = 222, NULL, rv3_a);
	
	criminal_last_date_mn_w := map(
		criminal_last_date_mn = NULL => -0.139802,
		criminal_last_date_mn <= 10   => 0.473807,
		criminal_last_date_mn <= 15   => 0.695374,
		criminal_last_date_mn <= 16   => 0.708562,
		criminal_last_date_mn <= 21   => 0.864487,
		criminal_last_date_mn <= 24   => 0.849558,
		criminal_last_date_mn <= 26   => 0.843474,
		criminal_last_date_mn <= 30   => 0.803704,
		criminal_last_date_mn <= 36   => 0.772752,
		criminal_last_date_mn <= 38   => 0.764500,
		criminal_last_date_mn <= 40   => 0.659035,
		criminal_last_date_mn <= 42   => 0.630472,
		criminal_last_date_mn <= 44   => 0.595334,
		criminal_last_date_mn <= 46   => 0.525816,
		criminal_last_date_mn <= 55   => 0.509928,
		criminal_last_date_mn <= 71   => 0.467402,
		criminal_last_date_mn <= 77   => 0.389415,
		criminal_last_date_mn <= 83   => 0.351625,
										0.243924);
	
	dl_avail_3 := (integer)dl_avail > 0;
	
	add1_avm_med_fips_w := map(
		add1_avm_med_fips_1 = 0       => -0.264228,
		add1_avm_med_fips_1 <= 125143 => -0.154386,
		add1_avm_med_fips_1 <= 142695 => 0.163852,
		add1_avm_med_fips_1 <= 155125 => 0.183502,
		add1_avm_med_fips_1 <= 228192 => 0.256592,
		add1_avm_med_fips_1 <= 230000 => 0.476507,
		add1_avm_med_fips_1 <= 266858 => 0.316378,
		add1_avm_med_fips_1 <= 346383 => 0.259504,
		add1_avm_med_fips_1 <= 518844 => 0.097288,
		add1_avm_med_fips_1 <= 582060 => 0.061030,
									-0.011585);
	
	rv3_a_w := map(
		rv3_a_1 <= 552 => 0.638635,
		rv3_a_1 <= 561 => 0.597724,
		rv3_a_1 <= 567 => 0.583855,
		rv3_a_1 <= 571 => 0.559804,
		rv3_a_1 <= 576 => 0.535832,
		rv3_a_1 <= 578 => 0.490505,
		rv3_a_1 <= 582 => 0.484099,
		rv3_a_1 <= 586 => 0.471829,
		rv3_a_1 <= 592 => 0.421858,
		rv3_a_1 <= 598 => 0.388844,
		rv3_a_1 <= 600 => 0.360332,
		rv3_a_1 <= 602 => 0.345620,
		rv3_a_1 <= 603 => 0.300359,
		rv3_a_1 <= 608 => 0.264648,
		rv3_a_1 <= 610 => 0.236720,
		rv3_a_1 <= 611 => 0.222172,
		rv3_a_1 <= 614 => 0.185965,
		rv3_a_1 <= 615 => 0.145635,
		rv3_a_1 <= 618 => 0.121672,
		rv3_a_1 <= 620 => 0.096505,
		rv3_a_1 <= 626 => 0.069530,
		rv3_a_1 <= 629 => -0.027471,
		rv3_a_1 <= 631 => -0.040396,
		rv3_a_1 <= 634 => -0.046443,
		rv3_a_1 <= 636 => -0.056624,
		rv3_a_1 <= 639 => -0.061472,
		rv3_a_1 <= 641 => -0.075610,
		rv3_a_1 <= 642 => -0.087506,
		rv3_a_1 <= 653 => -0.132200,
		rv3_a_1 <= 660 => -0.173751,
		rv3_a_1 <= 661 => -0.184276,
		rv3_a_1 <= 662 => -0.235448,
		rv3_a_1 <= 670 => -0.263648,
		rv3_a_1 <= 673 => -0.277150,
		rv3_a_1 <= 680 => -0.309108,
		rv3_a_1 <= 682 => -0.356924,
		rv3_a_1 <= 684 => -0.381713,
		rv3_a_1 <= 688 => -0.478487,
		rv3_a_1 <= 696 => -0.483815,
		rv3_a_1 <= 706 => -0.603464,
						-0.670571);
	
	inputcurraddrstatediff_w := map(
		TRIM(InputCurrAddrStateDiff) = '' => -0.684903,
		(INTEGER)InputCurrAddrStateDiff = 0     => 0.068089,
										-0.354902);
	
	rv2_r_w := map(
		rv2_r_1 <= 522 => 0.546386,
		rv2_r_1 <= 528 => 0.501901,
		rv2_r_1 <= 533 => 0.494607,
		rv2_r_1 <= 536 => 0.456314,
		rv2_r_1 <= 541 => 0.441166,
		rv2_r_1 <= 545 => 0.418152,
		rv2_r_1 <= 549 => 0.379905,
		rv2_r_1 <= 554 => 0.332577,
		rv2_r_1 <= 559 => 0.291141,
		rv2_r_1 <= 565 => 0.284258,
		rv2_r_1 <= 571 => 0.262531,
		rv2_r_1 <= 574 => 0.251452,
		rv2_r_1 <= 583 => 0.233591,
		rv2_r_1 <= 584 => 0.211214,
		rv2_r_1 <= 585 => 0.210568,
		rv2_r_1 <= 587 => 0.203759,
		rv2_r_1 <= 588 => 0.181069,
		rv2_r_1 <= 589 => 0.170315,
		rv2_r_1 <= 591 => 0.138045,
		rv2_r_1 <= 593 => 0.072704,
		rv2_r_1 <= 596 => 0.048519,
		rv2_r_1 <= 597 => 0.018573,
		rv2_r_1 <= 600 => 0.014836,
		rv2_r_1 <= 607 => 0.008730,
		rv2_r_1 <= 609 => -0.009764,
		rv2_r_1 <= 610 => -0.017780,
		rv2_r_1 <= 612 => -0.022245,
		rv2_r_1 <= 613 => -0.038506,
		rv2_r_1 <= 618 => -0.080962,
		rv2_r_1 <= 622 => -0.121986,
		rv2_r_1 <= 624 => -0.157661,
		rv2_r_1 <= 651 => -0.171300,
		rv2_r_1 <= 666 => -0.190091,
		rv2_r_1 <= 669 => -0.101087,
		rv2_r_1 <= 673 => -0.079574,
						-0.056487);
	
	attr_eviction_count36_w := map(
		attr_eviction_count36 = 0  => -0.046975,
		attr_eviction_count36 <= 2 => 0.306044,
		attr_eviction_count36 <= 3 => 0.412597,
		attr_eviction_count36 <= 4 => 0.363863,
									0.347576);
	
	dist_a1toa2_w := map(
		dist_a1toa2_2 = NULL => -0.389655,
		dist_a1toa2_2 = 0     => -0.024411,
		dist_a1toa2_2 <= 1    => 0.136243,
		dist_a1toa2_2 <= 2    => 0.143176,
		dist_a1toa2_2 <= 21   => 0.148625,
		dist_a1toa2_2 <= 22   => 0.185180,
		dist_a1toa2_2 <= 23   => 0.170765,
		dist_a1toa2_2 <= 24   => 0.155978,
		dist_a1toa2_2 <= 48   => 0.131978,
		dist_a1toa2_2 <= 68   => 0.081936,
		dist_a1toa2_2 <= 87   => 0.081535,
		dist_a1toa2_2 <= 104  => 0.061174,
		dist_a1toa2_2 <= 149  => -0.005063,
		dist_a1toa2_2 <= 168  => -0.013028,
		dist_a1toa2_2 <= 203  => -0.085401,
		dist_a1toa2_2 <= 230  => -0.107796,
		dist_a1toa2_2 <= 311  => -0.154228,
		dist_a1toa2_2 <= 346  => -0.245200,
		dist_a1toa2_2 <= 484  => -0.271543,
		dist_a1toa2_2 <= 609  => -0.307000,
							-0.332949);
	
	lienjudgmentfiledtotal_w := map(
		LienJudgmentFiledTotal = 0      => -0.112135,
		LienJudgmentFiledTotal <= 4041  => 0.259583,
		LienJudgmentFiledTotal <= 4177  => 0.277859,
		LienJudgmentFiledTotal <= 4341  => 0.355353,
		LienJudgmentFiledTotal <= 4493  => 0.289803,
		LienJudgmentFiledTotal <= 4830  => 0.283765,
		LienJudgmentFiledTotal <= 11714 => 0.275459,
		LienJudgmentFiledTotal <= 26986 => 0.262176,
		LienJudgmentFiledTotal <= 35478 => 0.242607,
										0.143119);
	
	ams_class_sr_3 := (integer)ams_class_sr > 0;
	
	addrs_per_adl_c6_3 := addrs_per_adl_c6 > 0;
	
	em_only_count_w := map(
		em_only_count = 0  => -0.023275,
		em_only_count <= 2 => 0.160950,
		em_only_count <= 4 => 0.020255,
							-0.014939);
	
	gong_did_last_seen_mn_w := map(
		gong_did_last_seen_mn = NULL => -0.036125,
		gong_did_last_seen_mn = 0     => -0.137753,
		gong_did_last_seen_mn <= 5    => 0.067596,
		gong_did_last_seen_mn <= 9    => 0.083565,
		gong_did_last_seen_mn <= 21   => 0.110941,
		gong_did_last_seen_mn <= 24   => 0.116191,
		gong_did_last_seen_mn <= 37   => 0.137683,
		gong_did_last_seen_mn <= 38   => 0.161491,
		gong_did_last_seen_mn <= 39   => 0.091559,
		gong_did_last_seen_mn <= 43   => 0.088854,
		gong_did_last_seen_mn <= 55   => 0.083938,
		gong_did_last_seen_mn <= 57   => 0.066704,
		gong_did_last_seen_mn <= 86   => 0.059368,
		gong_did_last_seen_mn <= 89   => 0.041205,
		gong_did_last_seen_mn <= 100  => -0.102873,
		gong_did_last_seen_mn <= 104  => -0.157357,
		gong_did_last_seen_mn <= 109  => -0.174012,
										-0.213734);
	
	lienfederaltaxfiledtotal_w := map(
		LienFederalTaxFiledTotal = 0      => -0.004087,
		LienFederalTaxFiledTotal <= 32074 => 0.123721,
											0.165068);
	
	vo_addrs_per_adl_w := map(
		vo_addrs_per_adl <= 1 => 0.003513,
		vo_addrs_per_adl <= 4 => -0.038735,
								-0.262241);
	
	attr_num_proflic180_3 := attr_num_proflic180 > 0;
	
	add2_mortgage_due_date_mn_w := map(
		add2_mortgage_due_date_mn = NULL => 0.005549,
		add2_mortgage_due_date_mn <= 642  => -0.011008,
		add2_mortgage_due_date_mn <= 644  => -0.027842,
		add2_mortgage_due_date_mn <= 792  => -0.053547,
											-0.092169);
	
	impulse_count180_w := map(
		impulse_count180 = 0  => -0.003495,
		impulse_count180 <= 1 => 0.226582,
								0.278936);
	
	addrs_per_ssn_c6_w := map(
		addrs_per_ssn_c6 = 0  => 0.010032,
		addrs_per_ssn_c6 <= 1 => -0.059227,
								-0.153838);
	
	attr_date_last_purchase_mn_w := map(
		attr_date_last_purchase_mn = NULL => -0.003587,
		attr_date_last_purchase_mn <= 9    => -0.113450,
		attr_date_last_purchase_mn <= 16   => -0.092686,
		attr_date_last_purchase_mn <= 22   => 0.005013,
		attr_date_last_purchase_mn <= 47   => 0.021919,
		attr_date_last_purchase_mn <= 164  => 0.036606,
		attr_date_last_purchase_mn <= 187  => 0.128516,
											0.164584);
	
	liens_rel_sc_ct_w := map(
		liens_rel_sc_ct = 0  => 0.002967,
		liens_rel_sc_ct <= 1 => -0.056785,
		liens_rel_sc_ct <= 2 => -0.221548,
								-0.263776);
	
	liens_rel_ot_total_amount_w := map(
		liens_rel_ot_total_amount <= 91    => 0.004529,
		liens_rel_ot_total_amount <= 226   => -0.003810,
		liens_rel_ot_total_amount <= 288   => -0.093864,
		liens_rel_ot_total_amount <= 519   => -0.201795,
		liens_rel_ot_total_amount <= 1316  => -0.247551,
		liens_rel_ot_total_amount <= 1759  => -0.135912,
		liens_rel_ot_total_amount <= 4282  => -0.126752,
		liens_rel_ot_total_amount <= 10385 => 0.068654,
											0.121946);
	
	liens_hist_unrel_ct_w := map(
		liens_hist_unrel_ct = 0   => -0.090624,
		liens_hist_unrel_ct <= 1  => 0.172610,
		liens_hist_unrel_ct <= 2  => 0.198329,
		liens_hist_unrel_ct <= 3  => 0.247137,
		liens_hist_unrel_ct <= 4  => 0.298153,
		liens_hist_unrel_ct <= 5  => 0.306484,
		liens_hist_unrel_ct <= 7  => 0.347502,
		liens_hist_unrel_ct <= 14 => 0.396124,
									0.371468);
	
	educationinstitutionrating_w := map(
		TRIM(EducationInstitutionRating) = '' => 0.019451,
		(INTEGER)EducationInstitutionRating <= 3    => -0.378395,
		(INTEGER)EducationInstitutionRating <= 4    => -0.258546,
											-0.180081);
	
	bankrupt_3 := (integer)bankrupt > 0;
	
	inputssncharflag_5_3 := (INTEGER)(TRIM(inputssncharflag) = '5');
	
	score1 := criminal_last_date_mn_w * -1.52160491 +
		(integer)dl_avail_3 * 0.54123053 +
		add1_avm_med_fips_w * -0.81858098 +
		rv3_a_w * -0.74043480 +
		inputcurraddrstatediff_w * -0.68233984 +
		rv2_r_w * -0.68502704 +
		attr_eviction_count36_w * -0.83713291 +
		dist_a1toa2_w * -0.55494381 +
		lienjudgmentfiledtotal_w * -0.28820114 +
		(integer)ams_class_sr_3 * 0.59541026 +
		(integer)addrs_per_adl_c6_3 * 0.11802130 +
		inputssncharflag_5_3 * 0.36966041 +
		em_only_count_w * -0.95850463 +
		gong_did_last_seen_mn_w * -0.62717259 +
		lienfederaltaxfiledtotal_w * -1.77458467 +
		vo_addrs_per_adl_w * -1.95283695 +
		(integer)attr_num_proflic180_3 * -0.32487143 +
		add2_mortgage_due_date_mn_w * -1.71786601 +
		impulse_count180_w * -1.06444909 +
		addrs_per_ssn_c6_w * -1.06465687 +
		attr_date_last_purchase_mn_w * -1.72608772 +
		liens_rel_sc_ct_w * -1.38408798 +
		liens_rel_ot_total_amount_w * -0.85373218 +
		liens_hist_unrel_ct_w * -0.37718118 +
		educationinstitutionrating_w * -0.47477965 +
		(integer)bankrupt_3 * 0.40388493;
	
	/* ***********************************************************
	 *     Score 2 --> 651 <= RV_R <= 700 OR RV_R = 222          *
	 ************************************************************* */
	 
	add3_date_first_seen_mn_c16 := if(lg_8 = 4, cuyr - (real)oldyr_8_c15_b1, (cuyr - (real)oldyr_8_c15_b1) * 12 + cumn - (real)oldmn_8_c15_b1);
	
	add3_date_first_seen_mn := if(not((trim((string)add3_date_first_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_8 >= 4, add3_date_first_seen_mn_c16, NULL);
	
	gong_did_first_seen_mn_c18 := if(lg_9 = 4, cuyr - (real)oldyr_9_c17_b1, (cuyr - (real)oldyr_9_c17_b1) * 12 + cumn - (real)oldmn_9_c17_b1);
	
	gong_did_first_seen_mn := if(not((trim(gong_did_first_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_9 >= 4, gong_did_first_seen_mn_c18, NULL);
	
	adl_vo_first_seen_mn_c20 := if(lg_10 = 4, cuyr - (real)oldyr_10_c19_b1, (cuyr - (real)oldyr_10_c19_b1) * 12 + cumn - (real)oldmn_10_c19_b1);
	
	adl_vo_first_seen_mn := if(not((trim((string)adl_vo_first_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_10 >= 4, adl_vo_first_seen_mn_c20, NULL);
	
	add1_assessed_value_year_mn_c22 := if(lg_11 = 4, cuyr - (real)oldyr_11_c21_b1, (cuyr - (real)oldyr_11_c21_b1) * 12 + cumn - (real)oldmn_11_c21_b1);
	
	add1_assessed_value_year_mn := if(not((trim(add1_assessed_value_year, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_11 >= 4, add1_assessed_value_year_mn_c22, NULL);
	
	rv3_r_1 := if(rv3_r = 222, NULL, rv3_r);
	
	add2_avm_med_fips_1 := if(add2_avm_med_fips = 999999999, NULL, add2_avm_med_fips);
	
	dist_a2toa3_2 := if(dist_a2toa3_1 = 999999999, NULL, dist_a2toa3_1);
	
	max_lres_2 := if(max_lres_1 = 999999999, NULL, max_lres_1);
	
	rv3_r_w := map(
		rv3_r_1 <= 501 => 0.614411,
		rv3_r_1 <= 516 => 0.539746,
		rv3_r_1 <= 523 => 0.469882,
		rv3_r_1 <= 526 => 0.458226,
		rv3_r_1 <= 529 => 0.403274,
		rv3_r_1 <= 538 => 0.395851,
		rv3_r_1 <= 546 => 0.378023,
		rv3_r_1 <= 554 => 0.354044,
		rv3_r_1 <= 560 => 0.344126,
		rv3_r_1 <= 563 => 0.325762,
		rv3_r_1 <= 566 => 0.319666,
		rv3_r_1 <= 575 => 0.297162,
		rv3_r_1 <= 580 => 0.286904,
		rv3_r_1 <= 584 => 0.262265,
		rv3_r_1 <= 593 => 0.251583,
		rv3_r_1 <= 594 => 0.244967,
		rv3_r_1 <= 598 => 0.229175,
		rv3_r_1 <= 599 => 0.213791,
		rv3_r_1 <= 606 => 0.198261,
		rv3_r_1 <= 608 => 0.177667,
		rv3_r_1 <= 613 => 0.153435,
		rv3_r_1 <= 623 => 0.136245,
		rv3_r_1 <= 624 => 0.117098,
		rv3_r_1 <= 632 => 0.110978,
		rv3_r_1 <= 633 => 0.077763,
		rv3_r_1 <= 636 => 0.073866,
		rv3_r_1 <= 637 => 0.054048,
		rv3_r_1 <= 642 => 0.038508,
		rv3_r_1 <= 644 => 0.025586,
		rv3_r_1 <= 646 => 0.017023,
		rv3_r_1 <= 649 => -0.005183,
		rv3_r_1 <= 654 => -0.024138,
		rv3_r_1 <= 656 => -0.031339,
		rv3_r_1 <= 657 => -0.035790,
		rv3_r_1 <= 662 => -0.044302,
		rv3_r_1 <= 664 => -0.069472,
		rv3_r_1 <= 666 => -0.087725,
		rv3_r_1 <= 672 => -0.115476,
		rv3_r_1 <= 673 => -0.138165,
		rv3_r_1 <= 674 => -0.189051,
		rv3_r_1 <= 675 => -0.232892,
		rv3_r_1 <= 678 => -0.246857,
		rv3_r_1 <= 679 => -0.252794,
		rv3_r_1 <= 680 => -0.291210,
		rv3_r_1 <= 684 => -0.304594,
		rv3_r_1 <= 685 => -0.360150,
		rv3_r_1 <= 686 => -0.372735,
		rv3_r_1 <= 690 => -0.419720,
		rv3_r_1 <= 692 => -0.481881,
		rv3_r_1 <= 693 => -0.501297,
		rv3_r_1 <= 698 => -0.589764,
		rv3_r_1 <= 701 => -0.598157,
		rv3_r_1 <= 703 => -0.697199,
		rv3_r_1 <= 704 => -0.707666,
		rv3_r_1 <= 707 => -0.772570,
		rv3_r_1 <= 710 => -0.824817,
		rv3_r_1 <= 711 => -0.864726,
						-0.881685);
	
	criminal_last_date_mn_w_s2 := map(
		criminal_last_date_mn = NULL => -0.053017,
		criminal_last_date_mn <= 5    => 0.466107,
		criminal_last_date_mn <= 11   => 0.726317,
		criminal_last_date_mn <= 16   => 0.936654,
		criminal_last_date_mn <= 17   => 1.178412,
		criminal_last_date_mn <= 22   => 1.189257,
		criminal_last_date_mn <= 23   => 1.217183,
		criminal_last_date_mn <= 25   => 1.180452,
		criminal_last_date_mn <= 27   => 1.173471,
		criminal_last_date_mn <= 29   => 1.118290,
		criminal_last_date_mn <= 36   => 1.091621,
		criminal_last_date_mn <= 38   => 1.047339,
		criminal_last_date_mn <= 40   => 0.993188,
		criminal_last_date_mn <= 42   => 0.908863,
		criminal_last_date_mn <= 44   => 0.802919,
		criminal_last_date_mn <= 46   => 0.784034,
		criminal_last_date_mn <= 48   => 0.779467,
		criminal_last_date_mn <= 50   => 0.748614,
		criminal_last_date_mn <= 52   => 0.722707,
		criminal_last_date_mn <= 54   => 0.703572,
		criminal_last_date_mn <= 58   => 0.694960,
		criminal_last_date_mn <= 60   => 0.694119,
		criminal_last_date_mn <= 66   => 0.603549,
		criminal_last_date_mn <= 68   => 0.583681,
		criminal_last_date_mn <= 76   => 0.573341,
										0.535519);
	
	add2_avm_med_fips_w := map(
		add2_avm_med_fips_1 <= 61613  => -0.229338,
		add2_avm_med_fips_1 <= 125143 => -0.151072,
		add2_avm_med_fips_1 <= 126847 => -0.143843,
		add2_avm_med_fips_1 <= 140173 => 0.042234,
		add2_avm_med_fips_1 <= 143000 => 0.047343,
		add2_avm_med_fips_1 <= 153572 => 0.065171,
		add2_avm_med_fips_1 <= 200300 => 0.196163,
		add2_avm_med_fips_1 <= 220000 => 0.275680,
		add2_avm_med_fips_1 <= 266858 => 0.242193,
		add2_avm_med_fips_1 <= 346383 => 0.212873,
		add2_avm_med_fips_1 <= 427401 => 0.097167,
		add2_avm_med_fips_1 <= 582060 => 0.058061,
		add2_avm_med_fips_1 <= 715000 => -0.012627,
									-0.527868);
	
	dl_avail_3_s2 := (integer)dl_avail > 0;
	
	liencount_w := map(
		LienCount = 0   => -0.088482,
		LienCount <= 2  => 0.325112,
		LienCount <= 4  => 0.395600,
		LienCount <= 6  => 0.434936,
		LienCount <= 7  => 0.453973,
		LienCount <= 26 => 0.506214,
						0.399151);
	
	gong_did_last_seen_mn_w_s2 := map(
		gong_did_last_seen_mn = NULL => -0.003407,
		gong_did_last_seen_mn = 0     => -0.266402,
		gong_did_last_seen_mn <= 1    => 0.006936,
		gong_did_last_seen_mn <= 3    => 0.029967,
		gong_did_last_seen_mn <= 4    => 0.094266,
		gong_did_last_seen_mn <= 5    => 0.110936,
		gong_did_last_seen_mn <= 9    => 0.113045,
		gong_did_last_seen_mn <= 18   => 0.141827,
		gong_did_last_seen_mn <= 25   => 0.155056,
		gong_did_last_seen_mn <= 48   => 0.162891,
		gong_did_last_seen_mn <= 52   => 0.182219,
		gong_did_last_seen_mn <= 53   => 0.260086,
		gong_did_last_seen_mn <= 54   => 0.183830,
		gong_did_last_seen_mn <= 57   => 0.167355,
		gong_did_last_seen_mn <= 63   => 0.139038,
		gong_did_last_seen_mn <= 80   => 0.137688,
		gong_did_last_seen_mn <= 86   => 0.125830,
		gong_did_last_seen_mn <= 88   => 0.115747,
		gong_did_last_seen_mn <= 89   => 0.071566,
		gong_did_last_seen_mn <= 90   => 0.019003,
		gong_did_last_seen_mn <= 91   => 0.011294,
		gong_did_last_seen_mn <= 101  => -0.026831,
		gong_did_last_seen_mn <= 104  => -0.030919,
		gong_did_last_seen_mn <= 114  => -0.117580,
		gong_did_last_seen_mn <= 117  => -0.158781,
										-0.187877);
	
	disposition_dc_3 := disposition = 'Discharged';
	
	dist_a1toa2_w_s2 := map(
		dist_a1toa2_1 = NULL => -0.362805,
		dist_a1toa2_1 <= 79   => 0.143440,
		dist_a1toa2_1 <= 87   => 0.136865,
		dist_a1toa2_1 <= 153  => 0.098885,
		dist_a1toa2_1 <= 203  => 0.081572,
		dist_a1toa2_1 <= 228  => 0.065499,
		dist_a1toa2_1 <= 238  => -0.027310,
		dist_a1toa2_1 <= 244  => -0.062108,
		dist_a1toa2_1 <= 304  => -0.076004,
		dist_a1toa2_1 <= 315  => -0.097462,
		dist_a1toa2_1 <= 369  => -0.107753,
		dist_a1toa2_1 <= 457  => -0.120236,
		dist_a1toa2_1 <= 597  => -0.177853,
		dist_a1toa2_1 <= 2464 => -0.240565,
		dist_a1toa2_1 <= 9998 => -0.264309,
							-0.362805);
	
	pr_count_w := map(
		pr_count = 0   => 0.052182,
		pr_count <= 2  => -0.119373,
		pr_count <= 3  => -0.207581,
		pr_count <= 4  => -0.233858,
		pr_count <= 5  => -0.250460,
		pr_count <= 6  => -0.299516,
		pr_count <= 7  => -0.325396,
		pr_count <= 8  => -0.294462,
		pr_count <= 9  => -0.287446,
		pr_count <= 16 => -0.228115,
		pr_count <= 22 => -0.144396,
						0.069227);
	
	ssn3years_w := map(
		TRIM(SSN3Years) = '' => 0.001731,
		(INTEGER)SSN3Years = 0     => 0.004416,
							-0.833619);
	
	educationinstitutionrating_w_s2 := map(
		TRIM(EducationInstitutionRating) = '' => 0.021101,
		(INTEGER)EducationInstitutionRating <= 2    => -0.398753,
		(INTEGER)EducationInstitutionRating <= 3    => -0.358503,
		(INTEGER)EducationInstitutionRating <= 4    => -0.232885,
											-0.078201);
	
	add3_date_first_seen_mn_w := map(
		add3_date_first_seen_mn = NULL => -0.119310,
		add3_date_first_seen_mn <= 3    => 0.267933,
		add3_date_first_seen_mn <= 5    => 0.254111,
		add3_date_first_seen_mn <= 6    => 0.220032,
		add3_date_first_seen_mn <= 17   => 0.190745,
		add3_date_first_seen_mn <= 40   => 0.183986,
		add3_date_first_seen_mn <= 51   => 0.135075,
		add3_date_first_seen_mn <= 53   => 0.113744,
		add3_date_first_seen_mn <= 63   => 0.099063,
		add3_date_first_seen_mn <= 76   => 0.049804,
		add3_date_first_seen_mn <= 77   => 0.021358,
		add3_date_first_seen_mn <= 92   => 0.009780,
		add3_date_first_seen_mn <= 98   => 0.001378,
		add3_date_first_seen_mn <= 110  => -0.021890,
		add3_date_first_seen_mn <= 122  => -0.039120,
		add3_date_first_seen_mn <= 125  => -0.060549,
		add3_date_first_seen_mn <= 127  => -0.085463,
		add3_date_first_seen_mn <= 129  => -0.100939,
		add3_date_first_seen_mn <= 137  => -0.110625,
		add3_date_first_seen_mn <= 139  => -0.118904,
		add3_date_first_seen_mn <= 141  => -0.143038,
		add3_date_first_seen_mn <= 147  => -0.154457,
		add3_date_first_seen_mn <= 148  => -0.172334,
		add3_date_first_seen_mn <= 159  => -0.187894,
		add3_date_first_seen_mn <= 161  => -0.209386,
		add3_date_first_seen_mn <= 183  => -0.224804,
		add3_date_first_seen_mn <= 184  => -0.245663,
		add3_date_first_seen_mn <= 195  => -0.258350,
		add3_date_first_seen_mn <= 228  => -0.360453,
		add3_date_first_seen_mn <= 267  => -0.378474,
		add3_date_first_seen_mn <= 328  => -0.459713,
										-0.989670);
	
	rc_dwelltype_e_3 := rc_dwelltype = 'E';
	
	em_only_count_w_s2 := map(
		em_only_count = 0  => -0.012138,
		em_only_count <= 2 => 0.106463,
		em_only_count <= 3 => -0.042168,
		em_only_count <= 4 => -0.065328,
		em_only_count <= 5 => -0.137230,
							-0.307671);
	
	gong_did_first_ct_w := map(
		gong_did_first_ct <= 1 => -0.002932,
		gong_did_first_ct <= 2 => 0.024390,
		gong_did_first_ct <= 3 => 0.129427,
								0.334603);
	
	gong_did_first_seen_mn_w := map(
		gong_did_first_seen_mn = NULL => -0.003407,
		gong_did_first_seen_mn <= 3    => 0.067505,
		gong_did_first_seen_mn <= 5    => 0.121860,
		gong_did_first_seen_mn <= 8    => 0.127713,
		gong_did_first_seen_mn <= 10   => 0.128521,
		gong_did_first_seen_mn <= 12   => 0.145977,
		gong_did_first_seen_mn <= 23   => 0.185191,
		gong_did_first_seen_mn <= 35   => 0.201694,
		gong_did_first_seen_mn <= 36   => 0.229679,
		gong_did_first_seen_mn <= 37   => 0.252228,
		gong_did_first_seen_mn <= 40   => 0.281875,
		gong_did_first_seen_mn <= 52   => 0.202413,
		gong_did_first_seen_mn <= 64   => 0.196420,
		gong_did_first_seen_mn <= 79   => 0.078730,
		gong_did_first_seen_mn <= 93   => 0.059355,
		gong_did_first_seen_mn <= 101  => 0.023784,
		gong_did_first_seen_mn <= 102  => -0.064669,
		gong_did_first_seen_mn <= 103  => -0.107532,
		gong_did_first_seen_mn <= 104  => -0.107686,
		gong_did_first_seen_mn <= 105  => -0.142924,
		gong_did_first_seen_mn <= 119  => -0.315891,
		gong_did_first_seen_mn <= 121  => -0.492601,
										-0.663375);
	
	dist_a2toa3_w := map(
		dist_a2toa3_2 = NULL => -0.119452,
		dist_a2toa3_2 = 0     => -0.077878,
		dist_a2toa3_2 <= 1    => 0.112732,
		dist_a2toa3_2 <= 2    => 0.126107,
		dist_a2toa3_2 <= 27   => 0.131316,
		dist_a2toa3_2 <= 28   => 0.135545,
		dist_a2toa3_2 <= 30   => 0.139300,
		dist_a2toa3_2 <= 32   => 0.145758,
		dist_a2toa3_2 <= 35   => 0.149522,
		dist_a2toa3_2 <= 37   => 0.159698,
		dist_a2toa3_2 <= 39   => 0.163423,
		dist_a2toa3_2 <= 50   => 0.165584,
		dist_a2toa3_2 <= 58   => 0.169228,
		dist_a2toa3_2 <= 59   => 0.137546,
		dist_a2toa3_2 <= 62   => 0.135858,
		dist_a2toa3_2 <= 68   => 0.094493,
		dist_a2toa3_2 <= 90   => 0.058429,
		dist_a2toa3_2 <= 155  => 0.048810,
		dist_a2toa3_2 <= 240  => 0.040438,
		dist_a2toa3_2 <= 305  => 0.013700,
		dist_a2toa3_2 <= 380  => -0.021574,
		dist_a2toa3_2 <= 446  => -0.063135,
		dist_a2toa3_2 <= 462  => -0.080149,
		dist_a2toa3_2 <= 479  => -0.084695,
		dist_a2toa3_2 <= 572  => -0.086261,
		dist_a2toa3_2 <= 2496 => -0.115220,
		dist_a2toa3_2 <= 2560 => -0.129135,
							-0.246344);
	
	gong_did_phone_ct_w := map(
		gong_did_phone_ct <= 2 => -0.002466,
		gong_did_phone_ct <= 3 => 0.004334,
		gong_did_phone_ct <= 7 => 0.067542,
								0.098498);
	
	did3_liens_recent_unrel_count_3 := did3_liens_recent_unrel_count > 0;
	
	adl_vo_first_seen_mn_w := map(
		adl_vo_first_seen_mn = NULL => -0.001560,
		adl_vo_first_seen_mn <= 15   => 0.109301,
		adl_vo_first_seen_mn <= 29   => 0.066720,
		adl_vo_first_seen_mn <= 36   => 0.057859,
		adl_vo_first_seen_mn <= 38   => -0.065899,
		adl_vo_first_seen_mn <= 87   => -0.067018,
		adl_vo_first_seen_mn <= 89   => -0.257061,
		adl_vo_first_seen_mn <= 90   => -0.405007,
		adl_vo_first_seen_mn <= 114  => -0.089747,
										0.008348);
	
	liens_unrel_o_ct_3 := liens_unrel_o_ct > 0;
	
	add1_assessed_value_year_mn_w := map(
		add1_assessed_value_year_mn = NULL => -0.106748,
		add1_assessed_value_year_mn = 0     => 0.271138,
		add1_assessed_value_year_mn <= 1    => 0.142012,
		add1_assessed_value_year_mn <= 2    => 0.015112,
		add1_assessed_value_year_mn <= 5    => -0.136176,
		add1_assessed_value_year_mn <= 6    => 0.114348,
											0.211531);
	
	rc_bansflag_2 := rc_bansflag = (string)0;
	
	liens_unrel_ft_total_amount_w := map(
		liens_unrel_ft_total_amount = 0      => -0.005763,
		liens_unrel_ft_total_amount <= 5161  => 0.287994,
		liens_unrel_ft_total_amount <= 28468 => 0.350598,
												0.337386);
	
	rc_altlname1_flag_3 := (integer)rc_altlname1_flag > 0;
	
	phones_per_addr_w := map(
		phones_per_addr = 0   => -0.052213,
		phones_per_addr <= 1  => -0.012581,
		phones_per_addr <= 2  => 0.109773,
		phones_per_addr <= 15 => 0.136498,
		phones_per_addr <= 19 => 0.059352,
		phones_per_addr <= 23 => 0.046354,
		phones_per_addr <= 38 => 0.022965,
		phones_per_addr <= 42 => -0.005101,
								-0.009678);
	
	max_lres_w := map(
		max_lres_2 = NULL => -0.322991,
		max_lres_2 = 0     => -0.751296,
		max_lres_2 <= 1    => -0.501594,
		max_lres_2 <= 2    => -0.340931,
		max_lres_2 <= 4    => -0.329128,
		max_lres_2 <= 7    => -0.310402,
		max_lres_2 <= 8    => -0.299341,
		max_lres_2 <= 9    => -0.231007,
		max_lres_2 <= 11   => -0.160983,
		max_lres_2 <= 12   => -0.096337,
		max_lres_2 <= 13   => -0.012013,
		max_lres_2 <= 18   => -0.005589,
		max_lres_2 <= 22   => 0.011865,
		max_lres_2 <= 23   => 0.032376,
		max_lres_2 <= 25   => 0.105940,
		max_lres_2 <= 95   => 0.123891,
		max_lres_2 <= 112  => 0.078063,
		max_lres_2 <= 118  => 0.038001,
		max_lres_2 <= 123  => 0.012116,
		max_lres_2 <= 129  => -0.003522,
		max_lres_2 <= 130  => -0.015538,
		max_lres_2 <= 131  => -0.028753,
		max_lres_2 <= 138  => -0.063038,
		max_lres_2 <= 156  => -0.087497,
		max_lres_2 <= 159  => -0.088735,
		max_lres_2 <= 166  => -0.127942,
		max_lres_2 <= 174  => -0.131631,
		max_lres_2 <= 194  => -0.159140,
		max_lres_2 <= 196  => -0.208887,
		max_lres_2 <= 198  => -0.227132,
		max_lres_2 <= 228  => -0.232881,
		max_lres_2 <= 248  => -0.267371,
		max_lres_2 <= 252  => -0.276644,
							-0.293953);
	
	add2_naprop_w := map(
		add2_naprop = 0  => -0.038085,
		add2_naprop <= 2 => 0.163813,
		add2_naprop <= 3 => 0.084432,
							-0.291568);
	
	ams_college_tier_2_3 := ams_college_tier = '2';
	
	curraddrcountyindex_w := map(
		CurrAddrCountyIndex = 0     => -0.075374,
		CurrAddrCountyIndex <= 0.95 => 0.192765,
		CurrAddrCountyIndex <= 0.96 => 0.112892,
		CurrAddrCountyIndex <= 1.02 => 0.111735,
		CurrAddrCountyIndex <= 1.08 => 0.090949,
		CurrAddrCountyIndex <= 1.12 => 0.081910,
		CurrAddrCountyIndex <= 1.17 => 0.080094,
		CurrAddrCountyIndex <= 1.2  => 0.058482,
		CurrAddrCountyIndex <= 1.21 => 0.058480,
		CurrAddrCountyIndex <= 1.27 => 0.057814,
		CurrAddrCountyIndex <= 1.3  => 0.043956,
		CurrAddrCountyIndex <= 1.38 => 0.015714,
		CurrAddrCountyIndex <= 1.47 => 0.014036,
		CurrAddrCountyIndex <= 1.65 => -0.031810,
		CurrAddrCountyIndex <= 1.71 => -0.050599,
		CurrAddrCountyIndex <= 1.91 => -0.062551,
		CurrAddrCountyIndex <= 2.03 => -0.102060,
		CurrAddrCountyIndex <= 2.06 => -0.125857,
		CurrAddrCountyIndex <= 2.26 => -0.134470,
		CurrAddrCountyIndex <= 2.34 => -0.141176,
		CurrAddrCountyIndex <= 2.6  => -0.146049,
		CurrAddrCountyIndex <= 3.47 => -0.178544,
									-0.220655);
	
	add1_eda_sourced_3 := (integer)add1_eda_sourced > 0;
	
	statusmostrecent_o_3 := StatusMostRecent = 'O';
	
	add2_eda_sourced_3 := (integer)add2_eda_sourced > 0;
	
	add3_eda_sourced_3 := (integer)add3_eda_sourced > 0;
	
	watercraft_count_3 := watercraft_count > 0;
	
	prof_license_category_1_3 := (integer)prof_license_category_1 > 0;
	
	ams_college_tier_1_3 := ams_college_tier = '1';
	
	score2 := 	rv3_r_w * 											-0.75238332 +
		criminal_last_date_mn_w_s2 * 							-1.44089908 +
		add2_avm_med_fips_w * 										-0.48920296 +
		(integer)dl_avail_3_s2 * 									 0.46098585 +
		liencount_w * 														-0.87674757 +
		gong_did_last_seen_mn_w_s2 * 							-0.62047352 +
		(integer)disposition_dc_3 * 							 0.31992326 +
		dist_a1toa2_w_s2 * 												-0.24281159 +
		pr_count_w * 															-1.13161659 +
		ssn3years_w * 														-1.22046734 +
		educationinstitutionrating_w_s2 * 				-0.71546259 +
		add3_date_first_seen_mn_w * 							-0.24500853 +
		(integer)rc_dwelltype_e_3 * 							-0.37627426 +
		em_only_count_w_s2 * 											-1.10994370 +
		gong_did_first_ct_w * 										-2.58773391 +
		gong_did_first_seen_mn_w * 								-0.38328884 +
		dist_a2toa3_w * 													-0.37114542 +
		gong_did_phone_ct_w * 										-3.64410903 +
		(integer)did3_liens_recent_unrel_count_3 *-1.33850222 +
		adl_vo_first_seen_mn_w * 									-1.01408484 +
		inputssncharflag_5_3 * 										 0.20749941 +
		(integer)liens_unrel_o_ct_3 * 						-1.03335012 +
		add1_assessed_value_year_mn_w * 					-0.84759248 +
		(integer)rc_bansflag_2 * 									-0.09025173 +
		liens_unrel_ft_total_amount_w * 					-0.72021640 +
		(integer)rc_altlname1_flag_3 * 						 0.12517421 +
		phones_per_addr_w * 											-0.46846882 +
		max_lres_w * 															-0.12030372 +
		add2_naprop_w * 													-0.22427083 +
		(integer)ams_college_tier_2_3 * 					 0.30383371 +
		curraddrcountyindex_w * 									-0.20353523 +
		(integer)add1_eda_sourced_3 * 						 0.04044470 +
		(integer)statusmostrecent_o_3 * 					-0.05064986 +
		(integer)add2_eda_sourced_3 * 						 0.08627044 +
		(integer)add3_eda_sourced_3 * 						 0.07559386 +
		(integer)watercraft_count_3 * 						-0.16903610 +
		(integer)prof_license_category_1_3 * 			-0.14605656 +
		(integer)ams_college_tier_1_3 * 					 0.67422491;
	
	/* ***********************************************************
	 *                  Score 3 --> RV_R > 700                   *
	 ************************************************************* */
	attr_date_last_eviction_mn_c24 := if(lg_12 = 4, cuyr - (real)oldyr_12_c23_b1, (cuyr - (real)oldyr_12_c23_b1) * 12 + cumn - (real)oldmn_12_c23_b1);
	
	attr_date_last_eviction_mn := if(not((trim((string)attr_date_last_eviction, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_12 >= 4, attr_date_last_eviction_mn_c24, NULL);
	
	adl_w_first_seen_mn_c26 := if(lg_13 = 4, cuyr - (real)oldyr_13_c25_b1, (cuyr - (real)oldyr_13_c25_b1) * 12 + cumn - (real)oldmn_13_c25_b1);
	
	adl_w_first_seen_mn := if(not((trim((string)adl_w_first_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_13 >= 4, adl_w_first_seen_mn_c26, NULL);
	
	adl_vo_last_seen_mn_c28 := if(lg_14 = 4, cuyr - (real)oldyr_14_c27_b1, (cuyr - (real)oldyr_14_c27_b1) * 12 + cumn - (real)oldmn_14_c27_b1);
	
	adl_vo_last_seen_mn := if(not((trim((string)adl_vo_last_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_14 >= 4, adl_vo_last_seen_mn_c28, NULL);
	
	liens_unrel_o_first_seen_mn_c30 := if(lg_15 = 4, cuyr - (real)oldyr_15_c29_b1, (cuyr - (real)oldyr_15_c29_b1) * 12 + cumn - (real)oldmn_15_c29_b1);
	
	liens_unrel_o_first_seen_mn := if(not((trim((string)liens_unrel_o_first_seen, LEFT, RIGHT) in ['', '0', '0000', '000000', '00000000'])) and lg_15 >= 4, liens_unrel_o_first_seen_mn_c30, NULL);
	
	rv2_p_1 := if(rv2_p = 222, NULL, rv2_p);
		
	rv2_p_w := map(
		rv2_p_1 = NULL => -0.149495,
		rv2_p_1 <= 529  => 1.017183,
		rv2_p_1 <= 539  => 0.898800,
		rv2_p_1 <= 549  => 0.884407,
		rv2_p_1 <= 566  => 0.876872,
		rv2_p_1 <= 568  => 0.794621,
		rv2_p_1 <= 583  => 0.769828,
		rv2_p_1 <= 585  => 0.756807,
		rv2_p_1 <= 590  => 0.688771,
		rv2_p_1 <= 595  => 0.652562,
		rv2_p_1 <= 599  => 0.621081,
		rv2_p_1 <= 604  => 0.610580,
		rv2_p_1 <= 607  => 0.592420,
		rv2_p_1 <= 612  => 0.571169,
		rv2_p_1 <= 616  => 0.548785,
		rv2_p_1 <= 618  => 0.486180,
		rv2_p_1 <= 623  => 0.479820,
		rv2_p_1 <= 624  => 0.444106,
		rv2_p_1 <= 627  => 0.436464,
		rv2_p_1 <= 635  => 0.390906,
		rv2_p_1 <= 640  => 0.339550,
		rv2_p_1 <= 643  => 0.319242,
		rv2_p_1 <= 648  => 0.271792,
		rv2_p_1 <= 653  => 0.227276,
		rv2_p_1 <= 655  => 0.216742,
		rv2_p_1 <= 663  => 0.172516,
		rv2_p_1 <= 666  => 0.103308,
		rv2_p_1 <= 671  => 0.035927,
		rv2_p_1 <= 675  => 0.020592,
		rv2_p_1 <= 677  => -0.019802,
		rv2_p_1 <= 685  => -0.068965,
		rv2_p_1 <= 686  => -0.118692,
		rv2_p_1 <= 694  => -0.150893,
		rv2_p_1 <= 697  => -0.205631,
		rv2_p_1 <= 701  => -0.218384,
		rv2_p_1 <= 705  => -0.269554,
		rv2_p_1 <= 708  => -0.291682,
		rv2_p_1 <= 710  => -0.322476,
		rv2_p_1 <= 715  => -0.419141,
		rv2_p_1 <= 717  => -0.448476,
		rv2_p_1 <= 724  => -0.496930,
		rv2_p_1 <= 728  => -0.524573,
		rv2_p_1 <= 740  => -0.593434,
		rv2_p_1 <= 743  => -0.666737,
		rv2_p_1 <= 752  => -0.721743,
		rv2_p_1 <= 778  => -0.746894,
						-0.909111);
	
	add1_avm_med_fips_w_s3 := map(
		add1_avm_med_fips = 0       => -0.422519,
		add1_avm_med_fips <= 125143 => -0.307554,
		add1_avm_med_fips <= 128872 => -0.072392,
		add1_avm_med_fips <= 139720 => 0.100853,
		add1_avm_med_fips <= 250000 => 0.115578,
		add1_avm_med_fips <= 291211 => 0.279671,
		add1_avm_med_fips <= 346383 => 0.319391,
		add1_avm_med_fips <= 395150 => 0.211870,
		add1_avm_med_fips <= 715000 => 0.089913,
									-0.168958);
	
	dl_avail_3_s3 := (integer)dl_avail > 0;
	
	add1_family_owned_2 := (integer)add1_family_owned = 0;
	
	avg_avm_value_w := map(
		avg_avm_value = 0       => -0.043697,
		avg_avm_value <= 40724  => -0.001182,
		avg_avm_value <= 43768  => 0.054591,
		avg_avm_value <= 92322  => 0.055606,
		avg_avm_value <= 102843 => 0.104698,
		avg_avm_value <= 110409 => 0.116329,
		avg_avm_value <= 183133 => 0.120521,
		avg_avm_value <= 321680 => 0.120740,
		avg_avm_value <= 386250 => 0.136326,
		avg_avm_value <= 411033 => 0.184807,
		avg_avm_value <= 458814 => 0.218051,
		avg_avm_value <= 655700 => 0.272462,
		avg_avm_value <= 725028 => 0.414876,
		avg_avm_value <= 816667 => 0.129859,
								0.102226);
	
	subjectaddrcount_w := map(
		SubjectAddrCount <= 3  => -0.330818,
		SubjectAddrCount <= 4  => -0.256111,
		SubjectAddrCount <= 5  => -0.150564,
		SubjectAddrCount <= 6  => -0.079013,
		SubjectAddrCount <= 7  => 0.003372,
		SubjectAddrCount <= 8  => 0.048745,
		SubjectAddrCount <= 9  => 0.111139,
		SubjectAddrCount <= 10 => 0.125387,
		SubjectAddrCount <= 11 => 0.190747,
		SubjectAddrCount <= 12 => 0.253917,
		SubjectAddrCount <= 14 => 0.300555,
		SubjectAddrCount <= 16 => 0.376615,
		SubjectAddrCount <= 17 => 0.387481,
		SubjectAddrCount <= 18 => 0.418358,
		SubjectAddrCount <= 19 => 0.458135,
		SubjectAddrCount <= 21 => 0.514787,
		SubjectAddrCount <= 27 => 0.529120,
								0.562881);
	
	avg_add_last_seen_w := map(
		avg_add_last_seen = NULL => 0.175892,
		avg_add_last_seen <= 21   => 0.214860,
		avg_add_last_seen <= 22   => 0.169124,
		avg_add_last_seen <= 25   => 0.131830,
		avg_add_last_seen <= 29   => 0.119782,
		avg_add_last_seen <= 30   => 0.105961,
		avg_add_last_seen <= 31   => 0.087038,
		avg_add_last_seen <= 33   => 0.050104,
		avg_add_last_seen <= 34   => -0.012065,
		avg_add_last_seen <= 43   => -0.026648,
		avg_add_last_seen <= 46   => -0.086855,
		avg_add_last_seen <= 50   => -0.100074,
		avg_add_last_seen <= 55   => -0.115824,
		avg_add_last_seen <= 61   => -0.149188,
		avg_add_last_seen <= 62   => -0.163940,
		avg_add_last_seen <= 66   => -0.194869,
		avg_add_last_seen <= 77   => -0.256515,
		avg_add_last_seen <= 79   => -0.293280,
		avg_add_last_seen <= 88   => -0.316862,
		avg_add_last_seen <= 90   => -0.360030,
		avg_add_last_seen <= 93   => -0.407197,
		avg_add_last_seen <= 100  => -0.471452,
		avg_add_last_seen <= 107  => -0.490489,
		avg_add_last_seen <= 137  => -0.542220,
		avg_add_last_seen <= 142  => -0.577270,
		avg_add_last_seen <= 143  => -0.631135,
		avg_add_last_seen <= 204  => -0.730903,
		avg_add_last_seen <= 214  => -0.751011,
		avg_add_last_seen <= 234  => -0.841332,
									-0.889399);
	
	liens_unrel_cj_total_amount_w := map(
		liens_unrel_cj_total_amount = 0      => -0.041503,
		liens_unrel_cj_total_amount <= 394   => 0.687084,
		liens_unrel_cj_total_amount <= 2916  => 0.755775,
		liens_unrel_cj_total_amount <= 3550  => 0.805639,
		liens_unrel_cj_total_amount <= 5442  => 0.852171,
		liens_unrel_cj_total_amount <= 15340 => 0.746891,
												0.662675);
	
	attr_num_purchase12_3 := attr_num_purchase12 > 0;
	
	add2_family_owned_3 := (integer)add2_family_owned > 0;
	
	gong_did_first_seen_mn_w_s3 := map(
		gong_did_first_seen_mn = NULL => -0.036608,
		gong_did_first_seen_mn <= 2    => -0.014666,
		gong_did_first_seen_mn <= 6    => 0.155188,
		gong_did_first_seen_mn <= 23   => 0.216593,
		gong_did_first_seen_mn <= 24   => 0.250352,
		gong_did_first_seen_mn <= 27   => 0.277613,
		gong_did_first_seen_mn <= 38   => 0.296839,
		gong_did_first_seen_mn <= 39   => 0.425302,
		gong_did_first_seen_mn <= 43   => 0.390425,
		gong_did_first_seen_mn <= 44   => 0.371829,
		gong_did_first_seen_mn <= 64   => 0.323830,
		gong_did_first_seen_mn <= 97   => 0.142568,
		gong_did_first_seen_mn <= 101  => 0.135142,
		gong_did_first_seen_mn <= 104  => 0.116803,
		gong_did_first_seen_mn <= 119  => -0.255977,
		gong_did_first_seen_mn <= 121  => -0.312616,
										-0.680290);
	
	add1_naprop_w := map(
		add1_naprop = 0  => -0.110130,
		add1_naprop <= 2 => 0.343520,
		add1_naprop <= 3 => 0.362295,
							-0.087033);
	
	did_count_w := map(
		did_count <= 1 => -0.013345,
		did_count <= 2 => 0.283919,
		did_count <= 3 => 0.305758,
						0.399207);
	
	gong_did_phone_ct_w_s3 := map(
		gong_did_phone_ct <= 1 => -0.047672,
		gong_did_phone_ct <= 2 => 0.087595,
		gong_did_phone_ct <= 3 => 0.203283,
		gong_did_phone_ct <= 4 => 0.252078,
		gong_did_phone_ct <= 8 => 0.312092,
								0.610697);
	
	impulse_annual_income_w := map(
		impulse_annual_income = 0      => -0.006009,
		impulse_annual_income <= 21000 => 0.734019,
		impulse_annual_income <= 33000 => 0.957755,
		impulse_annual_income <= 54000 => 1.110257,
										1.088278);
	
	dist_a1toa2_w_s3 := map(
		dist_a1toa2_1 = NULL => -0.266868,
		dist_a1toa2_1 = 0     => -0.125612,
		dist_a1toa2_1 <= 5    => 0.101918,
		dist_a1toa2_1 <= 7    => 0.139443,
		dist_a1toa2_1 <= 9    => 0.142787,
		dist_a1toa2_1 <= 12   => 0.160457,
		dist_a1toa2_1 <= 30   => 0.175172,
		dist_a1toa2_1 <= 55   => 0.226076,
		dist_a1toa2_1 <= 57   => 0.230169,
		dist_a1toa2_1 <= 59   => 0.288901,
		dist_a1toa2_1 <= 61   => 0.195734,
		dist_a1toa2_1 <= 71   => 0.054622,
		dist_a1toa2_1 <= 73   => 0.054571,
		dist_a1toa2_1 <= 120  => -0.013244,
		dist_a1toa2_1 <= 352  => -0.020437,
		dist_a1toa2_1 <= 368  => -0.041859,
		dist_a1toa2_1 <= 389  => -0.049771,
		dist_a1toa2_1 <= 470  => -0.093477,
		dist_a1toa2_1 <= 2614 => -0.214555,
							-0.274581);
	
	nonderogcount06_w := map(
		NonDerogCount06 = 0  => 0.153747,
		NonDerogCount06 <= 1 => 0.092823,
		NonDerogCount06 <= 2 => -0.104282,
		NonDerogCount06 <= 4 => -0.185731,
								-0.253555);
	
	source_count_w := map(
		source_count = 0  => 0.123000,
		source_count <= 1 => -0.059396,
		source_count <= 2 => -0.089483,
		source_count <= 3 => -0.062484,
		source_count <= 4 => 0.048677,
		source_count <= 5 => 0.128820,
		source_count <= 6 => 0.204240,
		source_count <= 7 => 0.282995,
		source_count <= 8 => 0.291111,
							0.456043);
	
	add1_family_sold_3 := (integer)add1_family_sold > 0;
	
	inputcurraddrstatediff_w_s3 := map(
		TRIM(InputCurrAddrStateDiff) = '' => -0.124054,
		(INTEGER)InputCurrAddrStateDiff = 0     => 0.012759,
										-0.235677);
	
	liens_unrel_sc_ct_w := map(
		liens_unrel_sc_ct = 0  => -0.015612,
		liens_unrel_sc_ct <= 1 => 0.593604,
		liens_unrel_sc_ct <= 2 => 0.702559,
		liens_unrel_sc_ct <= 4 => 0.741181,
								0.538473);
	
	liens_unrel_ot_total_amount_w := map(
		liens_unrel_ot_total_amount = 0     => -0.020697,
		liens_unrel_ot_total_amount <= 74   => 0.320066,
		liens_unrel_ot_total_amount <= 217  => 0.461291,
		liens_unrel_ot_total_amount <= 859  => 0.463210,
		liens_unrel_ot_total_amount <= 1048 => 0.615880,
		liens_unrel_ot_total_amount <= 2467 => 0.631044,
		liens_unrel_ot_total_amount <= 7682 => 0.674625,
											0.745615);
	
	attr_date_last_eviction_mn_w := map(
		attr_date_last_eviction_mn = NULL => -0.016107,
		attr_date_last_eviction_mn <= 27   => 0.818142,
		attr_date_last_eviction_mn <= 41   => 1.024864,
		attr_date_last_eviction_mn <= 51   => 1.105775,
		attr_date_last_eviction_mn <= 56   => 1.065137,
		attr_date_last_eviction_mn <= 71   => 0.982744,
		attr_date_last_eviction_mn <= 81   => 0.936360,
											0.732475);
	
	did2_criminal_count_3 := did2_criminal_count > 0;
	
	subjectssncount_w := map(
		SubjectSSNCount <= 1 => -0.082693,
		SubjectSSNCount <= 2 => 0.166914,
		SubjectSSNCount <= 3 => 0.418178,
		SubjectSSNCount <= 4 => 0.628570,
		SubjectSSNCount <= 5 => 0.731091,
								1.020508);
	
	adl_w_first_seen_mn_w := map(
		adl_w_first_seen_mn = NULL => 0.005935,
		adl_w_first_seen_mn <= 9    => 0.345931,
		adl_w_first_seen_mn <= 12   => 0.338302,
		adl_w_first_seen_mn <= 22   => 0.143055,
		adl_w_first_seen_mn <= 25   => 0.138656,
		adl_w_first_seen_mn <= 44   => 0.107309,
		adl_w_first_seen_mn <= 56   => 0.035235,
		adl_w_first_seen_mn <= 65   => 0.033497,
		adl_w_first_seen_mn <= 68   => 0.003683,
		adl_w_first_seen_mn <= 70   => -0.163330,
		adl_w_first_seen_mn <= 92   => -0.394066,
		adl_w_first_seen_mn <= 124  => -0.183452,
		adl_w_first_seen_mn <= 129  => -0.012971,
		adl_w_first_seen_mn <= 134  => 0.000632,
		adl_w_first_seen_mn <= 203  => 0.046976,
									0.102831);
	
	proflicage_w := map(
		TRIM(ProfLicAge) = '' => 0.005377,
		(INTEGER)ProfLicAge = 0     => -0.259457,
		(INTEGER)ProfLicAge <= 24   => -0.134335,
		(INTEGER)ProfLicAge <= 26   => -0.020721,
							0.067857);
	
	adl_vo_last_seen_mn_w := map(
		adl_vo_last_seen_mn = NULL => 0.011722,
		adl_vo_last_seen_mn <= 6    => -0.309164,
		adl_vo_last_seen_mn <= 16   => -0.016818,
		adl_vo_last_seen_mn <= 30   => 0.027932,
		adl_vo_last_seen_mn <= 40   => 0.078324,
		adl_vo_last_seen_mn <= 41   => 0.146842,
		adl_vo_last_seen_mn <= 62   => 0.183898,
		adl_vo_last_seen_mn <= 67   => 0.183235,
		adl_vo_last_seen_mn <= 81   => 0.099649,
		adl_vo_last_seen_mn <= 184  => -0.053668,
									-0.102734);
	
	liens_unrel_o_first_seen_mn_2 := liens_unrel_o_first_seen_mn >= 0;
	
	liens_unrel_ft_ct_w := map(
		liens_unrel_ft_ct = 0  => -0.009352,
		liens_unrel_ft_ct <= 1 => 0.755768,
		liens_unrel_ft_ct <= 2 => 0.886565,
								1.011222);
	
	attr_num_rel_liens12_3 := attr_num_rel_liens12 > 0;
	
	rc_hrisksic_w := map(
		rc_hrisksic <= (string)NULL => -0.000449,
		rc_hrisksic <= (string)2381 => 0.150381,
									0.344793);
	
	did2_liens_recent_unrel_count_3 := did2_liens_recent_unrel_count > 0;
	
	add3_applicant_sold_3 := (integer)add3_applicant_sold > 0;
	
	add3_family_owned_3 := (integer)add3_family_owned > 0;
	
	score3 := rv2_p_w * -0.60955481 +
		add1_avm_med_fips_w_s3 * -0.79989437 +
		(integer)dl_avail_3_s3 * 0.48497712 +
		(integer)add1_family_owned_2 * -0.24472059 +
		avg_avm_value_w * -1.16217473 +
		subjectaddrcount_w * -0.30959299 +
		avg_add_last_seen_w * -0.39460419 +
		liens_unrel_cj_total_amount_w * -0.42915080 +
		(integer)attr_num_purchase12_3 * 0.28957125 +
		(integer)add2_family_owned_3 * 0.16980670 +
		gong_did_first_seen_mn_w_s3 * -0.44591514 +
		add1_naprop_w * -0.41080371 +
		did_count_w * -0.76414791 +
		gong_did_phone_ct_w_s3 * -0.73067256 +
		impulse_annual_income_w * -0.80370005 +
		dist_a1toa2_w_s3 * -0.61754109 +
		nonderogcount06_w * -0.54672340 +
		source_count_w * -0.75792132 +
		(integer)add1_family_sold_3 * -0.14302999 +
		inputcurraddrstatediff_w_s3 * -0.78040192 +
		liens_unrel_sc_ct_w * -0.55525339 +
		liens_unrel_ot_total_amount_w * -0.33813905 +
		attr_date_last_eviction_mn_w * -0.27400808 +
		(integer)did2_criminal_count_3 * -1.60820942 +
		subjectssncount_w * -0.23148910 +
		adl_w_first_seen_mn_w * -0.48003512 +
		proflicage_w * -0.71890857 +
		adl_vo_last_seen_mn_w * -0.39414894 +
		(integer)liens_unrel_o_first_seen_mn_2 * -2.20965541 +
		liens_unrel_ft_ct_w * -0.39584935 +
		(integer)attr_num_rel_liens12_3 * -0.61415675 +
		rc_hrisksic_w * -2.59885012 +
		(integer)did2_liens_recent_unrel_count_3 * -0.69221741 +
		(integer)add3_applicant_sold_3 * 0.09746307 +
		(integer)add3_family_owned_3 * 0.12385041;
	
	/* ***********************************************************
	 *                Select Subscore to Return                  *
	 ************************************************************* */
	finalScore := MAP(
										rv3_r = NULL OR rv3_r = 222																	=> nsc,
										0 <= rv_r AND rv_r <= 650 AND rv_r <> 222										=> score1,
										(651 <= rv_r AND rv_r <= 700) OR rv_r = NULL OR rv_r = 222	=> score2,
										rv_r >= 701																									=> score3,
																																									 nsc // Unscorable - 999
										);
										
	/* ***********************************************************
	 *                Populate Score and Return                  *
	 ************************************************************* */									
		#if(MODEL_DEBUG)
		/* Model Input Variables */
		SELF.add1_date_last_seen := add1_date_last_seen;
		SELF.add2_date_last_seen := add2_date_last_seen;
		SELF.add3_date_last_seen := add3_date_last_seen;
		SELF.criminal_last_date := criminal_last_date;
		SELF.gong_did_last_seen := gong_did_last_seen;
		SELF.add2_mortgage_due_date := add2_mortgage_due_date;
		SELF.attr_date_last_purchase := attr_date_last_purchase;
		SELF.add3_date_first_seen := add3_date_first_seen;
		SELF.gong_did_first_seen := gong_did_first_seen;
		SELF.adl_vo_first_seen := adl_vo_first_seen;
		SELF.add1_assessed_value_year := add1_assessed_value_year;
		SELF.attr_date_last_eviction := attr_date_last_eviction;
		SELF.adl_w_first_seen := adl_w_first_seen;
		SELF.adl_vo_last_seen := adl_vo_last_seen;
		SELF.liens_unrel_o_first_seen := liens_unrel_o_first_seen;
		SELF.did3_liens_recent_unrel_count := did3_liens_recent_unrel_count;
		SELF.dist_a1toa2 := dist_a1toa2;
		SELF.dist_a1toa3 := dist_a1toa3;
		SELF.dist_a2toa3 := dist_a2toa3;
		SELF.max_lres := max_lres;
		SELF.add1_assessed_amount := add1_assessed_amount;
		SELF.add2_assessed_amount := add2_assessed_amount;
		SELF.add3_assessed_amount := add3_assessed_amount;
		SELF.rc_dwelltype := rc_dwelltype;
		SELF.ams_class := ams_class;
		SELF.ams_college_type := ams_college_type;
		SELF.prof_license_category := prof_license_category;
		SELF.add1_avm_med_fips := add1_avm_med_fips;
		SELF.dl_avail := dl_avail;
		SELF.attr_eviction_count36 := attr_eviction_count36;
		SELF.LienJudgmentFiledTotal := LienJudgmentFiledTotal;
		SELF.addrs_per_adl_c6 := addrs_per_adl_c6;
		SELF.em_only_count := em_only_count;
		SELF.LienFederalTaxFiledTotal := LienFederalTaxFiledTotal;
		SELF.vo_addrs_per_adl := vo_addrs_per_adl;
		SELF.attr_num_proflic180 := attr_num_proflic180;
		SELF.impulse_count180 := impulse_count180;
		SELF.addrs_per_ssn_c6 := addrs_per_ssn_c6;
		SELF.liens_rel_sc_ct := liens_rel_sc_ct;
		SELF.liens_rel_ot_total_amount := liens_rel_ot_total_amount;
		SELF.liens_hist_unrel_ct := liens_hist_unrel_ct;
		SELF.bankrupt := bankrupt;
		SELF.inputssncharflag := inputssncharflag;
		SELF.add2_avm_med_fips := add2_avm_med_fips;
		SELF.disposition := disposition;
		SELF.pr_count := pr_count;
		SELF.gong_did_first_ct := gong_did_first_ct;
		SELF.gong_did_phone_ct := gong_did_phone_ct;
		SELF.liens_unrel_o_ct := liens_unrel_o_ct;
		SELF.rc_bansflag := rc_bansflag;
		SELF.liens_unrel_ft_total_amount := liens_unrel_ft_total_amount;
		SELF.rc_altlname1_flag := rc_altlname1_flag;
		SELF.phones_per_addr := phones_per_addr;
		SELF.add2_naprop := add2_naprop;
		SELF.ams_college_tier := ams_college_tier;
		SELF.add1_eda_sourced := add1_eda_sourced;
		SELF.add2_eda_sourced := add2_eda_sourced;
		SELF.add3_eda_sourced := add3_eda_sourced;
		SELF.watercraft_count := watercraft_count;
		SELF.add1_family_owned := add1_family_owned;
		SELF.liens_unrel_cj_total_amount := liens_unrel_cj_total_amount;
		SELF.attr_num_purchase12 := attr_num_purchase12;
		SELF.add2_family_owned := add2_family_owned;
		SELF.add1_naprop := add1_naprop;
		SELF.did_count := did_count;
		SELF.impulse_annual_income := impulse_annual_income;
		SELF.source_count := source_count;
		SELF.add1_family_sold := add1_family_sold;
		SELF.liens_unrel_sc_ct := liens_unrel_sc_ct;
		SELF.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
		SELF.did2_criminal_count := did2_criminal_count;
		SELF.liens_unrel_ft_ct := liens_unrel_ft_ct;
		SELF.attr_num_rel_liens12 := attr_num_rel_liens12;
		SELF.rc_hrisksic := rc_hrisksic;
		SELF.did2_liens_recent_unrel_count := did2_liens_recent_unrel_count;
		SELF.add3_applicant_sold := add3_applicant_sold;
		SELF.add3_family_owned := add3_family_owned;
		SELF.InputCurrAddrStateDiff := InputCurrAddrStateDiff;
		SELF.EducationInstitutionRating := EducationInstitutionRating;
		SELF.LienCount := LienCount;
		SELF.SSN3Years := SSN3Years;
		SELF.CurrAddrCountyIndex := CurrAddrCountyIndex;
		SELF.StatusMostRecent := StatusMostRecent;
		SELF.SubjectAddrCount := SubjectAddrCount;
		SELF.NonDerogCount06 := NonDerogCount06;
		SELF.SubjectSSNCount := SubjectSSNCount;
		SELF.ProfLicAge := ProfLicAge;
		SELF.archive_date := archive_date;
		SELF.rv_r := rv_r;
		
		/* Intermediate Variables */
		SELF.rv2_r := rv2_r;
		SELF.rv3_a := rv3_a;
		SELF.rv3_r := rv3_r;
		SELF.rv2_p := rv2_p;
		SELF.cuyr := cuyr;
		SELF.cumn := cumn;
		SELF.lg_1 := lg_1;
		SELF.oldyr_1_c1_b1 := oldyr_1_c1_b1;
		SELF.oldmn_1_c1_b1 := oldmn_1_c1_b1;
		SELF.add1_date_last_seen_mn_c2 := add1_date_last_seen_mn_c2;
		SELF.add1_date_last_seen_mn := add1_date_last_seen_mn;
		SELF.lg_2 := lg_2;
		SELF.oldyr_2_c3_b1 := oldyr_2_c3_b1;
		SELF.oldmn_2_c3_b1 := oldmn_2_c3_b1;
		SELF.add2_date_last_seen_mn_c4 := add2_date_last_seen_mn_c4;
		SELF.add2_date_last_seen_mn := add2_date_last_seen_mn;
		SELF.lg_3 := lg_3;
		SELF.oldyr_3_c5_b1 := oldyr_3_c5_b1;
		SELF.oldmn_3_c5_b1 := oldmn_3_c5_b1;
		SELF.add3_date_last_seen_mn_c6 := add3_date_last_seen_mn_c6;
		SELF.add3_date_last_seen_mn := add3_date_last_seen_mn;
		SELF.lg_4 := lg_4;
		SELF.oldyr_4_c7_b1 := oldyr_4_c7_b1;
		SELF.oldmn_4_c7_b1 := oldmn_4_c7_b1;
		SELF.criminal_last_date_mn_c8 := criminal_last_date_mn_c8;
		SELF.criminal_last_date_mn := criminal_last_date_mn;
		SELF.lg_5 := lg_5;
		SELF.oldyr_5_c9_b1 := oldyr_5_c9_b1;
		SELF.oldmn_5_c9_b1 := oldmn_5_c9_b1;
		SELF.gong_did_last_seen_mn_c10 := gong_did_last_seen_mn_c10;
		SELF.gong_did_last_seen_mn := gong_did_last_seen_mn;
		SELF.lg_6 := lg_6;
		SELF.oldyr_6_c11_b1 := oldyr_6_c11_b1;
		SELF.oldmn_6_c11_b1 := oldmn_6_c11_b1;
		SELF.add2_mortgage_due_date_mn_c12 := add2_mortgage_due_date_mn_c12;
		SELF.add2_mortgage_due_date_mn_2 := add2_mortgage_due_date_mn_2;
		SELF.lg_7 := lg_7;
		SELF.oldyr_7_c13_b1 := oldyr_7_c13_b1;
		SELF.oldmn_7_c13_b1 := oldmn_7_c13_b1;
		SELF.lg_8 := lg_8;
		SELF.oldyr_8_c15_b1 := oldyr_8_c15_b1;
		SELF.oldmn_8_c15_b1 := oldmn_8_c15_b1;
		SELF.lg_9 := lg_9;
		SELF.oldyr_9_c17_b1 := oldyr_9_c17_b1;
		SELF.oldmn_9_c17_b1 := oldmn_9_c17_b1;
		SELF.lg_10 := lg_10;
		SELF.oldyr_10_c19_b1 := oldyr_10_c19_b1;
		SELF.oldmn_10_c19_b1 := oldmn_10_c19_b1;
		SELF.lg_11 := lg_11;
		SELF.oldyr_11_c21_b1 := oldyr_11_c21_b1;
		SELF.oldmn_11_c21_b1 := oldmn_11_c21_b1;
		SELF.lg_12 := lg_12;
		SELF.oldyr_12_c23_b1 := oldyr_12_c23_b1;
		SELF.oldmn_12_c23_b1 := oldmn_12_c23_b1;
		SELF.lg_13 := lg_13;
		SELF.oldyr_13_c25_b1 := oldyr_13_c25_b1;
		SELF.oldmn_13_c25_b1 := oldmn_13_c25_b1;
		SELF.lg_14 := lg_14;
		SELF.oldyr_14_c27_b1 := oldyr_14_c27_b1;
		SELF.oldmn_14_c27_b1 := oldmn_14_c27_b1;
		SELF.lg_15 := lg_15;
		SELF.oldyr_15_c29_b1 := oldyr_15_c29_b1;
		SELF.oldmn_15_c29_b1 := oldmn_15_c29_b1;
		SELF.add2_mortgage_due_date_mn_1 := add2_mortgage_due_date_mn_1;
		SELF.lg_16 := lg_16;
		SELF.oldyr_16_c32_b1 := oldyr_16_c32_b1;
		SELF.oldmn_16_c32_b1 := oldmn_16_c32_b1;
		SELF.dist_a1toa2_1 := dist_a1toa2_1;
		SELF.dist_a1toa3_1 := dist_a1toa3_1;
		SELF.dist_a2toa3_1 := dist_a2toa3_1;
		SELF.max_lres_1 := max_lres_1;
		SELF.add1_assessed_amount_1 := add1_assessed_amount_1;
		SELF.add2_assessed_amount_1 := add2_assessed_amount_1;
		SELF.add3_assessed_amount_1 := add3_assessed_amount_1;
		SELF.dist_a1toa2_2 := dist_a1toa2_2;
		SELF.avg_avm_value := avg_avm_value;
		SELF.rc_dwelltype_a := rc_dwelltype_a;
		SELF.rc_dwelltype_e := rc_dwelltype_e;
		SELF.rc_dwelltype_r := rc_dwelltype_r;
		SELF.rc_dwelltype_s := rc_dwelltype_s;
		SELF.ams_class_fr := ams_class_fr;
		SELF.ams_class_gr := ams_class_gr;
		SELF.ams_class_jr := ams_class_jr;
		SELF.ams_class_so := ams_class_so;
		SELF.ams_class_sr := ams_class_sr;
		SELF.ams_class_un := ams_class_un;
		SELF.ams_class_num := ams_class_num;
		SELF.ams_college_type_p := ams_college_type_p;
		SELF.ams_college_type_r := ams_college_type_r;
		SELF.ams_college_type_s := ams_college_type_s;
		SELF.prof_license_category_0 := prof_license_category_0;
		SELF.prof_license_category_1 := prof_license_category_1;
		SELF.prof_license_category_2 := prof_license_category_2;
		SELF.prof_license_category_3 := prof_license_category_3;
		SELF.prof_license_category_4 := prof_license_category_4;
		SELF.prof_license_category_5 := prof_license_category_5;
		SELF.avg_add_last_seen := avg_add_last_seen;
		SELF.add1_avm_med_fips_1 := add1_avm_med_fips_1;
		SELF.attr_date_last_purchase_mn_c14 := attr_date_last_purchase_mn_c14;
		SELF.attr_date_last_purchase_mn_1 := attr_date_last_purchase_mn_1;
		SELF.add2_mortgage_due_date_mn := add2_mortgage_due_date_mn;
		SELF.attr_date_last_purchase_mn_c33 := attr_date_last_purchase_mn_c33;
		SELF.attr_date_last_purchase_mn := attr_date_last_purchase_mn;
		SELF.rv2_r_1 := rv2_r_1;
		SELF.rv3_a_1 := rv3_a_1;
		SELF.criminal_last_date_mn_w := criminal_last_date_mn_w;
		SELF.dl_avail_3 := dl_avail_3;
		SELF.add1_avm_med_fips_w := add1_avm_med_fips_w;
		SELF.rv3_a_w := rv3_a_w;
		SELF.inputcurraddrstatediff_w := inputcurraddrstatediff_w;
		SELF.rv2_r_w := rv2_r_w;
		SELF.attr_eviction_count36_w := attr_eviction_count36_w;
		SELF.dist_a1toa2_w := dist_a1toa2_w;
		SELF.lienjudgmentfiledtotal_w := lienjudgmentfiledtotal_w;
		SELF.ams_class_sr_3 := ams_class_sr_3;
		SELF.addrs_per_adl_c6_3 := addrs_per_adl_c6_3;
		SELF.em_only_count_w := em_only_count_w;
		SELF.gong_did_last_seen_mn_w := gong_did_last_seen_mn_w;
		SELF.lienfederaltaxfiledtotal_w := lienfederaltaxfiledtotal_w;
		SELF.vo_addrs_per_adl_w := vo_addrs_per_adl_w;
		SELF.attr_num_proflic180_3 := attr_num_proflic180_3;
		SELF.add2_mortgage_due_date_mn_w := add2_mortgage_due_date_mn_w;
		SELF.impulse_count180_w := impulse_count180_w;
		SELF.addrs_per_ssn_c6_w := addrs_per_ssn_c6_w;
		SELF.attr_date_last_purchase_mn_w := attr_date_last_purchase_mn_w;
		SELF.liens_rel_sc_ct_w := liens_rel_sc_ct_w;
		SELF.liens_rel_ot_total_amount_w := liens_rel_ot_total_amount_w;
		SELF.liens_hist_unrel_ct_w := liens_hist_unrel_ct_w;
		SELF.educationinstitutionrating_w := educationinstitutionrating_w;
		SELF.bankrupt_3 := bankrupt_3;
		SELF.inputssncharflag_5_3 := inputssncharflag_5_3;
		SELF.score1 := score1;
		SELF.add3_date_first_seen_mn_c16 := add3_date_first_seen_mn_c16;
		SELF.add3_date_first_seen_mn := add3_date_first_seen_mn;
		SELF.gong_did_first_seen_mn_c18 := gong_did_first_seen_mn_c18;
		SELF.gong_did_first_seen_mn := gong_did_first_seen_mn;
		SELF.adl_vo_first_seen_mn_c20 := adl_vo_first_seen_mn_c20;
		SELF.adl_vo_first_seen_mn := adl_vo_first_seen_mn;
		SELF.add1_assessed_value_year_mn_c22 := add1_assessed_value_year_mn_c22;
		SELF.add1_assessed_value_year_mn := add1_assessed_value_year_mn;
		SELF.rv3_r_1 := rv3_r_1;
		SELF.add2_avm_med_fips_1 := add2_avm_med_fips_1;
		SELF.dist_a2toa3_2 := dist_a2toa3_2;
		SELF.max_lres_2 := max_lres_2;
		SELF.rv3_r_w := rv3_r_w;
		SELF.criminal_last_date_mn_w_s2 := criminal_last_date_mn_w_s2;
		SELF.add2_avm_med_fips_w := add2_avm_med_fips_w;
		SELF.dl_avail_3_s2 := dl_avail_3_s2;
		SELF.liencount_w := liencount_w;
		SELF.gong_did_last_seen_mn_w_s2 := gong_did_last_seen_mn_w_s2;
		SELF.disposition_dc_3 := disposition_dc_3;
		SELF.dist_a1toa2_w_s2 := dist_a1toa2_w_s2;
		SELF.pr_count_w := pr_count_w;
		SELF.ssn3years_w := ssn3years_w;
		SELF.educationinstitutionrating_w_s2 := educationinstitutionrating_w_s2;
		SELF.add3_date_first_seen_mn_w := add3_date_first_seen_mn_w;
		SELF.rc_dwelltype_e_3 := rc_dwelltype_e_3;
		SELF.em_only_count_w_s2 := em_only_count_w_s2;
		SELF.gong_did_first_ct_w := gong_did_first_ct_w;
		SELF.gong_did_first_seen_mn_w := gong_did_first_seen_mn_w;
		SELF.dist_a2toa3_w := dist_a2toa3_w;
		SELF.gong_did_phone_ct_w := gong_did_phone_ct_w;
		SELF.did3_liens_recent_unrel_count_3 := did3_liens_recent_unrel_count_3;
		SELF.adl_vo_first_seen_mn_w := adl_vo_first_seen_mn_w;
		SELF.liens_unrel_o_ct_3 := liens_unrel_o_ct_3;
		SELF.add1_assessed_value_year_mn_w := add1_assessed_value_year_mn_w;
		SELF.rc_bansflag_2 := rc_bansflag_2;
		SELF.liens_unrel_ft_total_amount_w := liens_unrel_ft_total_amount_w;
		SELF.rc_altlname1_flag_3 := rc_altlname1_flag_3;
		SELF.phones_per_addr_w := phones_per_addr_w;
		SELF.max_lres_w := max_lres_w;
		SELF.add2_naprop_w := add2_naprop_w;
		SELF.ams_college_tier_2_3 := ams_college_tier_2_3;
		SELF.curraddrcountyindex_w := curraddrcountyindex_w;
		SELF.add1_eda_sourced_3 := add1_eda_sourced_3;
		SELF.statusmostrecent_o_3 := statusmostrecent_o_3;
		SELF.add2_eda_sourced_3 := add2_eda_sourced_3;
		SELF.add3_eda_sourced_3 := add3_eda_sourced_3;
		SELF.watercraft_count_3 := watercraft_count_3;
		SELF.prof_license_category_1_3 := prof_license_category_1_3;
		SELF.ams_college_tier_1_3 := ams_college_tier_1_3;
		SELF.score2 := score2;
		SELF.attr_date_last_eviction_mn_c24 := attr_date_last_eviction_mn_c24;
		SELF.attr_date_last_eviction_mn := attr_date_last_eviction_mn;
		SELF.adl_w_first_seen_mn_c26 := adl_w_first_seen_mn_c26;
		SELF.adl_w_first_seen_mn := adl_w_first_seen_mn;
		SELF.adl_vo_last_seen_mn_c28 := adl_vo_last_seen_mn_c28;
		SELF.adl_vo_last_seen_mn := adl_vo_last_seen_mn;
		SELF.liens_unrel_o_first_seen_mn_c30 := liens_unrel_o_first_seen_mn_c30;
		SELF.liens_unrel_o_first_seen_mn := liens_unrel_o_first_seen_mn;
		SELF.rv2_p_1 := rv2_p_1;
		SELF.rv2_p_w := rv2_p_w;
		SELF.add1_avm_med_fips_w_s3 := add1_avm_med_fips_w_s3;
		SELF.dl_avail_3_s3 := dl_avail_3_s3;
		SELF.add1_family_owned_2 := add1_family_owned_2;
		SELF.avg_avm_value_w := avg_avm_value_w;
		SELF.subjectaddrcount_w := subjectaddrcount_w;
		SELF.avg_add_last_seen_w := avg_add_last_seen_w;
		SELF.liens_unrel_cj_total_amount_w := liens_unrel_cj_total_amount_w;
		SELF.attr_num_purchase12_3 := attr_num_purchase12_3;
		SELF.add2_family_owned_3 := add2_family_owned_3;
		SELF.gong_did_first_seen_mn_w_s3 := gong_did_first_seen_mn_w_s3;
		SELF.add1_naprop_w := add1_naprop_w;
		SELF.did_count_w := did_count_w;
		SELF.gong_did_phone_ct_w_s3 := gong_did_phone_ct_w_s3;
		SELF.impulse_annual_income_w := impulse_annual_income_w;
		SELF.dist_a1toa2_w_s3 := dist_a1toa2_w_s3;
		SELF.nonderogcount06_w := nonderogcount06_w;
		SELF.source_count_w := source_count_w;
		SELF.add1_family_sold_3 := add1_family_sold_3;
		SELF.inputcurraddrstatediff_w_s3 := inputcurraddrstatediff_w_s3;
		SELF.liens_unrel_sc_ct_w := liens_unrel_sc_ct_w;
		SELF.liens_unrel_ot_total_amount_w := liens_unrel_ot_total_amount_w;
		SELF.attr_date_last_eviction_mn_w := attr_date_last_eviction_mn_w;
		SELF.did2_criminal_count_3 := did2_criminal_count_3;
		SELF.subjectssncount_w := subjectssncount_w;
		SELF.adl_w_first_seen_mn_w := adl_w_first_seen_mn_w;
		SELF.proflicage_w := proflicage_w;
		SELF.adl_vo_last_seen_mn_w := adl_vo_last_seen_mn_w;
		SELF.liens_unrel_o_first_seen_mn_2 := liens_unrel_o_first_seen_mn_2;
		SELF.liens_unrel_ft_ct_w := liens_unrel_ft_ct_w;
		SELF.attr_num_rel_liens12_3 := attr_num_rel_liens12_3;
		SELF.rc_hrisksic_w := rc_hrisksic_w;
		SELF.did2_liens_recent_unrel_count_3 := did2_liens_recent_unrel_count_3;
		SELF.add3_applicant_sold_3 := add3_applicant_sold_3;
		SELF.add3_family_owned_3 := add3_family_owned_3;
		SELF.score3 := score3;
		SELF.finalScore := finalScore;
		SELF.score := finalScore;
		
		SELF.clam.seq := le.seq;

		SELF.clam := le;
	#else
		SELF.seq := le.seq;
		SELF.score := finalScore;
	#end
	END;
		
	model := PROJECT(scoredClam, doModel(LEFT));
	
	RETURN(model);
END;	