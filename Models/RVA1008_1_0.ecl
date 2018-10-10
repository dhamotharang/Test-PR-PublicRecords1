import risk_indicators, ut, riskwisefcra, riskwise, std, riskview;

export RVA1008_1_0( grouped dataset(risk_indicators.layout_boca_shell) clam,
	boolean inCalif, real in_employment_years, real in_employment_months, real total_income
	) := FUNCTION

RVA_DEBUG := false;

#if(RVA_DEBUG)
	layout_debug := record
		risk_indicators.Layout_Boca_Shell clam;
		real in_employment_years;
		real in_employment_months;
		real total_income;
		Boolean trueDID;
		String out_unit_desig;
		String out_sec_range;
		String out_addr_type;
		Integer NAS_Summary;
		Integer NAP_Summary;
		String rc_hriskphoneflag;
		String rc_phonevalflag;
		String rc_hphonevalflag;
		String rc_phonezipflag;
		String rc_pwphonezipflag;
		String rc_hriskaddrflag;
		String rc_decsflag;
		String rc_pwssnvalflag;
		String rc_dwelltype;
		String rc_bansflag;
		String rc_sources;
		String rc_phonetype;
		String rc_ziptypeflag;
		String rc_zipclass;
		Integer combo_dobscore;
		Boolean voter_avail;
		String add1_avm_land_use;
		Integer add1_avm_automated_valuation;
		Integer add1_avm_med_fips;
		Integer add1_naprop;
		String add1_building_area;
		Integer property_owned_total;
		Integer property_sold_total;
		Integer dist_a1toa2;
		String telcordia_type;
		Integer addrs_per_adl_c6;
		Integer infutor_nap;
		Integer impulse_count;
		Integer attr_eviction_count;
		Integer attr_date_last_eviction;
		Boolean Bankrupt;
		Integer date_last_seen;
		String disposition;
		Integer filing_count;
		Integer bk_recent_count;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer criminal_count;
		Integer criminal_last_date;
		String ams_college_tier;
		String prof_license_category;
		String input_dob_match_level;
		String addr_stability;
		Integer archive_date;

		Integer sysdate;
		Boolean source_tot_BA;
		Boolean source_tot_DS;
		Boolean source_tot_VO;
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean bk_flag;
		Integer date_last_seen2;
		Real mth_date_last_seen;
		Integer bk_lvl;
		Real bk_lvl_m;
		Integer attr_date_last_eviction2;
		Real mth_attr_date_last_eviction;
		Real evict_lvl;
		Real evict_lvl_m;
		Integer criminal_last_date2;
		Real mth_criminal_last_date;
		Integer criminal_lvl;
		Real criminal_lvl_m;
		Integer impulse_count_2;
		Real impulse_count_2_m;
		Integer liens_unrel_lvl;
		Real liens_unrel_lvl_m;
		Boolean add_pobox;
		Boolean add_unit;
		Boolean add_sec;
		Boolean add_apt;
		Integer addprob;
		Integer sfd_lvl;
		Real sfd_lvl_m;
		Real addr_stability_m;
		Integer avm_index_fips;
		Integer avm_index_fips_lvl;
		Real avm_index_fips_lvl_m;
		Integer college_tier_lvl;
		Real college_tier_lvl_m;
		Integer prof_lic_lvl;
		Real prof_lic_lvl_m;
		Boolean nas_ver10;
		Integer nap_lvl;
		Integer infutor_lvl;
		Integer verx_lvl;
		Integer verx_lvl2;
		Integer dob_ver;
		Integer verx_lvl3;
		Real verx_lvl3_m;
		Boolean phn_disconnected;
		Boolean phn_inval;
		Boolean phn_nonus;
		Boolean phn_notpots;
		Boolean phn_zipmismatch;
		Boolean phn_business;
		Integer phn_prob;
		Real phn_prob_m;
		Boolean move50;
		Boolean ssn_issued18;
		Boolean voter;
		Integer addrs_per_adl_c6_lvl;
		Real addrs_per_adl_c6_lvl_m;
		Integer income_lvl_client;
		Real income_lvl_client_m;
		Real employment_years;
		Integer employ_yrs_rd_2;
		Real employ_yrs_rd_2_m;
		Real custom_1;
		Integer Base;
		Real odds;
		Integer point;
		Real Custom;
		Real phat;
		Integer rva1008_3;
		Integer rva1008_2;
		Integer rva1008_1;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean lien_flag;
		Boolean ssn_deceased;
		Boolean scored_222s;
		Integer rva1008;
		Models.Layout_ModelOut;
	end;
	layout_debug doModel( clam le ) := TRANSFORM
