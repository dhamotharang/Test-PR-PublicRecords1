import risk_indicators, ut, riskwisefcra, riskwise;

export RVD1010_1_0( dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia ) := FUNCTION

	RVD_DEBUG := false;

	#if(RVD_DEBUG)
		layout_debug := record
			integer seq;
			Integer NAS_Summary;
			Integer CVI;
			String rc_hphonetypeflag;
			String rc_hphonevalflag;
			String rc_pwphonezipflag;
			String rc_pwssnvalflag;
			String rc_addrvalflag;
			Integer rc_lnamecount;
			Integer rc_addrcount;
			Integer rc_ssncount;
			Integer rc_numelever;
			Integer rc_phoneaddr_addrcount;
			Integer rc_disthphoneaddr;
			String rc_phonetype;
			String rc_zipclass;
			Boolean rc_lnamessnmatch;
			Boolean rc_lnamessnmatch2;
			Boolean rc_fnamessnmatch;
			Integer combo_fnamescore;
			Integer combo_addrscore;
			Integer combo_hphonescore;
			Integer combo_ssnscore;
			Integer combo_dobscore;
			Integer combo_fnamecount;
			Integer combo_lnamecount;
			Integer EQ_count;
			Integer PR_count;
			Integer EM_count;
			Integer VO_count;
			String fname_eda_sourced_type;
			String lname_eda_sourced_type;
			Integer age;
			Integer add1_address_score;
			Boolean add1_house_number_match;
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
			Integer add1_source_count;
			Boolean add1_applicant_owned;
			Integer add1_purchase_amount;
			Integer add1_mortgage_amount;
			String add1_financing_type;
			Integer add1_assessed_amount;
			String add1_building_area;
			String add1_no_of_rooms;
			String add1_no_of_bedrooms;
			String add1_parking_no_of_cars;
			Integer property_owned_purchase_total;
			Integer property_owned_assessed_total;
			Integer property_sold_purchase_total;
			Integer property_sold_assessed_total;
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
			Integer recent_disconnects;
			Integer gong_did_phone_ct;
			Integer gong_did_addr_ct;
			Integer gong_did_first_ct;
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
			Integer ssns_per_adl_c6;
			Integer addrs_per_ssn_c6;
			Integer adls_per_addr_c6;
			Integer ssns_per_addr_c6;
			Integer vo_addrs_per_adl;
			Integer pl_addrs_per_adl;
			Integer invalid_ssns_per_adl;
			Integer invalid_addrs_per_adl;
			Integer infutor_nap;
			Integer impulse_count;
			Integer impulse_annual_income;
			Integer attr_addrs_last12;
			Integer attr_addrs_last24;
			Integer attr_addrs_last36;
			Integer attr_num_purchase60;
			Integer attr_num_sold24;
			Integer attr_num_sold36;
			Integer attr_total_number_derogs;
			Integer attr_felonies60;
			Integer attr_num_unrel_liens90;
			Integer attr_num_unrel_liens12;
			Integer attr_num_unrel_liens24;
			Integer attr_num_unrel_liens36;
			Integer attr_num_unrel_liens60;
			Integer attr_num_rel_liens180;
			Integer attr_num_rel_liens12;
			Integer attr_bankruptcy_count24;
			Integer attr_bankruptcy_count60;
			Integer attr_eviction_count;
			Integer attr_eviction_count180;
			Integer attr_eviction_count12;
			Integer attr_eviction_count24;
			Integer attr_eviction_count36;
			Integer attr_eviction_count60;
			Integer attr_num_nonderogs;
			Integer attr_num_nonderogs30;
			Integer attr_num_nonderogs180;
			Integer attr_num_nonderogs12;
			Integer attr_num_nonderogs24;
			Integer attr_num_nonderogs36;
			Integer attr_num_nonderogs60;
			Integer attr_num_proflic60;
			String filing_type;
			String disposition;
			Integer filing_count;
			Integer bk_recent_count;
			Integer bk_disposed_recent_count;
			Integer bk_disposed_historical_count;
			Integer liens_historical_unreleased_ct;
			Integer liens_unrel_cj_ct;
			Integer liens_unrel_cj_total_amount;
			Integer liens_rel_cj_total_amount;
			Integer liens_unrel_lt_ct;
			Integer liens_unrel_ot_ct;
			Integer liens_unrel_ot_total_amount;
			Integer liens_rel_ot_total_amount;
			Integer liens_unrel_sc_total_amount;
			Integer liens_rel_sc_total_amount;
			Integer criminal_count;
			Integer felony_count;
			String ams_college_code;
			String ams_college_type;
			String ams_income_level_code;
			String ams_file_type;
			String ams_college_tier;
			String prof_license_category;
			String wealth_index;
			String input_dob_match_level;
			String addr_stability;
			real tnscore;
			real score1;
			real score0;
			real expsum;
			real prob1;
			real prob0;
			real REPB_Treenet_Score1;
			real REPB_Treenet_Score2;
			boolean isUnscorable;

			models.layout_modelout - seq;
		end;
		layout_debug doModel( clam le ) := TRANSFORM
	#else
		models.layout_modelout doModel( clam le ) := TRANSFORM
	#end
		string remap( string field, string newval ) := if( trim(field)='', newval, field );

		nas_summary                      := le.iid.nas_summary;
		cvi                              := le.iid.cvi;
		rc_hphonetypeflag                := remap(le.iid.hphonetypeflag,'1');
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_addrvalflag                   := remap(le.iid.addrvalflag,'V');
		rc_lnamecount                    := le.iid.lastcount;
		rc_addrcount                     := le.iid.addrcount;
		rc_ssncount                      := le.iid.socscount;
		rc_numelever                     := le.iid.numelever;
		rc_phoneaddr_addrcount           := le.iid.phoneaddr_addrcount;
		rc_disthphoneaddr                := le.iid.disthphoneaddr;
		rc_phonetype                     := le.iid.phonetype;
		rc_zipclass                      := le.iid.zipclass;
		rc_lnamessnmatch                 := le.iid.lastssnmatch;
		rc_lnamessnmatch2                := le.iid.lastssnmatch2;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		combo_fnamescore                 := le.iid.combo_firstscore;
		combo_addrscore                  := le.iid.combo_addrscore;
		combo_hphonescore                := le.iid.combo_hphonescore;
		combo_ssnscore                   := le.iid.combo_ssnscore;
		combo_dobscore                   := le.iid.combo_dobscore;
		combo_fnamecount                 := le.iid.combo_firstcount;
		combo_lnamecount                 := le.iid.combo_lastcount;
		eq_count                         := le.source_verification.eq_count;
		pr_count                         := le.source_verification.pr_count;
		em_count                         := le.source_verification.em_count;
		vo_count                         := le.source_verification.vo_count;
		fname_eda_sourced_type           := le.name_verification.fname_eda_sourced_type;
		lname_eda_sourced_type           := le.name_verification.lname_eda_sourced_type;
		age                              := le.name_verification.age;
		add1_address_score               := le.address_verification.input_address_information.address_score;
		add1_house_number_match          := le.address_verification.input_address_information.house_number_match;
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
		add1_source_count                := le.address_verification.input_address_information.source_count;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_purchase_amount             := le.address_verification.input_address_information.purchase_amount;
		add1_mortgage_amount             := le.address_verification.input_address_information.mortgage_amount;
		add1_financing_type              := le.address_verification.input_address_information.type_financing;
		add1_assessed_amount             := le.address_verification.input_address_information.assessed_amount;
		add1_building_area               := (string)le.address_verification.input_address_information.building_area;
		add1_no_of_rooms                 := (string)le.address_verification.input_address_information.no_of_rooms;
		add1_no_of_bedrooms              := (string)le.address_verification.input_address_information.no_of_bedrooms;
		add1_parking_no_of_cars          := (string)le.address_verification.input_address_information.parking_no_of_cars;
		property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
		property_owned_assessed_total    := le.address_verification.owned.property_owned_assessed_total;
		property_sold_purchase_total     := le.address_verification.sold.property_owned_purchase_total;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
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
		recent_disconnects               := le.phone_verification.recent_disconnects;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		gong_did_addr_ct                 := le.phone_verification.gong_did.gong_did_addr_ct;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
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
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		addrs_per_ssn_c6                 := le.velocity_counters.addrs_per_ssn_created_6months;
		adls_per_addr_c6                 := le.velocity_counters.adls_per_addr_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		vo_addrs_per_adl                 := le.velocity_counters.vo_addrs_per_adl;
		pl_addrs_per_adl                 := le.velocity_counters.pl_addrs_per_adl;
		invalid_ssns_per_adl             := le.velocity_counters.invalid_ssns_per_adl;
		invalid_addrs_per_adl            := le.velocity_counters.invalid_addrs_per_adl;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		impulse_annual_income            := le.impulse.annual_income;
		attr_addrs_last12                := le.other_address_info.addrs_last12;
		attr_addrs_last24                := le.other_address_info.addrs_last24;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_num_purchase60              := le.other_address_info.num_purchase60;
		attr_num_sold24                  := le.other_address_info.num_sold24;
		attr_num_sold36                  := le.other_address_info.num_sold36;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_felonies60                  := le.bjl.criminal_count60;
		attr_num_unrel_liens90           := le.bjl.liens_unreleased_count90;
		attr_num_unrel_liens12           := le.bjl.liens_unreleased_count12;
		attr_num_unrel_liens24           := le.bjl.liens_unreleased_count24;
		attr_num_unrel_liens36           := le.bjl.liens_unreleased_count36;
		attr_num_unrel_liens60           := le.bjl.liens_unreleased_count60;
		attr_num_rel_liens180            := le.bjl.liens_released_count180;
		attr_num_rel_liens12             := le.bjl.liens_released_count12;
		attr_bankruptcy_count24          := le.bjl.bk_count24;
		attr_bankruptcy_count60          := le.bjl.bk_count60;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_eviction_count180           := le.bjl.eviction_count180;
		attr_eviction_count12            := le.bjl.eviction_count12;
		attr_eviction_count24            := le.bjl.eviction_count24;
		attr_eviction_count36            := le.bjl.eviction_count36;
		attr_eviction_count60            := le.bjl.eviction_count60;
		attr_num_nonderogs               := le.source_verification.num_nonderogs;
		attr_num_nonderogs30             := le.source_verification.num_nonderogs30;
		attr_num_nonderogs180            := le.source_verification.num_nonderogs180;
		attr_num_nonderogs12             := le.source_verification.num_nonderogs12;
		attr_num_nonderogs24             := le.source_verification.num_nonderogs24;
		attr_num_nonderogs36             := le.source_verification.num_nonderogs36;
		attr_num_nonderogs60             := le.source_verification.num_nonderogs60;
		attr_num_proflic60               := le.professional_license.proflic_count60;
		filing_type                      := le.bjl.filing_type;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		bk_disposed_recent_count         := le.bjl.bk_disposed_recent_count;
		bk_disposed_historical_count     := le.bjl.bk_disposed_historical_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_unrel_cj_total_amount      := le.liens.liens_unreleased_civil_judgment.total_amount;
		liens_rel_cj_total_amount        := le.liens.liens_released_civil_judgment.total_amount;
		liens_unrel_lt_ct                := le.liens.liens_unreleased_landlord_tenant.count;
		liens_unrel_ot_ct                := le.liens.liens_unreleased_other_tax.count;
		liens_unrel_ot_total_amount      := le.liens.liens_unreleased_other_tax.total_amount;
		liens_rel_ot_total_amount        := le.liens.liens_released_other_tax.total_amount;
		liens_unrel_sc_total_amount      := le.liens.liens_unreleased_small_claims.total_amount;
		liens_rel_sc_total_amount        := le.liens.liens_released_small_claims.total_amount;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		ams_college_code                 := le.student.college_code;
		ams_college_type                 := le.student.college_type;
		ams_income_level_code            := le.student.income_level_code;
		ams_file_type                    := le.student.file_type;
		ams_college_tier                 := remap(le.student.college_tier,'0'); // NOTE: this model was developed prior to 60298 which introduced blanks; per 2010-10-19 conversation with Eric Graves, a recasting of this field will conform the data to what the model expects
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		input_dob_match_level            := remap(le.dobmatchlevel,'8');
		addr_stability                   := le.mobility_indicator;





		integer NULL := -999999999;

		N0_5 := if(((real)attr_num_unrel_liens12 < 0.5), -1.08325, -0.932121);

		N0_4 := if(((real)add1_lres < 7.5), -1.11106, -1.14285);

		N0_3 := if((liens_unrel_ot_total_amount < 91), N0_4, N0_5);

		N0_2 := if(((real)attr_total_number_derogs < 0.5), -1.16249, -1.13756);

		N0_1 := if(((real)addrs_per_ssn < 5.5), N0_2, N0_3);

		N1_5 := if(((real)ssns_per_adl_c6 < 0.5), 0.0139656, 0.043589);

		N1_4 := if((liens_unrel_ot_total_amount < 154), N1_5, 0.0971765);

		N1_3 := if(((real)attr_num_unrel_liens12 < 0.5), 0.012754, 0.164251);

		N1_2 := if((liens_unrel_ot_total_amount < 133), -0.00224549, N1_3);

		N1_1 := if(((real)addrs_10yr < 5.5), N1_2, N1_4);

		N2_5 := if(((real)attr_num_unrel_liens24 < 0.5), 0.0131973, 0.103569);

		N2_4 := if(((real)attr_addrs_last36 < 2.5), 0.0055328, 0.0458463);

		N2_3 := if(((real)liens_unrel_ot_total_amount < 85.5), N2_4, N2_5);

		N2_2 := if(((real)addrs_per_ssn < 5.5), -0.0517402, 0.00134617);

		N2_1 := if(((real)attr_total_number_derogs < 0.5), N2_2, N2_3);

		N3_5 := if((dist_a2toa3 < 347), 0.033106, 0.0963457);

		N3_4 := if(((real)ssns_per_adl_c6 < 0.5), 0.0130114, N3_5);

		N3_3 := if(((real)add1_lres < 12.5), N3_4, -0.00220604);

		N3_2 := if(((integer)add1_isbestmatch < 0.5), -0.0019675, -0.0194421);

		N3_1 := if(((real)attr_total_number_derogs < 0.5), N3_2, N3_3);

		N4_5 := if(((real)attr_num_unrel_liens12 < 0.5), 0.020239, 0.107576);

		N4_4 := map((prof_license_category in ['0', '1', '2', '5']) => 0.0512927,
					(prof_license_category in ['3', '4'])           => 0.516879,
																	   0.0512927);

		N4_3 := map((disposition in ['Discharged'])                => 0.00161071,
					(disposition in ['Discharge NA', 'Dismissed']) => N4_4,
																	  0.00161071);

		N4_2 := if(((real)addrs_10yr < 8.5), N4_3, 0.0412671);

		N4_1 := if(((real)liens_unrel_ot_total_amount < 85.5), N4_2, N4_5);

		N5_5 := if(((real)avg_lres < 44.5), 0.0389207, 0.128773);

		N5_4 := if(((real)attr_addrs_last36 < 2.5), 0.0256902, N5_5);

		N5_3 := if(((real)dist_a1toa2 < 18.5), 0.00866966, N5_4);

		N5_2 := if(((real)addr_stability < 2.5), N5_3, -0.00729896);

		N5_1 := if(((real)addrs_per_ssn < 3.5), -0.0238758, N5_2);

		N6_5 := if(((real)infutor_nap < 2.5), 0.0498299, -0.0137301);

		N6_4 := if(((real)add1_lres < 5.5), N6_5, 0.00112696);

		N6_3 := if(((real)attr_num_unrel_liens24 < 0.5), -0.0084398, 0.0686766);

		N6_2 := if((liens_unrel_ot_total_amount < 196), -0.00247629, N6_3);

		N6_1 := if(((real)addrs_15yr < 8.5), N6_2, N6_4);

		N7_5 := if(((real)liens_unrel_ot_total_amount < 149.5), 0.0045743, 0.0342055);

		N7_4 := if(((real)addrs_per_ssn_c6 < 0.5), N7_5, 0.042687);

		N7_3 := if(((real)addrs_per_ssn_c6 < 0.5), 0.000958448, 0.0324832);

		N7_2 := if(((real)dist_a1toa2 < 8.5), -0.0111091, N7_3);

		N7_1 := if(((real)attr_num_unrel_liens36 < 0.5), N7_2, N7_4);

		N8_5 := map((ams_income_level_code in ['A', 'B', 'C', 'E', 'G', 'H', 'J', 'K']) => 0.0537161,
					(ams_income_level_code in ['D', 'F', 'I'])                          => 0.265419,
																						   0.0537161);

		N8_4 := map((ams_income_level_code in ['A', 'C', 'D', 'E', 'G', 'I', 'J']) => 0.00874595,
					(ams_income_level_code in ['B', 'F', 'H', 'K'])                => 0.0475126,
																					  0.00874595);

		N8_3 := if(((real)attr_addrs_last12 < 2.5), N8_4, 0.0614172);

		N8_2 := if(((real)liens_unrel_cj_total_amount < 8934.5), N8_3, N8_5);

		N8_1 := if(((real)addrs_10yr < 4.5), -0.00432411, N8_2);

		N9_6 := if(((real)dist_a2toa3 < 19.5), 0.0113779, 0.0603704);

		N9_5 := map((ams_income_level_code in ['A', 'B', 'F', 'H', 'I', 'J']) => N9_6,
					(ams_income_level_code in ['C', 'D', 'E', 'G', 'K'])      => 0.0977307,
																				 N9_6);

		N9_4 := if(((real)liens_unrel_cj_total_amount < 1614.5), 0.00543122, N9_5);

		N9_3 := if(((integer)add1_avm_market_total_value < 41682), 0.0622099, 0.00824992);

		N9_2 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', N9_3, N9_4);

		N9_1 := if(((real)addrs_10yr < 4.5), -0.00733686, N9_2);

		N10_5 := if(((real)addrs_10yr < 8.5), 0.0342055, 0.085861);

		N10_4 := if(((real)add1_lres < 2.5), N10_5, 0.00676169);

		N10_3 := if(((real)attr_num_unrel_liens60 < 2.5), -0.00211048, 0.0274787);

		N10_2 := if(((real)dist_a1toa2 < 25.5), N10_3, N10_4);

		N10_1 := if(((real)addrs_per_ssn < 3.5), -0.0189373, N10_2);

		N11_5 := if(((real)adls_per_addr_c6 < 0.5), 0.0193213, 0.0601967);

		N11_4 := if(((real)attr_addrs_last12 < 0.5), 0.0126202, N11_5);

		N11_3 := if(((real)add1_lres < 0.5), N11_4, 0.00356354);

		N11_2 := if(((real)age < 40.5), N11_3, -0.0060628);

		N11_1 := if(((real)addrs_15yr < 3.5), -0.0134979, N11_2);

		N12_5 := if(((real)felony_count < 0.5), 0.0179843, 0.0653975);

		N12_4 := if(((real)ssns_per_addr < 27.5), N12_5, 0.0843987);

		N12_3 := if(((real)addrs_per_ssn < 4.5), -0.00542641, N12_4);

		N12_2 := if(((real)add1_lres < 3.5), N12_3, -0.000930331);

		N12_1 := if(((real)addrs_15yr < 4.5), -0.008418, N12_2);

		N13_5 := if(((real)attr_num_unrel_liens60 < 0.5), -0.00575976, 0.00612186);

		N13_4 := if(((real)dist_a1toa2 < 102.5), N13_5, 0.0198477);

		N13_3 := if(((real)dist_a1toa2 < 16.5), -0.0172995, 0.0571049);

		N13_2 := if(((real)avg_lres < 84.5), -0.031835, N13_3);

		N13_1 := if(((real)addrs_per_ssn < 2.5), N13_2, N13_4);

		N14_5 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '5', '7', '9', 'A', 'U']) => -0.00726412,
					 (rc_hphonetypeflag in ['6'])                                         => 0.676809,
																							 -0.00726412);

		N14_4 := if(((real)attr_addrs_last24 < 2.5), 0.0143241, 0.0529005);

		N14_3 := if(((real)dist_a1toa3 < 11.5), 0.00250019, N14_4);

		N14_2 := if(((real)addrs_per_ssn < 2.5), -0.0192535, N14_3);

		N14_1 := if(((integer)add1_isbestmatch < 0.5), N14_2, N14_5);

		N15_5 := if(((real)attr_num_unrel_liens12 < 0.5), 0.0211517, 0.0643567);

		N15_4 := if(((real)dist_a2toa3 < 3.5), 0.00414542, 0.0304563);

		N15_3 := if(((real)max_lres < 48.5), -0.00396792, N15_4);

		N15_2 := if(((real)addr_stability < 1.5), N15_3, -0.00317257);

		N15_1 := if((liens_unrel_ot_total_amount < 223), N15_2, N15_5);

		N16_5 := if((add1_avm_med_geo12 < 30401), 0.0110523, 0.0635781);

		N16_4 := if(((real)pr_count < 0.5), N16_5, -0.0102813);

		N16_3 := map((ams_income_level_code in ['A', 'C', 'D', 'E', 'G', 'H', 'I', 'J', 'K']) => 0.0044393,
					 (ams_income_level_code in ['B', 'F'])                                    => 0.0501799,
																								 0.0044393);

		N16_2 := if(((real)add1_lres < 2.5), N16_3, -0.00677963);

		N16_1 := if((liens_unrel_ot_total_amount < 75), N16_2, N16_4);

		N17_5 := if(((real)pl_addrs_per_adl < 0.5), 0.0122057, 0.0680697);

		N17_4 := if(((real)combo_fnamecount < 3.5), 0.0637927, -0.00274776);

		N17_3 := if(((integer)rc_lnamessnmatch2 < 0.5), -0.0188747, -3.95178e-005);

		N17_2 := if(((real)liens_unrel_ot_ct < 0.5), N17_3, N17_4);

		N17_1 := if(((real)attr_total_number_derogs < 2.5), N17_2, N17_5);

		N18_5 := if(((integer)add1_isbestmatch < 0.5), 0.0636072, -0.0096989);

		N18_4 := map((ams_college_type in ['P', 'R']) => 0.00564641,
					 (ams_college_type in ['S'])      => 0.0592095,
														 0.00564641);

		N18_3 := if(((real)attr_addrs_last12 < 1.5), N18_4, N18_5);

		N18_2 := if((property_owned_assessed_total < 3563), 0.001228, -0.0194714);

		N18_1 := if(((real)attr_total_number_derogs < 1.5), N18_2, N18_3);

		N19_5 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'G', 'H', 'I', 'J']) => 0.038042,
					 (ams_income_level_code in ['F', 'K'])                                    => 0.187976,
																								 0.038042);

		N19_4 := if(((real)addrs_15yr < 4.5), 0.00129158, N19_5);

		N19_3 := if(((real)avg_lres < 36.5), -0.00105252, N19_4);

		N19_2 := if(((real)criminal_count < 0.5), N19_3, 0.05877);

		N19_1 := if(((real)addrs_per_ssn_c6 < 0.5), 1.60617e-005, N19_2);

		N20_5 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '5', '7', '9', 'A', 'U']) => -0.00545543,
					 (rc_hphonetypeflag in ['6'])                                         => 0.341923,
																							 -0.00545543);

		N20_4 := if(((real)nas_summary < 9.5), 0.00641435, N20_5);

		N20_3 := if((impulse_annual_income < 19822), N20_4, 0.0301371);

		N20_2 := if((add1_mortgage_amount < 466000), N20_3, 0.0637495);

		N20_1 := if(((real)felony_count < 0.5), N20_2, 0.0305458);

		N21_5 := if(((real)dist_a1toa2 < 427.5), 0.0130986, 0.0484909);

		N21_4 := if(((real)age < 44.5), N21_5, -0.00530211);

		N21_3 := if(((real)attr_num_nonderogs24 < 1.5), N21_4, -0.00251301);

		N21_2 := if(((real)liens_unrel_ot_total_amount < 85.5), N21_3, 0.0220761);

		N21_1 := if(((real)age < 26.5), -0.0118492, N21_2);

		N22_5 := map((input_dob_match_level in ['0', '1', '2', '3', '6', '7', '8']) => 0.0333431,
					 (input_dob_match_level in ['4', '5'])                          => 0.282871,
																					   0.0333431);

		N22_4 := if(((real)eq_count < 35.5), 0.0451997, -0.0189836);

		N22_3 := if(((real)attr_num_nonderogs36 < 1.5), N22_4, 0.00778843);

		N22_2 := if(((real)addrs_per_ssn < 10.5), 0.00161639, N22_3);

		N22_1 := if(((real)invalid_ssns_per_adl < 0.5), N22_2, N22_5);

		N23_5 := if(((real)liens_rel_cj_total_amount < 1902.5), 0.00222471, 0.0588857);

		N23_4 := map((prof_license_category in ['1', '2', '4', '5']) => -0.0189853,
					 (prof_license_category in ['0', '3'])           => 0.19363,
																		-0.0189853);

		N23_3 := if(((real)age < 41.5), 0.00108998, N23_4);

		N23_2 := if(((real)phones_per_adl < 0.5), N23_3, -0.0219982);

		N23_1 := if(((real)dist_a1toa2 < 2.5), N23_2, N23_5);

		N24_5 := if((liens_unrel_sc_total_amount < 540), -0.0199556, 0.0463011);

		N24_4 := if(((real)dist_a2toa3 < 114.5), 0.0146683, 0.0526534);

		N24_3 := if(((real)bk_disposed_historical_count < 0.5), N24_4, -0.0173066);

		N24_2 := if(((real)addrs_per_ssn < 12.5), 0.000367221, N24_3);

		N24_1 := if(((real)rc_pwssnvalflag < 0.5), N24_2, N24_5);

		N25_5 := if(((real)addrs_per_ssn < 12.5), 0.0073153, 0.0476157);

		N25_4 := if(((real)ssns_per_addr < 27.5), N25_5, 0.063405);

		N25_3 := if(((integer)add1_building_area < 18399), -0.00371793, 0.060653);

		N25_2 := if((add1_avm_med_fips < 171580), N25_3, N25_4);

		N25_1 := if(((real)felony_count < 0.5), N25_2, 0.0290391);

		N26_5 := map((ams_college_tier in ['0', '1', '3', '4', '5', '6']) => -0.00499811,
					 (ams_college_tier in ['2'])                          => 0.542529,
																			 -0.00499811);

		N26_4 := if(((real)attr_addrs_last36 < 0.5), -0.005444, 0.0166008);

		N26_3 := if(((real)addrs_per_adl < 0.5), 0.0366508, -0.00672516);

		N26_2 := if(((real)avg_lres < 31.5), N26_3, N26_4);

		N26_1 := if(((real)addr_stability < 2.5), N26_2, N26_5);

		N27_6 := if((liens_unrel_cj_total_amount < 468), 0.00847363, -0.0354038);

		N27_5 := if(((real)liens_unrel_cj_total_amount < 1242.5), N27_6, 0.0265296);

		N27_4 := if(((real)add1_avm_assessed_total_value < 59459.5), 0.0110617, -0.0127836);

		N27_3 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N27_4, -0.00193123);

		N27_2 := if(((real)ssns_per_addr_c6 < 0.5), N27_3, N27_5);

		N27_1 := if(((real)add1_no_of_bedrooms < 5.5), N27_2, 0.0603467);

		N28_5 := if(((real)gong_did_first_ct < 0.5), 0.00293552, 0.0795489);

		N28_4 := if(((real)add1_source_count < 1.5), N28_5, -0.00127397);

		N28_3 := if(((real)add1_building_area < 3604.5), 0.000148185, 0.0320692);

		N28_2 := map((rc_hphonetypeflag in ['3', '5', 'A'])                     => -0.0121924,
					 (rc_hphonetypeflag in ['0', '1', '2', '6', '7', '9', 'U']) => N28_3,
																				   N28_3);

		N28_1 := map((add1_financing_type in ['CNV'])        => N28_2,
					 (add1_financing_type in ['ADJ', 'OTH']) => N28_4,
																N28_2);

		N29_6 := if(((real)rc_ssncount < 1.5), -0.00607158, 0.0101805);

		N29_5 := if(((real)liens_unrel_sc_total_amount < 323.5), -0.00207797, 0.0314773);

		N29_4 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N29_5, N29_6);

		N29_3 := map((ams_college_tier in ['0', '2', '3', '4', '5', '6']) => N29_4,
					 (ams_college_tier in ['1'])                          => 0.410792,
																			 N29_4);

		N29_2 := if(((real)liens_rel_ot_total_amount < 197.5), N29_3, 0.0317396);

		N29_1 := if((impulse_annual_income < 17850), N29_2, 0.0272152);

		N30_5 := map((input_dob_match_level in ['0', '1', '2', '4', '6']) => -0.0134135,
					 (input_dob_match_level in ['3', '5', '7', '8'])      => 0.0209098,
																			 -0.0134135);

		N30_4 := map((ams_income_level_code in ['D', 'E', 'G'])                          => N30_5,
					 (ams_income_level_code in ['A', 'B', 'C', 'F', 'H', 'I', 'J', 'K']) => 0.0695416,
																							N30_5);

		N30_3 := if((add1_avm_med_fips < 131502), 0.000386406, N30_4);

		N30_2 := if(((real)gong_did_first_ct < 2.5), -0.00428332, 0.0426233);

		N30_1 := if(((real)attr_num_unrel_liens60 < 0.5), N30_2, N30_3);

		N31_5 := if(((real)attr_num_nonderogs < 1.5), 0.0714632, 0.0193416);

		N31_4 := if((add1_avm_price_index_valuation < 10028), N31_5, -0.0181097);

		N31_3 := if(((real)eq_count < 15.5), 0.00356617, -0.00764421);

		N31_2 := if(((real)addrs_per_ssn < 12.5), N31_3, N31_4);

		N31_1 := map((disposition in ['Discharge NA', 'Discharged']) => -0.0180009,
					 (disposition in ['Dismissed'])                  => N31_2,
																		N31_2);

		N32_6 := if((dist_a1toa3 < 611), 0.0550123, -0.00975304);

		N32_5 := if(((real)add1_avm_sales_price < 33826.5), 0.074903, 0.0028519);

		N32_4 := if(trim(ADD1_AVM_SALES_PRICE) != '', N32_5, 0.00422423);

		N32_3 := if(((real)criminal_count < 0.5), N32_4, N32_6);

		N32_2 := if(((real)dist_a1toa2 < 32.5), -0.00117868, N32_3);

		N32_1 := if(((real)attr_num_rel_liens180 < 0.5), N32_2, 0.0543364);

		N33_5 := map((ams_income_level_code in ['A', 'C', 'D', 'E', 'F', 'G', 'I', 'J']) => 0.0212103,
					 (ams_income_level_code in ['B', 'H', 'K'])                          => 0.155419,
																							0.0212103);

		N33_4 := if((liens_unrel_ot_total_amount < 653), -0.000563419, N33_5);

		N33_3 := if(((real)attr_num_sold36 < 0.5), N33_4, 0.0543762);

		N33_2 := if(((real)pr_count < 2.5), N33_3, -0.0198296);

		N33_1 := if(((real)attr_num_unrel_liens24 < 4.5), N33_2, 0.0461893);

		N34_5 := if(((real)vo_addrs_per_adl < 3.5), 0.00157485, 0.0524738);

		N34_4 := if(((real)gong_did_addr_ct < 1.5), N34_5, -0.00714639);

		N34_3 := map((ams_college_tier in ['0', '2', '3', '4', '5', '6']) => N34_4,
					 (ams_college_tier in ['1'])                          => 0.154767,
																			 N34_4);

		N34_2 := if((impulse_annual_income < 27342), N34_3, 0.0418975);

		N34_1 := if(((real)add1_unit_count < 235.5), N34_2, 0.0197317);

		N35_5 := if(((real)eq_count < 33.5), 0.0179843, -0.00601979);

		N35_4 := if(((real)max_lres < 31.5), -0.0270494, -0.00226353);

		N35_3 := if(((real)age < 25.5), N35_4, 0.0027545);

		N35_2 := if(((real)infutor_nap < 6.5), N35_3, -0.0194317);

		N35_1 := if(((real)addrs_per_ssn < 10.5), N35_2, N35_5);

		N36_5 := map((ams_income_level_code in ['A', 'D', 'G', 'H', 'I', 'J']) => -0.0109025,
					 (ams_income_level_code in ['B', 'C', 'E', 'F', 'K'])      => 0.0409979,
																				  -0.0109025);

		N36_4 := if(((real)adlperssn_count < 1.5), 0.00216821, 0.0257329);

		N36_3 := if(((real)attr_num_nonderogs12 < 1.5), N36_4, N36_5);

		N36_2 := if(((real)addrs_per_ssn < 9.5), -0.00485715, N36_3);

		N36_1 := if((liens_unrel_ot_total_amount < 1420), N36_2, 0.0355482);

		N37_5 := if(((real)criminal_count < 1.5), 0.0128472, 0.060673);

		N37_4 := if((add1_avm_med_fips < 325521), N37_5, 0.0732362);

		N37_3 := if(((real)avg_lres < 23.5), -0.00352686, N37_4);

		N37_2 := if(((real)addr_stability < 1.5), N37_3, -0.000226581);

		N37_1 := if(((real)dist_a1toa2 < 0.5), -0.00658716, N37_2);

		N38_5 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'G', 'H', 'I']) => 0.036546,
					 (ams_income_level_code in ['F', 'J', 'K'])                          => 0.186903,
																							0.036546);

		N38_4 := if(((real)adls_per_addr < 19.5), 0.0127983, N38_5);

		N38_3 := if(((real)gong_did_addr_ct < 2.5), N38_4, -0.0103871);

		N38_2 := if(((real)addrs_per_ssn < 3.5), -0.00959296, N38_3);

		N38_1 := if(((integer)add1_house_number_match < 0.5), N38_2, -0.00412215);

		N39_5 := if((add1_avm_med_fips < 144250), 0.0102653, 0.0572195);

		N39_4 := if(((real)infutor_nap < 6.5), 0.00257191, -0.0137585);

		N39_3 := if(((real)eq_count < 25.5), N39_4, -0.0118956);

		N39_2 := if(((real)criminal_count < 1.5), N39_3, N39_5);

		N39_1 := if((add1_purchase_amount < 104800), N39_2, -0.0204702);

		N40_5 := map((lname_eda_sourced_type in ['A', 'AP']) => 0.0443842,
					 (lname_eda_sourced_type in ['P'])       => 0.275479,
																0.0443842);

		N40_4 := if(((real)add1_lres < 16.5), N40_5, 0.00603747);

		N40_3 := map((rc_addrvalflag in ['M', 'V']) => 0.0226776,
					 (rc_addrvalflag in ['N'])      => 0.216555,
													   0.0226776);

		N40_2 := if(((real)invalid_ssns_per_adl < 0.5), -0.000712719, N40_3);

		N40_1 := map((disposition in ['Discharge NA', 'Discharged']) => N40_2,
					 (disposition in ['Dismissed'])                  => N40_4,
																		N40_2);

		N41_5 := map((input_dob_match_level in ['0', '1', '2', '4', '6', '8']) => 0.0249907,
					 (input_dob_match_level in ['3', '5', '7'])                => 0.136725,
																				  0.0249907);

		N41_4 := if(((real)rc_numelever < 3.5), -0.00442076, N41_5);

		N41_3 := if(((real)dist_a1toa2 < 91.5), 0.00121758, N41_4);

		N41_2 := if((cvi < 35), N41_3, -0.00561219);

		N41_1 := if(((real)attr_num_unrel_liens24 < 3.5), N41_2, 0.0300641);

		N42_5 := map((input_dob_match_level in ['0', '1', '2', '4', '5', '6', '7', '8']) => -0.0112352,
					 (input_dob_match_level in ['3'])                                    => 0.271944,
																							-0.0112352);

		N42_4 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'I', 'K']) => -0.00705592,
					 (ams_income_level_code in ['F', 'G', 'H', 'J'])                => 0.00515267,
																					   0.00515267);

		N42_3 := if(((real)age < 50.5), N42_4, N42_5);

		N42_2 := map((input_dob_match_level in ['5', '7'])                          => -0.0263027,
					 (input_dob_match_level in ['0', '1', '2', '3', '4', '6', '8']) => N42_3,
																					   N42_3);

		N42_1 := if((combo_dobscore < 65), 0.0524088, N42_2);

		N43_5 := if(((real)liens_unrel_lt_ct < 0.5), 0.0100038, 0.0557699);

		N43_4 := if((impulse_annual_income < 26940), -0.00247251, 0.0386506);

		N43_3 := if(((real)dist_a1toa3 < 105.5), N43_4, N43_5);

		N43_2 := if(((real)avg_lres < 55.5), -0.0179646, 0.018212);

		N43_1 := if(((real)age < 25.5), N43_2, N43_3);

		N44_5 := if(((real)liens_unrel_lt_ct < 1.5), 0.00716399, 0.0502316);

		N44_4 := if(((real)dist_a1toa3 < 1.5), -0.00676967, N44_5);

		N44_3 := if(((real)avg_lres < 117.5), -0.00695412, 0.0204318);

		N44_2 := if(((real)attr_eviction_count60 < 2.5), N44_3, -0.0345481);

		N44_1 := if(((real)adls_per_addr < 6.5), N44_2, N44_4);

		N45_5 := if(((real)add1_lres < 4.5), 0.0473565, 0.000674377);

		N45_4 := map((rc_zipclass in [''])       => N45_5,
					 (rc_zipclass in ['P', 'U']) => 0.304285,
													N45_5);

		N45_3 := map((disposition in ['Discharge NA', 'Discharged']) => 0.00609122,
					 (disposition in ['Dismissed'])                  => N45_4,
																		0.00609122);

		N45_2 := if(((real)age < 25.5), -0.00678169, N45_3);

		N45_1 := if(((real)phones_per_adl < 0.5), N45_2, -0.00729879);

		N46_5 := map((prof_license_category in ['2', '3'])           => 0.0141652,
					 (prof_license_category in ['0', '1', '4', '5']) => 0.0820961,
																		0.0141652);

		N46_4 := map((ams_college_tier in ['0', '1', '2', '4', '6']) => -0.0183299,
					 (ams_college_tier in ['3', '5'])                => 0.0978437,
																		-0.0183299);

		N46_3 := if(((real)gong_did_last_ct < 1.5), 0.00196334, N46_4);

		N46_2 := if(((real)max_lres < 149.5), N46_3, -0.014638);

		N46_1 := if(((real)rc_lnamecount < 5.5), N46_2, N46_5);

		N47_5 := if(((real)filing_count < 1.5), -0.00834291, 0.0378625);

		N47_4 := map((ams_file_type in ['C', 'M']) => N47_5,
					 (ams_file_type in ['H'])      => 0.12638,
													  N47_5);

		N47_3 := if(((real)age < 25.5), -0.00559743, 0.00780842);

		N47_2 := if(((real)age < 39.5), N47_3, N47_4);

		N47_1 := if(((real)attr_eviction_count36 < 2.5), N47_2, -0.0263478);

		N48_5 := if(((real)avg_lres < 24.5), -0.00514183, 0.0406301);

		N48_4 := map((input_dob_match_level in ['1', '2', '3', '5', '6', '7', '8']) => N48_5,
					 (input_dob_match_level in ['0', '4'])                          => 0.153236,
																					   N48_5);

		N48_3 := if(((real)em_count < 5.5), -0.000269664, -0.0347335);

		N48_2 := if(((real)attr_num_rel_liens12 < 0.5), N48_3, 0.032986);

		N48_1 := if(((real)addrs_10yr < 10.5), N48_2, N48_4);

		N49_7 := map((prof_license_category in ['1', '2', '3', '4', '5']) => -0.00194442,
					 (prof_license_category in ['0'])                     => 0.0908286,
																			 -0.00194442);

		N49_6 := map((input_dob_match_level in ['7', '8'])                          => 0.0311722,
					 (input_dob_match_level in ['0', '1', '2', '3', '4', '5', '6']) => 0.433067,
																					   0.433067);

		N49_5 := if(((real)rc_lnamecount < 5.5), 0.00344013, N49_6);

		N49_4 := map((rc_addrvalflag in ['N', 'V']) => N49_5,
					 (rc_addrvalflag in ['M'])      => 0.526487,
													   N49_5);

		N49_3 := map((ams_college_type in ['P', 'S']) => N49_4,
					 (ams_college_type in ['R'])      => 0.822561,
														 N49_4);

		N49_2 := if((add1_mortgage_amount < 89175), N49_3, -0.0178938);

		N49_1 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N49_2, N49_7);

		N50_5 := if(((real)ssns_per_adl < 1.5), -0.0182705, 0.067576);

		N50_4 := if(((real)attr_addrs_last24 < 0.5), N50_5, 0.0590246);

		N50_3 := if(((real)combo_lnamecount < 3.5), 0.00691504, N50_4);

		N50_2 := if(((real)liens_unrel_lt_ct < 0.5), N50_3, -0.024466);

		N50_1 := if(((real)attr_num_nonderogs60 < 1.5), N50_2, -0.00314671);

		N51_5 := if(((real)addrs_per_ssn < 6.5), -0.00708731, 0.0522093);

		N51_4 := if((add1_avm_med_geo11 < 101607), 0.014627, 0.0617603);

		N51_3 := map((filing_type in [''])  => -0.00014098,
					 (filing_type in ['I']) => N51_4,
											   -0.00014098);

		N51_2 := map((disposition in ['Discharge NA', 'Discharged']) => -0.0160336,
					 (disposition in ['Dismissed'])                  => N51_3,
																		N51_3);

		N51_1 := if((liens_unrel_cj_total_amount < 11011), N51_2, N51_5);

		N52_5 := if(((real)attr_num_unrel_liens24 < 0.5), 0.0317446, -0.00643107);

		N52_4 := if(((real)add1_lres < 0.5), N52_5, 0.00125173);

		N52_3 := if(((real)attr_addrs_last12 < 0.5), 0.00218389, N52_4);

		N52_2 := if(((real)avg_lres < 15.5), -0.0134413, N52_3);

		N52_1 := if(((real)age < 41.5), N52_2, -0.006074);

		N53_5 := if(((real)avg_lres < 95.5), 0.0116831, 0.0682959);

		N53_4 := if(((real)felony_count < 0.5), 0.000813358, N53_5);

		N53_3 := if(((real)addrs_10yr < 9.5), N53_4, 0.0359549);

		N53_2 := if(((real)eq_count < 19.5), N53_3, -0.006835);

		N53_1 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '5', '7', '9', 'A', 'U']) => N53_2,
					 (rc_hphonetypeflag in ['6'])                                         => 0.177012,
																							 N53_2);

		N54_8 := if(((real)adls_per_addr < 8.5), -0.0358172, 0.0202022);

		N54_7 := if(((integer)add1_avm_assessed_total_value < 34108), 0.000163517, 0.0463512);

		N54_6 := if((add1_avm_med_fips < 106689), N54_7, 0.0657798);

		N54_5 := if((add1_avm_med_fips < 121939), N54_6, -0.00385058);

		N54_4 := if(((real)addrs_10yr < 1.5), -0.0190661, N54_5);

		N54_3 := if(((real)add1_avm_assessed_total_value < 65151.5), N54_4, -0.0152254);

		N54_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N54_3, N54_8);

		N54_1 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', N54_2, 0.00251618);

		N55_6 := if(((real)liens_historical_unreleased_ct < 0.5), 0.0108067, 0.0506133);

		N55_5 := if(((real)felony_count < 0.5), -0.000247879, N55_6);

		N55_4 := map((ams_income_level_code in ['C', 'D', 'F', 'I', 'K'])      => -0.0345502,
					 (ams_income_level_code in ['A', 'B', 'E', 'G', 'H', 'J']) => 0.0313646,
																				  0.0313646);

		N55_3 := if(((integer)add1_avm_assessed_total_value < 16417), N55_4, -1.82245e-006);

		N55_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N55_3, N55_5);

		N55_1 := map((disposition in ['Discharge NA', 'Discharged']) => -0.0136837,
					 (disposition in ['Dismissed'])                  => N55_2,
																		N55_2);

		N56_5 := if(((real)avg_lres < 46.5), 0.0197246, 0.0841328);

		N56_4 := if(((real)addrs_15yr < 3.5), -0.025316, N56_5);

		N56_3 := if((combo_addrscore < 16), N56_4, 0.00385542);

		N56_2 := if(((real)addrs_per_ssn_c6 < 0.5), -0.00278049, N56_3);

		N56_1 := if((liens_unrel_ot_total_amount < 147), N56_2, 0.0169829);

		N57_6 := if(((real)add1_avm_confidence_score < 84.5), -0.00244378, 0.0515981);

		N57_5 := map((rc_hphonetypeflag in ['0', '1', '3', '5', 'A', 'U']) => N57_6,
					 (rc_hphonetypeflag in ['2', '6', '7', '9'])           => 0.148207,
																			  N57_6);

		N57_4 := map((ams_income_level_code in ['A', 'C', 'D', 'F', 'G', 'H', 'J', 'K']) => 0.0179959,
					 (ams_income_level_code in ['B', 'E', 'I'])                          => 0.159051,
																							0.0179959);

		N57_3 := if((liens_unrel_cj_total_amount < 694), -0.00175677, N57_4);

		N57_2 := if(trim(ADD1_AVM_SALES_PRICE) != '', N57_3, N57_5);

		N57_1 := if(((real)attr_num_unrel_liens36 < 5.5), N57_2, 0.0428916);

		N58_5 := map((ams_college_tier in ['0', '3', '4', '5', '6']) => -0.00693244,
					 (ams_college_tier in ['1', '2'])                => 0.194133,
																		-0.00693244);

		N58_4 := if(((real)gong_did_phone_ct < 0.5), -0.00193692, 0.0659625);

		N58_3 := if(((real)rc_pwphonezipflag < 0.5), 0.00163234, N58_4);

		N58_2 := if(((real)eq_count < 13.5), N58_3, N58_5);

		N58_1 := if(((real)attr_bankruptcy_count60 < 1.5), N58_2, 0.0438444);

		N59_5 := map((ams_income_level_code in ['A', 'B', 'D', 'E', 'F', 'H', 'I', 'J', 'K']) => -0.0421255,
					 (ams_income_level_code in ['C', 'G'])                                    => 0.0212828,
																								 0.0212828);

		N59_4 := map((ams_income_level_code in ['A', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']) => N59_5,
					 (ams_income_level_code in ['B', 'K'])                                    => 0.166248,
																								 N59_5);

		N59_3 := if(((real)liens_unrel_ot_total_amount < 321.5), 0.00112655, N59_4);

		N59_2 := if(((integer)rc_lnamessnmatch2 < 0.5), -0.013804, N59_3);

		N59_1 := if((property_sold_assessed_total < 117150), N59_2, -0.0443918);

		N60_5 := map((input_dob_match_level in ['0', '1', '2', '4', '5', '8']) => -0.0208886,
					 (input_dob_match_level in ['3', '6', '7'])                => 0.13337,
																				  -0.0208886);

		N60_4 := map((disposition in ['Discharge NA', 'Discharged']) => 0.0114838,
					 (disposition in ['Dismissed'])                  => 0.0649417,
																		0.0114838);

		N60_3 := if(((real)liens_unrel_cj_ct < 4.5), N60_4, N60_5);

		N60_2 := map((prof_license_category in ['1', '2', '3', '5']) => N60_3,
					 (prof_license_category in ['0', '4'])           => 0.103106,
																		N60_3);

		N60_1 := if(((real)liens_unrel_cj_total_amount < 902.5), -0.00145877, N60_2);

		N61_5 := if(((real)attr_eviction_count24 < 0.5), 0.00671552, 0.04028);

		N61_4 := if(((real)attr_eviction_count24 < 2.5), -0.00192318, -0.0317939);

		N61_3 := if((add1_avm_hedonic_valuation < 299750), N61_4, 0.058314);

		N61_2 := if(((real)dist_a1toa3 < 105.5), N61_3, N61_5);

		N61_1 := if((liens_unrel_ot_total_amount < 1037), N61_2, -0.0220631);

		N62_5 := map((ams_income_level_code in ['A', 'B', 'D', 'E', 'F', 'H', 'I', 'J', 'K']) => -0.0157743,
					 (ams_income_level_code in ['C', 'G'])                                    => 0.0400766,
																								 -0.0157743);

		N62_4 := if(((real)attr_bankruptcy_count60 < 1.5), -0.00139306, 0.0368335);

		N62_3 := if(((real)adls_per_phone < 1.5), N62_4, 0.0258928);

		N62_2 := if((add1_mortgage_amount < 26350), N62_3, N62_5);

		N62_1 := if((add1_avm_price_index_valuation < 383339), N62_2, 0.062254);

		N63_5 := if(((real)adls_per_addr < 12.5), 0.0665027, -0.000892707);

		N63_4 := map((add1_financing_type in ['ADJ', 'OTH']) => N63_5,
					 (add1_financing_type in ['CNV'])        => 0.212081,
																N63_5);

		N63_3 := if((add1_avm_med_geo11 < 91971), 0.0125638, N63_4);

		N63_2 := if(((real)impulse_count < 1.5), N63_3, -0.0221407);

		N63_1 := if(((real)impulse_count < 0.5), 9.19187e-005, N63_2);

		N64_5 := if(((integer)add1_building_area < 745), 0.081352, 0.0210368);

		N64_4 := if(((real)dist_a1toa2 < 504.5), N64_5, -0.0358846);

		N64_3 := if((add1_avm_automated_valuation < 121494), N64_4, -0.00156754);

		N64_2 := if(((real)add1_avm_automated_valuation < 85775.5), -0.00334101, N64_3);

		N64_1 := if(((real)attr_addrs_last12 < 2.5), N64_2, 0.0274964);

		N65_5 := if(((real)wealth_index < 2.5), 0.00407625, 0.0595939);

		N65_4 := if((dist_a2toa3 < 292), N65_5, -0.0188031);

		N65_3 := if(trim(RC_PHONETYPE) != '', N65_4, 0.331083);

		N65_2 := if((add1_avm_med_geo11 < 461467), -0.00117156, 0.0580947);

		N65_1 := if(((integer)add1_building_area < 3624), N65_2, N65_3);

		N66_5 := map((rc_addrvalflag in ['N', 'V']) => 0.0237867,
					 (rc_addrvalflag in ['M'])      => 0.697403,
													   0.0237867);

		N66_4 := if((dist_a1toa2 < 1452), -0.000232376, 0.0353994);

		N66_3 := if(((real)addrs_per_ssn < 3.5), -0.0112933, N66_4);

		N66_2 := if(((real)avg_lres < 159.5), N66_3, N66_5);

		N66_1 := if(((real)avg_lres < 1.5), 0.0316329, N66_2);

		N67_5 := map((prof_license_category in ['0', '3', '4', '5']) => -0.0296779,
					 (prof_license_category in ['1', '2'])           => 0.129896,
																		-0.0296779);

		N67_4 := if(((real)phones_per_addr < 37.5), 0.000226375, -0.0419476);

		N67_3 := if(((real)attr_total_number_derogs < 10.5), N67_4, 0.0327275);

		N67_2 := if((property_sold_assessed_total < 37750), N67_3, N67_5);

		N67_1 := if(((real)ssns_per_adl < 4.5), N67_2, 0.0386351);

		N68_6 := if(((real)attr_eviction_count < 3.5), -0.00867331, -0.0352752);

		N68_5 := if((add1_avm_med_fips < 320937), 0.00133209, 0.0245205);

		N68_4 := if(((integer)rc_lnamessnmatch < 0.5), -0.0140206, N68_5);

		N68_3 := if(((integer)add1_avm_sales_price < 14022), 0.051526, 1.78394e-005);

		N68_2 := if(trim(ADD1_AVM_SALES_PRICE) != '', N68_3, N68_4);

		N68_1 := if(((real)gong_did_addr_ct < 2.5), N68_2, N68_6);

		N69_5 := if((combo_addrscore < 5), 0.0348233, 0.00315867);

		N69_4 := if(((real)addrs_15yr < 2.5), -0.00929566, N69_5);

		N69_3 := if(((real)liens_unrel_sc_total_amount < 5062.5), N69_4, 0.0418103);

		N69_2 := if(((real)liens_historical_unreleased_ct < 7.5), N69_3, -0.0325745);

		N69_1 := if(((real)attr_num_rel_liens12 < 0.5), N69_2, 0.0360983);

		N70_5 := map((input_dob_match_level in ['0', '2', '3', '4', '5', '7', '8']) => 0.02372,
					 (input_dob_match_level in ['1', '6'])                          => 0.29796,
																					   0.02372);

		N70_4 := map((ams_college_tier in ['0', '1', '2', '3', '5']) => -0.0278291,
					 (ams_college_tier in ['4', '6'])                => 0.0765869,
																		-0.0278291);

		N70_3 := if(((real)dist_a1toa2 < 5.5), -0.00702653, 0.00230893);

		N70_2 := if(((real)pr_count < 2.5), N70_3, N70_4);

		N70_1 := if((liens_unrel_sc_total_amount < 4381), N70_2, N70_5);

		N71_5 := map((fname_eda_sourced_type in ['AP', 'P']) => 0.0125449,
					 (fname_eda_sourced_type in ['A'])       => 0.0868871,
																0.0125449);

		N71_4 := if(((real)avg_lres < 44.5), -0.00336623, 0.011703);

		N71_3 := if((cvi < 35), N71_4, -0.0042001);

		N71_2 := if(((real)invalid_ssns_per_adl < 0.5), N71_3, N71_5);

		N71_1 := if(((real)attr_total_number_derogs < 7.5), N71_2, -0.024254);

		N72_5 := if(trim(RC_PHONETYPE) != '', -0.0305799, 0.230872);

		N72_4 := if(((real)add1_avm_confidence_score < 48.5), 0.0448011, 0.0114012);

		N72_3 := map((prof_license_category in ['0', '1', '3', '4', '5']) => N72_4,
					 (prof_license_category in ['2'])                     => 0.167752,
																			 N72_4);

		N72_2 := if((add1_purchase_amount < 97750), N72_3, N72_5);

		N72_1 := if(((real)add1_parking_no_of_cars < 1.5), -0.000555886, N72_2);

		N73_5 := map((disposition in ['Discharge NA', 'Discharged']) => 0.0333025,
					 (disposition in ['Dismissed'])                  => 0.155276,
																		0.0333025);

		N73_4 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'H', 'I', 'J', 'K']) => -0.0287574,
					 (ams_income_level_code in ['E', 'F', 'G'])                          => 0.0977052,
																							-0.0287574);

		N73_3 := if((combo_fnamescore < 95), 0.0228995, -0.000516672);

		N73_2 := if(((real)attr_eviction_count12 < 1.5), N73_3, N73_4);

		N73_1 := if(((real)adls_per_addr < 32.5), N73_2, N73_5);

		N74_6 := if(((real)dist_a1toa2 < 16.5), 0.00874781, 0.0411239);

		N74_5 := map((ams_income_level_code in ['A', 'B', 'E', 'F', 'G', 'H', 'J']) => N74_6,
					 (ams_income_level_code in ['C', 'D', 'I', 'K'])                => 0.0886615,
																					   N74_6);

		N74_4 := if(((real)addrs_5yr < 1.5), -0.0055141, N74_5);

		N74_3 := if(((real)ssns_per_addr < 18.5), -0.00296879, N74_4);

		N74_2 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', -5.82198e-005, N74_3);

		N74_1 := map((rc_hphonetypeflag in ['0', '1', '3', '5', '6', 'A', 'U']) => N74_2,
					 (rc_hphonetypeflag in ['2', '7', '9'])                     => 0.116822,
																				   N74_2);

		N75_5 := if(((real)max_lres < 54.5), -0.0115422, 0.0780189);

		N75_4 := if(((real)dist_a1toa3 < 13.5), 0.0082831, 0.0556242);

		N75_3 := if((liens_unrel_cj_total_amount < 8613), -0.0013784, N75_4);

		N75_2 := if((liens_unrel_sc_total_amount < 1190), N75_3, -0.0172337);

		N75_1 := if((add1_mortgage_amount < 293668), N75_2, N75_5);

		N76_5 := map((ams_income_level_code in ['A', 'B', 'D', 'E', 'G', 'H', 'I', 'J']) => -0.00972887,
					 (ams_income_level_code in ['C', 'F', 'K'])                          => 0.0624957,
																							-0.00972887);

		N76_4 := if(((real)attr_total_number_derogs < 0.5), 0.0253098, N76_5);

		N76_3 := if(((real)max_lres < 117.5), N76_4, 0.053187);

		N76_2 := if(((real)attr_num_nonderogs < 3.5), -0.000114021, -0.0122274);

		N76_1 := if(((real)addrs_5yr < 4.5), N76_2, N76_3);

		N77_6 := if(((real)liens_historical_unreleased_ct < 1.5), -0.013135, -0.0559964);

		N77_5 := map((fname_eda_sourced_type in [''])             => N77_6,
					 (fname_eda_sourced_type in ['A', 'AP', 'P']) => 0.0886729,
																	 N77_6);

		N77_4 := if(((real)attr_num_unrel_liens24 < 2.5), 0.00232615, N77_5);

		N77_3 := map((ams_college_tier in ['0', '6'])                => -0.0285013,
					 (ams_college_tier in ['1', '2', '3', '4', '5']) => 0.020545,
																		0.020545);

		N77_2 := if(trim(AMS_COLLEGE_CODE) != '', N77_3, N77_4);

		N77_1 := if(((real)attr_num_nonderogs30 < 1.5), N77_2, -0.0101087);

		N78_6 := if(((real)vo_count < 2.5), -0.00876998, -0.0458589);

		N78_5 := map((disposition in ['Discharge NA', 'Discharged']) => -0.0471389,
					 (disposition in ['Dismissed'])                  => 0.0368769,
																		0.0368769);

		N78_4 := if(((real)add1_avm_price_index_valuation < 32788.5), N78_5, N78_6);

		N78_3 := if(trim(ADD1_AVM_SALES_PRICE) != '', N78_4, -0.00789303);

		N78_2 := map((ams_income_level_code in ['A', 'C', 'D', 'E', 'F', 'I', 'J', 'K']) => 0.000777985,
					 (ams_income_level_code in ['B', 'G', 'H'])                          => 0.0428856,
																							0.000777985);

		N78_1 := if(((real)attr_num_nonderogs < 2.5), N78_2, N78_3);

		N79_5 := map((prof_license_category in ['0', '1', '2', '3', '5']) => -0.0186424,
					 (prof_license_category in ['4'])                     => 0.146838,
																			 -0.0186424);

		N79_4 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'H', 'I', 'J', 'K']) => N79_5,
					 (ams_income_level_code in ['G'])                                              => 0.133484,
																									  N79_5);

		N79_3 := if(((integer)rc_lnamessnmatch2 < 0.5), -0.0135717, 0.00185738);

		N79_2 := if(((real)attr_num_unrel_liens36 < 2.5), N79_3, N79_4);

		N79_1 := if(((real)bk_recent_count < 0.5), N79_2, 0.0448426);

		N80_5 := if(((real)dist_a1toa3 < 18.5), 0.0528827, -0.00169233);

		N80_4 := if(((real)avg_lres < 63.5), N80_5, -0.0105288);

		N80_3 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J']) => N80_4,
					 (ams_income_level_code in ['K'])                                              => 0.216928,
																									  N80_4);

		N80_2 := if(((real)adls_per_addr < 25.5), 0.0033829, N80_3);

		N80_1 := if(((integer)add1_applicant_owned < 0.5), N80_2, -0.0148196);

		N81_5 := if((add1_assessed_amount < 398825), -0.00286533, 0.0487281);

		N81_4 := if(((real)age < 35.5), 0.00866835, N81_5);

		N81_3 := if(((real)avg_lres < 21.5), -0.00853947, N81_4);

		N81_2 := if(((real)eq_count < 50.5), N81_3, 0.0367505);

		N81_1 := if(((real)attr_bankruptcy_count60 < 1.5), N81_2, 0.0360571);

		N82_5 := if(((real)attr_addrs_last12 < 0.5), -0.00335174, -0.0424946);

		N82_4 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'F', 'G', 'H', 'I', 'J', 'K']) => N82_5,
					 (ams_income_level_code in ['E'])                                              => 0.106903,
																									  N82_5);

		N82_3 := if((liens_rel_sc_total_amount < 483), 0.000602344, -0.0367396);

		N82_2 := if(((real)attr_num_unrel_liens90 < 0.5), N82_3, 0.0300035);

		N82_1 := if(((real)attr_eviction_count180 < 0.5), N82_2, N82_4);

		N83_5 := if(((real)addrs_per_ssn < 8.5), -0.00378363, 0.0283253);

		N83_4 := if(((real)liens_unrel_cj_ct < 1.5), N83_5, -0.0253848);

		N83_3 := if(((real)age < 29.5), 0.0305011, N83_4);

		N83_2 := if(((real)criminal_count < 0.5), -0.000520758, N83_3);

		N83_1 := map((input_dob_match_level in ['1', '2'])                          => -0.0317076,
					 (input_dob_match_level in ['0', '3', '4', '5', '6', '7', '8']) => N83_2,
																					   N83_2);

		N84_5 := map((ams_college_tier in ['0', '3'])                => 0.02385,
					 (ams_college_tier in ['1', '2', '4', '5', '6']) => 0.250329,
																		0.250329);

		N84_4 := map((prof_license_category in ['0', '1', '2', '3', '5']) => N84_5,
					 (prof_license_category in ['4'])                     => 0.295159,
																			 N84_5);

		N84_3 := map((ams_college_type in ['R', 'S']) => -0.0133645,
					 (ams_college_type in ['P'])      => 0.310345,
														 -0.0133645);

		N84_2 := if(((real)gong_did_last_ct < 1.5), 0.00230921, N84_3);

		N84_1 := if(((real)liens_unrel_lt_ct < 1.5), N84_2, N84_4);

		N85_5 := if(((real)add1_lres < 33.5), 0.00101193, 0.0852648);

		N85_4 := if((add1_avm_hedonic_valuation < 120539), -0.00778978, N85_5);

		N85_3 := if(((real)dist_a1toa2 < 1.5), N85_4, 0.00297356);

		N85_2 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '5', '9', 'A', 'U']) => -0.0163961,
					 (rc_hphonetypeflag in ['6', '7'])                               => 0.151195,
																						-0.0163961);

		N85_1 := map((ams_income_level_code in ['A', 'E', 'G', 'H', 'I', 'J']) => N85_2,
					 (ams_income_level_code in ['B', 'C', 'D', 'F', 'K'])      => N85_3,
																				  N85_3);

		N86_5 := if((combo_hphonescore < 45), 0.0152552, -0.025511);

		N86_4 := if(((real)addrs_per_adl < 3.5), -0.00228898, 0.0746545);

		N86_3 := map((ams_college_tier in ['0', '1', '2', '3', '4', '6']) => N86_4,
					 (ams_college_tier in ['5'])                          => 0.2749,
																			 N86_4);

		N86_2 := if(((real)combo_fnamescore < 82.5), N86_3, -0.000609756);

		N86_1 := if((add1_assessed_amount < 162360), N86_2, N86_5);

		N87_5 := map((input_dob_match_level in ['0', '2', '5', '8'])      => 0.00605243,
					 (input_dob_match_level in ['1', '3', '4', '6', '7']) => 0.058749,
																			 0.058749);

		N87_4 := map((prof_license_category in ['1', '5'])           => N87_5,
					 (prof_license_category in ['0', '2', '3', '4']) => 0.105997,
																		N87_5);

		N87_3 := if(((real)ssns_per_adl < 2.5), -0.0224978, 0.0263879);

		N87_2 := if(((real)rc_pwssnvalflag < 0.5), -0.000352001, N87_3);

		N87_1 := if(((real)max_lres < 152.5), N87_2, N87_4);

		N88_5 := if(((real)add1_avm_med_fips < 79448.5), 0.048546, 0.00599749);

		N88_4 := if(((real)add1_unit_count < 29.5), -0.00547944, N88_5);

		N88_3 := map((ams_income_level_code in ['A', 'B', 'H', 'J'])                => N88_4,
					 (ams_income_level_code in ['C', 'D', 'E', 'F', 'G', 'I', 'K']) => 0.0166487,
																					   N88_4);

		N88_2 := if(((real)rc_disthphoneaddr < 2.5), 0.024076, N88_3);

		N88_1 := if(((real)attr_addrs_last24 < 0.5), -0.00404429, N88_2);

		N89_5 := map((input_dob_match_level in ['0', '1', '2', '4', '6', '7', '8']) => -0.00280267,
					 (input_dob_match_level in ['3', '5'])                          => 0.226238,
																					   -0.00280267);

		N89_4 := if(((real)add1_avm_med_geo11 < 70058.5), -0.0301105, N89_5);

		N89_3 := if(((real)attr_eviction_count24 < 0.5), 0.002731, N89_4);

		N89_2 := if((add1_avm_tax_assessed_valuation < 117206), N89_3, -0.0138439);

		N89_1 := if((liens_rel_cj_total_amount < 783), N89_2, -0.0274821);

		N90_6 := map((rc_addrvalflag in ['M', 'V']) => -0.00118831,
					 (rc_addrvalflag in ['N'])      => 0.269208,
													   -0.00118831);

		N90_5 := if(((real)max_lres < 83.5), 0.0462187, N90_6);

		N90_4 := if(((real)gong_did_first_ct < 2.5), -0.00124092, 0.0408769);

		N90_3 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', 0.00337923, N90_4);

		N90_2 := if(((real)attr_bankruptcy_count24 < 0.5), N90_3, N90_5);

		N90_1 := if(((real)age < 25.5), -0.0114416, N90_2);

		N91_5 := if(((integer)rc_lnamessnmatch2 < 0.5), -0.0363654, 0.025214);

		N91_4 := map((input_dob_match_level in ['2', '6', '8'])                => -0.000210658,
					 (input_dob_match_level in ['0', '1', '3', '4', '5', '7']) => N91_5,
																				  N91_5);

		N91_3 := if(((real)attr_num_sold24 < 0.5), N91_4, 0.0447092);

		N91_2 := if((property_sold_purchase_total < 89975), N91_3, -0.0267301);

		N91_1 := if(((real)age < 25.5), -0.0138706, N91_2);

		N92_5 := if(((real)add1_unit_count < 9.5), 0.0148387, 0.0719411);

		N92_4 := if(((real)gong_did_addr_ct < 2.5), 0.00349472, N92_5);

		N92_3 := if(((real)add1_no_of_rooms < 7.5), -0.0029786, 0.0348694);

		N92_2 := if(((real)wealth_index < 2.5), N92_3, N92_4);

		N92_1 := map((ams_income_level_code in ['A', 'E', 'G', 'H', 'J', 'K']) => -0.0171049,
					 (ams_income_level_code in ['B', 'C', 'D', 'F', 'I'])      => N92_2,
																				  N92_2);

		N93_5 := map((ams_college_tier in ['0', '1', '2', '4', '5', '6']) => 0.0293538,
					 (ams_college_tier in ['3'])                          => 0.26196,
																			 0.0293538);

		N93_4 := if(((real)dist_a1toa3 < 5.5), -0.00244708, N93_5);

		N93_3 := map((ams_income_level_code in ['A', 'B', 'D', 'E', 'F', 'G', 'H', 'J']) => -0.0023983,
					 (ams_income_level_code in ['C', 'I', 'K'])                          => N93_4,
																							-0.0023983);

		N93_2 := if(((real)invalid_addrs_per_adl < 7.5), N93_3, 0.0410222);

		N93_1 := if((add1_lres < 229), N93_2, 0.0727841);

		N94_7 := if(((real)pl_addrs_per_adl < 1.5), -0.000317619, 0.0321105);

		N94_6 := if(((real)criminal_count < 2.5), N94_7, -0.030511);

		N94_5 := if(((real)liens_rel_ot_total_amount < 467.5), N94_6, -0.0298721);

		N94_4 := map((ams_income_level_code in ['B', 'C', 'D', 'F', 'J'])      => -0.0342203,
					 (ams_income_level_code in ['A', 'E', 'G', 'H', 'I', 'K']) => 0.0107701,
																				  0.0107701);

		N94_3 := map((ams_college_tier in ['0', '1', '3', '4', '5', '6']) => -0.013346,
					 (ams_college_tier in ['2'])                          => 0.190305,
																			 -0.013346);

		N94_2 := if(((integer)add1_avm_sales_price < 82950), N94_3, N94_4);

		N94_1 := if(trim(ADD1_AVM_SALES_PRICE) != '', N94_2, N94_5);

		N95_5 := if(((real)attr_num_nonderogs < 2.5), 0.0248138, -0.00366653);

		N95_4 := if(((integer)rc_lnamessnmatch2 < 0.5), 0.0643534, N95_5);

		N95_3 := if(((real)adls_per_addr < 17.5), N95_4, -0.0126249);

		N95_2 := if((add1_avm_med_fips < 189896), -0.000295287, N95_3);

		N95_1 := if((add1_avm_hedonic_valuation < 173140), N95_2, -0.0221107);

		N96_5 := map((add1_financing_type in ['CNV'])        => -0.00179159,
					 (add1_financing_type in ['ADJ', 'OTH']) => 0.0877721,
																-0.00179159);

		N96_4 := map((lname_eda_sourced_type in ['A', 'AP']) => 0.0329078,
					 (lname_eda_sourced_type in ['P'])       => 0.372351,
																0.0329078);

		N96_3 := if((liens_unrel_cj_total_amount < 4793), N96_4, N96_5);

		N96_2 := map((ams_income_level_code in ['A', 'B', 'E', 'F', 'G', 'H']) => N96_3,
					 (ams_income_level_code in ['C', 'D', 'I', 'J', 'K'])      => 0.075402,
																				  N96_3);

		N96_1 := if(((real)liens_unrel_cj_total_amount < 3795.5), -0.00139068, N96_2);

		N97_5 := map((ams_college_tier in ['0', '1', '2', '5', '6']) => -0.00649976,
					 (ams_college_tier in ['3', '4'])                => 0.196194,
																		-0.00649976);

		N97_4 := if(((real)addrs_10yr < 4.5), 0.0255085, N97_5);

		N97_3 := if(((real)attr_addrs_last36 < 2.5), -0.00431963, 0.00846279);

		N97_2 := if(((real)criminal_count < 0.5), N97_3, N97_4);

		N97_1 := if(((real)liens_unrel_ot_total_amount < 1182.5), N97_2, 0.0246465);

		N98_5 := if(((real)combo_lnamecount < 5.5), 0.00928403, 0.0681442);

		N98_4 := map((prof_license_category in ['3', '5'])           => 0.0225195,
					 (prof_license_category in ['0', '1', '2', '4']) => 0.115754,
																		0.0225195);

		N98_3 := map((ams_income_level_code in ['A', 'B', 'D', 'E', 'H', 'J', 'K']) => 0.00388068,
					 (ams_income_level_code in ['C', 'F', 'G', 'I'])                => N98_4,
																					   0.00388068);

		N98_2 := if(((real)addrs_per_ssn < 6.5), -0.00237135, N98_3);

		N98_1 := if(((real)bk_disposed_recent_count < 0.5), N98_2, N98_5);

		N99_5 := if(((real)add1_building_area < 1354.5), 0.0265076, -0.0206095);

		N99_4 := if(((real)addrs_per_ssn_c6 < 0.5), -0.00226567, 0.0110646);

		N99_3 := if(((real)addrs_per_ssn < 12.5), N99_4, N99_5);

		N99_2 := if(((real)eq_count < 30.5), N99_3, -0.0152571);

		N99_1 := if((add1_avm_hedonic_valuation < 304000), N99_2, 0.0544255);

		N100_5 := map((prof_license_category in ['1', '3', '4', '5']) => -0.00787289,
					  (prof_license_category in ['0', '2'])           => 0.162447,
																		 -0.00787289);

		N100_4 := if((add2_add3_score < 15), -0.0382447, N100_5);

		N100_3 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'G', 'H', 'I', 'J']) => N100_4,
					  (ams_income_level_code in ['E', 'F', 'K'])                          => 0.0642377,
																							 N100_4);

		N100_2 := if((add1_avm_price_index_valuation < 149420), -0.00120618, 0.0188082);

		N100_1 := if(((real)attr_num_unrel_liens60 < 3.5), N100_2, N100_3);

		N101_5 := if((liens_unrel_cj_total_amount < 3920), -0.000368568, 0.0349084);

		N101_4 := if((add1_avm_med_geo11 < 67950), -0.0163217, N101_5);

		N101_3 := if(((real)add1_avm_hedonic_valuation < 94562.5), N101_4, -0.0365446);

		N101_2 := if(((real)attr_num_rel_liens12 < 0.5), 0.00277641, 0.0303838);

		N101_1 := if(((real)gong_did_phone_ct < 2.5), N101_2, N101_3);

		N102_5 := if(((real)combo_lnamecount < 3.5), 0.0284416, -0.0117039);

		N102_4 := if(((real)attr_addrs_last12 < 1.5), -0.00262276, N102_5);

		N102_3 := if((add1_avm_med_geo12 < 399672), N102_4, -0.0374591);

		N102_2 := if(((real)liens_unrel_cj_total_amount < 16164.5), N102_3, 0.0399718);

		N102_1 := if(((real)attr_num_rel_liens180 < 0.5), N102_2, 0.0451906);

		N103_5 := if(((real)rc_ssncount < 1.5), 0.0107017, 0.0478426);

		N103_4 := if(trim(AMS_COLLEGE_CODE) != '', -0.0789249, N103_5);

		N103_3 := map((ams_income_level_code in ['A', 'B', 'D', 'G', 'J', 'K']) => N103_4,
					  (ams_income_level_code in ['C', 'E', 'F', 'H', 'I'])      => 0.0748922,
																				   N103_4);

		N103_2 := if(((real)attr_num_unrel_liens60 < 0.5), 0.00431393, N103_3);

		N103_1 := if(((real)dist_a2toa3 < 348.5), -0.00219016, N103_2);

		N104_5 := if((combo_fnamescore < 82), 0.0478071, 0.00224433);

		N104_4 := if(((real)rc_pwssnvalflag < 0.5), N104_5, -0.0128579);

		N104_3 := if(((real)liens_historical_unreleased_ct < 4.5), N104_4, -0.0383936);

		N104_2 := if(((real)liens_historical_unreleased_ct < 6.5), N104_3, 0.0363509);

		N104_1 := if(((real)attr_eviction_count36 < 1.5), N104_2, -0.0139621);

		N105_7 := map((ams_college_tier in ['2', '3', '6'])      => -0.0351005,
					  (ams_college_tier in ['0', '1', '4', '5']) => 0.00114516,
																	0.00114516);

		N105_6 := if(((real)ssns_per_addr < 7.5), 0.013612, -0.0184284);

		N105_5 := if((add1_add3_score < 65), 0.00824131, 0.0670586);

		N105_4 := if(((real)dist_a1toa3 < 17.5), N105_5, N105_6);

		N105_3 := if(((real)add1_avm_assessed_total_value < 9588.5), -0.0240379, N105_4);

		N105_2 := if(((real)gong_did_addr_ct < 4.5), N105_3, -0.043197);

		N105_1 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N105_2, N105_7);

		N106_5 := map((prof_license_category in ['0', '1', '2', '4', '5']) => 0.0168283,
					  (prof_license_category in ['3'])                     => 0.549876,
																			  0.0168283);

		N106_4 := if(((real)recent_disconnects < 0.5), 0.00119224, N106_5);

		N106_3 := if(((real)attr_num_unrel_liens24 < 3.5), N106_4, 0.0327065);

		N106_2 := map((ams_income_level_code in ['G', 'I', 'J', 'K'])                => -0.0247347,
					  (ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'H']) => N106_3,
																						N106_3);

		N106_1 := if((add1_avm_price_index_valuation < 180713), N106_2, -0.0246184);

		N107_5 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'G', 'H', 'I', 'J', 'K']) => 0.0300953,
					  (ams_income_level_code in ['F'])                                              => 0.170694,
																									   0.0300953);

		N107_4 := map((disposition in ['Discharged'])                => -0.0576543,
					  (disposition in ['Discharge NA', 'Dismissed']) => N107_5,
																		N107_5);

		N107_3 := if(((real)ssns_per_adl_c6 < 0.5), -0.00227855, 0.00606897);

		N107_2 := map((rc_hphonetypeflag in ['0', '1', '3', '5', '6', '7', '9', 'A', 'U']) => N107_3,
					  (rc_hphonetypeflag in ['2'])                                         => 0.129581,
																							  N107_3);

		N107_1 := if((add1_mortgage_amount < 194707), N107_2, N107_4);

		N108_5 := map((add1_financing_type in ['ADJ', 'CNV']) => -0.020525,
					  (add1_financing_type in ['OTH'])        => 0.357142,
																 -0.020525);

		N108_4 := if((add1_avm_med_geo11 < 212750), 0.0717026, 0.0090257);

		N108_3 := if((add1_avm_med_fips < 359284), 0.000698712, N108_4);

		N108_2 := if(((real)pr_count < 2.5), N108_3, N108_5);

		N108_1 := map((rc_hphonetypeflag in ['0', '1', '2', '3', '5', '6', 'A', 'U']) => N108_2,
					  (rc_hphonetypeflag in ['7', '9'])                               => 0.201665,
																						 N108_2);

		N109_5 := if((add1_add2_score < 15), 0.0535403, 0.00781928);

		N109_4 := if(((real)attr_num_nonderogs36 < 2.5), 0.00383462, N109_5);

		N109_3 := if(((real)dist_a1toa3 < 13.5), -0.00225901, N109_4);

		N109_2 := if(((real)liens_unrel_ot_total_amount < 1252.5), N109_3, -0.0253889);

		N109_1 := if(((real)add1_no_of_bedrooms < 5.5), N109_2, 0.0515926);

		N110_7 := if(((real)add1_unit_count < 378.5), -0.00179568, 0.0193208);

		N110_6 := if(((real)adls_per_addr < 33.5), N110_7, 0.0373051);

		N110_5 := map((prof_license_category in ['0', '1', '4', '5']) => 0.00849749,
					  (prof_license_category in ['2', '3'])           => 0.199257,
																		 0.00849749);

		N110_4 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'F', 'I', 'J', 'K']) => N110_5,
					  (ams_income_level_code in ['G', 'H'])                                    => 0.3831,
																								  N110_5);

		N110_3 := if((add1_address_score < 16), 0.0500519, N110_4);

		N110_2 := if(((real)add1_avm_tax_assessed_valuation < 29724.5), N110_3, -0.00482295);

		N110_1 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N110_2, N110_6);

		N111_5 := if(((real)avg_lres < 52.5), 0.00173951, 0.0241683);

		N111_4 := if(((real)attr_addrs_last24 < 1.5), -0.00128945, N111_5);

		N111_3 := if(((real)gong_did_phone_ct < 6.5), N111_4, -0.0306111);

		N111_2 := if(((real)attr_addrs_last12 < 2.5), N111_3, -0.0260469);

		N111_1 := if(((real)phones_per_addr < 35.5), N111_2, -0.0462855);

		N112_5 := map((input_dob_match_level in ['0', '4', '5'])                => -0.0437477,
					  (input_dob_match_level in ['1', '2', '3', '6', '7', '8']) => 0.0500572,
																				   0.0500572);

		N112_4 := if(((real)addrs_per_ssn < 5.5), 0.0106809, N112_5);

		N112_3 := map((ams_income_level_code in ['C', 'E', 'H', 'J'])                => -0.0362776,
					  (ams_income_level_code in ['A', 'B', 'D', 'F', 'G', 'I', 'K']) => N112_4,
																						N112_4);

		N112_2 := if(((real)vo_count < 1.5), 0.000833961, -0.0109978);

		N112_1 := if(((real)attr_felonies60 < 0.5), N112_2, N112_3);

		N113_5 := if(((real)dist_a1toa2 < 0.5), 0.0455076, -0.0177644);

		N113_4 := if((add1_avm_med_geo12 < 138279), 0.0197199, N113_5);

		N113_3 := if(((real)addrs_10yr < 8.5), N113_4, 0.0490639);

		N113_2 := map((rc_hphonetypeflag in ['0', '1', '2', '5', '6', '7', 'A']) => -0.00274648,
					  (rc_hphonetypeflag in ['3', '9', 'U'])                     => 0.0107142,
																					-0.00274648);

		N113_1 := if((add1_assessed_amount < 98995), N113_2, N113_3);

		N114_5 := if(((real)add1_parking_no_of_cars < 1.5), 0.000334998, 0.0123914);

		N114_4 := if((add1_avm_price_index_valuation < 227728), N114_5, -0.0234935);

		N114_3 := map((rc_hphonetypeflag in ['7', '9'])                               => -0.0729825,
					  (rc_hphonetypeflag in ['0', '1', '2', '3', '5', '6', 'A', 'U']) => N114_4,
																						 N114_4);

		N114_2 := if(((real)liens_unrel_ot_total_amount < 594.5), N114_3, -0.0282008);

		N114_1 := if(((real)liens_unrel_ot_total_amount < 1336.5), N114_2, 0.0209182);

		N115_5 := if(((real)add1_avm_confidence_score < 52.5), -0.0115292, 0.0363407);

		N115_4 := if(((real)gong_did_phone_ct < 6.5), 0.00311876, 0.054382);

		N115_3 := if(((real)phones_per_addr < 5.5), N115_4, N115_5);

		N115_2 := if(((real)attr_num_purchase60 < 0.5), N115_3, -0.0158429);

		N115_1 := if(((integer)rc_fnamessnmatch < 0.5), -0.0186832, N115_2);

		N116_5 := if(((real)eq_count < 16.5), 0.0206014, 0.00100585);

		N116_4 := if(((real)attr_num_nonderogs180 < 1.5), N116_5, -0.00313108);

		N116_3 := if(((real)infutor_nap < 6.5), N116_4, -0.0129372);

		N116_2 := if(((real)max_lres < 26.5), -0.0113406, N116_3);

		N116_1 := if(((real)attr_addrs_last24 < 0.5), -0.00465494, N116_2);

		N117_5 := map((prof_license_category in ['1', '2', '3', '5']) => 0.0265474,
					  (prof_license_category in ['0', '4'])           => 0.464837,
																		 0.0265474);

		N117_4 := if(((real)phones_per_addr < 7.5), 0.0042535, N117_5);

		N117_3 := if(((real)attr_num_nonderogs12 < 1.5), -0.00234623, N117_4);

		N117_2 := if(((real)addrs_15yr < 15.5), N117_3, -0.0272778);

		N117_1 := if(((real)liens_unrel_ot_total_amount < 1139.5), N117_2, 0.0218622);

		N118_5 := if(((real)addrs_10yr < 9.5), -0.00494726, 0.0300754);

		N118_4 := map((disposition in ['Discharge NA', 'Discharged']) => 0.00148137,
					  (disposition in ['Dismissed'])                  => 0.0323017,
																		 0.00148137);

		N118_3 := if((liens_unrel_ot_total_amount < 25), N118_4, 0.0217748);

		N118_2 := if(((real)gong_did_first_ct < 2.5), N118_3, 0.0411814);

		N118_1 := if(((real)max_lres < 75.5), N118_2, N118_5);

		N119_5 := if(((real)attr_num_unrel_liens36 < 0.5), 0.014521, 0.0654697);

		N119_4 := map((input_dob_match_level in ['0', '2', '3', '4', '6', '7', '8']) => N119_5,
					  (input_dob_match_level in ['1', '5'])                          => 0.200648,
																						N119_5);

		N119_3 := if((add1_assessed_amount < 65229), N119_4, -0.0113064);

		N119_2 := if((property_owned_purchase_total < 40750), -0.0033047, N119_3);

		N119_1 := if((liens_unrel_sc_total_amount < 3591), N119_2, 0.0225974);

		N120_5 := map((ams_college_tier in ['0', '1', '4', '5', '6']) => 0.00750446,
					  (ams_college_tier in ['2', '3'])                => 0.1349,
																		 0.00750446);

		N120_4 := if(((real)attr_num_proflic60 < 1.5), -0.00580202, 0.0425112);

		N120_3 := if(((real)avg_lres < 78.5), N120_4, N120_5);

		N120_2 := if((add1_avm_med_fips < 174570), N120_3, 0.00897793);

		N120_1 := map((add1_financing_type in ['CNV'])        => -0.0432081,
					  (add1_financing_type in ['ADJ', 'OTH']) => N120_2,
																 N120_2);

		N121_5 := if((add1_avm_med_geo12 < 110998), 0.0557724, -0.010003);

		N121_4 := map((ams_income_level_code in ['A', 'C', 'E', 'F', 'G', 'H', 'I', 'K']) => N121_5,
					  (ams_income_level_code in ['B', 'D', 'J'])                          => 0.208158,
																							 N121_5);

		N121_3 := map((fname_eda_sourced_type in ['A', 'AP']) => N121_4,
					  (fname_eda_sourced_type in ['P'])       => 0.271977,
																 N121_4);

		N121_2 := if(((real)eq_count < 12.5), N121_3, -0.00956417);

		N121_1 := map((input_dob_match_level in ['0', '1', '2', '4', '6', '8']) => -0.00108769,
					  (input_dob_match_level in ['3', '5', '7'])                => N121_2,
																				   -0.00108769);

		N122_5 := if(((real)ssns_per_addr < 18.5), 0.0313306, -0.0194324);

		N122_4 := map((ams_income_level_code in ['A', 'B', 'D', 'F', 'G', 'H', 'I', 'J', 'K']) => N122_5,
					  (ams_income_level_code in ['C', 'E'])                                    => 0.0962233,
																								  N122_5);

		N122_3 := if((dist_a1toa3 < 786), N122_4, -0.0273747);

		N122_2 := if(((real)addr_stability < 1.5), N122_3, 0.00113474);

		N122_1 := if(((real)add1_avm_hedonic_valuation < 48909.5), -0.00372342, N122_2);

		N123_7 := if(((real)rc_lnamecount < 3.5), 0.0734822, 0.0166599);

		N123_6 := if(((real)addrs_10yr < 5.5), 0.00794549, N123_7);

		N123_5 := if(((real)rc_phoneaddr_addrcount < 0.5), -0.00562434, 0.00687749);

		N123_4 := map((prof_license_category in ['0', '1', '3', '5']) => 0.0265237,
					  (prof_license_category in ['2', '4'])           => 0.32803,
																		 0.0265237);

		N123_3 := if(((real)add1_unit_count < 0.5), N123_4, N123_5);

		N123_2 := map((ams_income_level_code in ['A', 'C', 'E', 'G', 'H', 'J']) => N123_3,
					  (ams_income_level_code in ['B', 'D', 'F', 'I', 'K'])      => N123_6,
																				   N123_3);

		N123_1 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', 0.00225904, N123_2);

		N124_5 := if(((real)invalid_addrs_per_adl < 5.5), -0.00337876, 0.0316482);

		N124_4 := map((rc_hphonetypeflag in ['0', '1', '3', '5', '6', '7', '9', 'U']) => N124_5,
					  (rc_hphonetypeflag in ['2', 'A'])                               => 0.346506,
																						 N124_5);

		N124_3 := if((cvi < 25), -0.0163727, N124_4);

		N124_2 := map((input_dob_match_level in ['0', '1', '3', '4', '5', '6', '7', '8']) => 0.00219688,
					  (input_dob_match_level in ['2'])                                    => 0.251823,
																							 0.00219688);

		N124_1 := if(((real)addrs_per_adl < 8.5), N124_2, N124_3);

		N125_5 := if(((real)addrs_15yr < 9.5), 0.00726886, 0.0415364);

		N125_4 := map((ams_college_tier in ['0', '1', '2', '4', '5', '6']) => N125_5,
					  (ams_college_tier in ['3'])                          => 0.179245,
																			  N125_5);

		N125_3 := if(((real)em_count < 4.5), -0.0010772, N125_4);

		N125_2 := if((liens_unrel_sc_total_amount < 5111), N125_3, 0.0288462);

		N125_1 := if(((real)eq_count < 51.5), N125_2, 0.0412301);

		N126_5 := map((lname_eda_sourced_type in ['A', 'AP']) => 0.0185271,
					  (lname_eda_sourced_type in ['P'])       => 0.265345,
																 0.0185271);

		N126_4 := map((prof_license_category in ['0', '1', '2', '3', '5']) => -0.023214,
					  (prof_license_category in ['4'])                     => 0.149619,
																			  -0.023214);

		N126_3 := if(((real)combo_fnamecount < 5.5), 0.00188001, N126_4);

		N126_2 := if(((real)addrs_10yr < 10.5), N126_3, N126_5);

		N126_1 := if(((real)age < 38.5), N126_2, -0.00674594);

		N127_5 := if(((real)avg_lres < 41.5), 0.0283275, -0.0278722);

		N127_4 := if(((real)attr_addrs_last12 < 0.5), N127_5, -0.0432085);

		N127_3 := if((property_owned_assessed_total < 108154), N127_4, 0.033913);

		N127_2 := if(((real)attr_num_nonderogs60 < 3.5), -1.60234e-005, N127_3);

		N127_1 := if((add1_avm_price_index_valuation < 366912), N127_2, 0.0540137);

		N128_6 := if((add1_assessed_amount < 6250), 0.0759672, 0.0119753);

		N128_5 := if(((real)add1_avm_assessed_total_value < 16305.5), N128_6, -0.00118466);

		N128_4 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N128_5, 0.00343752);

		N128_3 := if(((real)addrs_10yr < 10.5), N128_4, -0.0274366);

		N128_2 := if(((real)attr_eviction_count < 1.5), N128_3, -0.0115757);

		N128_1 := if(((real)liens_unrel_ot_total_amount < 1960.5), N128_2, -0.0337487);

		N129_5 := if(((real)dist_a1toa3 < 16.5), -0.00268959, 0.0119499);

		N129_4 := map((ams_income_level_code in ['B', 'F'])                                    => -0.0381542,
					  (ams_income_level_code in ['A', 'C', 'D', 'E', 'G', 'H', 'I', 'J', 'K']) => N129_5,
																								  N129_5);

		N129_3 := map((prof_license_category in ['1', '2', '3', '4', '5']) => 0.0136275,
					  (prof_license_category in ['0'])                     => 0.190435,
																			  0.0136275);

		N129_2 := if(((real)max_lres < 79.5), N129_3, N129_4);

		N129_1 := if(((real)avg_lres < 41.5), -0.00458072, N129_2);

		N130_5 := if(((real)avg_lres < 64.5), 0.0242913, -0.0338932);

		N130_4 := if(((real)adlperssn_count < 1.5), N130_5, 0.0435165);

		N130_3 := map((prof_license_category in ['2', '3'])           => N130_4,
					  (prof_license_category in ['0', '1', '4', '5']) => 0.157089,
																		 N130_4);

		N130_2 := if(((real)attr_bankruptcy_count24 < 0.5), -0.00045354, N130_3);

		N130_1 := if(((real)phones_per_adl < 1.5), N130_2, -0.0206751);

		N131_7 := if(((real)add1_lres < 104.5), 0.00476891, -0.0197793);

		N131_6 := if((add1_avm_tax_assessed_valuation < 284685), N131_7, -0.0410558);

		N131_5 := if(((real)liens_unrel_cj_ct < 1.5), -0.00461613, -0.0257487);

		N131_4 := if((add1_avm_med_geo12 < 49094), N131_5, N131_6);

		N131_3 := if(((real)gong_did_last_ct < 1.5), -3.49104e-005, -0.0343218);

		N131_2 := if(((real)attr_eviction_count < 2.5), N131_3, 0.0306647);

		N131_1 := if(trim(ADD1_AVM_MARKET_TOTAL_VALUE) != '', N131_2, N131_4);

		N132_8 := if(((real)infutor_nap < 0.5), -0.00223468, 0.0717377);

		N132_7 := map((input_dob_match_level in ['0', '2', '3', '5', '6', '8']) => N132_8,
					  (input_dob_match_level in ['1', '4', '7'])                => 0.273695,
																				   N132_8);

		N132_6 := if(((real)em_count < 0.5), -0.00102632, N132_7);

		N132_5 := if((add1_avm_price_index_valuation < 73083), -0.0231921, N132_6);

		N132_4 := if(trim(ADD1_AVM_SALES_PRICE) != '', N132_5, 0.00061054);

		N132_3 := if(((real)liens_unrel_ot_total_amount < 208.5), -0.00232612, 0.0261207);

		N132_2 := if(((real)add1_avm_assessed_total_value < 2923.5), 0.0650921, N132_3);

		N132_1 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N132_2, N132_4);

		N133_5 := map((fname_eda_sourced_type in ['A', 'P']) => -0.0100291,
					  (fname_eda_sourced_type in ['AP'])     => 0.0594391,
																0.0594391);

		N133_4 := if(((real)addrs_10yr < 5.5), -0.0042995, -0.0433673);

		N133_3 := map((input_dob_match_level in ['2', '5', '7'])                => N133_4,
					  (input_dob_match_level in ['0', '1', '3', '4', '6', '8']) => 0.00395533,
																				   0.00395533);

		N133_2 := if(((real)addrs_per_ssn < 0.5), -0.0456863, N133_3);

		N133_1 := if(((real)gong_did_first_ct < 2.5), N133_2, N133_5);

		N134_5 := map((ams_income_level_code in ['A', 'B', 'C', 'D', 'E', 'G', 'I', 'J', 'K']) => -0.0252048,
					  (ams_income_level_code in ['F', 'H'])                                    => 0.192209,
																								  -0.0252048);

		N134_4 := if((add1_avm_hedonic_valuation < 209950), 0.000215778, -0.0245499);

		N134_3 := if((liens_rel_cj_total_amount < 581), N134_4, N134_5);

		N134_2 := if(((real)attr_num_rel_liens12 < 0.5), N134_3, 0.0322362);

		N134_1 := if(((real)liens_rel_sc_total_amount < 404.5), N134_2, -0.0312214);

		N135_5 := if((add1_avm_med_fips < 139677), 0.0158188, 0.0694468);

		N135_4 := if(((integer)add1_building_area < 942), 0.033639, -0.0326693);

		N135_3 := if(((real)addrs_5yr < 1.5), N135_4, 0.0628387);

		N135_2 := if(((real)rc_addrcount < 2.5), -0.000915066, N135_3);

		N135_1 := if(((real)combo_ssnscore < 177.5), N135_2, N135_5);

		N136_6 := map((input_dob_match_level in ['0', '1', '2', '4', '5', '6', '7', '8']) => -0.00744481,
					  (input_dob_match_level in ['3'])                                    => 0.171353,
																							 -0.00744481);

		N136_5 := if(((integer)add1_avm_assessed_total_value < 23715), 0.0122572, 0.0614426);

		N136_4 := if(((real)gong_did_phone_ct < 0.5), N136_5, 0.00103817);

		N136_3 := if(((integer)add1_avm_assessed_total_value < 46916), N136_4, N136_6);

		N136_2 := if(trim(ADD1_AVM_ASSESSED_TOTAL_VALUE) != '', N136_3, 0.000976187);

		N136_1 := if(((real)rc_hphonevalflag < 3.5), -0.0083699, N136_2);


		tnscore := sum(N0_1, N1_1, N2_1, N3_1, N4_1, N5_1, N6_1, N7_1, N8_1, N9_1, N10_1, N11_1, N12_1, N13_1, N14_1, N15_1, N16_1, N17_1, N18_1, N19_1, N20_1, N21_1, N22_1, N23_1, N24_1, N25_1, N26_1, N27_1, N28_1, N29_1, N30_1, N31_1, N32_1, N33_1, N34_1, N35_1, N36_1, N37_1, N38_1, N39_1, N40_1, N41_1, N42_1, N43_1, N44_1, N45_1, N46_1, N47_1, N48_1, N49_1, N50_1, N51_1, N52_1, N53_1, N54_1, N55_1, N56_1, N57_1, N58_1, N59_1, N60_1, N61_1, N62_1, N63_1, N64_1, N65_1, N66_1, N67_1, N68_1, N69_1, N70_1, N71_1, N72_1, N73_1, N74_1, N75_1, N76_1, N77_1, N78_1, N79_1, N80_1, N81_1, N82_1, N83_1, N84_1, N85_1, N86_1, N87_1, N88_1, N89_1, N90_1, N91_1, N92_1, N93_1, N94_1, N95_1, N96_1, N97_1, N98_1, N99_1, N100_1, N101_1, N102_1, N103_1, N104_1, N105_1, N106_1, N107_1, N108_1, N109_1, N110_1, N111_1, N112_1, N113_1, N114_1, N115_1, N116_1, N117_1, N118_1, N119_1, N120_1, N121_1, N122_1, N123_1, N124_1, N125_1, N126_1, N127_1, N128_1, N129_1, N130_1, N131_1, N132_1, N133_1, N134_1, N135_1, N136_1);

		score1 := exp(-tnscore); /* DEPVAR = 0 */
		score0 := exp(tnscore); /* DEPVAR = 1 */
		expsum := score1 + score0;

		/***************************************/
		/* Probabilities for each target class */
		/***************************************/

		prob0 := score0 / expsum; /* DEPVAR = 1 */
		prob1 := score1 / expsum; /* DEPVAR = 0 */
		REPB_Treenet_Score1 := round(-40*(log(prob0/(1-prob0)) - log(.1/.9))/log(2) + 700);
		REPB_Treenet_Score2 := min(max(REPB_Treenet_Score1,501),900);

		isUnscorable := models.common.isRV3Unscorable(le);
		final := if( isUnscorable, '222', (string3)REPB_Treenet_Score2 );

		#if(RVD_DEBUG)
			self.nas_summary := nas_summary;
			self.cvi := cvi;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_hphonevalflag := rc_hphonevalflag;
			self.rc_pwphonezipflag := rc_pwphonezipflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_addrvalflag := rc_addrvalflag;
			self.rc_lnamecount := rc_lnamecount;
			self.rc_addrcount := rc_addrcount;
			self.rc_ssncount := rc_ssncount;
			self.rc_numelever := rc_numelever;
			self.rc_phoneaddr_addrcount := rc_phoneaddr_addrcount;
			self.rc_disthphoneaddr := rc_disthphoneaddr;
			self.rc_phonetype := rc_phonetype;
			self.rc_zipclass := rc_zipclass;
			self.rc_lnamessnmatch := rc_lnamessnmatch;
			self.rc_lnamessnmatch2 := rc_lnamessnmatch2;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.combo_fnamescore := combo_fnamescore;
			self.combo_addrscore := combo_addrscore;
			self.combo_hphonescore := combo_hphonescore;
			self.combo_ssnscore := combo_ssnscore;
			self.combo_dobscore := combo_dobscore;
			self.combo_fnamecount := combo_fnamecount;
			self.combo_lnamecount := combo_lnamecount;
			self.eq_count := eq_count;
			self.pr_count := pr_count;
			self.em_count := em_count;
			self.vo_count := vo_count;
			self.fname_eda_sourced_type := fname_eda_sourced_type;
			self.lname_eda_sourced_type := lname_eda_sourced_type;
			self.age := age;
			self.add1_address_score := add1_address_score;
			self.add1_house_number_match := add1_house_number_match;
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
			self.add1_source_count := add1_source_count;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_purchase_amount := add1_purchase_amount;
			self.add1_mortgage_amount := add1_mortgage_amount;
			self.add1_financing_type := add1_financing_type;
			self.add1_assessed_amount := add1_assessed_amount;
			self.add1_building_area := add1_building_area;
			self.add1_no_of_rooms := add1_no_of_rooms;
			self.add1_no_of_bedrooms := add1_no_of_bedrooms;
			self.add1_parking_no_of_cars := add1_parking_no_of_cars;
			self.property_owned_purchase_total := property_owned_purchase_total;
			self.property_owned_assessed_total := property_owned_assessed_total;
			self.property_sold_purchase_total := property_sold_purchase_total;
			self.property_sold_assessed_total := property_sold_assessed_total;
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
			self.recent_disconnects := recent_disconnects;
			self.gong_did_phone_ct := gong_did_phone_ct;
			self.gong_did_addr_ct := gong_did_addr_ct;
			self.gong_did_first_ct := gong_did_first_ct;
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
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.addrs_per_ssn_c6 := addrs_per_ssn_c6;
			self.adls_per_addr_c6 := adls_per_addr_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.vo_addrs_per_adl := vo_addrs_per_adl;
			self.pl_addrs_per_adl := pl_addrs_per_adl;
			self.invalid_ssns_per_adl := invalid_ssns_per_adl;
			self.invalid_addrs_per_adl := invalid_addrs_per_adl;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.impulse_annual_income := impulse_annual_income;
			self.attr_addrs_last12 := attr_addrs_last12;
			self.attr_addrs_last24 := attr_addrs_last24;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_num_purchase60 := attr_num_purchase60;
			self.attr_num_sold24 := attr_num_sold24;
			self.attr_num_sold36 := attr_num_sold36;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_felonies60 := attr_felonies60;
			self.attr_num_unrel_liens90 := attr_num_unrel_liens90;
			self.attr_num_unrel_liens12 := attr_num_unrel_liens12;
			self.attr_num_unrel_liens24 := attr_num_unrel_liens24;
			self.attr_num_unrel_liens36 := attr_num_unrel_liens36;
			self.attr_num_unrel_liens60 := attr_num_unrel_liens60;
			self.attr_num_rel_liens180 := attr_num_rel_liens180;
			self.attr_num_rel_liens12 := attr_num_rel_liens12;
			self.attr_bankruptcy_count24 := attr_bankruptcy_count24;
			self.attr_bankruptcy_count60 := attr_bankruptcy_count60;
			self.attr_eviction_count := attr_eviction_count;
			self.attr_eviction_count180 := attr_eviction_count180;
			self.attr_eviction_count12 := attr_eviction_count12;
			self.attr_eviction_count24 := attr_eviction_count24;
			self.attr_eviction_count36 := attr_eviction_count36;
			self.attr_eviction_count60 := attr_eviction_count60;
			self.attr_num_nonderogs := attr_num_nonderogs;
			self.attr_num_nonderogs30 := attr_num_nonderogs30;
			self.attr_num_nonderogs180 := attr_num_nonderogs180;
			self.attr_num_nonderogs12 := attr_num_nonderogs12;
			self.attr_num_nonderogs24 := attr_num_nonderogs24;
			self.attr_num_nonderogs36 := attr_num_nonderogs36;
			self.attr_num_nonderogs60 := attr_num_nonderogs60;
			self.attr_num_proflic60 := attr_num_proflic60;
			self.filing_type := filing_type;
			self.disposition := disposition;
			self.filing_count := filing_count;
			self.bk_recent_count := bk_recent_count;
			self.bk_disposed_recent_count := bk_disposed_recent_count;
			self.bk_disposed_historical_count := bk_disposed_historical_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_unrel_cj_total_amount := liens_unrel_cj_total_amount;
			self.liens_rel_cj_total_amount := liens_rel_cj_total_amount;
			self.liens_unrel_lt_ct := liens_unrel_lt_ct;
			self.liens_unrel_ot_ct := liens_unrel_ot_ct;
			self.liens_unrel_ot_total_amount := liens_unrel_ot_total_amount;
			self.liens_rel_ot_total_amount := liens_rel_ot_total_amount;
			self.liens_unrel_sc_total_amount := liens_unrel_sc_total_amount;
			self.liens_rel_sc_total_amount := liens_rel_sc_total_amount;
			self.criminal_count := criminal_count;
			self.felony_count := felony_count;
			self.ams_college_code := ams_college_code;
			self.ams_college_type := ams_college_type;
			self.ams_income_level_code := ams_income_level_code;
			self.ams_file_type := ams_file_type;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_category := prof_license_category;
			self.wealth_index := wealth_index;
			self.input_dob_match_level := input_dob_match_level;
			self.addr_stability := addr_stability;
			self.tnscore := tnscore;
			self.score1 := score1;
			self.score0 := score0;
			self.expsum := expsum;
			self.prob1 := prob1;
			self.prob0 := prob0;
			self.REPB_Treenet_Score1 := REPB_Treenet_Score1;
			self.REPB_Treenet_Score2 := REPB_Treenet_Score2;
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