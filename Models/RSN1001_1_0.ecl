import ut, Risk_Indicators, easi, riskwise, std;

// custom recover score for GRC
export RSN1001_1_0(grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam) := function

	RSN_DEBUG := false;

	#if(RSN_DEBUG)
	Layout_Debug := record
		// integer seq;
		risk_indicators.layout_boca_shell clam;
		Integer adl_hphn;
		Integer adl_addr;
		Integer adl_ssn;
		Integer in_hphnpop;
		Boolean trueDID;
		Integer nas_summary;
		Integer nap_summary;
		String rc_dwelltype;
		Boolean add1_isbestmatch;
		Boolean add1_applicant_owned;
		Boolean add1_occupant_owned;
		Boolean add1_family_owned;
		String add1_building_area;
		String add1_no_of_stories;
		String add1_no_of_rooms;
		String add1_no_of_bedrooms;
		String add1_no_of_baths;
		String add1_parking_no_of_cars;
		Integer property_owned_purchase_total;
		Integer property_owned_purchase_count;
		Boolean add2_applicant_owned;
		Boolean add2_occupant_owned;
		Boolean add2_family_owned;
		Boolean add3_applicant_owned;
		Boolean add3_occupant_owned;
		Boolean add3_family_owned;
		String telcordia_type;
		Integer recent_disconnects;
		String gong_did_last_seen;
		Integer gong_did_first_ct;
		Integer gong_did_last_ct;
		Integer adls_per_addr;
		Integer infutor_nap;
		Integer impulse_count;
		Integer attr_num_aircraft;
		Integer attr_total_number_derogs;
		Integer attr_num_unrel_liens30;
		Integer attr_num_rel_liens30;
		Integer attr_num_rel_liens90;
		Integer attr_num_rel_liens180;
		Integer attr_num_rel_liens12;
		Integer attr_num_rel_liens24;
		Integer attr_num_rel_liens36;
		Integer attr_eviction_count;
		String disposition;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer liens_unrel_cj_ct;
		Integer liens_rel_ot_last_seen;
		Integer criminal_count;
		Integer felony_count;
		Integer rel_count;
		Integer rel_prop_owned_count;
		Integer rel_incomeunder75_count;
		Integer rel_incomeunder100_count;
		Integer rel_incomeover100_count;
		Integer watercraft_count;
		Integer acc_count;
		String ams_college_code;
		String ams_file_type;
		Boolean prof_license_flag;
		String input_dob_age;
		Integer inferred_age;
		String archive_date;
		String c_inc_200k_p;
		String c_inc_201k_p;
		String c_inc_150k_p;
		String c_inc_125k_p;
		String c_inc_100k_p;
		Integer sysdate;
		Integer _archive_date;
		Integer sysdate_2;
		Integer adl_match_lvl;
		Real adl_match_lvl_m;
		String curr_owner_lvl_b1;
		String prev_owner_lvl_b1;
		String curr_owner_lvl_b2;
		String prev_owner_lvl_b2;
		String prev_owner_lvl;
		String curr_owner_lvl;
		Integer curr_prev_owner_lvl;
		Real curr_prev_owner_lvl_m;
		Boolean hi_area;
		Boolean hi_stories;
		Boolean hi_rooms;
		Boolean hi_beds;
		Boolean hi_baths;
		Boolean hi_parking;
		Integer nice_house_lvl;
		Integer nice_house_lvl_b1;
		Integer nice_house_lvl_2;
		Real nice_house_lvl_m;
		Real property_owned_purchase_total_a;
		Integer property_owned_purchase_tot_lvl;
		Real prop_owned_purchase_tot_lvl_m;
		Integer _liens_rel_ot_last_seen;
		Real months_liens_rel_ot_last_seen;
		Integer rel_ot_lien_lvl;
		Real rel_ot_lien_lvl_m;
		Integer criminal_lvl;
		Real criminal_lvl_m;
		Integer rel_income100plus_count;
		Integer rel_income75plus_count;
		Integer rel_income50plus_count;
		Integer rel_prop_own_pct;
		Integer rel_income75plus_pct;
		Integer rel_income100plus_pct;
		Integer rel_income75plus_count_2;
		Integer rel_income100plus_count_2;
		Integer rel_income50plus_pct;
		Integer rel_income50plus_count_2;
		Integer rel_income_lvl;
		Real rel_income_lvl_m;
		Integer rel_prop_own_pct_lvl;
		Real rel_prop_own_pct_lvl_m;
		Integer adls_per_addr_lvl_b1;
		Integer adls_per_addr_lvl_b2;
		Integer adls_per_addr_lvl;
		Real adls_per_addr_lvl_m;
		Real c_inc200kplus_pct;
		Real c_inc150kplus_pct;
		Real c_inc125kplus_pct;
		Real c_inc100kplus_pct;
		Integer c_income_lvl;
		Real c_income_lvl_m;
		Integer attr_total_number_derogs_lvl;
		Real attr_total_number_derogs_lvl_m;
		Integer attr_num_rel_liens_lvl;
		Real attr_num_rel_liens_lvl_m;
		Integer ams_college_lvl;
		Real ams_college_lvl_m;
		Integer combo_age;
		Integer combo_age_c;
		Boolean nas12;
		Boolean phn_pots;
		Boolean good_phn_counts;
		Integer _gong_did_last_seen;
		Real months_gong_did_last_seen;
		Boolean adl_seen_recent_no_dcs;
		Boolean attr_num_unrel_liens30_flag;
		Boolean attr_eviction_count_flag;
		Boolean hphnpop;
		Integer nap_ver_b1_c2_b1;
		Integer nap_ver_b1_c2_b2;
		Integer nap_ver_b1;
		Integer nap_ver;
		Integer combo_nap_ver;
		Real combo_nap_ver_m;
		Integer bk_lvl;
		Real bk_lvl_m;
		Integer lien_unrel_lvl;
		Integer combo_lien_unrel_lvl;
		Real combo_lien_unrel_lvl_m;
		Boolean other_bad_flag;
		Real RSN1001_Log;
		Integer Base;
		Integer point;
		Real odds;
		Real phat;
		Integer RSN1001_1_0;
		Integer rsn1001_1_0_2;
	END;
	Layout_Debug doModel(clam le, easi.key_easi_census rt) := TRANSFORM 

	#else
	Layout_RecoverScore doModel(clam le, easi.key_easi_census rt) := TRANSFORM 
	#end

		adl_hphn                         := le.ADL_Shell_Flags.adl_hphn;
		adl_addr                         := le.ADL_Shell_Flags.adl_addr;
		adl_ssn                          := le.ADL_Shell_Flags.adl_ssn;
		in_hphnpop                       := le.ADL_Shell_Flags.in_hphnpop;
		truedid                          := le.truedid;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_dwelltype                     := le.iid.dwelltype;
		add1_isbestmatch                 := le.address_verification.input_address_information.isbestmatch;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_occupant_owned              := le.address_verification.input_address_information.occupant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_building_area               := (string)le.address_verification.input_address_information.building_area;
		add1_no_of_stories               := (string)le.address_verification.input_address_information.no_of_stories;
		add1_no_of_rooms                 := (string)le.address_verification.input_address_information.no_of_rooms;
		add1_no_of_bedrooms              := (string)le.address_verification.input_address_information.no_of_bedrooms;
		add1_no_of_baths                 := (string)le.address_verification.input_address_information.no_of_baths;
		add1_parking_no_of_cars          := (string)le.address_verification.input_address_information.parking_no_of_cars;
		property_owned_purchase_total    := le.address_verification.owned.property_owned_purchase_total;
		property_owned_purchase_count    := le.address_verification.owned.property_owned_purchase_count;
		add2_applicant_owned             := le.address_verification.address_history_1.applicant_owned;
		add2_occupant_owned              := le.address_verification.address_history_1.occupant_owned;
		add2_family_owned                := le.address_verification.address_history_1.family_owned;
		add3_applicant_owned             := le.address_verification.address_history_2.applicant_owned;
		add3_occupant_owned              := le.address_verification.address_history_2.occupant_owned;
		add3_family_owned                := le.address_verification.address_history_2.family_owned;
		telcordia_type                   := le.phone_verification.telcordia_type;
		recent_disconnects               := le.phone_verification.recent_disconnects;
		gong_did_last_seen               := le.phone_verification.gong_did.gong_adl_dt_last_seen_full;
		gong_did_first_ct                := le.phone_verification.gong_did.gong_did_first_ct;
		gong_did_last_ct                 := le.phone_verification.gong_did.gong_did_last_ct;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		attr_num_aircraft                := le.aircraft.aircraft_count;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_num_unrel_liens30           := le.bjl.liens_unreleased_count30;
		attr_num_rel_liens30             := le.bjl.liens_released_count30;
		attr_num_rel_liens90             := le.bjl.liens_released_count90;
		attr_num_rel_liens180            := le.bjl.liens_released_count180;
		attr_num_rel_liens12             := le.bjl.liens_released_count12;
		attr_num_rel_liens24             := le.bjl.liens_released_count24;
		attr_num_rel_liens36             := le.bjl.liens_released_count36;
		attr_eviction_count              := le.bjl.eviction_count;
		disposition                      := le.bjl.disposition;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		liens_unrel_cj_ct                := le.liens.liens_unreleased_civil_judgment.count;
		liens_rel_ot_last_seen           := le.liens.liens_released_other_tax.most_recent_filing_date;
		criminal_count                   := le.bjl.criminal_count;
		felony_count                     := le.bjl.felony_count;
		rel_count                        := le.relatives.relative_count;
		rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
		rel_incomeunder75_count          := le.relatives.relative_incomeunder75_count;
		rel_incomeunder100_count         := le.relatives.relative_incomeunder100_count;
		rel_incomeover100_count          := le.relatives.relative_incomeover100_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		acc_count                        := le.accident_data.acc.num_accidents;
		ams_college_code                 := le.student.college_code;
		ams_file_type                    := le.student.file_type;
		prof_license_flag                := le.professional_license.professional_license_flag;
		input_dob_age                    := le.shell_input.age;
		inferred_age                     := le.inferred_age;
		archive_date                     := if(le.historydate=999999, ((STRING)Std.Date.Today())[1..6], (string6)le.historydate);

		c_inc_200k_p                     := trim(rt.in200K_p);
		c_inc_201k_p                     := trim(rt.in201K_p);
		c_inc_150k_p                     := trim(rt.in150K_p);
		c_inc_125k_p                     := trim(rt.in125K_p);
		c_inc_100k_p                     := trim(rt.in100K_p);



		NULL := -999999999;

		sysdate := (ut.DaysSince1900((string)archive_date[1..4], (string)archive_date[5..6], '01') - ut.DaysSince1900('1960', '1', '1'));

		_archive_date := common.sas_date(archive_date);

		sysdate_2 := _archive_date;

		adl_match_lvl :=  map(((integer)adl_hphn = 2) and (((integer)adl_addr = 2) and ((integer)adl_ssn = 2))    => 4,
				  (adl_hphn in [1, 3]) and (((integer)adl_addr = 2) and ((integer)adl_ssn = 2))       => 3,
				  ((integer)adl_hphn != 0) and (((integer)adl_addr != 0) and ((integer)adl_ssn != 0)) => 2,
																										 1);

		adl_match_lvl_m :=  map(adl_match_lvl = 1 => 0.105764411,
					adl_match_lvl = 2 => 0.1221843897,
					adl_match_lvl = 3 => 0.2088993382,
										 0.2590799031);

		curr_owner_lvl_b1 := map(add1_applicant_owned => 'APP',
					 add1_family_owned    => 'FAM',
					 add1_occupant_owned  => 'OCC',
											 'ELS');

		prev_owner_lvl_b1 := map(add2_applicant_owned => 'APP',
					 add2_family_owned    => 'FAM',
					 add2_occupant_owned  => 'OCC',
											 'ELS');

		curr_owner_lvl_b2 := map(add2_applicant_owned => 'APP',
					 add2_family_owned    => 'FAM',
					 add2_occupant_owned  => 'OCC',
											 'ELS');

		prev_owner_lvl_b2 := map(add3_applicant_owned => 'APP',
					 add3_family_owned    => 'FAM',
					 add3_occupant_owned  => 'OCC',
											 'ELS');

		prev_owner_lvl := if(add1_isbestmatch, prev_owner_lvl_b1, prev_owner_lvl_b2);

		curr_owner_lvl := if(add1_isbestmatch, curr_owner_lvl_b1, curr_owner_lvl_b2);

		curr_prev_owner_lvl :=  map((prev_owner_lvl = 'APP') and (curr_owner_lvl = 'APP')                                         => 5,
						(prev_owner_lvl in ['FAM', 'ELS']) and (curr_owner_lvl = 'APP')                               => 4,
						curr_owner_lvl = 'APP'                                                                        => 3,
						(prev_owner_lvl = 'APP') or ((prev_owner_lvl = 'FAM') and (curr_owner_lvl in ['FAM', 'OCC'])) => 2,
						(curr_owner_lvl = 'OCC') or ((curr_owner_lvl = 'ELS') and (prev_owner_lvl = 'ELS'))           => 0,
																														 1);

		curr_prev_owner_lvl_m :=  map(curr_prev_owner_lvl = 0 => 0.1262380393,
						  curr_prev_owner_lvl = 1 => 0.1443022296,
						  curr_prev_owner_lvl = 2 => 0.1965989216,
						  curr_prev_owner_lvl = 3 => 0.2385964912,
						  curr_prev_owner_lvl = 4 => 0.2629840889,
													 0.3181818182);

		hi_area := ((integer)add1_building_area > 2000);
		hi_stories := ((integer)add1_no_of_stories > 1);
		hi_rooms := ((integer)add1_no_of_rooms > 7);
		hi_beds := ((integer)add1_no_of_bedrooms > 3);
		hi_baths := ((integer)add1_no_of_baths > 2);
		hi_parking := ((integer)add1_parking_no_of_cars > 1);

		nice_house_lvl :=  if((boolean)watercraft_count or (boolean)attr_num_aircraft, 1, NULL);

		nice_house_lvl_b1 := map(if(max((integer)hi_area, (integer)hi_stories, (integer)hi_rooms, (integer)hi_beds, (integer)hi_baths, (integer)hi_parking) = NULL, NULL, sum((integer)hi_area, (integer)hi_stories, (integer)hi_rooms, (integer)hi_beds, (integer)hi_baths, (integer)hi_parking)) = 6 => 2,
					 if(max((integer)hi_area, (integer)hi_stories, (integer)hi_rooms, (integer)hi_beds, (integer)hi_baths, (integer)hi_parking) = NULL, NULL, sum((integer)hi_area, (integer)hi_stories, (integer)hi_rooms, (integer)hi_beds, (integer)hi_baths, (integer)hi_parking)) > 1 => 1,
																																																																							  0);

		nice_house_lvl_2 := if(rc_dwelltype = ' ', nice_house_lvl_b1, 0);

		nice_house_lvl_m :=  map(nice_house_lvl_2 = 0 => 0.1529827798,
					 nice_house_lvl_2 = 1 => 0.2086234,
											 0.3362609787);

		property_owned_purchase_total_a :=  if(property_owned_purchase_count > 0, (property_owned_purchase_total / property_owned_purchase_count), -1);

		property_owned_purchase_tot_lvl :=  map((integer)property_owned_purchase_total_a >= 250000 => 3,
									(integer)property_owned_purchase_total_a >= 125000 => 2,
									property_owned_purchase_count > 0                  => 1,
																						  0);

		prop_owned_purchase_tot_lvl_m :=  map(property_owned_purchase_tot_lvl = 0 => 0.1345496009,
								  property_owned_purchase_tot_lvl = 1 => 0.2271995708,
								  property_owned_purchase_tot_lvl = 2 => 0.2692648361,
																		 0.2969255663);

		_liens_rel_ot_last_seen := common.sas_date((string)liens_rel_ot_last_seen);

		months_liens_rel_ot_last_seen := if( NULL in [sysdate_2,_liens_rel_ot_last_seen], NULL, ((sysdate_2 - _liens_rel_ot_last_seen) / (365.25 / 12)));

		rel_ot_lien_lvl :=  map(
					(0 <= (integer)months_liens_rel_ot_last_seen) AND ((integer)months_liens_rel_ot_last_seen < 5)  => 2,
					(0 <= (integer)months_liens_rel_ot_last_seen) AND ((integer)months_liens_rel_ot_last_seen < 15) => 1,
																													   0);

		rel_ot_lien_lvl_m :=  map(rel_ot_lien_lvl = 0 => 0.1649386198,
					  rel_ot_lien_lvl = 1 => 0.251572327,
											 0.4913294798);

		criminal_lvl :=  map((criminal_count > 3) or (felony_count > 0) => 2,
				 criminal_count > 0                         => 1,
															   0);

		criminal_lvl_m :=  map(criminal_lvl = 0 => 0.1775180034,
				   criminal_lvl = 1 => 0.1358300727,
									   0.1065934066);

		rel_income100plus_count := rel_incomeover100_count;

		rel_income75plus_count := if(max(rel_incomeover100_count, rel_incomeunder100_count) = NULL, NULL, sum(if(rel_incomeover100_count = NULL, 0, rel_incomeover100_count), if(rel_incomeunder100_count = NULL, 0, rel_incomeunder100_count)));

		rel_income50plus_count := if(max(rel_income75plus_count, rel_incomeunder75_count) = NULL, NULL, sum(if(rel_income75plus_count = NULL, 0, rel_income75plus_count), if(rel_incomeunder75_count = NULL, 0, rel_incomeunder75_count)));

		rel_prop_own_pct :=  if(rel_count > 0, truncate(((rel_prop_owned_count / rel_count) * 100)), -1);

		rel_income75plus_pct      := if(rel_count > 0, truncate(((rel_income75plus_count / rel_count) * 100)), NULL);
		rel_income100plus_pct     := if(rel_count > 0, truncate(((rel_income100plus_count / rel_count) * 100)), NULL);
		rel_income75plus_count_2  := if(rel_count > 0, NULL, -1);
		rel_income100plus_count_2 := if(rel_count > 0, NULL, -1);
		rel_income50plus_pct      := if(rel_count > 0, truncate(((rel_income50plus_count / rel_count) * 100)), NULL);
		rel_income50plus_count_2  := if(rel_count > 0, NULL, -1);

		rel_income_lvl :=  map(rel_income100plus_pct >= 20 => 3,
				   rel_income75plus_pct >= 10  => 2,
				   rel_income50plus_pct >= 40  => 1,
												  0);

		rel_income_lvl_m :=  map(rel_income_lvl = 0 => 0.1448703822,
					 rel_income_lvl = 1 => 0.2042079208,
					 rel_income_lvl = 2 => 0.2356105433,
										   0.2601054482);

		rel_prop_own_pct_lvl :=  map(rel_prop_own_pct >= 70 => 5,
						 rel_prop_own_pct >= 40 => 4,
						 rel_prop_own_pct >= 20 => 3,
						 rel_prop_own_pct >= 10 => 2,
						 rel_prop_own_pct > 0   => 1,
												   0);

		rel_prop_own_pct_lvl_m :=  map(rel_prop_own_pct_lvl = 0 => 0.1306641837,
						   rel_prop_own_pct_lvl = 1 => 0.1542497377,
						   rel_prop_own_pct_lvl = 2 => 0.1714210248,
						   rel_prop_own_pct_lvl = 3 => 0.1958932238,
						   rel_prop_own_pct_lvl = 4 => 0.2151340346,
													   0.2444864524);

		adls_per_addr_lvl_b1 := map((0 < adls_per_addr) AND (adls_per_addr < 4)  => 0,
						(3 < adls_per_addr) AND (adls_per_addr < 13) => 1,
																		2);

		adls_per_addr_lvl_b2 := map(adls_per_addr = 2                            => 0,
						(2 < adls_per_addr) AND (adls_per_addr < 10) => 1,
						(9 < adls_per_addr) AND (adls_per_addr < 14) => 2,
																		3);

		adls_per_addr_lvl := if(rc_dwelltype = 'A', adls_per_addr_lvl_b1, adls_per_addr_lvl_b2);

		adls_per_addr_lvl_m :=  map(adls_per_addr_lvl = 0 => 0.222002635,
						adls_per_addr_lvl = 1 => 0.1885335272,
						adls_per_addr_lvl = 2 => 0.164166804,
												 0.1254253768);

		c_inc200kplus_pct := if(c_inc_200k_p='' and c_inc_201k_p='', NULL, sum(if(c_inc_200k_p = '', 0, (real)c_inc_200k_p), if(c_inc_201k_p = '', 0, (real)c_inc_201k_p)));
		c_inc150kplus_pct := if(c_inc200kplus_pct=NULL and c_inc_150k_p='', NULL, sum(if(c_inc200kplus_pct = NULL, 0, c_inc200kplus_pct), if(c_inc_150k_p = '', 0, (real)c_inc_150k_p)));
		c_inc125kplus_pct := if(c_inc150kplus_pct=NULL and c_inc_125k_p='', NULL, sum(if(c_inc150kplus_pct = NULL, 0, c_inc150kplus_pct), if(c_inc_125k_p = '', 0, (real)c_inc_125k_p)));
		c_inc100kplus_pct := if(c_inc125kplus_pct=NULL and c_inc_100k_p='', NULL, sum(if(c_inc125kplus_pct = NULL, 0, c_inc125kplus_pct), if(c_inc_100k_p = '', 0, (real)c_inc_100k_p)));

		c_income_lvl :=  map(c_inc200kplus_pct > 20 => 4,
				 c_inc150kplus_pct > 20 => 3,
				 c_inc125kplus_pct > 20 => 2,
				 c_inc100kplus_pct > 20 => 1,
										   0);

		c_income_lvl_m :=  map(c_income_lvl = 0 => 0.1254665008,
				   c_income_lvl = 1 => 0.1595468696,
				   c_income_lvl = 2 => 0.1927061749,
				   c_income_lvl = 3 => 0.2507896399,
									   0.2616179002);

		attr_total_number_derogs_lvl :=  map(attr_total_number_derogs > 14 => 6,
								 attr_total_number_derogs > 8  => 5,
								 attr_total_number_derogs > 5  => 4,
								 attr_total_number_derogs > 2  => 3,
								 attr_total_number_derogs = 2  => 2,
								 attr_total_number_derogs = 1  => 1,
																  0);

		attr_total_number_derogs_lvl_m :=  map(attr_total_number_derogs_lvl = 0 => 0.2385786802,
								   attr_total_number_derogs_lvl = 1 => 0.2256532067,
								   attr_total_number_derogs_lvl = 2 => 0.1850758853,
								   attr_total_number_derogs_lvl = 3 => 0.1527993109,
								   attr_total_number_derogs_lvl = 4 => 0.137573127,
								   attr_total_number_derogs_lvl = 5 => 0.1073790003,
																	   0.0916334661);

		attr_num_rel_liens_lvl :=  map(attr_num_rel_liens30 > 0  => 6,
						   attr_num_rel_liens90 > 0  => 5,
						   attr_num_rel_liens180 > 0 => 4,
						   attr_num_rel_liens12 > 0  => 3,
						   attr_num_rel_liens24 > 0  => 2,
						   attr_num_rel_liens36 > 0  => 1,
														0);

		attr_num_rel_liens_lvl_m :=  map(attr_num_rel_liens_lvl = 0 => 0.1634911994,
							 attr_num_rel_liens_lvl = 1 => 0.1853932584,
							 attr_num_rel_liens_lvl = 2 => 0.2005208333,
							 attr_num_rel_liens_lvl = 3 => 0.2068273092,
							 attr_num_rel_liens_lvl = 4 => 0.2575757576,
							 attr_num_rel_liens_lvl = 5 => 0.2871287129,
														   0.3125);

		ams_college_lvl :=  map((integer)ams_college_code = 4 => 2,
					(integer)ams_college_code > 0 => 1,
					ams_file_type = 'M'           => -1,
													 0);

		ams_college_lvl_m :=  map(ams_college_lvl = -1 => 0.1288461538,
					  ams_college_lvl = 0  => 0.1711993739,
					  ams_college_lvl = 1  => 0.2029850746,
											  0.2727272727);

		combo_age :=  if((integer)input_dob_age <= 0, inferred_age, (integer)input_dob_age);
		combo_age_c := min(if(max((integer)combo_age, 1) = NULL, -NULL, max((integer)combo_age, 1)), 65);

		nas12 := (nas_summary = 12);
		phn_pots := (telcordia_type in ['00', '50', '51', '52', '54']);
		good_phn_counts := (phn_pots and ((gong_did_first_ct in [1, 2]) and (gong_did_last_ct = 1)));
		_gong_did_last_seen := common.sas_date(gong_did_last_seen);
		months_gong_did_last_seen := ((sysdate_2 - _gong_did_last_seen) / (365.25 / 12));
		adl_seen_recent_no_dcs := (((0 <= (integer)months_gong_did_last_seen) AND ((integer)months_gong_did_last_seen <= 2)) and (recent_disconnects = 0));
		attr_num_unrel_liens30_flag := (attr_num_unrel_liens30 > 0);
		attr_eviction_count_flag := (attr_eviction_count > 0);
		hphnpop := not((not((boolean)(integer)in_hphnpop) and ((integer)adl_hphn = 0)));

		nap_ver_b1_c2_b1 := map(nap_summary = 12        => 6,
					nap_summary in [10, 11] => 5,
					nap_summary = 0         => 3,
					nap_summary = 1         => 2,
											   4);

		nap_ver_b1_c2_b2 := if(nap_summary = 0, 0, 1);

		nap_ver_b1 := if(hphnpop, nap_ver_b1_c2_b1, nap_ver_b1_c2_b2);

		nap_ver := if(truedid, nap_ver_b1, -1);

		combo_nap_ver :=  map((nap_ver = 6) and (infutor_nap = 0)                                => 6,
				  (nap_ver in [5, 6]) and ((0 < infutor_nap) AND (infutor_nap < 11)) => 3,
				  (nap_ver in [5, 6]) and (infutor_nap > 10)                         => 4,
				  nap_ver = 5                                                        => 5,
				  (nap_ver = 4) and (infutor_nap > 10)                               => 5,
				  (nap_ver = 3) and (infutor_nap = 12)                               => 5,
				  (nap_ver = 4) and (infutor_nap = 1)                                => 3,
				  nap_ver = 4                                                        => 4,
				  (nap_ver = 3) and (infutor_nap = 0)                                => 3,
				  nap_ver in [2, 3]                                                  => 2,
				  nap_ver = 1                                                        => 1,
				  nap_ver = 0                                                        => 0,
																						-1);

		combo_nap_ver_m :=  map(combo_nap_ver = -1 => 0.16889,
					combo_nap_ver = 0  => 0.0625,
					combo_nap_ver = 1  => 0.0846613546,
					combo_nap_ver = 2  => 0.1251959686,
					combo_nap_ver = 3  => 0.1398305085,
					combo_nap_ver = 4  => 0.1738232865,
					combo_nap_ver = 5  => 0.2219899666,
										  0.2701008449);

		bk_lvl :=  map((string)StringLib.StringToUpperCase(trim(disposition, ALL)) = 'DISMISSED'  => 2,
		   (string)StringLib.StringToUpperCase(trim(disposition, ALL)) = 'DISCHARGED' => 0,
																	1);

		bk_lvl_m :=  map(bk_lvl = 0 => 0.2121904762,
			 bk_lvl = 1 => 0.1661355529,
						   0.118705036);

		lien_unrel_lvl :=  map((liens_recent_unreleased_count = 0) and (liens_historical_unreleased_ct < 2) => 0,
				   (liens_recent_unreleased_count = 1) and (liens_historical_unreleased_ct < 2) => 1,
				   (liens_recent_unreleased_count = 0) and (liens_historical_unreleased_ct = 2) => 1,
				   (liens_recent_unreleased_count = 2) and (liens_historical_unreleased_ct < 2) => 2,
				   (liens_recent_unreleased_count = 1) and (liens_historical_unreleased_ct = 2) => 2,
				   (liens_recent_unreleased_count = 0) and (liens_historical_unreleased_ct = 3) => 2,
				   liens_recent_unreleased_count < 3                                            => 3,
																								   4);

		combo_lien_unrel_lvl :=  map((lien_unrel_lvl = 0) and (liens_unrel_cj_ct > 0) => 5,
						 (lien_unrel_lvl = 1) and (liens_unrel_cj_ct > 1) => 5,
						 lien_unrel_lvl = 0                               => 4,
						 (lien_unrel_lvl = 1) and (liens_unrel_cj_ct = 1) => 3,
						 (lien_unrel_lvl = 2) and (liens_unrel_cj_ct > 1) => 3,
						 lien_unrel_lvl = 1                               => 2,
						 (lien_unrel_lvl = 2) and (liens_unrel_cj_ct = 1) => 2,
						 (lien_unrel_lvl = 2) and (liens_unrel_cj_ct = 0) => 1,
						 (lien_unrel_lvl = 3) and (liens_unrel_cj_ct > 0) => 1,
																			 0);

		combo_lien_unrel_lvl_m :=  map(combo_lien_unrel_lvl = 0 => 0.1121463078,
						   combo_lien_unrel_lvl = 1 => 0.1388308977,
						   combo_lien_unrel_lvl = 2 => 0.1698113208,
						   combo_lien_unrel_lvl = 3 => 0.2069970845,
						   combo_lien_unrel_lvl = 4 => 0.2319267763,
													   0.2905701754);

		other_bad_flag := ((boolean)impulse_count or (boolean)acc_count);

		RSN1001_Log := -10.67427916 +
			(adl_match_lvl_m * 2.8049262872) +
			(curr_prev_owner_lvl_m * 1.0102236131) +
			(nice_house_lvl_m * 1.5298215809) +
			(prop_owned_purchase_tot_lvl_m * 1.7879270258) +
			(rel_ot_lien_lvl_m * 3.7264347696) +
			(criminal_lvl_m * 2.4400191835) +
			(rel_income_lvl_m * 1.6360425411) +
			(rel_prop_own_pct_lvl_m * 1.5864841373) +
			(adls_per_addr_lvl_m * 3.5689934337) +
			(c_income_lvl_m * 2.1383230901) +
			(attr_total_number_derogs_lvl_m * 3.5476685488) +
			(attr_num_rel_liens_lvl_m * 5.5674428835) +
			(ams_college_lvl_m * 3.9417903326) +
			(combo_age_c * 0.0114122678) +
			((integer)nas12 * 0.2679694027) +
			((integer)good_phn_counts * 0.0925816275) +
			((integer)adl_seen_recent_no_dcs * 0.1801847244) +
			((integer)prof_license_flag * 0.4711071367) +
			((integer)attr_num_unrel_liens30_flag * -0.377012128) +
			((integer)attr_eviction_count_flag * -0.149278544) +
			(combo_nap_ver_m * 1.74987628) +
			(bk_lvl_m * 6.6155075058) +
			(combo_lien_unrel_lvl_m * 4.4173961493) +
			((integer)other_bad_flag * -0.262951242);

		base := 700;
		point := 50;
		odds := .16889/(1-.16889);
		phat := (exp(RSN1001_Log) / (1 + exp(RSN1001_Log)));
		rsn1001_1_0 := round(((point * ((ln((phat / (1 - phat))) - ln(odds)) / ln(2))) + base));
		rsn1001_1_0_2 := max(300, min(999, rsn1001_1_0));


		#if(RSN_DEBUG)
			// self.seq := le.seq;
			self.clam := le;
			self.adl_hphn := adl_hphn;
			self.adl_addr := adl_addr;
			self.adl_ssn := adl_ssn;
			self.in_hphnpop := in_hphnpop;
			self.truedid := truedid;
			self.nas_summary := nas_summary;
			self.nap_summary := nap_summary;
			self.rc_dwelltype := rc_dwelltype;
			self.add1_isbestmatch := add1_isbestmatch;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_occupant_owned := add1_occupant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_building_area := add1_building_area;
			self.add1_no_of_stories := add1_no_of_stories;
			self.add1_no_of_rooms := add1_no_of_rooms;
			self.add1_no_of_bedrooms := add1_no_of_bedrooms;
			self.add1_no_of_baths := add1_no_of_baths;
			self.add1_parking_no_of_cars := add1_parking_no_of_cars;
			self.property_owned_purchase_total := property_owned_purchase_total;
			self.property_owned_purchase_count := property_owned_purchase_count;
			self.add2_applicant_owned := add2_applicant_owned;
			self.add2_occupant_owned := add2_occupant_owned;
			self.add2_family_owned := add2_family_owned;
			self.add3_applicant_owned := add3_applicant_owned;
			self.add3_occupant_owned := add3_occupant_owned;
			self.add3_family_owned := add3_family_owned;
			self.telcordia_type := telcordia_type;
			self.recent_disconnects := recent_disconnects;
			self.gong_did_last_seen := gong_did_last_seen;
			self.gong_did_first_ct := gong_did_first_ct;
			self.gong_did_last_ct := gong_did_last_ct;
			self.adls_per_addr := adls_per_addr;
			self.infutor_nap := infutor_nap;
			self.impulse_count := impulse_count;
			self.attr_num_aircraft := attr_num_aircraft;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_num_unrel_liens30 := attr_num_unrel_liens30;
			self.attr_num_rel_liens30 := attr_num_rel_liens30;
			self.attr_num_rel_liens90 := attr_num_rel_liens90;
			self.attr_num_rel_liens180 := attr_num_rel_liens180;
			self.attr_num_rel_liens12 := attr_num_rel_liens12;
			self.attr_num_rel_liens24 := attr_num_rel_liens24;
			self.attr_num_rel_liens36 := attr_num_rel_liens36;
			self.attr_eviction_count := attr_eviction_count;
			self.disposition := disposition;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.liens_unrel_cj_ct := liens_unrel_cj_ct;
			self.liens_rel_ot_last_seen := liens_rel_ot_last_seen;
			self.criminal_count := criminal_count;
			self.felony_count := felony_count;
			self.rel_count := rel_count;
			self.rel_prop_owned_count := rel_prop_owned_count;
			self.rel_incomeunder75_count := rel_incomeunder75_count;
			self.rel_incomeunder100_count := rel_incomeunder100_count;
			self.rel_incomeover100_count := rel_incomeover100_count;
			self.watercraft_count := watercraft_count;
			self.acc_count := acc_count;
			self.ams_college_code := ams_college_code;
			self.ams_file_type := ams_file_type;
			self.prof_license_flag := prof_license_flag;
			self.input_dob_age := input_dob_age;
			self.inferred_age := inferred_age;
			self.archive_date := archive_date;
			self.c_inc_200k_p := c_inc_200k_p;
			self.c_inc_201k_p := c_inc_201k_p;
			self.c_inc_150k_p := c_inc_150k_p;
			self.c_inc_125k_p := c_inc_125k_p;
			self.c_inc_100k_p := c_inc_100k_p;
			self.sysdate := sysdate;
			self._archive_date := _archive_date;
			self.sysdate_2 := sysdate_2;
			self.adl_match_lvl := adl_match_lvl;
			self.adl_match_lvl_m := adl_match_lvl_m;
			self.curr_owner_lvl_b1 := curr_owner_lvl_b1;
			self.prev_owner_lvl_b1 := prev_owner_lvl_b1;
			self.curr_owner_lvl_b2 := curr_owner_lvl_b2;
			self.prev_owner_lvl_b2 := prev_owner_lvl_b2;
			self.prev_owner_lvl := prev_owner_lvl;
			self.curr_owner_lvl := curr_owner_lvl;
			self.curr_prev_owner_lvl := curr_prev_owner_lvl;
			self.curr_prev_owner_lvl_m := curr_prev_owner_lvl_m;
			self.hi_area := hi_area;
			self.hi_stories := hi_stories;
			self.hi_rooms := hi_rooms;
			self.hi_beds := hi_beds;
			self.hi_baths := hi_baths;
			self.hi_parking := hi_parking;
			self.nice_house_lvl := nice_house_lvl;
			self.nice_house_lvl_b1 := nice_house_lvl_b1;
			self.nice_house_lvl_2 := nice_house_lvl_2;
			self.nice_house_lvl_m := nice_house_lvl_m;
			self.property_owned_purchase_total_a := property_owned_purchase_total_a;
			self.property_owned_purchase_tot_lvl := property_owned_purchase_tot_lvl;
			self.prop_owned_purchase_tot_lvl_m := prop_owned_purchase_tot_lvl_m;
			self._liens_rel_ot_last_seen := _liens_rel_ot_last_seen;
			self.months_liens_rel_ot_last_seen := months_liens_rel_ot_last_seen;
			self.rel_ot_lien_lvl := rel_ot_lien_lvl;
			self.rel_ot_lien_lvl_m := rel_ot_lien_lvl_m;
			self.criminal_lvl := criminal_lvl;
			self.criminal_lvl_m := criminal_lvl_m;
			self.rel_income100plus_count := rel_income100plus_count;
			self.rel_income75plus_count := rel_income75plus_count;
			self.rel_income50plus_count := rel_income50plus_count;
			self.rel_prop_own_pct := rel_prop_own_pct;
			self.rel_income75plus_pct := rel_income75plus_pct;
			self.rel_income100plus_pct := rel_income100plus_pct;
			self.rel_income75plus_count_2 := rel_income75plus_count_2;
			self.rel_income100plus_count_2 := rel_income100plus_count_2;
			self.rel_income50plus_pct := rel_income50plus_pct;
			self.rel_income50plus_count_2 := rel_income50plus_count_2;
			self.rel_income_lvl := rel_income_lvl;
			self.rel_income_lvl_m := rel_income_lvl_m;
			self.rel_prop_own_pct_lvl := rel_prop_own_pct_lvl;
			self.rel_prop_own_pct_lvl_m := rel_prop_own_pct_lvl_m;
			self.adls_per_addr_lvl_b1 := adls_per_addr_lvl_b1;
			self.adls_per_addr_lvl_b2 := adls_per_addr_lvl_b2;
			self.adls_per_addr_lvl := adls_per_addr_lvl;
			self.adls_per_addr_lvl_m := adls_per_addr_lvl_m;
			self.c_inc200kplus_pct := c_inc200kplus_pct;
			self.c_inc150kplus_pct := c_inc150kplus_pct;
			self.c_inc125kplus_pct := c_inc125kplus_pct;
			self.c_inc100kplus_pct := c_inc100kplus_pct;
			self.c_income_lvl := c_income_lvl;
			self.c_income_lvl_m := c_income_lvl_m;
			self.attr_total_number_derogs_lvl := attr_total_number_derogs_lvl;
			self.attr_total_number_derogs_lvl_m := attr_total_number_derogs_lvl_m;
			self.attr_num_rel_liens_lvl := attr_num_rel_liens_lvl;
			self.attr_num_rel_liens_lvl_m := attr_num_rel_liens_lvl_m;
			self.ams_college_lvl := ams_college_lvl;
			self.ams_college_lvl_m := ams_college_lvl_m;
			self.combo_age := combo_age;
			self.combo_age_c := combo_age_c;
			self.nas12 := nas12;
			self.phn_pots := phn_pots;
			self.good_phn_counts := good_phn_counts;
			self._gong_did_last_seen := _gong_did_last_seen;
			self.months_gong_did_last_seen := months_gong_did_last_seen;
			self.adl_seen_recent_no_dcs := adl_seen_recent_no_dcs;
			self.attr_num_unrel_liens30_flag := attr_num_unrel_liens30_flag;
			self.attr_eviction_count_flag := attr_eviction_count_flag;
			self.hphnpop := hphnpop;
			self.nap_ver_b1_c2_b1 := nap_ver_b1_c2_b1;
			self.nap_ver_b1_c2_b2 := nap_ver_b1_c2_b2;
			self.nap_ver_b1 := nap_ver_b1;
			self.nap_ver := nap_ver;
			self.combo_nap_ver := combo_nap_ver;
			self.combo_nap_ver_m := combo_nap_ver_m;
			self.bk_lvl := bk_lvl;
			self.bk_lvl_m := bk_lvl_m;
			self.lien_unrel_lvl := lien_unrel_lvl;
			self.combo_lien_unrel_lvl := combo_lien_unrel_lvl;
			self.combo_lien_unrel_lvl_m := combo_lien_unrel_lvl_m;
			self.other_bad_flag := other_bad_flag;
			self.RSN1001_Log := RSN1001_Log;
			self.base := base;
			self.point := point;
			self.odds := odds;
			self.phat := phat;
			self.rsn1001_1_0 := rsn1001_1_0;
			self.rsn1001_1_0_2 := rsn1001_1_0_2;
		#else
			self.seq := (string)le.seq;
			self.recover_score := (string3)rsn1001_1_0_2;
			self := [];
		#end

	END;
	
	model := join(clam, easi.key_easi_census, 
				keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
				doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

	return model;

END;