#else
	Models.layout_modelout doModel( clam le ) := TRANSFORM
#end

		truedid                          := le.truedid;
		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_hphonevalflag                 := le.iid.hphonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_hriskaddrflag                 := le.iid.hriskaddrflag;
		rc_decsflag                      := le.iid.decsflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		rc_sources                       := le.iid.sources;
		rc_phonetype                     := le.iid.phonetype;
		rc_ziptypeflag                   := le.iid.ziptypeflag;
		rc_zipclass                      := le.iid.zipclass;
		combo_dobscore                   := le.iid.combo_dobscore;
		voter_avail                      := le.available_sources.voter;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_building_area               := (string)le.address_verification.input_address_information.building_area;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		telcordia_type                   := le.phone_verification.telcordia_type;
		addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
		infutor_nap                      := le.infutor_phone.infutor_nap;
		impulse_count                    := le.impulse.count;
		attr_eviction_count              := le.bjl.eviction_count;
		attr_date_last_eviction          := le.bjl.last_eviction_date;
		bankrupt                         := le.bjl.bankrupt;
		date_last_seen                   := le.bjl.date_last_seen;
		disposition                      := le.bjl.disposition;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		criminal_count                   := le.bjl.criminal_count;
		criminal_last_date               := le.bjl.last_criminal_date;
		ams_college_tier                 := le.student.college_tier;
		prof_license_category            := le.professional_license.plcategory;
		input_dob_match_level            := le.dobmatchlevel;
		addr_stability                   := le.mobility_indicator;
		archive_date                     := le.historydate;
		// archive_date                     := if( le.historydate=999999, (unsigned3)(ut.getdate[1..6]), le.historydate );;



		NULL := -999999999;

		INTEGER year(integer sas_date) :=
			if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		sysdate := map(
				trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
				length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																															 NULL);

		source_tot_ba := Models.common.findw_cpp(rc_sources, 'BA' , ' ,', 'I') > 0;
		source_tot_ds := Models.common.findw_cpp(rc_sources, 'DS' , ' ,', 'I') > 0;
		source_tot_vo := Models.common.findw_cpp(rc_sources, 'VO' , ' ,', 'I') > 0;
		source_tot_l2 := Models.common.findw_cpp(rc_sources, 'L2' , ' ,', 'I') > 0;
		source_tot_li := Models.common.findw_cpp(rc_sources, 'LI' , ' ,', 'I') > 0;

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)source_tot_ba = 1 or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		date_last_seen2 := models.common.sas_date((string)(date_last_seen));

		mth_date_last_seen := if(min(sysdate, date_last_seen2) = NULL, NULL, (sysdate - date_last_seen2) / 30.5);

		bk_lvl := map(
				0 <= mth_date_last_seen AND mth_date_last_seen <= 12 and filing_count > 1 => 1,
				0 <= mth_date_last_seen AND mth_date_last_seen <= 12                      => -1,
				(integer)bk_flag = 0                                                      => 0,
				(integer)bk_flag = 1 and disposition != ' '                                => 1,
				filing_count = 0 and (integer)bk_flag = 1                                 => 1,
				(integer)bk_flag = 1 and disposition  = ' '                                => 2,
																																										 0);

		bk_lvl_m := map(
				bk_lvl = -1 => 0.0370147457,
				bk_lvl = 0  => 0.0575479566,
				bk_lvl = 1  => 0.0641591266,
				bk_lvl = 2  => 0.0996309963,
											 0.0583380815);

		attr_date_last_eviction2 := models.common.sas_date((string)(attr_date_last_eviction));

		mth_attr_date_last_eviction := if(min(sysdate, attr_date_last_eviction2) = NULL, NULL, (sysdate - attr_date_last_eviction2) / 30.5);

		evict_lvl := map(
				attr_eviction_count = 0          => 0,
				mth_attr_date_last_eviction > 24 => 0.5,
																						min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 3));

		evict_lvl_m := map(
				evict_lvl = 0   => 0.0570490778,
				evict_lvl = 0.5 => 0.0687446627,
				evict_lvl = 1   => 0.0845771144,
				evict_lvl = 2   => 0.1013215859,
				evict_lvl = 3   => 0.1428571429,
													 0.0583380815);

		criminal_last_date2 := models.common.sas_date((string)(criminal_last_date));

		mth_criminal_last_date := if(min(sysdate, criminal_last_date2) = NULL, NULL, (sysdate - criminal_last_date2) / 30.5);

		criminal_lvl := map(
				criminal_count = 0                                                                          => 0,
				(criminal_count in [1, 2]) and mth_criminal_last_date > 12                                  => 1,
				(criminal_count in [1, 2]) and 0 <= mth_criminal_last_date AND mth_criminal_last_date <= 12 => 3,
				criminal_count > 2 and mth_criminal_last_date > 12                                          => 2,
				criminal_count > 2 and 0 <= mth_criminal_last_date AND mth_criminal_last_date <= 12         => 4,
																																																			 0);

		criminal_lvl_m := map(
				criminal_lvl = 0 => 0.0567452025,
				criminal_lvl = 1 => 0.0850086157,
				criminal_lvl = 2 => 0.1005025126,
				criminal_lvl = 3 => 0.13671875,
				criminal_lvl = 4 => 0.2291666667,
														0.0583380815);

		impulse_count_2 := min(if(impulse_count = NULL, -NULL, impulse_count), 2);

		impulse_count_2_m := map(
				impulse_count_2 = 0 => 0.0579415549,
				impulse_count_2 = 1 => 0.0829875519,
				impulse_count_2 = 2 => 0.1147540984,
															 0.0583380815);

		liens_unrel_lvl := map(
				(liens_historical_unreleased_ct in [0, 1]) and liens_recent_unreleased_count = 0                  => 0,
				(liens_historical_unreleased_ct in [0, 1, 2, 3]) and (liens_recent_unreleased_count in [0, 1, 2]) => 2,
				liens_historical_unreleased_ct > 3 and liens_recent_unreleased_count = 0                          => 1,
				liens_historical_unreleased_ct > 3 and (liens_recent_unreleased_count in [1, 2])                  => 3,
				(liens_historical_unreleased_ct in [0, 1]) and liens_recent_unreleased_count = 3                  => 3,
				(liens_historical_unreleased_ct in [2, 3]) and liens_recent_unreleased_count = 3                  => 4,
				liens_historical_unreleased_ct > 3 and liens_recent_unreleased_count = 3                          => 4,
				liens_recent_unreleased_count > 3                                                                 => 4,
																																																						 0);

		liens_unrel_lvl_m := map(
				liens_unrel_lvl = 0 => 0.0570102976,
				liens_unrel_lvl = 1 => 0.0596107056,
				liens_unrel_lvl = 2 => 0.0624633775,
				liens_unrel_lvl = 3 => 0.0714285714,
				liens_unrel_lvl = 4 => 0.1059190031,
															 0.0583380815);

		add_pobox := rc_hriskaddrflag = (string)1 or rc_ziptypeflag = (string)1 or StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'E' or StringLib.StringToUpperCase(trim(rc_zipclass, LEFT, RIGHT)) = 'P' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'P';

		add_unit := out_unit_desig != ' ';

		add_sec := out_sec_range != ' ';

		add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

		addprob := map(
				(integer)add_unit = 1 or (integer)add_sec = 1 or (integer)add_pobox = 1 => 2,
				(integer)add_apt = 1                                                    => 1,
																																									 0);

		sfd_lvl := map(
				(trim(rc_dwelltype) != '' or add1_avm_land_use = (string)2 or add1_building_area = (string)0) and addprob = 2 => -2,
				trim(rc_dwelltype) != '' or add1_avm_land_use = (string)2                                                     => 1,
				add1_building_area = (string)0                                                                           => 0,
				   0 < (integer)add1_building_area AND (integer)add1_building_area <= 1000                               => 0,
				1000 < (integer)add1_building_area AND (integer)add1_building_area <= 1500                               => 1500,
				1500 < (integer)add1_building_area AND (integer)add1_building_area <= 2000                               => 2000,
				2000 < (integer)add1_building_area AND (integer)add1_building_area <= 2500                               => 2500,
				2500 < (integer)add1_building_area AND (integer)add1_building_area <= 3000                               => 3000,
																																																								    3500);

		sfd_lvl_m := map(
				sfd_lvl = -2   => 0.0762476895,
				sfd_lvl = 0    => 0.0658910629,
				sfd_lvl = 1    => 0.0634985662,
				sfd_lvl = 1500 => 0.0563335455,
				sfd_lvl = 2000 => 0.0460559796,
				sfd_lvl = 2500 => 0.0422788606,
				sfd_lvl = 3000 => 0.04,
				sfd_lvl = 3500 => 0.0369588173,
													0.0583380815);

		addr_stability_m := map(
				addr_Stability = (string)0 => 0.0716064757,
				addr_Stability = (string)1 => 0.0782190132,
				addr_Stability = (string)2 => 0.0673127292,
				addr_Stability = (string)3 => 0.0598540146,
				addr_Stability = (string)4 => 0.0519507835,
				addr_Stability = (string)5 => 0.0498045057,
				addr_Stability = (string)6 => 0.0418395574,
																			0.0583380815);
		avm_index_fips := if(add1_avm_med_fips = 0 or add1_avm_automated_valuation = 0, -1, truncate(100*add1_avm_automated_valuation / add1_avm_med_fips));
		// avm_index_fips := if(add1_avm_med_fips = 0 or add1_avm_automated_valuation = 0, -1, truncate(add1_avm_automated_valuation / add1_avm_med_fips * 100));

		avm_index_fips_lvl := map(
				avm_index_fips = -1                           => -1,
				0 <= avm_index_fips AND avm_index_fips <= 70  => 1,
				70 < avm_index_fips AND avm_index_fips <= 110 => 2,
																												 3);

		avm_index_fips_lvl_m := map(
				avm_index_fips_lvl = -1 => 0.0667438888,
				avm_index_fips_lvl = 1  => 0.0565790798,
				avm_index_fips_lvl = 2  => 0.0529641186,
				avm_index_fips_lvl = 3  => 0.0395889997,
																	 0.0583380815);

		college_tier_lvl := map(
				trim(ams_college_tier) = '' or ams_college_tier = (string)0 => 0,
				(ams_college_tier in ['1', '2'])                                => 2,
				(ams_college_tier in ['3', '4'])                                => 4,
																																					 (unsigned1)ams_college_tier);

		college_tier_lvl_m := map(
				college_tier_lvl = 0 => 0.0596158005,
				college_tier_lvl = 2 => 0.0337837838,
				college_tier_lvl = 4 => 0.0382577987,
				college_tier_lvl = 5 => 0.0421496312,
				college_tier_lvl = 6 => 0.0425531915,
																0.0583380815);

		prof_lic_lvl := map(
				prof_license_category = (string)5 => 4,
				prof_license_category = (string)2 => 3,
				prof_license_category = (string)4 => 2,
				prof_license_category = (string)3 => 1,
																						 0);

		prof_lic_lvl_m := map(
				prof_lic_lvl = 0 => 0.0592353258,
				prof_lic_lvl = 1 => 0.0537190083,
				prof_lic_lvl = 2 => 0.0378854626,
				prof_lic_lvl = 3 => 0.0339506173,
				prof_lic_lvl = 4 => 0.0208333333,
														0.0583380815);

		nas_ver10 := nas_summary > 9;

		nap_lvl := map(
				nap_summary = 12              => 12,
				(nap_summary in [10, 11])     => 11,
				(nap_summary in [4, 6, 7, 9]) => 9,
				(nap_summary in [2, 3, 5, 8]) => 8,
				nap_summary = 0               => 0,
																				 -1);

		infutor_lvl := map(
				infutor_nap = 0 => 0,
				infutor_nap = 1 => 1,
													 2);

		verx_lvl := map(
				nap_lvl = 12 and infutor_lvl = 0                     => 5,
				nap_lvl = 11 and infutor_lvl = 0                     => 4,
				nap_lvl = 9 and infutor_lvl = 0                      => 3,
				(nap_lvl in [8, 0, -1]) and infutor_lvl = 2          => 3,
				(nap_lvl in [8, 0, -1]) and (infutor_lvl in [0, 1])  => 2,
				(nap_lvl in [9, 11, 12]) and (infutor_lvl in [1, 2]) => 1,
																																0);

		verx_lvl2 := map(
				verx_lvl = 1 and (integer)nas_ver10 = 0 => 0,
				verx_lvl = 1 and (integer)nas_ver10 = 1 => 1,
				verx_lvl = 2 and (integer)nas_ver10 = 0 => 1,
				verx_lvl = 2 and (integer)nas_ver10 = 1 => 2,
				verx_lvl = 3 and (integer)nas_ver10 = 0 => 2,
																									 verx_lvl);

		dob_ver := if(input_dob_match_level = (string)8, 1, 0);

		verx_lvl3 := map(
				verx_lvl2 = 0                 => -1,
				verx_lvl2 = 1 and dob_ver = 0 => 0,
				verx_lvl2 = 1 and dob_ver = 1 => 1,
				verx_lvl2 = 2 and dob_ver = 0 => 1,
				verx_lvl2 = 2 and dob_ver = 1 => 2,
																				 verx_lvl2);

		verx_lvl3_m := map(
				verx_lvl3 = -1 => 0.0888888889,
				verx_lvl3 = 0  => 0.077404222,
				verx_lvl3 = 1  => 0.073704232,
				verx_lvl3 = 2  => 0.0653395146,
				verx_lvl3 = 3  => 0.0503785891,
				verx_lvl3 = 4  => 0.0415606446,
				verx_lvl3 = 5  => 0.0338858736,
													0.0583380815);

		phn_disconnected := rc_hriskphoneflag = (string)5;

		phn_inval := rc_phonevalflag = (string)0 or rc_hphonevalflag = (string)0 or (rc_phonetype in ['5']);

		phn_nonus := (rc_phonetype in ['3', '4']);

		phn_notpots := not((telcordia_type in ['00', '50', '51', '52', '54']));

		phn_zipmismatch := rc_phonezipflag = (string)1 or rc_pwphonezipflag = (string)1;

		phn_business := rc_hphonevalflag = (string)1;

		phn_prob := map(
				(integer)phn_nonus = 1 or (integer)phn_inval = 1 => 3,
				(integer)phn_business = 1                        => 4,
				(integer)phn_disconnected = 1                    => 3,
				(integer)phn_zipmismatch = 1                     => 2,
				(integer)phn_notpots = 1                         => 1,
																														0);

		phn_prob_m := map(
				phn_prob = 0 => 0.0529718808,
				phn_prob = 1 => 0.0637545402,
				phn_prob = 2 => 0.0679785331,
				phn_prob = 3 => 0.0718512257,
				phn_prob = 4 => 0.0732758621,
												0.0583380815);

		move50 := 50 <= dist_a1toa2 AND dist_a1toa2 <= 9998;

		ssn_issued18 := rc_pwssnvalflag = (string)5;

		voter := voter_avail and (integer)source_tot_vo > 0;

		addrs_per_adl_c6_lvl := map(
				addrs_per_adl_c6 = 0 => 0,
				addrs_per_adl_c6 = 1 => 1,
																2);

		addrs_per_adl_c6_lvl_m := map(
				addrs_per_adl_c6_lvl = 0 => 0.0557632464,
				addrs_per_adl_c6_lvl = 1 => 0.075,
				addrs_per_adl_c6_lvl = 2 => 0.0939947781,
																		0.0583380815);

		income_lvl_client := map(
				total_income < 3000                          => 3,
				3000 <= total_income AND total_income < 4000 => 4,
				4000 <= total_income AND total_income < 5000 => 5,
				5000 <= total_income AND total_income < 6000 => 6,
				6000 <= total_income AND total_income < 7000 => 7,
				7000 <= total_income AND total_income < 8000 => 8,
																												9);

		income_lvl_client_m := map(
				income_lvl_client = 3 => 0.0701629037,
				income_lvl_client = 4 => 0.0679061444,
				income_lvl_client = 5 => 0.0646920545,
				income_lvl_client = 6 => 0.059945217,
				income_lvl_client = 7 => 0.0523668639,
				income_lvl_client = 8 => 0.0441003988,
				income_lvl_client = 9 => 0.0324141268,
																 0.0583380815);

		employment_years := in_employment_years + in_employment_months/12.0;
		employ_yrs_rd_2 := if(employment_years = NULL, 0, truncate(min(if(employment_years = NULL, -NULL, employment_years), 2)));

		employ_yrs_rd_2_m := map(
				employ_yrs_rd_2 = 0 => 0.0689139821,
				employ_yrs_rd_2 = 1 => 0.0636050022,
				employ_yrs_rd_2 = 2 => 0.0563238622,
															 0.0583380815);

		custom_1 := -13.65814298 +
				bk_lvl_m * 19.398078805 +
				evict_lvl_m * 6.946003058 +
				criminal_lvl_m * 10.343116751 +
				impulse_count_2_m * 13.732941844 +
				liens_unrel_lvl_m * 9.6411401628 +
				sfd_lvl_m * 7.1394162433 +
				addr_stability_m * 12.819960166 +
				(integer)move50 * -0.276224073 +
				avm_index_fips_lvl_m * 7.8374627841 +
				college_tier_lvl_m * 18.133008003 +
				prof_lic_lvl_m * 17.242805935 +
				(integer)voter * -0.219989793 +
				verx_lvl3_m * 14.99084269 +
				phn_prob_m * 7.909666024 +
				(integer)ssn_issued18 * 0.1678947347 +
				addrs_per_adl_c6_lvl_m * 6.2544123058 +
				income_lvl_client_m * 19.671929242 +
				employ_yrs_rd_2_m * 14.472193119;

		base := 660;

		odds := .10 / .90;

		point := -80;

		custom := exp(custom_1) / (1 + exp(custom_1));

		phat := custom;

		rva1008_3 := truncate(point * (ln(phat / (1 - phat)) - ln(odds)) / ln(2) + base);

		rva1008_2 := min(if(rva1008_3 = NULL, -NULL, rva1008_3), 900);

		rva1008_1 := max(rva1008_2, 501);

		lien_rec_unrel_flag := liens_recent_unreleased_count > 0;

		lien_hist_unrel_flag := liens_historical_unreleased_ct > 0;

		lien_flag := (integer)source_tot_l2 = 1 or (integer)source_tot_li = 1 or lien_rec_unrel_flag or lien_hist_unrel_flag;

		ssn_deceased := rc_decsflag = (string)1 or (integer)source_tot_ds = 1;

		scored_222s := if(max(property_owned_total, property_sold_total) = NULL, NULL, sum(if(property_owned_total = NULL, 0, property_owned_total), if(property_sold_total = NULL, 0, property_sold_total))) > 0 OR (90 <= combo_dobscore AND combo_dobscore <= 100 or input_dob_match_level >= (string)7 or (integer)lien_flag > 0 or criminal_count > 0 or (integer)bk_flag > 0 or ssn_deceased or truedid);

		rva1008 := if(riskview.constants.noscore(le.iid.nas_summary,le.iid.nap_summary, le.address_verification.input_address_information.naprop, le.truedid) , 222, rva1008_1);


		#if(RVA_DEBUG)
			self.clam := le;
			self.in_employment_years              := in_employment_years;
			self.in_employment_months             := in_employment_months;
			self.total_income                     := total_income;
		
			self.truedid                          := truedid;
			self.out_unit_desig                   := out_unit_desig;
			self.out_sec_range                    := out_sec_range;
			self.out_addr_type                    := out_addr_type;
			self.nas_summary                      := nas_summary;
			self.nap_summary                      := nap_summary;
			self.rc_hriskphoneflag                := rc_hriskphoneflag;
			self.rc_phonevalflag                  := rc_phonevalflag;
			self.rc_hphonevalflag                 := rc_hphonevalflag;
			self.rc_phonezipflag                  := rc_phonezipflag;
			self.rc_pwphonezipflag                := rc_pwphonezipflag;
			self.rc_hriskaddrflag                 := rc_hriskaddrflag;
			self.rc_decsflag                      := rc_decsflag;
			self.rc_pwssnvalflag                  := rc_pwssnvalflag;
			self.rc_dwelltype                     := rc_dwelltype;
			self.rc_bansflag                      := rc_bansflag;
			self.rc_sources                       := rc_sources;
			self.rc_phonetype                     := rc_phonetype;
			self.rc_ziptypeflag                   := rc_ziptypeflag;
			self.rc_zipclass                      := rc_zipclass;
			self.combo_dobscore                   := combo_dobscore;
			self.voter_avail                      := voter_avail;
			self.add1_avm_land_use                := add1_avm_land_use;
			self.add1_avm_automated_valuation     := add1_avm_automated_valuation;
			self.add1_avm_med_fips                := add1_avm_med_fips;
			self.add1_naprop                      := add1_naprop;
			self.add1_building_area               := add1_building_area;
			self.property_owned_total             := property_owned_total;
			self.property_sold_total              := property_sold_total;
			self.dist_a1toa2                      := dist_a1toa2;
			self.telcordia_type                   := telcordia_type;
			self.addrs_per_adl_c6                 := addrs_per_adl_c6;
			self.infutor_nap                      := infutor_nap;
			self.impulse_count                    := impulse_count;
			self.attr_eviction_count              := attr_eviction_count;
			self.attr_date_last_eviction          := attr_date_last_eviction;
			self.bankrupt                         := bankrupt;
			self.date_last_seen                   := date_last_seen;
			self.disposition                      := disposition;
			self.filing_count                     := filing_count;
			self.bk_recent_count                  := bk_recent_count;
			self.liens_recent_unreleased_count    := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct   := liens_historical_unreleased_ct;
			self.criminal_count                   := criminal_count;
			self.criminal_last_date               := criminal_last_date;
			self.ams_college_tier                 := ams_college_tier;
			self.prof_license_category            := prof_license_category;
			self.input_dob_match_level            := input_dob_match_level;
			self.addr_stability                   := addr_stability;
			self.archive_date                     := archive_date;

			self.sysdate                          := sysdate;
			self.source_tot_ba                    := source_tot_ba;
			self.source_tot_ds                    := source_tot_ds;
			self.source_tot_vo                    := source_tot_vo;
			self.source_tot_l2                    := source_tot_l2;
			self.source_tot_li                    := source_tot_li;
			self.bk_flag                          := bk_flag;
			self.date_last_seen2                  := date_last_seen2;
			self.mth_date_last_seen               := mth_date_last_seen;
			self.bk_lvl                           := bk_lvl;
			self.bk_lvl_m                         := bk_lvl_m;
			self.attr_date_last_eviction2         := attr_date_last_eviction2;
			self.mth_attr_date_last_eviction      := mth_attr_date_last_eviction;
			self.evict_lvl                        := evict_lvl;
			self.evict_lvl_m                      := evict_lvl_m;
			self.criminal_last_date2              := criminal_last_date2;
			self.mth_criminal_last_date           := mth_criminal_last_date;
			self.criminal_lvl                     := criminal_lvl;
			self.criminal_lvl_m                   := criminal_lvl_m;
			self.impulse_count_2                  := impulse_count_2;
			self.impulse_count_2_m                := impulse_count_2_m;
			self.liens_unrel_lvl                  := liens_unrel_lvl;
			self.liens_unrel_lvl_m                := liens_unrel_lvl_m;
			self.add_pobox                        := add_pobox;
			self.add_unit                         := add_unit;
			self.add_sec                          := add_sec;
			self.add_apt                          := add_apt;
			self.addprob                          := addprob;
			self.sfd_lvl                          := sfd_lvl;
			self.sfd_lvl_m                        := sfd_lvl_m;
			self.addr_stability_m                 := addr_stability_m;
			self.avm_index_fips                   := avm_index_fips;
			self.avm_index_fips_lvl               := avm_index_fips_lvl;
			self.avm_index_fips_lvl_m             := avm_index_fips_lvl_m;
			self.college_tier_lvl                 := college_tier_lvl;
			self.college_tier_lvl_m               := college_tier_lvl_m;
			self.prof_lic_lvl                     := prof_lic_lvl;
			self.prof_lic_lvl_m                   := prof_lic_lvl_m;
			self.nas_ver10                        := nas_ver10;
			self.nap_lvl                          := nap_lvl;
			self.infutor_lvl                      := infutor_lvl;
			self.verx_lvl                         := verx_lvl;
			self.verx_lvl2                        := verx_lvl2;
			self.dob_ver                          := dob_ver;
			self.verx_lvl3                        := verx_lvl3;
			self.verx_lvl3_m                      := verx_lvl3_m;
			self.phn_disconnected                 := phn_disconnected;
			self.phn_inval                        := phn_inval;
			self.phn_nonus                        := phn_nonus;
			self.phn_notpots                      := phn_notpots;
			self.phn_zipmismatch                  := phn_zipmismatch;
			self.phn_business                     := phn_business;
			self.phn_prob                         := phn_prob;
			self.phn_prob_m                       := phn_prob_m;
			self.move50                           := move50;
			self.ssn_issued18                     := ssn_issued18;
			self.voter                            := voter;
			self.addrs_per_adl_c6_lvl             := addrs_per_adl_c6_lvl;
			self.addrs_per_adl_c6_lvl_m           := addrs_per_adl_c6_lvl_m;
			self.income_lvl_client                := income_lvl_client;
			self.income_lvl_client_m              := income_lvl_client_m;
			self.employment_years                 := employment_years;
			self.employ_yrs_rd_2                  := employ_yrs_rd_2;
			self.employ_yrs_rd_2_m                := employ_yrs_rd_2_m;
			self.custom_1                         := custom_1;
			self.base                             := base;
			self.odds                             := odds;
			self.point                            := point;
			self.custom                           := custom;
			self.phat                             := phat;
			self.lien_rec_unrel_flag              := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag             := lien_hist_unrel_flag;
			self.lien_flag                        := lien_flag;
			self.ssn_deceased                     := ssn_deceased;
			self.scored_222s                      := scored_222s;
			self.rva1008_3                        := rva1008_3;
			self.rva1008_2                        := rva1008_2;
			self.rva1008_1                        := rva1008_1;
			self.rva1008                          := rva1008;
		#end


		employ_months := employment_years*12;
		
		self.seq := le.seq;
		corr := RiskWiseFCRA.corrReasonCodes(le.consumerflags, 4);
		
		r := riskwise.reasons( le, isCalifornia := inCalif );
		self.score := map(
			corr[1].hri in ['91','92','93','94'] => (string)((integer)corr[1].hri + 10),
			r.rc35 => '100',
			(string3)rva1008
		);

		// per darrin udean:
		// "For this model, I'd like to move the U1 threshold to 3000 and keep the U2 at 12 months. -darrin"
		inc_threshold := 3000;
		emp_threshold := 12;


		reasons_RVA1008 :=
			if(r.rc02, r.makeRC('02')) &
			if(r.rc03, r.makeRC('03')) &
			if(r.rc97, r.makeRC('97')) &
			if(r.rc50, r.makeRC('50')) &
			if(r.rc42, r.makeRC('42')) &
			if(r.rc43, r.makeRC('43')) &
			if(r.rc98, r.makeRC('98')) &
			if(r.rcEV, r.makeRC('EV')) &
			if(r.rc9H, r.makeRC('9H')) &
			if(r.rc9A, r.makeRC('9A')) &
			if(r.rc9B, r.makeRC('9B')) &
			if(r.rcPV, r.makeRC('PV')) &
			if(r.rc9E, r.makeRC('9E')) &
			if(r.rc9J, r.makeRC('9J')) &
			if(r.rc19, r.makeRC('19')) &
			if(r.rc20, r.makeRC('20')) &
			if(r.rc9C, r.makeRC('9C')) &
			if(r.rc9D, r.makeRC('9D')) &
			// if(r.rc21, r.makeRC('21')) &
			if(r.rc22, r.makeRC('22')) &
			if(r.rc23, r.makeRC('23')) &
			if(r.rc24, r.makeRC('24')) &
			if(r.rc25, r.makeRC('25')) &
			if(r.rc26, r.makeRC('26')) &
			if(risk_indicators.rcSet.isCodeU1( total_income, inc_threshold ), r.makeRC('U1')) &
			if(r.rc28, r.makeRC('28')) &
			if(r.rc27, r.makeRC('27')) &
			if(r.rc9F, r.makeRC('9F')) &
			if(r.rc77, r.makeRC('77')) &
			if(r.rc78, r.makeRC('78')) &
			if(r.rc79, r.makeRC('79')) &
			if(r.rc80, r.makeRC('80')) &
			if(r.rc81, r.makeRC('81')) &
			if(r.rcMS, r.makeRC('MS')) &
			if(r.rcMI, r.makeRC('MI')) &
			// if(NOT r.rcMI AND r.rc38, r.makeRC('38')) &
			if(r.rc9G, r.makeRC('9G')) &
			if(r.rc06, r.makeRC('06')) &
			if(risk_indicators.rcSet.isCodeU2( employ_months, emp_threshold ), r.makeRC('U2')) &
			if(r.rc07, r.makeRC('07')) &
			if(r.rc08, r.makeRC('08')) &
			if(r.rc09, r.makeRC('09')) &
			if(r.rc11, r.makeRC('11')) &
			if(r.rc12, r.makeRC('12')) &
			if(r.rc14, r.makeRC('14')) &
			if(r.rc15, r.makeRC('15')) &
			if(r.rc16, r.makeRC('16')) &
			if(r.rc72, r.makeRC('72')) &
			if(r.rc04, r.makeRC('04')) &
			if(r.rc45, r.makeRC('45')) &
			if(r.rc49, r.makeRC('49')) &
			if(r.rc37, r.makeRC('37')) &
			if(r.rc48, r.makeRC('48')) &
			if(r.rc99, r.makeRC('99')) &
			if(r.rc10, r.makeRC('10')) &
			if(r.rc71, r.makeRC('71')) &
			if(r.rc51, r.makeRC('51')) &
			if(r.rc52, r.makeRC('52')) &
			if(r.rc9I, r.makeRC('9I')) &
			if(r.rc73, r.makeRC('73')) &
			if(r.rc74, r.makeRC('74')) &
			if(r.rc82, r.makeRC('82')) &
			if(r.rc29, r.makeRC('29')) &
			if(r.rc30, r.makeRC('30')) &
			if(r.rc31, r.makeRC('31')) &
			if(r.rc83, r.makeRC('83')) &
			r.makeRC('00') & 
			r.makeRC('00') & 
			r.makeRC('00') & 
			r.makeRC('00')
		;

		self.ri := map(
			corr[1].hri in ['91','92','93','94'] => corr,
			r.rc35 => r.makeRC('35') & r.makeRC('00') & r.makeRC('00') & r.makeRC('00'),
			choosen( reasons_RVA1008, 4 )
		);
	END;

	model := project( clam, doModel(left) );	
	return model;
end;