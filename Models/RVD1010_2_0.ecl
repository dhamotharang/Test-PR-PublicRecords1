import risk_indicators, ut, riskwisefcra, riskwise;

export RVD1010_2_0( dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia ) := FUNCTION

	RVD_DEBUG := false;

	#if(RVD_DEBUG)
		layout_debug := record
			integer seq;
			String rc_ssnvalflag;
			Boolean add1_pop;
			Boolean add2_pop;
			Boolean add3_pop;
			Integer NAP_Summary;
			String NAP_Type;
			String NAP_Status;
			Integer did2_liens_recent_unrel_count;
			String rc_hphonetypeflag;
			String rc_phonevalflag;
			String rc_hphonevalflag;
			String rc_hriskaddrflag;
			String rc_decsflag;
			String rc_pwssnvalflag;
			String rc_addrvalflag;
			String rc_dwelltype;
			Integer rc_lnamecount;
			Integer rc_ssncount;
			Integer rc_phoneaddr_addrcount;
			Integer rc_disthphoneaddr;
			String rc_zipclass;
			Boolean rc_lnamessnmatch;
			Integer combo_fnamescore;
			Integer combo_lnamescore;
			Integer combo_addrscore;
			Integer combo_fnamecount;
			Integer combo_lnamecount;
			Integer combo_dobcount;
			Integer EQ_count;
			Integer PR_count;
			Integer EM_count;
			Integer VO_count;
			Integer EM_only_count;
			String fname_eda_sourced_type;
			String lname_eda_sourced_type;
			Integer age;
			Boolean add1_isbestmatch;
			Integer add1_unit_count;
			Integer add1_lres;
			String add1_avm_sales_price;
			String add1_avm_assessed_total_value;
			String add1_avm_market_total_value;
			Integer add1_avm_tax_assessed_valuation;
			Integer add1_avm_price_index_valuation;
			Integer add1_avm_hedonic_valuation;
			Integer add1_avm_automated_valuation;
			Integer add1_avm_confidence_score;
			Integer add1_avm_med_fips;
			Integer add1_avm_med_geo11;
			Integer add1_avm_med_geo12;
			Boolean add1_applicant_owned;
			Boolean add1_family_owned;
			Boolean add1_family_sold;
			Integer add1_naprop;
			Integer add1_purchase_amount;
			Integer add1_mortgage_amount;
			String add1_financing_type;
			Integer add1_assessed_amount;
			String add1_building_area;
			String add1_no_of_rooms;
			String add1_no_of_bedrooms;
			String add1_no_of_partial_baths;
			Integer property_owned_purchase_total;
			Integer property_owned_assessed_total;
			Integer property_sold_purchase_total;
			Integer prop1_prev_purchase_price;
			Integer dist_a1toa2;
			Integer dist_a1toa3;
			Integer dist_a2toa3;
			Integer add1_add2_score;
			Integer add1_add3_score;
			Integer add2_add3_score;
			Integer avg_lres;
			Integer max_lres;
			Integer addrs_5yr;
			Integer addrs_10yr;
			Integer addrs_15yr;
			Boolean addrs_prison_history;
			Integer gong_did_phone_ct;
			Integer gong_did_addr_ct;
			Integer gong_did_last_ct;
			Integer ssns_per_adl;
			Integer addrs_per_adl;
			Integer phones_per_adl;
			Integer adlPerSSN_count;
			Integer addrs_per_ssn;
			Integer adls_per_addr;
			Integer ssns_per_addr;
			Integer phones_per_addr;
			Integer adls_per_phone;
			Integer addrs_per_ssn_c6;
			Integer phones_per_addr_c6;
			Integer adls_per_phone_c6;
			Integer vo_addrs_per_adl;
			Integer invalid_phones_per_adl;
			Integer invalid_ssns_per_adl;
			Integer invalid_addrs_per_adl;
			Integer infutor_nap;
			Integer impulse_count;
			Integer impulse_count90;
			Integer impulse_count180;
			Integer impulse_count24;
			Integer impulse_annual_income;
			Integer attr_addrs_last12;
			Integer attr_addrs_last24;
			Integer attr_addrs_last36;
			Integer attr_num_purchase60;
			Integer attr_num_sold36;
			Integer attr_total_number_derogs;
			Integer attr_felonies60;
			Integer attr_num_unrel_liens90;
			Integer attr_num_unrel_liens180;
			Integer attr_num_unrel_liens12;
			Integer attr_num_unrel_liens24;
			Integer attr_num_unrel_liens36;
			Integer attr_num_unrel_liens60;
			Integer attr_num_rel_liens30;
			Integer attr_num_rel_liens180;
			Integer attr_num_rel_liens12;
			Integer attr_num_rel_liens24;
			Integer attr_num_rel_liens36;
			Integer attr_bankruptcy_count36;
			Integer attr_eviction_count;
			Integer attr_eviction_count30;
			Integer attr_eviction_count180;
			Integer attr_eviction_count12;
			Integer attr_eviction_count60;
			Integer attr_num_nonderogs;
			Integer attr_num_nonderogs90;
			Integer attr_num_nonderogs12;
			Integer attr_num_nonderogs24;
			Integer attr_num_nonderogs36;
			Integer attr_num_nonderogs60;
			Integer attr_num_proflic_exp12;
			Integer attr_num_proflic_exp24;
			String disposition;
			Integer filing_count;
			Integer bk_recent_count;
			Integer bk_disposed_recent_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_historical_released_count;
			Integer liens_unrel_cj_ct;
			Integer liens_unrel_cj_total_amount;
			Integer liens_rel_cj_ct;
			Integer liens_rel_cj_total_amount;
			Integer liens_unrel_ft_ct;
			Integer liens_unrel_ft_total_amount;
			Integer liens_rel_ft_ct;
			Integer liens_rel_ft_total_amount;
			Integer liens_unrel_fc_total_amount;
			Integer liens_unrel_lt_ct;
			Integer liens_rel_lt_ct;
			Integer liens_unrel_o_ct;
			Integer liens_rel_o_ct;
			Integer liens_rel_o_total_amount;
			Integer liens_unrel_ot_ct;
			Integer liens_unrel_ot_total_amount;
			Integer liens_rel_ot_ct;
			Integer liens_rel_ot_total_amount;
			Integer liens_unrel_sc_ct;
			Integer liens_unrel_sc_total_amount;
			Integer criminal_count;
			Integer felony_count;
			String ams_college_code;
			String ams_college_type;
			String ams_income_level_code;
			String ams_file_type;
			String ams_college_tier;
			String prof_license_category;
			String input_dob_match_level;
			String addr_stability;
			String eg_segment;
			real tnscore;
			Real score0;
			Real score1;
			Real expsum;
			Real prob0;
			Real prob1;
			Integer SBAR_Treenet_Score1;
			Integer SBAR_Treenet_Score2;
			Boolean isUnscorable;
			models.layout_modelout - seq;
		end;
		layout_debug doModel( clam le ) := TRANSFORM
	#else
		models.layout_modelout doModel( clam le ) := TRANSFORM
	#end

		string remap( string field, string newval ) := if( trim(field)='', newval, field );
		rc_ssnvalflag                    := le.iid.socsvalflag;
		add1_pop                         := le.addrpop;
		add2_pop                         := le.addrpop2;
		add3_pop                         := le.addrpop3;
		nap_summary                      := le.iid.nap_summary;
		nap_type                         := le.iid.nap_type;
		nap_status                       := le.iid.nap_status;
		did2_liens_recent_unrel_count    := le.iid.did2_liens_recent_unreleased_count;
		rc_hphonetypeflag                := remap(le.iid.hphonetypeflag, '1');
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_hriskaddrflag                 := le.iid.hriskaddrflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_addrvalflag                   := remap(le.iid.addrvalflag, 'V');
		rc_dwelltype                     := le.iid.dwelltype;
		rc_lnamecount                    := le.iid.lastcount;
		rc_ssncount                      := le.iid.socscount;
		rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_zipclass                      := le.iid.zipclass;
		rc_lnamessnmatch                 := le.iid.lastssnmatch;
		combo_fnamescore                 := le.iid.combo_firstscore;
		combo_lnamescore                 := le.iid.combo_lastscore;
		combo_addrscore                  := le.iid.combo_addrscore;
		combo_fnamecount                 := le.iid.combo_firstcount;
		combo_lnamecount                 := le.iid.combo_lastcount;
		combo_dobcount                   := le.iid.combo_dobcount;
		eq_count                         := le.source_verification.eq_count;
		pr_count                         := le.source_verification.pr_count;
		em_count                         := le.source_verification.em_count;
		vo_count                         := le.source_verification.vo_count;
		em_only_count                    := le.source_verification.em_only_count;
		fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
		lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
		age                              := le.name_verification.age;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_unit_count                  := le.address_verification.input_address_information.unit_count;
		add1_lres                        := le.lres;
		add1_avm_sales_price             := le.avm.input_address_information.avm_sales_price;
		add1_avm_assessed_total_value    := le.avm.input_address_information.avm_assessed_total_value;
		add1_avm_market_total_value      := le.avm.input_address_information.avm_market_total_value;
		add1_avm_tax_assessed_valuation  := le.avm.input_address_information.avm_tax_assessment_valuation;
		add1_avm_price_index_valuation   := le.avm.input_address_information.avm_price_index_valuation;
		add1_avm_hedonic_valuation       := le.avm.input_address_information.avm_hedonic_valuation;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_confidence_score        := le.avm.input_address_information.avm_confidence_score;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_family_sold                 := le.address_verification.input_address_information.family_sold;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
		add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
		add1_building_area               := (string)le.address_verification.input_address_information.building_area;
		add1_no_of_rooms                 := (string)le.address_verification.input_address_information.no_of_rooms;
		add1_no_of_bedrooms              := (string)le.address_verification.input_address_information.no_of_bedrooms;
		add1_no_of_partial_baths         := (string)le.address_verification.input_address_information.no_of_partial_baths;
		property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
		property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
		property_sold_purchase_total     := le.address_verification.sold.property_owned_purchase_total;
		prop1_prev_purchase_price        := le.address_verification.recent_property_sales.prev_purch_price1;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		add1_add2_score                  := le.address_verification.addr1addr2score;
		add1_add3_score                  := le.address_verification.addr1addr3score;
		add2_add3_score                  := le.address_verification.addr2addr3score;
		avg_lres                         := le.other_address_info.avg_lres;
		max_lres                         := le.other_address_info.max_lres;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		addrs_10yr                       := le.other_address_info.addrs_last_10years;
		addrs_15yr                       := le.other_address_info.addrs_last_15years;
		addrs_prison_history             := le.other_address_info.isprison;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
		gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		phones_per_adl                   := le.velocity_counters.phones_per_adl;
		adlperssn_count                  := le.ssn_verification.adlperssn_count;
		addrs_per_ssn                    := le.velocity_counters.addrs_per_ssn;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		ssns_per_addr                    := le.velocity_counters.ssns_per_addr;
		phones_per_addr                  := le.velocity_counters.phones_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		phones_per_addr_c6               := le.velocity_counters.phones_per_addr_created_6months;
		adls_per_phone_c6                := le.velocity_counters.adls_per_phone_created_6months;
		vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
		invalid_phones_per_adl           := le.velocity_counters.invalid_phones_per_adl;
		invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
		invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		impulse_count90                  := le.impulse.count90;
		impulse_count180                 := le.impulse.count180;
		impulse_count24                  := le.impulse.count24;
		impulse_annual_income            := le.impulse.annual_income;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_num_purchase60              := le.other_address_info.num_purchase60;
		attr_num_sold36                  := le.other_address_info.num_sold36;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_felonies60                  := le.bjl.criminal_count60;
		attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
		attr_num_unrel_liens180          := le.bjl.liens_unreleased_count180;
		attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
		attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
		attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
		attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
		attr_num_rel_liens30             := le.bjl.liens_released_count30;
		attr_num_rel_liens180            := le.bjl.liens_released_count180;
		attr_num_rel_liens12             := le.bjl.liens_released_count12;
		attr_num_rel_liens24             := le.bjl.liens_released_count24;
		attr_num_rel_liens36             := le.bjl.liens_released_count36;
		attr_bankruptcy_count36          := le.bjl.bk_count36;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_eviction_count30            := le.bjl.eviction_count30;
		attr_eviction_count180           := le.bjl.eviction_count180;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count60            := le.bjl.eviction_count60;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		attr_num_nonderogs90             := le.source_verification.num_nonderogs90;
		attr_num_nonderogs12             := le.source_verification.num_nonderogs12;
		attr_num_nonderogs24             := le.source_verification.num_nonderogs24;
		attr_num_nonderogs36             := le.source_verification.num_nonderogs36;
		attr_num_nonderogs60             := le.source_verification.num_nonderogs60;
		attr_num_proflic_exp12           := le.professional_license.expire_count12;
		attr_num_proflic_exp24           := le.professional_license.expire_count24;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_historical_released_count  := le.bjl.liens_historical_released_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
		liens_rel_cj_ct                  := le.liens.liens_released_civil_judgment.count;
		liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
		liens_unrel_ft_ct                := le.liens.liens_unreleased_federal_tax.count;
		liens_unrel_ft_total_amount      := le.liens.liens_unreleased_federal_tax.total_amount;
		liens_rel_ft_ct                  := le.liens.liens_released_federal_tax.count;
		liens_rel_ft_total_amount        := le.liens.liens_released_federal_tax.total_amount;
		liens_unrel_fc_total_amount      := le.liens.liens_unreleased_foreclosure.total_amount;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_rel_lt_ct                  := le.liens.liens_released_landlord_tenant.count;
		liens_unrel_o_ct                 := le.liens.liens_unreleased_other_lj.count;
		liens_rel_o_ct                   := le.liens.liens_released_other_lj.count;
		liens_rel_o_total_amount         := le.liens.liens_released_other_lj.total_amount;
		liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
		liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
		liens_rel_ot_ct                  := le.liens.liens_released_other_tax.count;
		liens_rel_ot_total_amount        := le.liens.liens_released_other_tax.total_amount;
		liens_unrel_sc_ct                := le.liens.liens_unreleased_small_claims.count;
		liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		ams_college_code                 := le.student.college_code;
		ams_college_type                 := le.student.college_type;
		ams_income_level_code            := le.student.income_level_code;
		ams_file_type                    := le.student.file_type;
		ams_college_tier                 := (string1)(integer1)le.student.college_tier; // NOTE: this model was developed prior to 60298 which introduced blanks; per 2010-10-19 conversation with Eric Graves, a recasting of this field will conform the data to what the model expects
		prof_license_category            := le.professional_license.plcategory;
		input_dob_match_level            := remap(le.dobmatchlevel,'8');
		addr_stability                   := le.mobility_indicator;




		NULL := -999999999;

		eg_segment :=  map((integer)rc_ssnvalflag = 1           => '1. Tax ID',
						   add1_pop and (add2_pop and add3_pop) => '2. 3 Addrs',
																   '3. Other');

		N0_5 := if((liens_unrel_ot_total_amount < 41), -1.12293, -1.04869);

		N0_4 := if(((real)attr_num_rel_liens12 < 0.5), -1.09327, -0.920156);

		N0_3 := map((eg_segment in ['1. Tax ID', '3. Other']) => -1.17337,
					(eg_segment in ['2. 3 Addrs'])            => -1.14859,
																 -1.17337);

		N0_2 := if(((real)liens_unrel_ot_total_amount < 70.5), N0_3, N0_4);

		N0_1 := if(((real)addrs_per_ssn < 6.5), N0_2, N0_5);

		N1_5 := if(((real)attr_num_rel_liens180 < 0.5), 0.0563817, 0.223085);

		N1_4 := if(((real)addrs_15yr < 3.5), -0.0133198, 0.00437574);

		N1_3 := map((eg_segment in ['1. Tax ID', '2. 3 Addrs']) => N1_4,
					(eg_segment in ['3. Other'])                => 0.044613,
																   N1_4);

		N1_2 := if(((real)addrs_15yr < 9.5), N1_3, 0.0328297);

		N1_1 := if(((real)liens_unrel_ot_total_amount < 54.5), N1_2, N1_5);

		N2_5 := if(((real)attr_num_rel_liens180 < 0.5), 0.00780124, 0.0986323);

		N2_4 := if(((real)attr_addrs_last24 < 1.5), N2_5, 0.0386528);

		N2_3 := if(((real)attr_num_rel_liens12 < 0.5), 0.0398537, 0.159803);

		N2_2 := if(((real)liens_unrel_ot_total_amount < 106.5), -0.0129254, N2_3);

		N2_1 := if(((real)addrs_per_adl < 5.5), N2_2, N2_4);

		N3_5 := if(((real)attr_num_rel_liens12 < 0.5), 0.0365714, 0.126145);

		N3_4 := if(((real)impulse_count24 < 2.5), -0.000692212, 0.205202);

		N3_3 := if(((real)dist_a1toa3 < 7.5), N3_4, 0.0191031);

		N3_2 := if((liens_unrel_ot_total_amount < 53), N3_3, N3_5);

		N3_1 := if(((real)addrs_15yr < 3.5), -0.0328551, N3_2);

		N4_5 := if(((real)add1_lres < 1.5), 0.0184992, 0.000839817);

		N4_4 := if(((real)liens_rel_cj_total_amount < 13932.5), N4_5, 0.182528);

		N4_3 := if(((real)liens_rel_ot_total_amount < 2581.5), N4_4, 0.177833);

		N4_2 := if((liens_rel_ot_total_amount < 680), -0.0251109, 0.113693);

		N4_1 := if(((real)addrs_per_adl < 5.5), N4_2, N4_3);

		N5_5 := if(((real)max_lres < 233.5), 0.0585914, 0.279269);

		N5_4 := if(((real)attr_num_unrel_liens24 < 0.5), 0.00908685, N5_5);

		N5_3 := if((impulse_annual_income < 20868), 0.00594183, 0.0465153);

		N5_2 := map((eg_segment in ['1. Tax ID', '3. Other']) => -0.0204623,
					(eg_segment in ['2. 3 Addrs'])            => N5_3,
																 -0.0204623);

		N5_1 := if(((real)liens_unrel_ot_total_amount < 31.5), N5_2, N5_4);

		N6_5 := if(((real)attr_eviction_count60 < 0.5), 0.150587, -0.00366407);

		N6_4 := if(((real)attr_num_rel_liens180 < 0.5), 0.0393423, N6_5);

		N6_3 := if(((real)rc_decsflag < 0.5), 0.007232, 0.317166);

		N6_2 := map((eg_segment in ['1. Tax ID', '3. Other']) => -0.0219282,
					(eg_segment in ['2. 3 Addrs'])            => N6_3,
																 -0.0219282);

		N6_1 := if(((real)liens_unrel_ot_total_amount < 76.5), N6_2, N6_4);

		N7_5 := if((add1_avm_med_fips < 404366), 0.0199892, 0.145046);

		N7_4 := if(((real)max_lres < 25.5), 0.131085, N7_5);

		N7_3 := if(((real)attr_addrs_last12 < 0.5), 0.00220266, 0.0194674);

		N7_2 := if((liens_unrel_ot_total_amount < 53), N7_3, N7_4);

		N7_1 := if(((real)addrs_per_ssn < 4.5), -0.0142986, N7_2);

		N8_5 := if(((real)filing_count < 3.5), -0.00360956, 0.22121);

		N8_4 := if(((real)liens_unrel_ft_ct < 0.5), 0.0111835, 0.170813);

		N8_3 := if(((integer)add1_isbestmatch < 0.5), N8_4, N8_5);

		N8_2 := if((liens_unrel_ot_total_amount < 58), N8_3, 0.0300312);

		N8_1 := if(((real)addrs_per_ssn < 3.5), -0.0185195, N8_2);

		N9_5 := if(((real)liens_unrel_ot_ct < 0.5), 0.387026, 0.0197846);

		N9_4 := if(((real)age < 23.5), 0.135703, N9_5);

		N9_3 := if(((real)addrs_per_ssn < 3.5), N9_4, -0.00814306);

		N9_2 := if(((real)attr_total_number_derogs < 0.5), -0.00514822, 0.0101774);

		N9_1 := map((eg_segment in ['1. Tax ID', '2. 3 Addrs']) => N9_2,
					(eg_segment in ['3. Other'])                => N9_3,
																   N9_2);

		N10_5 := if(((integer)add1_building_area < 1574), 0.0482478, 0.219632);

		N10_4 := if(((real)attr_num_unrel_liens90 < 0.5), 0.0150215, N10_5);

		N10_3 := if(((real)addrs_per_ssn < 8.5), -4.66921e-005, N10_4);

		N10_2 := map((eg_segment in ['1. Tax ID', '3. Other']) => -0.0316118,
					 (eg_segment in ['2. 3 Addrs'])            => -0.0103964,
																  -0.0316118);

		N10_1 := if(((real)addrs_per_ssn < 3.5), N10_2, N10_3);

		N11_5 := if((add1_avm_med_geo11 < 93554), -0.0295796, 0.210822);

		N11_4 := if(((real)criminal_count < 3.5), 0.0105381, N11_5);

		N11_3 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '6', '7', '9', 'U']) => N11_4,
					 (rc_hphonetypeflag in ['5', 'A'])                               => 0.338467,
																						N11_4);

		N11_2 := if(((real)attr_total_number_derogs < 0.5), -0.00410396, N11_3);

		N11_1 := if(((real)addrs_per_ssn < 3.5), -0.026703, N11_2);

		N12_5 := map((prof_license_category in ['0', '1', '2', '4', '5']) => 0.0182384,
					 (prof_license_category in ['3'])                     => 0.413542,
																			 0.0182384);

		N12_4 := if(((real)bk_recent_count < 0.5), -0.000600852, 0.0621571);

		N12_3 := if(((real)addrs_per_ssn_c6 < 0.5), N12_4, N12_5);

		N12_2 := if(((real)dist_a1toa2 < 2566.5), N12_3, 0.208315);

		N12_1 := map((eg_segment in ['1. Tax ID', '3. Other']) => -0.024661,
					 (eg_segment in ['2. 3 Addrs'])            => N12_2,
																  -0.024661);

		N13_5 := if(((real)addrs_5yr < 4.5), 0.00360985, 0.0233552);

		N13_4 := if((liens_rel_o_total_amount < 950), N13_5, 0.178421);

		N13_3 := if(((real)add1_no_of_rooms < 14.5), -0.00494515, 0.25913);

		N13_2 := if(((real)dist_a2toa3 < 1762.5), N13_3, -0.0289075);

		N13_1 := if(((real)addrs_per_ssn < 6.5), N13_2, N13_4);

		N14_5 := if(((real)liens_rel_ft_total_amount < 6612.5), 0.339122, 0.0470561);

		N14_4 := if(((real)felony_count < 2.5), 0.00700438, 0.215339);

		N14_3 := if(((real)age < 40.5), N14_4, -0.0060407);

		N14_2 := if((liens_rel_ft_total_amount < 3049), N14_3, N14_5);

		N14_1 := if((add2_add3_score < 85), N14_2, -0.0239359);

		N15_5 := if(((real)dist_a1toa3 < 448.5), 0.219267, 0.0506077);

		N15_4 := if(((real)addrs_10yr < 10.5), 0.0257324, N15_5);

		N15_3 := if(((real)liens_unrel_cj_total_amount < 533.5), -0.00249398, 0.0115613);

		N15_2 := if(((real)dist_a1toa3 < 177.5), N15_3, N15_4);

		N15_1 := map((eg_segment in ['1. Tax ID', '3. Other']) => -0.0217301,
					 (eg_segment in ['2. 3 Addrs'])            => N15_2,
																  -0.0217301);

		N16_6 := if(((integer)add1_avm_assessed_total_value < 540989), -0.000495421, 0.20764);

		N16_5 := if(((real)max_lres < 198.5), 0.0368414, 0.29107);

		N16_4 := if(((integer)add1_avm_assessed_total_value < 9897), N16_5, N16_6);

		N16_3 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N16_4, 0.00120817);

		N16_2 := if((liens_rel_ft_total_amount < 3027), N16_3, 0.112253);

		N16_1 := if(((real)addrs_per_ssn < 3.5), -0.0212943, N16_2);

		N17_5 := if((add1_avm_med_fips < 241500), 0.0236986, 0.201278);

		N17_4 := if(((real)liens_historical_released_count < 1.5), 0.00554546, N17_5);

		N17_3 := map((ams_college_type in ['R', 'S']) => N17_4,
					 (ams_college_type in ['P'])      => 0.199373,
														 N17_4);

		N17_2 := if(((real)add1_lres < 13.5), N17_3, -0.00595088);

		N17_1 := if(((real)addrs_per_ssn < 3.5), -0.0182661, N17_2);

		N18_5 := if(((real)avg_lres < 26.5), 0.207399, 0.0369933);

		N18_4 := if((impulse_annual_income < 35500), 0.0170452, 0.213255);

		N18_3 := if(((real)dist_a1toa2 < 80.5), -0.000397426, N18_4);

		N18_2 := if(((real)bk_recent_count < 0.5), N18_3, N18_5);

		N18_1 := if(((real)addrs_per_ssn < 3.5), -0.0191965, N18_2);

		N19_5 := if(((real)em_count < 0.5), 0.0417912, 0.159772);

		N19_4 := map((nap_status in ['C']) => 0.00693431,
					 (nap_status in ['D']) => 0.320423,
											  0.00693431);

		N19_3 := if(((real)attr_num_unrel_liens180 < 0.5), N19_4, N19_5);

		N19_2 := if((liens_rel_ot_total_amount < 87), -0.00262789, N19_3);

		N19_1 := if(((real)addrs_per_ssn_c6 < 0.5), N19_2, 0.0144988);

		N20_5 := if(((real)attr_addrs_last36 < 3.5), 0.0233668, 0.073295);

		N20_4 := map((ams_college_tier in ['1', '2', '3', '4', '5']) => 0.0193967,
					 (ams_college_tier in ['0', '6'])                => 0.359695,
																		0.0193967);

		N20_3 := if(((real)liens_unrel_ft_ct < 0.5), N20_4, 0.150834);

		N20_2 := if(((real)invalid_ssns_per_adl < 0.5), -0.00500574, N20_3);

		N20_1 := if(((real)addrs_per_ssn < 13.5), N20_2, N20_5);

		N21_5 := if(((real)addrs_per_ssn < 18.5), 0.0262923, 0.147239);

		N21_4 := if(((real)rc_decsflag < 0.5), 0.00361206, 0.149996);

		N21_3 := if(((real)nap_summary < 7.5), N21_4, -0.00993906);

		N21_2 := if((liens_rel_ft_total_amount < 5892), N21_3, 0.104133);

		N21_1 := if((impulse_annual_income < 21792), N21_2, N21_5);

		N22_5 := if(((real)dist_a2toa3 < 59.5), 0.00463865, 0.0318782);

		N22_4 := if(((real)addrs_per_ssn < 21.5), N22_5, 0.139783);

		N22_3 := if(((real)add1_lres < 0.5), N22_4, -0.00328337);

		N22_2 := if(((real)addrs_per_ssn < 2.5), -0.0193145, N22_3);

		N22_1 := if(((real)adlperssn_count < 7.5), N22_2, 0.155019);

		N23_6 := if((liens_unrel_ot_total_amount < 309), 0.013571, 0.0728195);

		N23_5 := if(((integer)add1_family_owned < 0.5), N23_6, 0.155009);

		N23_4 := if(((real)addr_stability < 1.5), 0.00835237, -0.00599078);

		N23_3 := if(((integer)add1_avm_assessed_total_value < 17831), 0.0242316, -0.00499377);

		N23_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N23_3, N23_4);

		N23_1 := if(((real)addrs_per_adl < 16.5), N23_2, N23_5);

		N24_5 := if(((real)add1_lres < 0.5), 0.0435713, 0.00511414);

		N24_4 := if(((real)attr_num_nonderogs < 2.5), -0.0114954, 0.180985);

		N24_3 := if(((real)addrs_15yr < 10.5), 0.0229021, N24_4);

		N24_2 := if(((real)attr_num_rel_liens12 < 0.5), -0.00296173, N24_3);

		N24_1 := if(((real)criminal_count < 0.5), N24_2, N24_5);

		N25_5 := if((adls_per_addr < 6), 0.304934, 0.0366566);

		N25_4 := if(((real)add1_avm_med_geo12 < 71685.5), 0.175845, -0.00513861);

		N25_3 := if(((real)liens_rel_ot_total_amount < 52.5), -0.00184138, 0.0230422);

		N25_2 := if(((real)liens_rel_ft_ct < 0.5), N25_3, N25_4);

		N25_1 := if(((integer)addrs_prison_history < 0.5), N25_2, N25_5);

		N26_5 := if(((real)attr_num_unrel_liens24 < 0.5), -0.00687459, 0.0922308);

		N26_4 := if(((real)nap_summary < 7.5), 0.00665489, -0.00777237);

		N26_3 := if((liens_unrel_ft_total_amount < 6741), N26_4, 0.118624);

		N26_2 := if((liens_rel_ot_total_amount < 1178), N26_3, N26_5);

		N26_1 := if(((real)pr_count < 0.5), N26_2, -0.0109027);

		N27_5 := if(((real)adlperssn_count < 1.5), 0.0282905, 0.255535);

		N27_4 := if(((real)em_only_count < 0.5), N27_5, -0.0233064);

		N27_3 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'F', 'H', 'J', 'K']) => N27_4,
					 (ams_income_level_code in ['E', 'G', 'I'])                          => 0.294628,
																							N27_4);

		N27_2 := if(((real)vo_addrs_per_adl < 3.5), 0.0113859, N27_3);

		N27_1 := if(((real)addrs_per_ssn_c6 < 0.5), -0.00256434, N27_2);

		N28_6 := if(((real)liens_unrel_ot_total_amount < 1080.5), 0.165219, 0.0384979);

		N28_5 := if(((real)avg_lres < 62.5), -0.0240293, 0.0761199);

		N28_4 := if(((real)attr_num_unrel_liens180 < 0.5), N28_5, N28_6);

		N28_3 := if(((real)bk_recent_count < 0.5), -0.0029577, 0.0873925);

		N28_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N28_3, -0.00161175);

		N28_1 := if(((real)liens_unrel_ot_ct < 1.5), N28_2, N28_4);

		N29_6 := if(((real)add1_avm_assessed_total_value < 9222.5), 0.0564019, 0.000121209);

		N29_5 := if(((real)liens_unrel_ft_ct < 0.5), N29_6, 0.15555);

		N29_4 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N29_5, 0.00659445);

		N29_3 := if(((real)attr_num_nonderogs36 < 1.5), N29_4, -0.00428926);

		N29_2 := map((ams_college_tier in ['2', '3', '4', '5', '6']) => N29_3,
					 (ams_college_tier in ['0', '1'])                => 0.138105,
																		N29_3);

		N29_1 := if(((real)liens_unrel_ot_ct < 1.5), N29_2, 0.0339723);

		N30_5 := if((liens_rel_cj_total_amount < 11640), 0.0184561, 0.124424);

		N30_4 := if(((real)attr_addrs_last36 < 1.5), -0.0203571, 0.186464);

		N30_3 := if(((integer)addrs_prison_history < 0.5), -0.00174873, N30_4);

		N30_2 := if(((real)did2_liens_recent_unrel_count < 0.5), N30_3, 0.185655);

		N30_1 := if(((real)attr_num_unrel_liens36 < 2.5), N30_2, N30_5);

		N31_5 := if((liens_unrel_ot_total_amount < 2191), 0.0124686, 0.103379);

		N31_4 := map((ams_college_tier in ['0', '1', '2', '4', '5', '6']) => N31_5,
					 (ams_college_tier in ['3'])                          => 0.266692,
																			 N31_5);

		N31_3 := if(((real)max_lres < 190.5), 0.0182295, 0.18233);

		N31_2 := map((ams_income_level_code in ['A', 'C', 'D', 'E', 'G', 'I', 'J', 'K']) => -0.00296418,
					 (ams_income_level_code in ['B', 'F', 'H'])                          => N31_3,
																							-0.00296418);

		N31_1 := if(((real)addrs_per_ssn_c6 < 0.5), N31_2, N31_4);

		N32_5 := if((add1_avm_med_fips < 114040), 0.0684768, -0.000668838);

		N32_4 := if(((real)rc_hphonevalflag < 0.5), 0.11124, -0.00965351);

		N32_3 := if((add1_avm_med_fips < 109889), N32_4, N32_5);

		N32_2 := if(((real)liens_rel_ot_total_amount < 3086.5), N32_3, -0.0695293);

		N32_1 := if(((real)did2_liens_recent_unrel_count < 0.5), N32_2, 0.148787);

		N33_5 := if(((real)add1_avm_med_geo11 < 66250.5), -0.056241, 0.139813);

		N33_4 := if(((real)liens_unrel_cj_total_amount < 18828.5), -0.0110822, N33_5);

		N33_3 := if((add1_avm_med_geo11 < 141467), 0.0318827, 0.156159);

		N33_2 := map((ams_college_tier in ['1', '2', '4', '6']) => 0.0014299,
					 (ams_college_tier in ['0', '3', '5'])      => N33_3,
																   0.0014299);

		N33_1 := if(((real)attr_num_nonderogs90 < 1.5), N33_2, N33_4);

		N34_5 := if(((real)addr_stability < 2.5), 0.229665, 0.015229);

		N34_4 := map((ams_college_tier in ['2'])                          => 0.0203776,
					 (ams_college_tier in ['0', '1', '3', '4', '5', '6']) => N34_5,
																			 0.0203776);

		N34_3 := if(((real)addrs_per_ssn < 16.5), 0.0224212, 0.146133);

		N34_2 := if(((real)invalid_ssns_per_adl < 0.5), 0.00104743, N34_3);

		N34_1 := if(((real)criminal_count < 0.5), N34_2, N34_4);

		N35_5 := if(((real)adls_per_addr < 8.5), 0.00836958, 0.242192);

		N35_4 := if((liens_unrel_cj_total_amount < 19965), 0.010987, N35_5);

		N35_3 := map((rc_hphonetypeflag in ['0', '1', '3', '5', '6', '7', '9', 'A', 'U']) => N35_4,
					 (rc_hphonetypeflag in ['2'])                                         => 0.57869,
																							 N35_4);

		N35_2 := map((lname_eda_sourced_type in ['AP', 'P']) => 0.000124139,
					 (lname_eda_sourced_type in ['A'])       => N35_3,
																0.000124139);

		N35_1 := if(((real)rc_pwssnvalflag < 0.5), N35_2, -0.0168483);

		N36_5 := map((rc_hphonetypeflag in ['3'])                                         => -0.0677719,
					 (rc_hphonetypeflag in ['0', '1', '2', '5', '6', '7', '9', 'A', 'U']) => 0.145133,
																							 0.145133);

		N36_4 := if((liens_rel_ft_total_amount < 7452), N36_5, -0.0494469);

		N36_3 := if(((real)attr_addrs_last12 < 1.5), 0.00253511, 0.0381411);

		N36_2 := if(((real)avg_lres < 40.5), -0.00564827, N36_3);

		N36_1 := if((liens_unrel_ft_total_amount < 1069), N36_2, N36_4);

		N37_6 := if(((real)attr_eviction_count60 < 0.5), 0.201383, -0.0123623);

		N37_5 := if(((real)liens_rel_ot_ct < 1.5), -6.56758e-006, -0.0549379);

		N37_4 := if(((integer)add1_avm_assessed_total_value < 1741), 0.15904, -0.00315162);

		N37_3 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N37_4, N37_5);

		N37_2 := if(((real)attr_num_rel_liens30 < 0.5), N37_3, N37_6);

		N37_1 := if((liens_rel_ot_total_amount < 3629), N37_2, 0.0904519);

		N38_5 := if(((real)attr_bankruptcy_count36 < 1.5), -0.0185722, 0.14077);

		N38_4 := if(((real)liens_unrel_cj_ct < 2.5), 0.0116195, N38_5);

		N38_3 := if(((real)combo_lnamecount < 7.5), 0.00395671, 0.228854);

		N38_2 := if(((integer)add1_isbestmatch < 0.5), N38_3, -0.0119665);

		N38_1 := if(((real)ssns_per_adl < 1.5), N38_2, N38_4);

		N39_5 := if((add1_avm_med_geo12 < 147118), 0.223356, -0.0555977);

		N39_4 := if(((real)add1_avm_automated_valuation < 24736.5), 0.0262464, N39_5);

		N39_3 := if(((real)addrs_15yr < 5.5), N39_4, 0.00288822);

		N39_2 := map((ams_income_level_code in ['A', 'B', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K']) => N39_3,
					 (ams_income_level_code in ['C'])                                              => 0.168625,
																									  N39_3);

		N39_1 := if((impulse_annual_income < 21516), -0.00266005, N39_2);

		N40_5 := if((impulse_annual_income < 27300), 0.114113, -0.0106069);

		N40_4 := if(((real)impulse_count90 < 0.5), N40_5, -0.0400572);

		N40_3 := if((add1_avm_tax_assessed_valuation < 84996), N40_4, 0.144457);

		N40_2 := if((impulse_annual_income < 19260), -0.00905517, N40_3);

		N40_1 := if(((real)dist_a1toa2 < 1.5), N40_2, 0.00446664);

		N41_5 := if(((real)attr_felonies60 < 0.5), -0.0310736, 0.124114);

		N41_4 := if(((real)addrs_per_ssn < 16.5), 0.0228922, 0.106746);

		N41_3 := if(((real)eq_count < 33.5), N41_4, N41_5);

		N41_2 := if(((real)invalid_addrs_per_adl < 3.5), -0.000634395, N41_3);

		N41_1 := if(((real)liens_unrel_o_ct < 0.5), N41_2, 0.221255);

		N42_5 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K']) => -0.0238546,
					 (ams_income_level_code in ['J'])                                              => 0.512332,
																									  -0.0238546);

		N42_4 := if(((real)attr_num_unrel_liens12 < 0.5), 0.00347456, 0.0367201);

		N42_3 := if(((real)liens_unrel_ot_total_amount < 54.5), -0.00123107, N42_4);

		N42_2 := if(((integer)add1_applicant_owned < 0.5), N42_3, N42_5);

		N42_1 := map((ams_college_tier in ['0', '3', '4', '5', '6']) => N42_2,
					 (ams_college_tier in ['1', '2'])                => 0.195946,
																		N42_2);

		N43_5 := if(((real)eq_count < 22.5), -0.00932569, 0.0754375);

		N43_4 := if(((real)attr_eviction_count60 < 2.5), N43_5, 0.123587);

		N43_3 := if(((real)impulse_count < 1.5), 0.00228733, N43_4);

		N43_2 := if(((real)bk_recent_count < 1.5), N43_3, 0.098037);

		N43_1 := if((add1_assessed_amount < 131753), N43_2, -0.0173274);

		N44_5 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', -0.00062661, 0.299652);

		N44_4 := map((rc_hphonetypeflag in ['0', '1', '3', '6', '7', '9', 'A', 'U']) => 0.00713404,
					 (rc_hphonetypeflag in ['2', '5'])                               => 0.202885,
																						0.00713404);

		N44_3 := if(((real)impulse_count24 < 2.5), N44_4, 0.0973974);

		N44_2 := if(((real)ssns_per_addr < 46.5), N44_3, N44_5);

		N44_1 := if(((real)ssns_per_adl < 1.5), -0.00385143, N44_2);

		N45_5 := if(trim(ADD1_AVM_SALES_PRICE) != '', 0.00763309, 0.222109);

		N45_4 := if(((real)max_lres < 84.5), N45_5, -0.00438071);

		N45_3 := if(((real)attr_eviction_count < 4.5), 0.000958678, -0.0190685);

		N45_2 := if(((real)eq_count < 62.5), N45_3, N45_4);

		N45_1 := map((rc_zipclass in ['M', 'P']) => N45_2,
					 (rc_zipclass in ['U'])      => 0.284237,
													N45_2);

		N46_5 := if((add1_avm_med_geo11 < 33000), 0.323894, -0.0551887);

		N46_4 := if(((real)add1_lres < 238.5), -0.00861584, N46_5);

		N46_3 := map((ams_income_level_code in ['A', 'C', 'D', 'E', 'H', 'I', 'J', 'K']) => 0.00108595,
					 (ams_income_level_code in ['B', 'F', 'G'])                          => 0.034522,
																							0.00108595);

		N46_2 := if((liens_rel_ft_total_amount < 2442), N46_3, 0.0674528);

		N46_1 := if(((real)combo_dobcount < 3.5), N46_2, N46_4);

		N47_6 := if(((real)infutor_nap < 3.5), 0.143263, 0.015855);

		N47_5 := if(((real)addrs_15yr < 14.5), -0.00155225, 0.0506461);

		N47_4 := if(((real)adls_per_phone < 2.5), N47_5, 0.13466);

		N47_3 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N47_4, -0.00174949);

		N47_2 := if((liens_unrel_ft_total_amount < 10364), N47_3, 0.129019);

		N47_1 := if(((real)eq_count < 64.5), N47_2, N47_6);

		N48_5 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', 0.294146, -0.0153622);

		N48_4 := if(((real)dist_a1toa3 < 52.5), 0.00461702, 0.0224346);

		N48_3 := if((property_owned_assessed_total < 393205), N48_4, N48_5);

		N48_2 := if(((real)gong_did_addr_ct < 1.5), N48_3, -0.00300696);

		N48_1 := if((add2_add3_score < 85), N48_2, -0.0146026);

		N49_5 := if((add1_assessed_amount < 257376), 0.0165191, 0.145665);

		N49_4 := if(((real)gong_did_phone_ct < 4.5), N49_5, -0.0199789);

		N49_3 := if(((real)addrs_per_ssn < 11.5), -0.00115004, N49_4);

		N49_2 := if(((real)liens_unrel_sc_ct < 6.5), N49_3, 0.114632);

		N49_1 := if((add1_avm_med_geo12 < 237009), N49_2, -0.0163154);

		N50_6 := if(((real)addrs_5yr < 5.5), -0.0404155, 0.0790057);

		N50_5 := if(((real)add1_lres < 12.5), N50_6, 0.148594);

		N50_4 := if(((real)attr_num_unrel_liens24 < 2.5), -0.0137601, N50_5);

		N50_3 := if(((integer)add1_avm_assessed_total_value < 13630), 0.0460345, -0.0235341);

		N50_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N50_3, N50_4);

		N50_1 := if(((real)attr_num_nonderogs < 3.5), 0.00272129, N50_2);

		N51_6 := if(((real)max_lres < 96.5), 0.0255901, -0.0205062);

		N51_5 := map((ams_income_level_code in ['A', 'B', 'C', 'E', 'F', 'G', 'H', 'I', 'K']) => -0.017034,
					 (ams_income_level_code in ['D', 'J'])                                    => 0.199048,
																								 -0.017034);

		N51_4 := if(trim(AMS_COLLEGE_CODE) != '', N51_5, 0.0157437);

		N51_3 := if(((real)attr_num_purchase60 < 0.5), -0.00156948, -0.0250667);

		N51_2 := if(((real)criminal_count < 0.5), N51_3, N51_4);

		N51_1 := if(((real)addrs_10yr < 9.5), N51_2, N51_6);

		N52_6 := if(((real)add1_avm_assessed_total_value < 19732.5), 0.0499746, 0.341171);

		N52_5 := if(((real)avg_lres < 135.5), 0.0125843, N52_6);

		N52_4 := if(((real)attr_num_proflic_exp12 < 0.5), N52_5, 0.171264);

		N52_3 := if(((real)add1_avm_assessed_total_value < 24828.5), N52_4, -0.00336798);

		N52_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N52_3, 0.00200214);

		N52_1 := if(((real)rc_pwssnvalflag < 0.5), N52_2, -0.0157685);

		N53_5 := if(((real)add1_unit_count < 31.5), -0.0581865, 0.0432586);

		N53_4 := if(((real)impulse_count180 < 2.5), 0.00306674, 0.0893032);

		N53_3 := if(((real)attr_num_unrel_liens36 < 12.5), N53_4, 0.167136);

		N53_2 := if(((real)rc_disthphoneaddr < 14.5), -0.0105387, N53_3);

		N53_1 := if(((real)liens_rel_ot_total_amount < 1762.5), N53_2, N53_5);

		N54_5 := if(((real)gong_did_addr_ct < 2.5), 0.241901, -0.014707);

		N54_4 := if((phones_per_addr < 32), -0.0132442, N54_5);

		N54_3 := if(((real)eq_count < 63.5), 0.000661282, 0.0797735);

		N54_2 := if(((real)attr_num_nonderogs < 3.5), N54_3, N54_4);

		N54_1 := if((liens_rel_ot_total_amount < 2693), N54_2, -0.0739999);

		N55_5 := if(((real)adls_per_addr < 12.5), 0.0317301, 0.201124);

		N55_4 := if(((real)vo_addrs_per_adl < 1.5), -0.0226254, N55_5);

		N55_3 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'H']) => N55_4,
					 (ams_income_level_code in ['G', 'I', 'J', 'K'])                => 0.26726,
																					   N55_4);

		N55_2 := if(((real)combo_fnamecount < 6.5), -0.00484433, N55_3);

		N55_1 := if(((real)ssns_per_adl < 1.5), N55_2, 0.0064);

		N56_5 := map((rc_dwelltype in ['A', 'R', 'S']) => 0.0114484,
					 (rc_dwelltype in ['E'])           => 0.40163,
														  0.0114484);

		N56_4 := if(((real)attr_num_nonderogs < 1.5), 0.1792, N56_5);

		N56_3 := map((ams_income_level_code in ['A', 'B', 'C', 'E', 'F', 'G', 'I', 'J']) => -0.0190285,
					 (ams_income_level_code in ['D', 'H', 'K'])                          => 0.00897449,
																							0.00897449);

		N56_2 := if(((real)addrs_per_ssn < 7.5), -0.00377368, N56_3);

		N56_1 := if(((real)liens_rel_o_ct < 0.5), N56_2, N56_4);

		N57_5 := if(((real)dist_a2toa3 < 4.5), 0.125106, 0.00483135);

		N57_4 := map((lname_eda_sourced_type in ['A', 'AP']) => N57_5,
					 (lname_eda_sourced_type in ['P'])       => 0.603981,
																N57_5);

		N57_3 := if(((integer)add1_family_sold < 0.5), 0.00413746, N57_4);

		N57_2 := if(((real)addrs_per_adl < 25.5), N57_3, -0.0540782);

		N57_1 := if(((real)attr_num_nonderogs90 < 1.5), N57_2, -0.00767199);

		N58_5 := if((add1_add2_score < 15), -0.00686512, 0.155953);

		N58_4 := if((add1_avm_med_geo12 < 255124), -0.000139753, 0.104234);

		N58_3 := if((add1_avm_med_geo12 < 259817), N58_4, -0.0163472);

		N58_2 := if(((integer)addrs_prison_history < 0.5), N58_3, N58_5);

		N58_1 := map((ams_college_tier in ['3', '4', '5', '6']) => N58_2,
					 (ams_college_tier in ['0', '1', '2'])      => 0.122921,
																   N58_2);

		N59_5 := if((add1_avm_med_geo12 < 477980), -0.00191917, 0.145679);

		N59_4 := if(((real)attr_addrs_last12 < 0.5), 0.0389734, 0.148424);

		N59_3 := map((ams_income_level_code in ['A', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K']) => 0.0128449,
					 (ams_income_level_code in ['B', 'J'])                                    => N59_4,
																								 0.0128449);

		N59_2 := if(((real)attr_num_nonderogs60 < 1.5), N59_3, N59_5);

		N59_1 := if(((real)add1_lres < 0.5), N59_2, -0.00419557);

		N60_5 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', -0.0627336, 0.161906);

		N60_4 := if((liens_unrel_ft_total_amount < 8931), 0.000934752, 0.0705972);

		N60_3 := if(((real)liens_unrel_o_ct < 0.5), N60_4, 0.124252);

		N60_2 := if(((real)adlperssn_count < 6.5), N60_3, N60_5);

		N60_1 := if(((real)vo_count < 4.5), N60_2, -0.0399806);

		N61_5 := map((ams_income_level_code in ['B', 'C', 'G'])                          => 0.11258,
					 (ams_income_level_code in ['A', 'D', 'E', 'F', 'H', 'I', 'J', 'K']) => 0.361894,
																							0.11258);

		N61_4 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'F', 'H', 'I', 'J', 'K']) => -0.0403333,
					 (ams_income_level_code in ['E', 'G'])                                    => 0.313171,
																								 -0.0403333);

		N61_3 := if(((real)addrs_5yr < 1.5), N61_4, N61_5);

		N61_2 := if(((real)invalid_phones_per_adl < 1.5), -0.000257883, 0.126336);

		N61_1 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '5', '6', '9', 'A']) => N61_2,
					 (rc_hphonetypeflag in ['7', 'U'])                               => N61_3,
																						N61_2);

		N62_5 := if((add1_avm_med_fips < 140057), 0.0157885, -0.00277834);

		N62_4 := if(((real)phones_per_adl < 3.5), N62_5, 0.218768);

		N62_3 := if((add1_avm_med_fips < 109412), -0.0071205, N62_4);

		N62_2 := if(((real)liens_unrel_ft_ct < 0.5), N62_3, 0.0756335);

		N62_1 := if((liens_rel_ft_total_amount < 4281), N62_2, -0.0590475);

		N63_5 := map((rc_dwelltype in ['A', 'R', 'S']) => -0.0269859,
					 (rc_dwelltype in ['E'])           => 0.494482,
														  -0.0269859);

		N63_4 := if((add1_avm_med_fips < 127297), 0.244531, N63_5);

		N63_3 := if(((real)add1_no_of_partial_baths < 1.5), 0.00134487, 0.107607);

		N63_2 := map((disposition in ['Discharge NA', 'Discharged']) => -0.0115933,
					 (disposition in ['Dismissed'])                  => N63_3,
																		N63_3);

		N63_1 := map((prof_license_category in ['0', '1', '2', '4', '5']) => N63_2,
					 (prof_license_category in ['3'])                     => N63_4,
																			 N63_2);

		N64_5 := if(((real)eq_count < 46.5), 0.00702807, -0.033661);

		N64_4 := if(((real)ssns_per_adl < 2.5), 0.0094793, 0.135369);

		N64_3 := if(((real)attr_num_rel_liens36 < 0.5), N64_4, 0.156606);

		N64_2 := if((add1_mortgage_amount < 194163), -0.00767237, N64_3);

		N64_1 := if(((real)dist_a1toa2 < 4.5), N64_2, N64_5);

		N65_5 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'G', 'H', 'J', 'K']) => -0.0149338,
					 (ams_income_level_code in ['F', 'I'])                                    => 0.0774059,
																								 -0.0149338);

		N65_4 := if(((real)dist_a2toa3 < 219.5), 0.0147195, 0.162264);

		N65_3 := if(((real)attr_eviction_count12 < 0.5), N65_4, 0.17443);

		N65_2 := if(((real)combo_lnamecount < 6.5), 0.00272715, N65_3);

		N65_1 := if(((real)eq_count < 26.5), N65_2, N65_5);

		N66_6 := if(((real)adls_per_addr < 12.5), 0.0277133, 0.278443);

		N66_5 := map((ams_income_level_code in ['B', 'I', 'K'])                          => -0.0596225,
					 (ams_income_level_code in ['A', 'C', 'D', 'E', 'F', 'G', 'H', 'J']) => N66_6,
																							N66_6);

		N66_4 := if((add1_avm_tax_assessed_valuation < 10968), 0.108112, -0.0202775);

		N66_3 := if(((real)liens_unrel_cj_total_amount < 3915.5), N66_4, N66_5);

		N66_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N66_3, -0.0124982);

		N66_1 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'H', 'I', 'K']) => N66_2,
					 (ams_income_level_code in ['F', 'G', 'J'])                          => 0.0028348,
																							0.0028348);

		N67_5 := map((rc_hphonetypeflag in ['0', '1', '3', '5', '6', '7', '9', 'A', 'U']) => -0.0117466,
					 (rc_hphonetypeflag in ['2'])                                         => 0.270708,
																							 -0.0117466);

		N67_4 := if(((real)filing_count < 2.5), 0.013013, 0.118648);

		N67_3 := if(((real)addrs_15yr < 8.5), 0.00127708, N67_4);

		N67_2 := if(((real)gong_did_last_ct < 1.5), N67_3, N67_5);

		N67_1 := if(((real)age < 45.5), N67_2, -0.0110385);

		N68_5 := if(((real)combo_fnamecount < 3.5), 0.00268182, 0.070986);

		N68_4 := if((impulse_annual_income < 29646), 0.163193, N68_5);

		N68_3 := map((ams_income_level_code in ['C', 'D', 'H', 'I', 'J'])      => -0.0507255,
					 (ams_income_level_code in ['A', 'B', 'E', 'F', 'G', 'K']) => N68_4,
																				  N68_4);

		N68_2 := if((impulse_annual_income < 28548), 0.000221401, N68_3);

		N68_1 := if(((real)rc_decsflag < 0.5), N68_2, 0.1067);

		N69_5 := if(((real)dist_a2toa3 < 229.5), 0.0372152, 0.151088);

		N69_4 := if(((real)avg_lres < 61.5), 0.00639338, N69_5);

		N69_3 := if(((real)liens_unrel_ot_ct < 0.5), N69_4, 0.0936957);

		N69_2 := if(((real)addrs_15yr < 7.5), 0.00235128, N69_3);

		N69_1 := if(((real)combo_fnamecount < 2.5), N69_2, -0.00479084);

		N70_5 := map((nap_type in ['A', 'P']) => -0.0600506,
					 (nap_type in [''])       => 0.145426,
												 0.145426);

		N70_4 := if(((real)max_lres < 35.5), 0.230481, 0.0215369);

		N70_3 := if(((real)attr_eviction_count < 4.5), -0.000188471, -0.0192876);

		N70_2 := if((add1_mortgage_amount < 450625), N70_3, N70_4);

		N70_1 := if((liens_rel_cj_total_amount < 12381), N70_2, N70_5);

		N71_5 := if(((real)combo_lnamecount < 4.5), -0.00173269, 0.110998);

		N71_4 := if(((real)attr_addrs_last24 < 1.5), N71_5, 0.12031);

		N71_3 := if(((real)addrs_10yr < 14.5), -0.00135527, -0.0566529);

		N71_2 := if((property_owned_purchase_total < 146450), N71_3, -0.039234);

		N71_1 := map((rc_hphonetypeflag in ['0', '1', '3', '5', '6', '9', 'A']) => N71_2,
					 (rc_hphonetypeflag in ['2', '7', 'U'])                     => N71_4,
																				   N71_2);

		N72_5 := if(((real)add1_unit_count < 70.5), 0.112479, -0.0508712);

		N72_4 := if(((real)ssns_per_addr < 2.5), N72_5, -0.0526996);

		N72_3 := if(((real)liens_unrel_cj_ct < 0.5), 0.0305982, 0.00321856);

		N72_2 := if(((real)attr_num_unrel_liens24 < 0.5), -0.000855545, N72_3);

		N72_1 := if(((real)addrs_per_adl < 21.5), N72_2, N72_4);

		N73_5 := if(((real)liens_unrel_cj_total_amount < 3166.5), 0.135886, 0.0226961);

		N73_4 := map((input_dob_match_level in ['1', '2', '3', '4', '5', '6', '7', '8']) => -0.0031837,
					 (input_dob_match_level in ['0'])                                    => 0.129801,
																							-0.0031837);

		N73_3 := if(((real)em_count < 1.5), N73_4, N73_5);

		N73_2 := if((property_owned_assessed_total < 149750), 1.31526e-005, -0.0413408);

		N73_1 := if(((real)liens_rel_ot_total_amount < 500.5), N73_2, N73_3);

		N74_5 := if(((real)liens_unrel_cj_ct < 6.5), 0.183958, -0.000323621);

		N74_4 := if((add1_avm_med_geo11 < 310549), -0.0250744, N74_5);

		N74_3 := if(((real)attr_eviction_count60 < 3.5), -0.00116042, N74_4);

		N74_2 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '5', '6', '9', 'A', 'U']) => N74_3,
					 (rc_hphonetypeflag in ['7'])                                         => 0.188379,
																							 N74_3);

		N74_1 := if(((real)attr_num_rel_liens30 < 0.5), N74_2, 0.0668162);

		N75_5 := if(((real)liens_unrel_lt_ct < 0.5), 0.0296351, 0.173173);

		N75_4 := if(((real)felony_count < 0.5), -0.0109128, N75_5);

		N75_3 := if(((real)addrs_per_adl < 12.5), 0.0110371, 0.0498997);

		N75_2 := if((add1_avm_med_fips < 54023), N75_3, 0.000372134);

		N75_1 := if(((real)gong_did_addr_ct < 2.5), N75_2, N75_4);

		N76_5 := if((add1_add3_score < 15), -0.00339356, 0.144026);

		N76_4 := if(((real)attr_eviction_count12 < 0.5), 0.0100737, 0.077041);

		N76_3 := if((liens_unrel_cj_total_amount < 8221), -0.00211479, N76_4);

		N76_2 := if(((real)eq_count < 62.5), N76_3, N76_5);

		N76_1 := map((disposition in ['Discharge NA', 'Discharged']) => -0.017273,
					 (disposition in ['Dismissed'])                  => N76_2,
																		N76_2);

		N77_7 := if(((real)avg_lres < 32.5), -0.0565112, 0.209799);

		N77_6 := map((rc_addrvalflag in ['V'])      => 0.0189834,
					 (rc_addrvalflag in ['M', 'N']) => N77_7,
													   N77_7);

		N77_5 := map((ams_college_tier in ['0', '1', '2', '4', '5']) => N77_6,
					 (ams_college_tier in ['3', '6'])                => 0.224157,
																		N77_6);

		N77_4 := if((dist_a2toa3 < 163), 0.001655, N77_5);

		N77_3 := if(((real)dist_a2toa3 < 700.5), N77_4, -0.0148158);

		N77_2 := if(((integer)add1_avm_assessed_total_value < 597895), -0.00084181, 0.161295);

		N77_1 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N77_2, N77_3);

		N78_5 := if(((real)adls_per_addr < 15.5), 0.0218462, -0.0457972);

		N78_4 := map((add1_financing_type in ['ADJ', 'OTH']) => N78_5,
					 (add1_financing_type in ['CNV'])        => 0.440233,
																N78_5);

		N78_3 := if(((real)dist_a2toa3 < 16.5), N78_4, 0.0550131);

		N78_2 := if(((real)impulse_count180 < 0.5), -0.000927112, N78_3);

		N78_1 := if(((real)liens_unrel_ot_ct < 3.5), N78_2, 0.0883007);

		N79_5 := if(((real)adls_per_addr < 11.5), 0.111967, 0.00652916);

		N79_4 := if(((real)addrs_15yr < 9.5), -0.0417385, N79_5);

		N79_3 := if((add2_add3_score < 15), N79_4, -0.00474303);

		N79_2 := if(((integer)add1_applicant_owned < 0.5), N79_3, 0.137644);

		N79_1 := if(((real)addrs_per_ssn < 15.5), -0.000955007, N79_2);

		N80_5 := if(((real)liens_unrel_sc_total_amount < 2042.5), 0.0193124, 0.170484);

		N80_4 := if(((real)phones_per_addr < 6.5), 0.041123, 0.231839);

		N80_3 := if((add1_avm_med_fips < 143959), N80_4, 0.00385606);

		N80_2 := if((add1_purchase_amount < 96954), -0.00247453, N80_3);

		N80_1 := map((ams_college_tier in ['0', '2', '4'])      => N80_2,
					 (ams_college_tier in ['1', '3', '5', '6']) => N80_5,
																   N80_2);

		N81_6 := map((ams_college_tier in ['0', '1', '2', '5']) => -0.0192126,
					 (ams_college_tier in ['3', '4', '6'])      => 0.108914,
																   -0.0192126);

		N81_5 := if((add1_avm_price_index_valuation < 109494), 0.0283735, 0.28341);

		N81_4 := if(((integer)add1_avm_assessed_total_value < 10205), N81_5, -0.0014033);

		N81_3 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N81_4, 0.00755256);

		N81_2 := if(((real)rc_phoneaddr_addrcount < 0.5), -0.00209792, N81_3);

		N81_1 := if((add1_mortgage_amount < 115250), N81_2, N81_6);

		N82_5 := if(((real)attr_num_rel_liens12 < 0.5), 0.00262271, 0.0317974);

		N82_4 := if(((real)attr_num_unrel_liens12 < 4.5), -0.00877679, 0.111866);

		N82_3 := if(((real)avg_lres < 29.5), N82_4, N82_5);

		N82_2 := if(((integer)rc_lnamessnmatch < 0.5), -0.0137112, N82_3);

		N82_1 := if(((real)liens_unrel_ot_ct < 3.5), N82_2, 0.0864122);

		N83_5 := if(((real)em_count < 6.5), -0.0222407, 0.119816);

		N83_4 := if((add1_avm_med_fips < 437236), 0.000967411, -0.0285075);

		N83_3 := if(((real)attr_num_sold36 < 1.5), N83_4, 0.113126);

		N83_2 := if(((real)liens_rel_lt_ct < 1.5), N83_3, 0.130873);

		N83_1 := if(((real)eq_count < 36.5), N83_2, N83_5);

		N84_5 := if(((real)liens_historical_unreleased_ct < 0.5), 0.0391385, 0.00253885);

		N84_4 := if(((real)addr_stability < 2.5), 0.0503228, 0.206564);

		N84_3 := if(((real)liens_unrel_ot_total_amount < 103.5), N84_4, N84_5);

		N84_2 := if((liens_unrel_ot_total_amount < 40), 0.000665451, N84_3);

		N84_1 := if((liens_rel_ft_total_amount < 5604), N84_2, -0.0571342);

		N85_5 := if(((real)rc_ssncount < 2.5), -0.00101891, 0.0231798);

		N85_4 := if(((real)addrs_per_ssn < 3.5), -0.00484796, 0.27312);

		N85_3 := if(((real)avg_lres < 15.5), N85_4, -0.0563595);

		N85_2 := map((rc_hphonetypeflag in ['0', '1'])                               => N85_3,
					 (rc_hphonetypeflag in ['2', '3', '5', '6', '7', '9', 'A', 'U']) => 0.543504,
																						0.543504);

		N85_1 := if(((real)combo_fnamescore < 34.5), N85_2, N85_5);

		N86_5 := map((rc_addrvalflag in ['M', 'V']) => -0.019256,
					 (rc_addrvalflag in ['N'])      => 0.0980886,
													   -0.019256);

		N86_4 := if(((real)liens_unrel_sc_total_amount < 1575.5), -0.0484422, 0.048258);

		N86_3 := if(((real)addrs_per_adl < 20.5), 0.000520135, N86_4);

		N86_2 := if(((real)addrs_per_adl < 28.5), N86_3, 0.106608);

		N86_1 := if(((real)liens_historical_unreleased_ct < 3.5), N86_2, N86_5);

		N87_5 := if((add1_mortgage_amount < 427250), 0.000584296, 0.0543783);

		N87_4 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']) => -0.0247553,
					 (ams_income_level_code in ['K'])                                              => 0.737689,
																									  -0.0247553);

		N87_3 := if(((real)addrs_per_ssn < 1.5), N87_4, N87_5);

		N87_2 := if(((real)liens_unrel_sc_ct < 3.5), N87_3, -0.0410091);

		N87_1 := if(((real)rc_phonevalflag < 1.5), -0.0263333, N87_2);

		N88_6 := if(((real)dist_a1toa2 < 8.5), 0.0937487, 0.318037);

		N88_5 := if(((real)eq_count < 11.5), N88_6, 0.0201269);

		N88_4 := if(((real)liens_unrel_cj_total_amount < 796.5), 0.00253619, N88_5);

		N88_3 := if((add1_avm_med_geo11 < 71586), 0.101464, -0.0135815);

		N88_2 := if(trim(ADD1_AVM_SALES_PRICE) != '', N88_3, N88_4);

		N88_1 := if(((real)invalid_ssns_per_adl < 0.5), 0.000791783, N88_2);

		N89_5 := map((input_dob_match_level in ['0', '1', '2', '4', '6', '7', '8']) => -0.0381026,
					 (input_dob_match_level in ['3', '5'])                          => 0.392095,
																					   -0.0381026);

		N89_4 := if(((real)criminal_count < 1.5), 0.0103986, 0.070909);

		N89_3 := if(((real)eq_count < 65.5), N89_4, -0.0648826);

		N89_2 := if(((real)addrs_10yr < 7.5), -0.00111463, N89_3);

		N89_1 := if(((real)combo_fnamecount < 6.5), N89_2, N89_5);

		N90_5 := map((nap_type in ['P']) => -0.0892857,
					 (nap_type in ['A']) => 0.078501,
											0.078501);

		N90_4 := if(((real)attr_num_rel_liens12 < 0.5), -0.0432857, 0.0228847);

		N90_3 := if(((real)addrs_15yr < 10.5), N90_4, N90_5);

		N90_2 := if(((real)liens_rel_ot_total_amount < 287.5), -0.00097267, N90_3);

		N90_1 := if(((real)bk_recent_count < 1.5), N90_2, 0.0781027);

		N91_5 := if(((real)rc_phonevalflag < 2.5), 0.000555022, 0.136196);

		N91_4 := if(((real)dist_a1toa3 < 0.5), -0.0408787, N91_5);

		N91_3 := if(((real)rc_lnamecount < 3.5), 0.00118232, 0.0178594);

		N91_2 := if(((real)attr_addrs_last12 < 0.5), -0.00359693, N91_3);

		N91_1 := if(((real)eq_count < 62.5), N91_2, N91_4);

		N92_5 := if((add1_avm_med_geo11 < 124220), 0.0232078, 0.184599);

		N92_4 := map((input_dob_match_level in ['8'])                                    => 0.0468609,
					 (input_dob_match_level in ['0', '1', '2', '3', '4', '5', '6', '7']) => 0.254634,
																							0.254634);

		N92_3 := if(((real)liens_unrel_sc_ct < 5.5), 0.00202666, N92_4);

		N92_2 := if((add1_add3_score < 35), N92_3, -0.00930155);

		N92_1 := if(((real)felony_count < 2.5), N92_2, N92_5);

		N93_5 := if(((real)liens_unrel_ot_total_amount < 518.5), 0.0803481, 0.0254909);

		N93_4 := if(((real)attr_num_unrel_liens36 < 0.5), -0.00124864, N93_5);

		N93_3 := if(((real)dist_a1toa2 < 28.5), N93_4, -0.0189309);

		N93_2 := if(((real)liens_unrel_cj_total_amount < 5792.5), N93_3, -0.032126);

		N93_1 := if(((real)liens_unrel_ot_total_amount < 54.5), 0.00110933, N93_2);

		N94_5 := if(((real)adls_per_phone_c6 < 0.5), -0.0363911, 0.0323903);

		N94_4 := map((ams_income_level_code in ['A', 'B', 'C', 'G', 'H', 'I', 'J', 'K']) => N94_5,
					 (ams_income_level_code in ['D', 'E', 'F'])                          => 0.0609034,
																							N94_5);

		N94_3 := if((liens_rel_ot_total_amount < 174), -0.00156243, 0.0872929);

		N94_2 := if(((real)liens_rel_ot_total_amount < 272.5), N94_3, N94_4);

		N94_1 := if(((real)phones_per_addr < 34.5), N94_2, -0.0498111);

		N95_5 := if(((real)liens_unrel_ft_total_amount < 5752.5), 0.156749, 0.0392589);

		N95_4 := if(((real)eq_count < 20.5), N95_5, -0.0234475);

		N95_3 := if(((real)liens_rel_cj_total_amount < 26712.5), 0.115321, -0.0599026);

		N95_2 := if(((real)liens_rel_cj_total_amount < 13729.5), -0.000418386, N95_3);

		N95_1 := if(((real)liens_unrel_ft_ct < 0.5), N95_2, N95_4);

		N96_5 := if(((real)addrs_10yr < 6.5), -0.000597151, 0.0104308);

		N96_4 := if(((real)em_count < 0.5), -0.0561203, 0.220839);

		N96_3 := if(((real)phones_per_addr_c6 < 12.5), -0.00810961, N96_4);

		N96_2 := if(((real)dist_a1toa2 < 1.5), N96_3, N96_5);

		N96_1 := if(((real)attr_num_unrel_liens24 < 5.5), N96_2, -0.0393325);

		N97_7 := if(((real)attr_num_nonderogs24 < 1.5), 0.00109299, 0.15563);

		N97_6 := if(((integer)addrs_prison_history < 0.5), -0.00145301, 0.0834679);

		N97_5 := if(((real)ssns_per_addr < 45.5), N97_6, N97_7);

		N97_4 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '6', '7', '9', 'A', 'U']) => -0.000954257,
					 (rc_hphonetypeflag in ['5'])                                         => 0.235524,
																							 -0.000954257);

		N97_3 := if((add1_assessed_amount < 14708), 0.206622, 0.023692);

		N97_2 := if(((integer)add1_avm_sales_price < 7400), N97_3, N97_4);

		N97_1 := if(trim(ADD1_AVM_SALES_PRICE) != '', N97_2, N97_5);

		N98_5 := if((add1_avm_med_geo12 < 88067), 0.00632903, 0.0659729);

		N98_4 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'G', 'I', 'J', 'K']) => N98_5,
					 (ams_income_level_code in ['F', 'H'])                                    => 0.197167,
																								 N98_5);

		N98_3 := if(((real)criminal_count < 0.5), 0.0063483, N98_4);

		N98_2 := if(((real)addrs_5yr < 1.5), -0.00230217, N98_3);

		N98_1 := if(((real)avg_lres < 41.5), -0.00548645, N98_2);

		N99_5 := if(((real)add1_no_of_bedrooms < 2.5), 0.0105557, 0.12398);

		N99_4 := if((liens_unrel_cj_total_amount < 11996), 0.00171083, N99_5);

		N99_3 := if((add1_mortgage_amount < 106939), N99_4, -0.016304);

		N99_2 := if(((real)eq_count < 65.5), N99_3, -0.0592321);

		N99_1 := if(((real)liens_unrel_ot_total_amount < 1820.5), N99_2, -0.0357188);

		N100_6 := if((add1_avm_med_fips < 129950), 0.114143, 0.0185557);

		N100_5 := if((add1_avm_med_fips < 126634), 0.000453263, N100_6);

		N100_4 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', 0.021352, N100_5);

		N100_3 := if(((real)attr_num_proflic_exp24 < 0.5), N100_4, 0.183673);

		N100_2 := if((add1_avm_med_fips < 131774), N100_3, 0.00172673);

		N100_1 := if((add1_avm_med_fips < 108233), -0.00354772, N100_2);

		N101_5 := if(((real)attr_eviction_count < 0.5), 0.00531256, 0.0729525);

		N101_4 := if(((real)eq_count < 25.5), N101_5, -0.0113033);

		N101_3 := if((add1_add2_score < 55), N101_4, 0.157487);

		N101_2 := if(((real)addrs_10yr < 10.5), 0.00158772, N101_3);

		N101_1 := if(((real)eq_count < 56.5), N101_2, -0.0498169);

		N102_5 := if((combo_addrscore < 25), 0.171594, -0.0287756);

		N102_4 := if(((real)liens_unrel_o_ct < 0.5), 0.000908058, 0.119369);

		N102_3 := if(((real)liens_rel_o_total_amount < 2097.5), N102_4, 0.132837);

		N102_2 := if((liens_rel_o_total_amount < 2715), N102_3, -0.0548323);

		N102_1 := map((rc_hphonetypeflag in ['0', '1', '3', '5', '6', '9', 'A', 'U']) => N102_2,
					  (rc_hphonetypeflag in ['2', '7'])                               => N102_5,
																						 N102_2);

		N103_5 := if((liens_unrel_cj_total_amount < 1344), -0.0128622, -0.0498653);

		N103_4 := if(((real)liens_rel_ot_total_amount < 420.5), N103_5, 0.0656796);

		N103_3 := if(((real)eq_count < 37.5), -0.000324205, N103_4);

		N103_2 := if(((real)attr_addrs_last36 < 5.5), N103_3, -0.0395577);

		N103_1 := if(((real)phones_per_addr < 33.5), N103_2, -0.0551006);

		N104_5 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', -0.0309387, 0.0463237);

		N104_4 := if((liens_unrel_cj_total_amount < 654), 0.229145, 0.0139098);

		N104_3 := if(((real)max_lres < 58.5), N104_4, N104_5);

		N104_2 := if(((real)avg_lres < 35.5), 0.0025841, N104_3);

		N104_1 := if(((real)attr_addrs_last24 < 2.5), -0.00124751, N104_2);

		N105_6 := if((add1_avm_med_fips < 126750), -0.0292263, 0.276844);

		N105_5 := if(((real)max_lres < 43.5), 0.210859, 0.0158533);

		N105_4 := if(((real)liens_unrel_cj_total_amount < 10872.5), -0.00208247, N105_5);

		N105_3 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N105_4, 7.76378e-005);

		N105_2 := map((ams_college_tier in ['3', '4', '5', '6']) => N105_3,
					  (ams_college_tier in ['0', '1', '2'])      => 0.0741802,
																	N105_3);

		N105_1 := if(((real)rc_hriskaddrflag < 1.5), N105_2, N105_6);

		N106_6 := if(((real)add1_avm_confidence_score < 51.5), -0.0261844, 0.163698);

		N106_5 := if(((real)impulse_count180 < 0.5), -0.0246963, N106_6);

		N106_4 := map((prof_license_category in ['0', '1', '3', '4', '5']) => N106_5,
					  (prof_license_category in ['2'])                     => 0.192431,
																			  N106_5);

		N106_3 := if((add1_purchase_amount < 30950), 0.00134958, N106_4);

		N106_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', -1.08988e-007, N106_3);

		N106_1 := if((prop1_prev_purchase_price < 324750), N106_2, 0.181409);

		N107_5 := if((avg_lres < 52), 0.0815795, -0.0418225);

		N107_4 := if((add1_add2_score < 35), -0.00980315, 0.0919099);

		N107_3 := if(((real)add1_lres < 12.5), N107_4, N107_5);

		N107_2 := if(((real)liens_rel_cj_ct < 1.5), N107_3, 0.114278);

		N107_1 := if(((real)addrs_10yr < 10.5), 0.0013951, N107_2);

		N108_5 := if(((real)gong_did_phone_ct < 3.5), 0.026939, 0.112186);

		N108_4 := map((lname_eda_sourced_type in ['A', 'AP']) => N108_5,
					  (lname_eda_sourced_type in ['P'])       => 0.250129,
																 N108_5);

		N108_3 := if(((real)addrs_per_ssn < 5.5), 0.00778331, N108_4);

		N108_2 := if(((real)add1_no_of_rooms < 7.5), N108_3, 0.171447);

		N108_1 := if(((real)dist_a1toa2 < 1032.5), -0.00253977, N108_2);

		N109_5 := if(((real)attr_num_nonderogs12 < 1.5), 0.00708563, 0.242467);

		N109_4 := if(((real)eq_count < 27.5), 0.0163341, -0.0500748);

		N109_3 := if((liens_rel_cj_total_amount < 1385), 0.122129, N109_4);

		N109_2 := map((input_dob_match_level in ['0', '2', '3', '4', '5', '8']) => N109_3,
					  (input_dob_match_level in ['1', '6', '7'])                => N109_5,
																				   N109_3);

		N109_1 := if(((real)liens_rel_cj_total_amount < 1282.5), -0.00320912, N109_2);

		N110_6 := if((age < 50), 0.0282886, 0.162039);

		N110_5 := if(((real)dist_a1toa2 < 1030.5), -0.00375376, N110_6);

		N110_4 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', -0.00495867, N110_5);

		N110_3 := if(((real)avg_lres < 62.5), N110_4, 0.00616512);

		N110_2 := if((add1_purchase_amount < 2.25e+006), N110_3, 0.12341);

		N110_1 := if(((real)invalid_addrs_per_adl < 10.5), N110_2, 0.104908);

		N111_5 := if(((real)eq_count < 23.5), 0.0270091, -0.0202397);

		N111_4 := if(((real)liens_unrel_sc_ct < 2.5), N111_5, 0.151224);

		N111_3 := if(((real)attr_addrs_last12 < 0.5), 0.00171943, N111_4);

		N111_2 := if(((real)avg_lres < 60.5), -0.00459749, N111_3);

		N111_1 := if(((real)attr_num_unrel_liens60 < 9.5), N111_2, -0.0456515);

		N112_7 := map((ams_college_type in ['R', 'S']) => -0.0207226,
					  (ams_college_type in ['P'])      => 0.222284,
														  -0.0207226);

		N112_6 := if((add1_avm_hedonic_valuation < 73050), -0.0206845, 0.12002);

		N112_5 := if(((real)add1_avm_med_fips < 79598.5), N112_6, N112_7);

		N112_4 := if((add1_avm_hedonic_valuation < 73359), 0.0538472, 0.0111583);

		N112_3 := if((add1_avm_automated_valuation < 72720), -0.00480367, N112_4);

		N112_2 := if(((integer)add1_avm_assessed_total_value < 89521), N112_3, N112_5);

		N112_1 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N112_2, 0.000208237);

		N113_6 := if(((real)age < 40.5), 0.00654029, -0.00591874);

		N113_5 := if(((real)adls_per_addr < 9.5), 0.206502, 0.00310672);

		N113_4 := if(((real)add1_building_area < 2965.5), 0.000251803, N113_5);

		N113_3 := if(trim(ADD1_AVM_SALES_PRICE) != '', N113_4, N113_6);

		N113_2 := map((ams_income_level_code in ['A', 'B', 'G', 'H', 'I', 'J']) => -0.0232126,
					  (ams_income_level_code in ['C', 'D', 'E', 'F', 'K'])      => N113_3,
																				   N113_3);

		N113_1 := if((add1_avm_med_geo11 < 197547), N113_2, -0.0148529);

		N114_5 := map((ams_college_tier in ['4'])                          => 0.0241973,
					  (ams_college_tier in ['0', '1', '2', '3', '5', '6']) => 0.509374,
																			  0.0241973);

		N114_4 := if(((real)dist_a2toa3 < 14.5), 0.0825334, 0.218757);

		N114_3 := if(((real)addr_stability < 1.5), N114_4, N114_5);

		N114_2 := if(((real)max_lres < 60.5), -0.00737172, N114_3);

		N114_1 := if(((real)ssns_per_addr < 28.5), -0.000161919, N114_2);

		N115_5 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'K']) => -0.0218547,
					  (ams_income_level_code in ['J'])                                              => 0.22026,
																									   -0.0218547);

		N115_4 := if(((real)nap_summary < 5.5), -0.00364464, 0.147837);

		N115_3 := if(((real)impulse_count < 2.5), -0.000297673, N115_4);

		N115_2 := if(((real)attr_eviction_count180 < 0.5), N115_3, N115_5);

		N115_1 := if(((real)bk_disposed_recent_count < 2.5), N115_2, 0.111875);

		N116_5 := if(((real)attr_eviction_count180 < 0.5), -0.0213725, 0.0925789);

		N116_4 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '5', '6', '9', 'A', 'U']) => 0.0066692,
					  (rc_hphonetypeflag in ['7'])                                         => 0.270325,
																							  0.0066692);

		N116_3 := if(((real)max_lres < 48.5), -0.00420758, N116_4);

		N116_2 := if((property_owned_assessed_total < 45225), N116_3, N116_5);

		N116_1 := if(((real)rc_pwssnvalflag < 0.5), N116_2, -0.0139376);

		N117_5 := if((add1_avm_automated_valuation < 135927), 0.169893, -0.00975295);

		N117_4 := if((add1_avm_hedonic_valuation < 118504), -0.0308066, N117_5);

		N117_3 := if(((real)combo_lnamescore < 6.5), 0.196806, 0.000528426);

		N117_2 := if(((real)impulse_count < 3.5), N117_3, 0.120698);

		N117_1 := if(((real)eq_count < 37.5), N117_2, N117_4);

		N118_6 := map((ams_income_level_code in ['A', 'D', 'F', 'H', 'I', 'J', 'K']) => 0.0452593,
					  (ams_income_level_code in ['B', 'C', 'E', 'G'])                => 0.159621,
																						0.0452593);

		N118_5 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', 0.00871029, N118_6);

		N118_4 := if(((real)ssns_per_adl < 1.5), N118_5, 0.00316988);

		N118_3 := if(((real)rc_lnamecount < 5.5), N118_4, -0.0601041);

		N118_2 := if(((real)adls_per_phone < 1.5), N118_3, 0.138141);

		N118_1 := if(((real)addrs_10yr < 9.5), 0.000470384, N118_2);

		N119_5 := if((add1_assessed_amount < 56710), 0.17753, -0.00941723);

		N119_4 := if(((real)add1_avm_confidence_score < 80.5), -0.031492, N119_5);

		N119_3 := if(((real)addrs_10yr < 8.5), -0.00359932, N119_4);

		N119_2 := if(((real)eq_count < 66.5), N119_3, 0.0883844);

		N119_1 := if(((real)gong_did_addr_ct < 2.5), 0.0036881, N119_2);

		N120_5 := if(((real)liens_unrel_sc_total_amount < 6002.5), 0.00847712, 0.0887116);

		N120_4 := if(((real)age < 50.5), N120_5, -0.0293454);

		N120_3 := if((add1_avm_med_geo12 < 396334), N120_4, 0.140277);

		N120_2 := if(((real)dist_a1toa2 < 1.5), N120_3, -0.00758);

		N120_1 := if(((real)add1_naprop < 0.5), 0.00508176, N120_2);

		N121_5 := if(((real)attr_num_nonderogs < 2.5), 0.161907, -0.0572424);

		N121_4 := if(((real)addrs_per_ssn_c6 < 0.5), 0.0166963, N121_5);

		N121_3 := if((dist_a2toa3 < 716), 0.000818523, -0.0156369);

		N121_2 := if(((real)avg_lres < 137.5), N121_3, N121_4);

		N121_1 := if((liens_unrel_fc_total_amount < 2877), N121_2, 0.111456);

		N122_5 := map((ams_college_tier in ['1', '2', '3', '4', '5']) => -0.0553163,
					  (ams_college_tier in ['0', '6'])                => 0.278104,
																		 -0.0553163);

		N122_4 := map((ams_income_level_code in ['C', 'E'])                                    => -0.0689218,
					  (ams_income_level_code in ['A', 'B', 'D', 'F', 'G', 'H', 'I', 'J', 'K']) => 0.0562776,
																								  0.0562776);

		N122_3 := map((input_dob_match_level in ['0', '1', '2', '4', '5', '6']) => -0.072016,
					  (input_dob_match_level in ['3', '7', '8'])                => N122_4,
																				   -0.072016);

		N122_2 := if(((real)addrs_15yr < 15.5), 0.000670255, N122_3);

		N122_1 := if(((real)gong_did_addr_ct < 6.5), N122_2, N122_5);

		N123_5 := if((liens_unrel_ot_total_amount < 126), 0.00572748, 0.0341746);

		N123_4 := if(((real)attr_total_number_derogs < 13.5), N123_5, 0.127387);

		N123_3 := if(((real)attr_addrs_last12 < 0.5), -0.00147303, N123_4);

		N123_2 := if(((real)attr_eviction_count12 < 1.5), N123_3, -0.020963);

		N123_1 := if(((real)liens_unrel_sc_ct < 5.5), N123_2, 0.0800324);

		N124_5 := if(((integer)add1_isbestmatch < 0.5), -0.0136138, 0.0293389);

		N124_4 := if((add1_mortgage_amount < 191794), N124_5, 0.145423);

		N124_3 := if((add1_avm_med_fips < 365362), N124_4, 0.111477);

		N124_2 := if(((real)attr_num_rel_liens24 < 0.5), -0.000922612, N124_3);

		N124_1 := if(((real)attr_eviction_count < 4.5), N124_2, -0.0223847);

		N125_5 := if((add1_avm_automated_valuation < 69971), 0.190072, 0.0085484);

		N125_4 := if(((real)add1_avm_automated_valuation < 69667.5), -0.002474, N125_5);

		N125_3 := map((fname_eda_sourced_type in ['AP'])     => -0.022998,
					  (fname_eda_sourced_type in ['A', 'P']) => N125_4,
																N125_4);

		N125_2 := if(((real)attr_total_number_derogs < 17.5), N125_3, -0.0717603);

		N125_1 := if(((real)liens_rel_ft_total_amount < 5706.5), N125_2, -0.0763153);

		N126_5 := map((ams_income_level_code in ['D', 'E', 'G'])                          => -0.0811053,
					  (ams_income_level_code in ['A', 'B', 'C', 'F', 'H', 'I', 'J', 'K']) => 0.130698,
																							 0.130698);

		N126_4 := if(((real)attr_addrs_last36 < 0.5), -0.0226064, N126_5);

		N126_3 := if(((real)liens_unrel_sc_ct < 6.5), -0.000887952, -0.0741589);

		N126_2 := if(((real)liens_unrel_ft_ct < 0.5), N126_3, N126_4);

		N126_1 := if(((real)vo_addrs_per_adl < 4.5), N126_2, -0.0440644);

		N127_6 := if(((real)em_only_count < 1.5), -0.00196922, 0.0492084);

		N127_5 := if(((real)liens_rel_ot_total_amount < 533.5), N127_6, 0.1007);

		N127_4 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', N127_5, 0.000931586);

		N127_3 := if(((real)liens_rel_cj_ct < 1.5), N127_4, -0.0246594);

		N127_2 := if(((real)add1_avm_confidence_score < 79.5), N127_3, -0.0178746);

		N127_1 := map((ams_college_tier in ['2', '3', '6'])      => -0.0443544,
					  (ams_college_tier in ['0', '1', '4', '5']) => N127_2,
																	N127_2);

		N128_5 := if(((real)add1_lres < 163.5), 0.0133354, 0.157642);

		N128_4 := map((input_dob_match_level in ['0', '1', '2', '3', '5', '7', '8']) => N128_5,
					  (input_dob_match_level in ['4', '6'])                          => 0.142589,
																						N128_5);

		N128_3 := map((ams_file_type in ['M'])      => N128_4,
					  (ams_file_type in ['C', 'H']) => 0.19377,
													   N128_4);

		N128_2 := if(((real)invalid_phones_per_adl < 1.5), -0.00186489, 0.0850421);

		N128_1 := if(((integer)add1_building_area < 2391), N128_2, N128_3);

		N129_5 := if(((real)addrs_per_adl < 29.5), -0.00236673, 0.0861166);

		N129_4 := if((addrs_per_ssn < 15), 0.0213373, 0.152259);

		N129_3 := map((ams_income_level_code in ['A', 'C', 'D', 'F', 'G', 'H', 'I', 'J', 'K']) => N129_4,
					  (ams_income_level_code in ['B', 'E'])                                    => 0.429985,
																								  N129_4);

		N129_2 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '6', '7', '9', 'A']) => N129_3,
					  (rc_hphonetypeflag in ['5', 'U'])                               => 0.716204,
																						 N129_3);

		N129_1 := if(((real)avg_lres < 1.5), N129_2, N129_5);

		N130_5 := map((ams_college_tier in ['0', '1', '3', '4', '5']) => -0.0280229,
					  (ams_college_tier in ['2', '6'])                => 0.263411,
																		 -0.0280229);

		N130_4 := if((avg_lres < 14), 0.148582, 0.0211827);

		N130_3 := map((rc_hphonetypeflag in ['0', '1', '3', '5', '6', '7', '9']) => -0.000570427,
					  (rc_hphonetypeflag in ['2', 'A', 'U'])                     => 0.0414094,
																					-0.000570427);

		N130_2 := if(((real)addrs_per_ssn < 20.5), N130_3, N130_4);

		N130_1 := if((add1_avm_price_index_valuation < 184429), N130_2, N130_5);

		N131_5 := if((add1_avm_med_geo12 < 186000), 0.254724, 0.0278869);

		N131_4 := if(((real)combo_fnamescore < 89.5), 0.0346022, -7.22006e-005);

		N131_3 := if(((real)liens_rel_ot_ct < 2.5), N131_4, 0.07593);

		N131_2 := if(((integer)rc_lnamessnmatch < 0.5), -0.0126929, N131_3);

		N131_1 := if((property_sold_purchase_total < 395275), N131_2, N131_5);

		N132_5 := if(((real)max_lres < 15.5), 0.056445, -0.0237231);

		N132_4 := if(((real)attr_eviction_count180 < 0.5), 0.00358478, N132_5);

		N132_3 := if(((real)age < 52.5), N132_4, -0.0151041);

		N132_2 := if(((real)liens_rel_ot_total_amount < 2780.5), N132_3, -0.056242);

		N132_1 := if(((real)addrs_per_ssn < 18.5), N132_2, -0.0421337);

		N133_5 := map((input_dob_match_level in ['0', '2', '3', '4', '5', '7', '8']) => 0.0878772,
					  (input_dob_match_level in ['1', '6'])                          => 0.484448,
																						0.0878772);

		N133_4 := if(((real)attr_eviction_count < 0.5), 0.0033942, 0.0320174);

		N133_3 := if(((real)add1_avm_confidence_score < 89.5), N133_4, N133_5);

		N133_2 := if((add1_avm_med_fips < 198944), -0.000671729, N133_3);

		N133_1 := if((add1_purchase_amount < 294250), N133_2, -0.0370627);

		N134_5 := if((add1_unit_count < 62), -0.0237371, 0.0365046);

		N134_4 := if(((real)liens_unrel_ot_total_amount < 553.5), 0.00041315, 0.0799557);

		N134_3 := if(((real)liens_unrel_ot_total_amount < 647.5), N134_4, N134_5);

		N134_2 := if((liens_unrel_ft_total_amount < 4291), N134_3, 0.0722745);

		N134_1 := if((liens_rel_ft_total_amount < 5124), N134_2, -0.0491842);

		N135_5 := if(((real)age < 38.5), 0.238207, 0.041442);

		N135_4 := if(((real)addrs_per_ssn < 10.5), 0.0108256, N135_5);

		N135_3 := if(((real)rc_decsflag < 0.5), -0.000201463, 0.0760214);

		N135_2 := if((add1_avm_price_index_valuation < 840833), N135_3, 0.114182);

		N135_1 := if(((real)attr_eviction_count30 < 0.5), N135_2, N135_4);

		N136_5 := if(((real)vo_count < 1.5), 0.232865, -0.00976736);

		N136_4 := if((add1_avm_automated_valuation < 8325), -0.029269, N136_5);

		N136_3 := if((add1_purchase_amount < 4850), 0.00243022, N136_4);

		N136_2 := if(((real)attr_num_unrel_liens180 < 2.5), N136_3, -0.0531062);

		N136_1 := if((add1_purchase_amount < 7600), N136_2, -0.0110339);

		N137_5 := if((liens_unrel_ot_total_amount < 2678), -0.00672507, 0.0788055);

		N137_4 := if((add1_avm_price_index_valuation < 156356), N137_5, -0.050582);

		N137_3 := if((impulse_annual_income < 26742), N137_4, -0.0464796);

		N137_2 := if(((real)addrs_per_ssn < 19.5), 0.000957237, 0.0571945);

		N137_1 := if(((real)gong_did_addr_ct < 2.5), N137_2, N137_3);

		N138_5 := if((dist_a2toa3 < 7), 0.17078, 0.00280735);

		N138_4 := if((liens_unrel_cj_total_amount < 3293), N138_5, -0.0580838);

		N138_3 := if(((real)attr_num_unrel_liens180 < 0.5), N138_4, 0.107762);

		N138_2 := if((liens_rel_o_total_amount < 406), -0.000744803, N138_3);

		N138_1 := if(((real)attr_num_unrel_liens36 < 11.5), N138_2, 0.106353);

		N139_6 := map((ams_college_tier in ['0', '1', '5', '6']) => -0.00767761,
					  (ams_college_tier in ['2', '3', '4'])      => 0.0826919,
																	-0.00767761);

		N139_5 := if(((real)attr_addrs_last12 < 1.5), 0.0072277, 0.043857);

		N139_4 := if(((real)avg_lres < 40.5), -0.00597269, N139_5);

		N139_3 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', 0.00426582, N139_4);

		N139_2 := if((add1_add3_score < 25), N139_3, N139_6);

		N139_1 := if(((real)liens_rel_ot_ct < 2.5), N139_2, 0.0847376);

		N140_5 := if(((real)liens_historical_released_count < 0.5), 0.00359881, 0.111484);

		N140_4 := if(((real)addrs_per_adl < 14.5), N140_5, 0.0657917);

		N140_3 := if(((real)eq_count < 27.5), N140_4, -0.00917706);

		N140_2 := if(((real)addrs_10yr < 15.5), -0.00103001, 0.102758);

		N140_1 := if(((real)invalid_addrs_per_adl < 3.5), N140_2, N140_3);

		N141_5 := if(((real)avg_lres < 63.5), 0.0484404, 0.25113);

		N141_4 := if(((real)liens_historical_released_count < 0.5), N141_5, -0.0112646);

		N141_3 := if((dist_a1toa3 < 718), 0.00333821, N141_4);

		N141_2 := if((liens_unrel_ot_total_amount < 96), 0.120842, N141_3);

		N141_1 := if(((real)liens_unrel_ot_total_amount < 53.5), 0.000623849, N141_2);

		N142_5 := if((add1_avm_med_fips < 126809), 0.111412, 0.00222671);

		N142_4 := if((add1_avm_med_fips < 126634), -0.00686633, N142_5);

		N142_3 := if(((real)add1_lres < 62.5), N142_4, 0.0123149);

		N142_2 := if((dist_a2toa3 < 1512), N142_3, -0.0170612);

		N142_1 := if(((real)eq_count < 36.5), N142_2, -0.0200402);

		N143_5 := map((prof_license_category in ['0', '1', '2', '4']) => 0.0014961,
					  (prof_license_category in ['3', '5'])           => 0.196416,
																		 0.0014961);

		N143_4 := if((liens_unrel_ot_total_amount < 2969), -0.00733604, 0.0905992);

		N143_3 := if(((real)dist_a1toa2 < 1.5), N143_4, N143_5);

		N143_2 := if(((real)attr_num_rel_liens30 < 0.5), N143_3, 0.0765081);

		N143_1 := if(((real)liens_historical_unreleased_ct < 3.5), N143_2, -0.0185339);


		tnscore := sum(N0_1, N1_1, N2_1, N3_1, N4_1, N5_1, N6_1, N7_1, N8_1, N9_1, N10_1, N11_1, N12_1, N13_1, N14_1, N15_1, N16_1, N17_1, N18_1, N19_1, N20_1, N21_1, N22_1, N23_1, N24_1, N25_1, N26_1, N27_1, N28_1, N29_1, N30_1, N31_1, N32_1, N33_1, N34_1, N35_1, N36_1, N37_1, N38_1, N39_1, N40_1, N41_1, N42_1, N43_1, N44_1, N45_1, N46_1, N47_1, N48_1, N49_1, N50_1, N51_1, N52_1, N53_1, N54_1, N55_1, N56_1, N57_1, N58_1, N59_1, N60_1, N61_1, N62_1, N63_1, N64_1, N65_1, N66_1, N67_1, N68_1, N69_1, N70_1, N71_1, N72_1, N73_1, N74_1, N75_1, N76_1, N77_1, N78_1, N79_1, N80_1, N81_1, N82_1, N83_1, N84_1, N85_1, N86_1, N87_1, N88_1, N89_1, N90_1, N91_1, N92_1, N93_1, N94_1, N95_1, N96_1, N97_1, N98_1, N99_1, N100_1, N101_1, N102_1, N103_1, N104_1, N105_1, N106_1, N107_1, N108_1, N109_1, N110_1, N111_1, N112_1, N113_1, N114_1, N115_1, N116_1, N117_1, N118_1, N119_1, N120_1, N121_1, N122_1, N123_1, N124_1, N125_1, N126_1, N127_1, N128_1, N129_1, N130_1, N131_1, N132_1, N133_1, N134_1, N135_1, N136_1, N137_1, N138_1, N139_1, N140_1, N141_1, N142_1, N143_1);


		score0 := exp(-tnscore); /* DEPVAR = 0 */
		score1 := exp(tnscore); /* DEPVAR = 1 */
		expsum := score0 + score1;

		/***************************************/
		/* Probabilities for each target class */
		/***************************************/

		prob0 := score0 / expsum; /* DEPVAR = 0 */
		prob1 := score1 / expsum; /* DEPVAR = 1 */
		SBAR_Treenet_Score1 := round(-40*(log(prob1/(1-prob1)) - log(.1/.9))/log(2) + 700);
		SBAR_Treenet_Score2 := min(max(SBAR_Treenet_Score1,501),900);

		isUnscorable := models.common.isRV3Unscorable(le);
		final := if( isUnscorable, '222', (string3)SBAR_Treenet_Score2 );

		#if(RVD_DEBUG)
			self.rc_ssnvalflag := rc_ssnvalflag;
			self.add1_pop := add1_pop;
			self.add2_pop := add2_pop;
			self.add3_pop := add3_pop;
			self.nap_summary := nap_summary;
			self.nap_type := nap_type;
			self.nap_status := nap_status;
			self.did2_liens_recent_unrel_count := did2_liens_recent_unrel_count;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_hriskaddrflag := rc_hriskaddrflag;
			self.rc_decsflag := rc_decsflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_dwelltype := rc_dwelltype;
			self.rc_lnamecount := rc_lnamecount;
			self.rc_ssncount := rc_ssncount;
			self.rc_phoneaddr_addrcount := rc_phoneaddr_addrcount;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_zipclass := rc_zipclass;
			self.rc_lnamessnmatch := rc_lnamessnmatch;
			self.combo_fnamescore := combo_fnamescore;
			self.combo_lnamescore := combo_lnamescore;
			self.combo_addrscore := combo_addrscore;
			self.combo_fnamecount := combo_fnamecount;
			self.combo_lnamecount := combo_lnamecount;
			self.combo_dobcount := combo_dobcount;
			self.eq_count := eq_count;
			self.pr_count := pr_count;
			self.em_count := em_count;
			self.vo_count := vo_count;
			self.em_only_count := em_only_count;
			self.fname_eda_sourced_type := fname_eda_sourced_type;
			self.lname_eda_sourced_type := lname_eda_sourced_type;
			self.age := age;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_unit_count := add1_unit_count;
			self.add1_lres := add1_lres;
			self.add1_avm_sales_price := add1_avm_sales_price;
			self.add1_avm_assessed_total_value := add1_avm_assessed_total_value;
			self.add1_avm_market_total_value := add1_avm_market_total_value;
			self.add1_avm_tax_assessed_valuation := add1_avm_tax_assessed_valuation;
			self.add1_avm_price_index_valuation := add1_avm_price_index_valuation;
			self.add1_avm_hedonic_valuation := add1_avm_hedonic_valuation;
			self.add1_avm_automated_valuation := add1_avm_automated_valuation;
			self.add1_avm_confidence_score := add1_avm_confidence_score;
			self.add1_avm_med_fips := add1_avm_med_fips;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_avm_med_geo12 := add1_avm_med_geo12;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_family_sold := add1_family_sold;
			self.add1_naprop := add1_naprop;
			self.add1_purchase_amount := add1_purchase_amount;
			self.add1_mortgage_amount := add1_mortgage_amount;
			self.add1_financing_type := add1_financing_type;
			self.add1_assessed_amount := add1_assessed_amount;
			self.add1_building_area := add1_building_area;
			self.add1_no_of_rooms := add1_no_of_rooms;
			self.add1_no_of_bedrooms := add1_no_of_bedrooms;
			self.add1_no_of_partial_baths := add1_no_of_partial_baths;
			self.property_owned_purchase_total := property_owned_purchase_total;
			self.property_owned_assessed_total := property_owned_assessed_total;
			self.property_sold_purchase_total := property_sold_purchase_total;
			self.prop1_prev_purchase_price := prop1_prev_purchase_price;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.add1_add2_score := add1_add2_score;
			self.add1_add3_score := add1_add3_score;
			self.add2_add3_score := add2_add3_score;
			self.avg_lres := avg_lres;
			self.max_lres := max_lres;
			self.addrs_5yr := addrs_5yr;
			self.addrs_10yr := addrs_10yr;
			self.addrs_15yr := addrs_15yr;
			self.addrs_prison_history := addrs_prison_history;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.gong_did_addr_ct := gong_did_addr_ct;
			self.gong_did_last_ct := gong_did_last_ct;
			self.ssns_per_adl := ssns_per_adl;
			self.addrs_per_adl := addrs_per_adl;
			self.phones_per_adl := phones_per_adl;
			self.adlperssn_count := adlperssn_count;
			self.addrs_per_ssn := addrs_per_ssn;
			self.adls_per_addr := adls_per_addr;
			self.ssns_per_addr := ssns_per_addr;
			self.phones_per_addr := phones_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.addrs_per_ssn_c6 := addrs_per_ssn_c6;
			self.phones_per_addr_c6 := phones_per_addr_c6;
			self.adls_per_phone_c6 := adls_per_phone_c6;
			self.vo_addrs_per_adl := vo_addrs_per_adl;
			self.invalid_phones_per_adl := invalid_phones_per_adl;
			self.invalid_ssns_per_adl := invalid_ssns_per_adl;
			self.invalid_addrs_per_adl := invalid_addrs_per_adl;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.impulse_count90 := impulse_count90;
			self.impulse_count180 := impulse_count180;
			self.impulse_count24 := impulse_count24;
			self.impulse_annual_income := impulse_annual_income;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_num_purchase60 := attr_num_purchase60;
			self.attr_num_sold36 := attr_num_sold36;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_felonies60 := attr_felonies60;
			self.attr_num_unrel_liens90 := attr_num_unrel_liens90;
			self.attr_num_unrel_liens180 := attr_num_unrel_liens180;
			self.attr_num_unrel_liens12 := attr_num_unrel_liens12;
			self.attr_num_unrel_liens24 := attr_num_unrel_liens24;
			self.attr_num_unrel_liens36 := attr_num_unrel_liens36;
			self.attr_num_unrel_liens60 := attr_num_unrel_liens60;
			self.attr_num_rel_liens30 := attr_num_rel_liens30;
			self.attr_num_rel_liens180 := attr_num_rel_liens180;
			self.attr_num_rel_liens12 := attr_num_rel_liens12;
			self.attr_num_rel_liens24 := attr_num_rel_liens24;
			self.attr_num_rel_liens36 := attr_num_rel_liens36;
			self.attr_bankruptcy_count36 := attr_bankruptcy_count36;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_eviction_count30 := attr_eviction_count30;
			self.attr_eviction_count180 := attr_eviction_count180;
			self.attr_eviction_count12 := attr_eviction_count12;
			self.attr_eviction_count60 := attr_eviction_count60;
			self.attr_num_nonderogs := attr_num_nonderogs;
			self.attr_num_nonderogs90 := attr_num_nonderogs90;
			self.attr_num_nonderogs12 := attr_num_nonderogs12;
			self.attr_num_nonderogs24 := attr_num_nonderogs24;
			self.attr_num_nonderogs36 := attr_num_nonderogs36;
			self.attr_num_nonderogs60 := attr_num_nonderogs60;
			self.attr_num_proflic_exp12 := attr_num_proflic_exp12;
			self.attr_num_proflic_exp24 := attr_num_proflic_exp24;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.bk_disposed_recent_count := bk_disposed_recent_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_historical_released_count := liens_historical_released_count;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_unrel_cj_total_amount := liens_unrel_cj_total_amount;
			self.liens_rel_cj_ct := liens_rel_cj_ct;
			self.liens_rel_cj_total_amount := liens_rel_cj_total_amount;
			self.liens_unrel_ft_ct := liens_unrel_ft_ct;
			self.liens_unrel_ft_total_amount := liens_unrel_ft_total_amount;
			self.liens_rel_ft_ct := liens_rel_ft_ct;
			self.liens_rel_ft_total_amount := liens_rel_ft_total_amount;
			self.liens_unrel_fc_total_amount := liens_unrel_fc_total_amount;
			self.liens_unrel_lt_ct := liens_unrel_lt_ct;
			self.liens_rel_lt_ct := liens_rel_lt_ct;
			self.liens_unrel_o_ct := liens_unrel_o_ct;
			self.liens_rel_o_ct := liens_rel_o_ct;
			self.liens_rel_o_total_amount := liens_rel_o_total_amount;
			self.liens_unrel_ot_ct := liens_unrel_ot_ct;
			self.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
			self.liens_rel_ot_ct := liens_rel_ot_ct;
			self.liens_rel_ot_total_amount := liens_rel_ot_total_amount;
			self.liens_unrel_sc_ct := liens_unrel_sc_ct;
			self.liens_unrel_sc_total_amount := liens_unrel_sc_total_amount;
			self.criminal_count := criminal_count;
			self.felony_count := felony_count;
			self.ams_college_code := ams_college_code;
			self.ams_college_type := ams_college_type;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_file_type := ams_file_type;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.input_dob_match_level := input_dob_match_level;
			self.addr_stability := addr_stability;
			self.eg_segment := eg_segment;
			self.tnscore := tnscore;
			self.score0 := score0;
			self.score1 := score1;
			self.expsum := expsum;
			self.prob0 := prob0;
			self.prob1 := prob1;
			self.SBAR_Treenet_Score1 := SBAR_Treenet_Score1;
			self.SBAR_Treenet_Score2 := SBAR_Treenet_Score2;
			self.isUnscorable := isUnscorable;
		#end;


		inCalif := isCalifornia and (
			(integer)(boolean)le.iid.combo_firstcount+(integer)(boolean)le.iid.combo_lastcount
			+(integer)(boolean)le.iid.combo_addrcount+(integer)(boolean)le.iid.combo_hphonecount
			+(integer)(boolean)le.iid.combo_ssncount+(integer)(boolean)le.iid.combo_dobcount) < 3;

		self.ri := riskwise.rv3retailReasonCodes( le, 4, inCalif, false );
		self.score := map(
			self.ri[1].hri in ['91','92','93','94'] => (string)((integer)self.ri[1].hri + 10),
			self.ri[1].hri='95' => '222', // per bug 52525, 95 returns a score of 222
			self.ri[1].hri='35' => '000',
			final
		);
		self.seq := le.seq;
	end;

	model := project( clam, doModel(left) );
	return model;

end;