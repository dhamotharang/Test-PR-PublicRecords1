import easi, risk_indicators, riskwise, ut;

export RSN1009_1_0( grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam	) := FUNCTION

	RSN_DEBUG := false;
	
	#if(RSN_DEBUG)
	layout_debug := record
		Risk_Indicators.Layout_Boca_Shell clam;
		Models.Layout_RecoverScore;
		String out_addr_type;
		String in_dob;
		Integer nap_summary;
		String nap_status;
		String rc_hriskphoneflag;
		String rc_hphonetypeflag;
		String rc_phonevalflag;
		String rc_phonezipflag;
		String rc_pwphonezipflag;
		String rc_pwssnvalflag;
		String rc_sources;
		Integer rc_phonelnamecount;
		Integer rc_phoneaddrcount;
		Integer rc_phonephonecount;
		Integer rc_phoneaddr_lnamecount;
		Boolean rc_altlname1_flag;
		Boolean rc_altlname2_flag;
		Boolean rc_fnamessnmatch;
		Boolean lname_eda_sourced;
		String add1_avm_land_use;
		Integer add1_avm_med_geo11;
		Boolean add1_eda_sourced;
		Boolean add1_applicant_owned;
		Boolean add1_family_owned;
		Integer add1_naprop;
		Integer property_owned_total;
		Integer property_sold_total;
		Integer dist_a1toa2;
		Integer dist_a1toa3;
		Integer dist_a2toa3;
		Integer max_lres;
		Integer addrs_5yr;
		Integer ssns_per_adl;
		Integer adls_per_addr;
		Integer adls_per_phone;
		Integer ssns_per_adl_c6;
		Integer addrs_per_adl_c6;
		Integer ssns_per_addr_c6;
		Integer infutor_first_seen;
		Integer attr_addrs_last36;
		Integer attr_total_number_derogs;
		Integer attr_eviction_count;
		Boolean Bankrupt;
		String disposition;
		Integer liens_recent_unreleased_count;
		Integer liens_historical_unreleased_ct;
		Integer criminal_count;
		Integer rel_criminal_total;
		Integer crim_rel_within25miles;
		Integer rel_prop_owned_count;
		Integer rel_prop_owned_assessed_total;
		Integer rel_prop_sold_count;
		Integer current_count;
		Integer watercraft_count;
		Integer acc_count;
		String ams_college_tier;
		Boolean prof_license_flag;
		String wealth_index;
		String addr_stability;
		Integer estimated_income;
		String archive_date;
		String c_ab_av_edu;
		String c_assault;
		String c_bel_edu;
		String c_born_usa;
		String c_burglary;
		String c_easiqlife;
		String c_exp_prod;
		String c_fammar_p;
		String c_famotf18_p;
		String c_hh2_p;
		String c_highinc;
		String c_hval_200k_p;
		String c_inc_100k_p;
		String c_larceny;
		String c_low_hval;
		String c_lux_prod;
		String c_med_hhinc;
		String c_med_hval;
		String c_med_inc;
		String c_no_move;
		String c_old_homes;
		String c_span_lang;
		String c_cpiall;
		String c_no_labfor;
		String c_housingcpi;
		Integer sysdate;
		Integer sysyear;
		Boolean lien_rec_unrel_flag;
		Boolean lien_hist_unrel_flag;
		Boolean lien_flag;
		Boolean source_tot_L2;
		Boolean source_tot_LI;
		Boolean watercraft_flag;
		Boolean verlst_p;
		Boolean veradd_p;
		Boolean verphn_p;
		Boolean contrary_phn;
		Boolean name_change_flag;
		Boolean phn_cellpager;
		Boolean phn_zipmismatch;
		Boolean ssn_issued18;
		Boolean ssn_adl_prob;
		Boolean add1_AVM_hit;
		Boolean prop_owned_flag;
		Boolean prop_sold_flag;
		Integer _daycap_b1;
		Integer infutor_first_seen2;
		Real years_infutor_first_seen;
		Boolean infutor_flag;
		Boolean attr_eviction_flag;
		Boolean crime_flag;
		Boolean acc_flag;
		Integer out_addr_type1;
		Integer in_dob2;
		Real years_in_dob;
		Integer years_in_dob1;
		Integer nap_summary1;
		Integer nap_status1;
		Integer rc_hphonetypeflag1;
		Integer rc_phonevalflag1;
		boolean source_tot_AM;
		boolean source_tot_AR;
		boolean source_tot_CY;
		boolean source_tot_D;
		boolean source_tot_DL;
		boolean source_tot_EB;
		boolean source_tot_EM;
		boolean source_tot_VO;
		boolean source_tot_EQ;
		boolean source_tot_MW;
		boolean source_tot_P;
		boolean source_tot_PL;
		boolean source_tot_SL;
		boolean source_tot_TU;
		boolean source_tot_V;
		boolean source_tot_W;
		boolean source_tot_WP;
		boolean source_tot_AK;
		boolean source_tot_BA;
		boolean source_tot_CG;
		boolean source_tot_CO;
		boolean source_tot_DA;
		boolean source_tot_DS;
		boolean source_tot_FF;
		boolean source_tot_FR;
		boolean source_tot_NT;
		Integer source_tot_count_pos;
		Integer source_tot_count_neg;
		Integer diff_source_tot_pos_neg;
		Integer diff_source_tot_pos_neg1;
		Integer add1_avm_med_geo11_lvl;
		Integer add1_naprop1;
		Integer addrs_5yr_cap;
		Integer ssns_per_adl1;
		Integer adls_per_addr1;
		Integer adls_per_phone1;
		Integer ssns_per_addr_c61;
		Integer attr_addrs_last361;
		Integer attr_total_number_derogs1;
		Integer disposition1;
		Integer criminal_count1;
		Integer rel_prop_owned_count1;
		Integer rel_prop_sold_count1;
		Integer ams_college_tier1;
		Integer addr_stability1;
		Integer estimated_income1;
		Integer dist_a1toa21;
		Integer dist_a1toa31;
		Integer dist_a2toa31;
		Integer rel_criminal_total1;
		Integer rel_prop_owned_assessed_total1;
		Integer crim_rel_within25miles1;
		Integer current_count1;
		Integer max_lres1;
		Integer c_ab_av_edu1;
		Integer c_assault1;
		Integer c_bel_edu1;
		Integer c_born_usa1;
		Integer c_burglary1;
		Integer c_easiqlife1;
		Integer c_exp_prod1;
		Integer c_fammar_p1;
		Integer c_famotf18_p1;
		Integer c_hh2_p1;
		Integer c_highinc1;
		Integer c_hval_200k_p1;
		Integer c_inc_100k_p1;
		Integer c_larceny1;
		Integer c_low_hval1;
		Integer c_lux_prod1;
		Integer c_med_hhinc1;
		Integer c_med_hval1;
		Integer c_med_inc1;
		Integer c_no_move1;
		Integer c_old_homes1;
		Integer c_span_lang1;
		Integer c_cpiall1;
		Integer c_no_labfor1;
		Integer c_housingcpi1;
		real N0_1;
		real N1_1;
		real N2_1;
		real N3_1;
		real N4_1;
		real N5_1;
		real N6_1;
		real N7_1;
		real N8_1;
		real N9_1;
		real N10_1;
		real N11_1;
		real N12_1;
		real N13_1;
		real N14_1;
		real N15_1;
		real N16_1;
		real N17_1;
		real N18_1;
		real N19_1;
		real N20_1;
		real N21_1;
		real N22_1;
		real N23_1;
		real N24_1;
		real N25_1;
		real N26_1;
		real N27_1;
		real N28_1;
		real N29_1;
		real N30_1;
		real N31_1;
		real N32_1;
		real N33_1;
		real N34_1;
		real N35_1;
		real N36_1;
		real N37_1;
		real N38_1;
		real N39_1;
		real N40_1;
		real N41_1;
		real N42_1;
		real N43_1;
		real N44_1;
		real N45_1;
		real N46_1;
		real N47_1;
		real N48_1;
		real N49_1;
		real N50_1;
		real N51_1;
		real N52_1;
		real N53_1;
		real N54_1;
		real N55_1;
		real N56_1;
		real N57_1;
		real N58_1;
		real N59_1;
		real N60_1;
		real N61_1;
		real N62_1;
		real N63_1;
		real N64_1;
		real N65_1;
		real N66_1;
		real N67_1;
		real N68_1;
		real N69_1;
		real N70_1;
		real N71_1;
		real N72_1;
		real N73_1;
		real N74_1;
		real N75_1;
		real N76_1;
		real N77_1;
		real N78_1;
		real N79_1;
		real N80_1;
		real N81_1;
		real N82_1;
		real N83_1;
		real N84_1;
		real N85_1;
		real N86_1;
		real N87_1;
		real N88_1;
		real N89_1;
		real N90_1;
		real N91_1;
		real N92_1;
		real N93_1;
		real N94_1;
		real N95_1;
		real N96_1;
		real N97_1;
		real N98_1;
		real N99_1;
		real N100_1;
		real N101_1;
		real N102_1;
		real N103_1;
		real N104_1;
		real N105_1;
		real N106_1;
		real N107_1;
		real N108_1;
		real N109_1;
		real N110_1;
		real N111_1;
		real N112_1;
		real N113_1;
		real N114_1;
		real N115_1;
		real N116_1;
		real N117_1;
		real N118_1;
		real N119_1;
		real N120_1;
		real N121_1;
		real N122_1;
		real N123_1;
		real N124_1;
		real N125_1;
		real N126_1;
		real N127_1;
		real N128_1;
		real N129_1;
		real N130_1;
		real N131_1;
		real N132_1;
		real N133_1;
		real N134_1;
		real N135_1;
		real N136_1;
		real N137_1;
		real N138_1;
		real N139_1;
		real N140_1;
		real N141_1;
		real N142_1;
		real N143_1;
		real N144_1;
		real N145_1;
		real N146_1;
		real N147_1;
		real N148_1;
		real N149_1;
		real N150_1;
		real N151_1;
		real N152_1;
		real N153_1;
		real N154_1;
		real N155_1;
		real N156_1;
		real N157_1;
		real N158_1;
		real N159_1;
		real N160_1;
		real N161_1;
		real N162_1;
		real N163_1;
		real N164_1;
		real N165_1;
		real N166_1;
		real N167_1;
		real N168_1;
		real N169_1;
		real N170_1;
		real N171_1;
		real N172_1;
		real N173_1;
		real N174_1;
		real N175_1;
		real N176_1;
		real N177_1;
		real N178_1;
		real N179_1;
		real N180_1;
		real N181_1;
		real N182_1;
		real N183_1;
		real N184_1;
		real N185_1;
		real N186_1;
		real N187_1;
		real N188_1;
		real N189_1;
		real N190_1;
		real N191_1;
		real N192_1;
		real N193_1;
		real tnscore;
		Real class_threshold;
		Real score1;
		Real expsum1;
		Real score0;
		Real expsum;
		Real prob0;
		Real prob1;
		Integer RSN1009_1_0_nocap;
		Integer RSN1009_1_0;
		Integer pred;
	end;
	layout_debug doModel(clam le, easi.Key_Easi_Census ri) := TRANSFORM 
	#else
	Models.Layout_RecoverScore doModel(clam le, easi.Key_Easi_Census ri) := TRANSFORM 
	#end
		out_addr_type                    := le.shell_input.addr_type;
		in_dob                           := le.shell_input.dob;
		nap_summary                      := le.iid.nap_summary;
		nap_status                       := le.iid.nap_status;
		rc_hriskphoneflag                := le.iid.hriskphoneflag;
		rc_hphonetypeflag                := le.iid.hphonetypeflag;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_phonezipflag                  := le.iid.phonezipflag;
		rc_pwphonezipflag                := le.iid.pwphonezipflag;
		rc_pwssnvalflag                  := le.iid.pwsocsvalflag;
		rc_sources                       := le.iid.sources;
		rc_phonelnamecount               := le.iid.phonelastcount;
		rc_phoneaddrcount                := le.iid.phoneaddrcount;
		rc_phonephonecount               := le.iid.phonephonecount;
		rc_phoneaddr_lnamecount          := le.iid.phoneaddr_lastcount;
		rc_altlname1_flag                := le.iid.altlastpop;
		rc_altlname2_flag                := le.iid.altlast2pop;
		rc_fnamessnmatch                 := le.iid.firstssnmatch;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		add1_avm_land_use                := le.avm.input_address_information.avm_land_use_code;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_eda_sourced                 := le.address_verification.input_address_information.eda_sourced;
		add1_applicant_owned             := le.address_verification.input_address_information.applicant_owned;
		add1_family_owned                := le.address_verification.input_address_information.family_owned;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		property_owned_total             := le.address_verification.owned.property_total;
		property_sold_total              := le.address_verification.sold.property_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a1toa3                      := le.address_verification.distance_in_2_h2;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		max_lres                         := le.other_address_info.max_lres;
		addrs_5yr                        := le.other_address_info.addrs_last_5years;
		ssns_per_adl                     := le.velocity_counters.ssns_per_adl;
		adls_per_addr                    := le.velocity_counters.adls_per_addr;
		adls_per_phone                   := le.velocity_counters.adls_per_phone;
		ssns_per_adl_c6                  := le.velocity_counters.ssns_per_adl_created_6months;
		addrs_per_adl_c6                 := le.velocity_counters.addrs_per_adl_created_6months;
		ssns_per_addr_c6                 := le.velocity_counters.ssns_per_addr_created_6months;
		infutor_first_seen               := le.infutor_phone.infutor_date_first_seen;
		attr_addrs_last36                := le.other_address_info.addrs_last36;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		bankrupt                         := le.bjl.bankrupt;
		disposition                      := le.bjl.disposition;
		liens_recent_unreleased_count    := le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct   := le.bjl.liens_historical_unreleased_count;
		criminal_count                   := le.bjl.criminal_count;
		rel_criminal_total               := le.relatives.relative_criminal_total;
		crim_rel_within25miles           := le.relatives.criminal_relative_within25miles;
		rel_prop_owned_count             := le.relatives.owned.relatives_property_count;
		rel_prop_owned_assessed_total    := le.relatives.owned.relatives_property_owned_assessed_total;
		rel_prop_sold_count              := le.relatives.sold.relatives_property_count;
		current_count                    := le.vehicles.current_count;
		watercraft_count                 := le.watercraft.watercraft_count;
		acc_count                        := le.accident_data.acc.num_accidents;
		ams_college_tier                 := le.student.college_tier;
		prof_license_flag                := le.professional_license.professional_license_flag;
		wealth_index                     := le.wealth_indicator;
		addr_stability                   := le.mobility_indicator;
		estimated_income                 := le.estimated_income;
		archive_date                     := if(999999=le.historydate, ut.GetDate[1..6], (string6)le.historydate );


		c_ab_av_edu                      := trim(ri.ab_av_edu);
		c_assault                        := trim(ri.assault);
		c_bel_edu                        := trim(ri.bel_edu);
		c_born_usa                       := trim(ri.born_usa);
		c_burglary                       := trim(ri.burglary);
		c_easiqlife                      := trim(ri.easiqlife);
		c_exp_prod                       := trim(ri.exp_prod);
		c_fammar_p                       := trim(ri.fammar_p);
		c_famotf18_p                     := trim(ri.famotf18_p);
		c_hh2_p                          := trim(ri.hh2_p);
		c_highinc                        := trim(ri.highinc);
		c_hval_200k_p                    := trim(ri.hval_200k_p);
		// c_inc_100k_p                     := trim(ri.inc_100k_p);
		c_inc_100k_p                     := trim(ri.in100k_p); // is this the right field?
		c_larceny                        := trim(ri.larceny);
		c_low_hval                       := trim(ri.low_hval);
		c_lux_prod                       := trim(ri.lux_prod);
		c_med_hhinc                      := trim(ri.med_hhinc);
		c_med_hval                       := trim(ri.med_hval);
		c_med_inc                        := trim(ri.med_inc);
		c_no_move                        := trim(ri.no_move);
		c_old_homes                      := trim(ri.old_homes);
		c_span_lang                      := trim(ri.span_lang);
		c_cpiall                         := trim(ri.cpiall);
		c_no_labfor                      := trim(ri.no_labfor);
		c_housingcpi                     := trim(ri.housingcpi);


		NULL := -999999999;
		INTEGER year(integer sas_date) := if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		sysdate := models.common.sas_date( archive_date );
		sysyear := year( sysdate );

		lien_rec_unrel_flag := (liens_recent_unreleased_count > 0);
		lien_hist_unrel_flag := (liens_historical_unreleased_ct > 0);
		Models.Common.findw(rc_sources, 'L2', ' ,', 'I', source_tot_L2, 'bool');
		Models.Common.findw(rc_sources, 'LI', ' ,', 'I', source_tot_LI, 'bool');
		lien_flag := (((integer)source_tot_L2 = 1) or (((integer)source_tot_LI = 1) or (lien_rec_unrel_flag or lien_hist_unrel_flag)));
		watercraft_flag := (watercraft_count > 0);
		verlst_p := (nap_summary in [2, 5, 7, 8, 9, 11, 12]);
		veradd_p := (nap_summary in [3, 5, 6, 8, 10, 11, 12]);
		verphn_p := (nap_summary in [4, 6, 7, 9, 10, 11, 12]);
		contrary_phn := (nap_summary in [1]);
		name_change_flag := (((integer)rc_altlname1_flag = 1) or ((integer)rc_altlname2_flag = 1));
		phn_cellpager := ((rc_hriskphoneflag in ['1', '2', '3']) or (rc_hphonetypeflag in ['1', '2', '3']));
		phn_zipmismatch := (((integer)rc_phonezipflag = 1) or ((integer)rc_pwphonezipflag = 1));
		ssn_issued18 := ((integer)rc_pwssnvalflag = 5);
		ssn_adl_prob := ((ssns_per_adl = 0) or ((ssns_per_adl >= 3) or (ssns_per_adl_c6 >= 2)));
		add1_AVM_hit := ((integer)add1_avm_land_use > 0);
		prop_owned_flag := (property_owned_total > 0);
		prop_sold_flag := (property_sold_total > 0);

		_daycap_b1 := map((min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))) in [1, 3, 5, 7, 8, 10, 12]) => 31,
						(min(12, if(max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim((string)infutor_first_seen, LEFT))[5..6]))) in [4, 6, 9, 11]) => 30,
						(28 + (integer)(((((integer)(trim((string)infutor_first_seen, LEFT))[1..4] % 4) = 0) and (((integer)(trim((string)infutor_first_seen, LEFT))[1..4] % 100) > 0)) or (((integer)(trim((string)infutor_first_seen, LEFT))[1..4] % 400) = 0))));

		infutor_first_seen2 := models.common.sas_date( (string)infutor_first_seen );

		years_infutor_first_seen :=  if((sysdate != NULL) and (infutor_first_seen2 != NULL), ((sysdate - infutor_first_seen2) / 365.25), NULL);
		infutor_flag := (years_infutor_first_seen > 0);
		attr_eviction_flag := (attr_eviction_count > 0);
		crime_flag := (criminal_count > 0);
		acc_flag := (acc_count > 0);
		out_addr_type1 :=  if(out_addr_type = 'S', 1, 2);

		in_dob2 := models.common.sas_date( in_dob );

		years_in_dob :=  if((sysdate != NULL) and (in_dob2 != NULL), ((sysdate - in_dob2) / 365.25), NULL);

		years_in_dob1 :=  map(years_in_dob = NULL  => 1,
							  years_in_dob <= 22 => 4,
							  years_in_dob <= 25 => 3,
							  years_in_dob <= 45 => 2,
															 1);

		nap_summary1 :=  map(nap_summary >= 11                      => 1,
							 (nap_summary = 6) or (nap_summary = 1) => 3,
																	   2);

		nap_status1 :=  if(nap_status = 'C', 1, 2);

		rc_hphonetypeflag1 :=  if((rc_hphonetypeflag = '1') or (rc_hphonetypeflag = '0'), 1, 2);

		rc_phonevalflag1 :=  map(((integer)rc_phonevalflag = 2) or ((integer)rc_phonevalflag = 1) => 1,
								 (integer)rc_phonevalflag = 4                                     => 3,
																									 2);

		Models.Common.findw(rc_sources, 'AM', ' ,', 'I', source_tot_AM, 'bool');
		Models.Common.findw(rc_sources, 'AR', ' ,', 'I', source_tot_AR, 'bool');
		Models.Common.findw(rc_sources, 'CY', ' ,', 'I', source_tot_CY, 'bool');
		Models.Common.findw(rc_sources, 'D', ' ,', 'I', source_tot_D, 'bool');
		Models.Common.findw(rc_sources, 'DL', ' ,', 'I', source_tot_DL, 'bool');
		Models.Common.findw(rc_sources, 'EB', ' ,', 'I', source_tot_EB, 'bool');
		Models.Common.findw(rc_sources, 'EM', ' ,', 'I', source_tot_EM, 'bool');
		Models.Common.findw(rc_sources, 'VO', ' ,', 'I', source_tot_VO, 'bool');
		Models.Common.findw(rc_sources, 'EQ', ' ,', 'I', source_tot_EQ, 'bool');
		Models.Common.findw(rc_sources, 'MW', ' ,', 'I', source_tot_MW, 'bool');
		Models.Common.findw(rc_sources, 'P', ' ,', 'I', source_tot_P, 'bool');
		Models.Common.findw(rc_sources, 'PL', ' ,', 'I', source_tot_PL, 'bool');
		Models.Common.findw(rc_sources, 'SL', ' ,', 'I', source_tot_SL, 'bool');
		Models.Common.findw(rc_sources, 'TU', ' ,', 'I', source_tot_TU, 'bool');
		Models.Common.findw(rc_sources, 'V', ' ,', 'I', source_tot_V, 'bool');
		Models.Common.findw(rc_sources, 'W', ' ,', 'I', source_tot_W, 'bool');
		Models.Common.findw(rc_sources, 'WP', ' ,', 'I', source_tot_WP, 'bool');
		Models.Common.findw(rc_sources, 'AK', ' ,', 'I', source_tot_AK, 'bool');
		Models.Common.findw(rc_sources, 'BA', ' ,', 'I', source_tot_BA, 'bool');
		Models.Common.findw(rc_sources, 'CG', ' ,', 'I', source_tot_CG, 'bool');
		Models.Common.findw(rc_sources, 'CO', ' ,', 'I', source_tot_CO, 'bool');
		Models.Common.findw(rc_sources, 'DA', ' ,', 'I', source_tot_DA, 'bool');
		Models.Common.findw(rc_sources, 'DS', ' ,', 'I', source_tot_DS, 'bool');
		Models.Common.findw(rc_sources, 'FF', ' ,', 'I', source_tot_FF, 'bool');
		Models.Common.findw(rc_sources, 'FR', ' ,', 'I', source_tot_FR, 'bool');
		Models.Common.findw(rc_sources, 'NT', ' ,', 'I', source_tot_NT, 'bool');

		source_tot_count_pos := sum((integer)source_tot_AM, (integer)source_tot_AR, (integer)source_tot_CY, (integer)source_tot_D, (integer)source_tot_DL, (integer)source_tot_EB, (integer)source_tot_EM, (integer)source_tot_VO, (integer)source_tot_EQ, (integer)source_tot_MW, (integer)source_tot_P, (integer)source_tot_PL, (integer)source_tot_SL, (integer)source_tot_V, (integer)source_tot_TU, (integer)source_tot_W, (integer)source_tot_WP);
		source_tot_count_neg := sum((integer)source_tot_AK, (integer)source_tot_BA, (integer)source_tot_CG, (integer)source_tot_CO, (integer)source_tot_DA, (integer)source_tot_DS, (integer)source_tot_FF, (integer)source_tot_FR, (integer)source_tot_L2, (integer)source_tot_LI, (integer)source_tot_NT);
		diff_source_tot_pos_neg := (source_tot_count_pos - source_tot_count_neg);

		diff_source_tot_pos_neg1 :=  map(diff_source_tot_pos_neg >= 4 => 4,
										 diff_source_tot_pos_neg <= 0 => 0,
																		 diff_source_tot_pos_neg);

		add1_avm_med_geo11_lvl :=  map(add1_avm_med_geo11 = 0       => 2,
									   add1_avm_med_geo11 <= 100000 => 3,
									   add1_avm_med_geo11 <= 200000 => 2,
																	   1);

		add1_naprop1 :=  map(add1_naprop = 0 => 1,
							 add1_naprop = 1 => 0,
												add1_naprop);

		addrs_5yr_cap :=  if(addrs_5yr >= 5, 5, addrs_5yr);

		ssns_per_adl1 :=  if(ssns_per_adl = 1, 1, 2);

		adls_per_addr1 :=  map(adls_per_addr = 2                              => 1,
							   (adls_per_addr > 2) and (adls_per_addr <= 8)   => 2,
							   (adls_per_addr >= 1) and (adls_per_addr <= 12) => 3,
																				 4);

		adls_per_phone1 :=  map(adls_per_phone = 2 => 1,
								adls_per_phone = 1 => 2,
													  3);

		ssns_per_addr_c61 :=  if(ssns_per_addr_c6 >= 2, 2, ssns_per_addr_c6);
		attr_addrs_last361 :=  if(attr_addrs_last36 >= 4, 4, attr_addrs_last36);
		attr_total_number_derogs1 :=  if(attr_total_number_derogs >= 4, 4, attr_total_number_derogs);

		disposition1 :=  map(disposition = 'Discharged' => 1,
							 disposition = 'Dismissed'  => 3,
														   2);

		criminal_count1 :=  if(criminal_count >= 2, 2, criminal_count);
		rel_prop_owned_count1 :=  if(rel_prop_owned_count > 0, 1, 0);
		rel_prop_sold_count1 :=  if(rel_prop_sold_count > 0, 1, 0);
		ams_college_tier1 :=  if(ams_college_tier = ' ', 0, 1);

		addr_stability1 :=  map((integer)addr_stability >= 5 => 1,
								(integer)addr_stability >= 2 => 2,
																3);

		estimated_income1 :=  map(estimated_income <= 35000 => 3,
								  estimated_income <= 40000 => 2,
															   1);

		dist_a1toa21 :=  map(dist_a1toa2 <= 1                               => 2,
							 (dist_a1toa2 >= 1000) and (dist_a1toa2 < 9999) => 1,
																			   3);

		dist_a1toa31 :=  map(dist_a1toa3 <= 1                               => 2,
							 (dist_a1toa3 >= 1000) and (dist_a1toa3 < 9999) => 1,
																			   3);

		dist_a2toa31 :=  map(dist_a2toa3 = 0                                => 2,
							 (dist_a2toa3 >= 1000) and (dist_a2toa3 < 9999) => 1,
																			   3);

		rel_criminal_total1 :=  if(rel_criminal_total >= 6, 6, rel_criminal_total);

		rel_prop_owned_assessed_total1 :=  map(rel_prop_owned_assessed_total <= 100000 => 3,
											   rel_prop_owned_assessed_total <= 300000 => 2,
																						  1);

		crim_rel_within25miles1 :=  if(crim_rel_within25miles >= 4, 4, crim_rel_within25miles);

		current_count1 :=  if(current_count >= 2, 2, current_count);

		max_lres1 :=  map(max_lres <= 60  => 4,
						  max_lres <= 80  => 3,
						  max_lres <= 172 => 2,
											 1);

		// # warning:  engineer intervention needed -- attribute not assigned in clause and no default value given for attribute
		// addrs_per_adl_c6 :=  if(addrs_per_adl_c6 >= 1, 1, 0);

		// Nick's converter used (integer) casts for all the census values, which is a big semantic bug, as it truncates values,
		// incorrectly bucketing some values. While it's not necessary for all of these to be cast to reals (see the plethora of
		// floating point issues we have) because some census values are only logical integers, it's probably safer to to guarantee
		// no truncation than it is to analyze every field and assert integers for some of them.
		// I hope the new census2010 file does better than string fields for everything.
		c_ab_av_edu1 :=  map((c_ab_av_edu = '') or ((real)c_ab_av_edu <= 23) => 5,
							 (real)c_ab_av_edu <= 60                                 => 4,
							 (real)c_ab_av_edu <= 112                                => 3,
							 (real)c_ab_av_edu <= 180                                => 2,
																						   1);

		c_assault1 :=  map((c_assault = '') or ((real)c_assault >= 174) => 4,
						   (real)c_assault <= 14                                => 1,
						   (real)c_assault <= 45                                => 2,
						   (real)c_assault <= 120                               => 3,
																					  4);

		c_bel_edu1 :=  map(c_bel_edu = '' => 4,
						   (real)c_bel_edu <= 54  => 1,
						   (real)c_bel_edu <= 99  => 2,
						   (real)c_bel_edu <= 147 => 3,
														4);

		c_born_usa1 :=  map((c_born_usa = '') or ((real)c_born_usa <= 23) => 4,
							(real)c_born_usa <= 48                                => 3,
							(real)c_born_usa <= 135                               => 2,
																						1);

		c_burglary1 :=  map(c_burglary = ''    => 4,
							(real)c_burglary <= 47  => 1,
							(real)c_burglary <= 125 => 2,
							(real)c_burglary <= 171 => 3,
														  4);

		c_easiqlife1 :=  map(c_easiqlife = ''    => 3,
							 (real)c_easiqlife <= 100 => 1,
							 (real)c_easiqlife <= 111 => 2,
															3);

		c_exp_prod1 :=  map((c_exp_prod = '') or ((real)c_exp_prod <= 57) => 4,
							(real)c_exp_prod <= 95                                => 3,
							(real)c_exp_prod <= 125                               => 2,
																						1);

		c_fammar_p1 :=  map((c_fammar_p = '' or (real)c_fammar_p <= 68) => 4,
							(real)c_fammar_p <= 83                                => 3,
							(real)c_fammar_p <= 89                                => 2,
																						1);

		c_famotf18_p1 :=  map(c_famotf18_p = ''   => 4,
							  (real)c_famotf18_p <= 4  => 1,
							  (real)c_famotf18_p <= 8  => 2,
							  (real)c_famotf18_p <= 10 => 3,
															 4);

		c_hh2_p1 :=  map((c_hh2_p = '') or ((real)c_hh2_p <= 22) => 4,
						 (real)c_hh2_p <= 28                             => 3,
						 (real)c_hh2_p <= 37                             => 2,
																			   1);

		c_highinc1 :=  map((c_highinc = '') or ((real)c_highinc <= 3) => 3,
						   (real)c_highinc <= 10                              => 2,
																					1);

		c_hval_200k_p1 :=  map((c_hval_200k_p = '') or ((real)c_hval_200k_p <= 0) => 4,
							   (real)c_hval_200k_p <= 4                                   => 3,
							   (real)c_hval_200k_p <= 9                                   => 2,
																								1);

		c_inc_100k_p1 :=  map((c_inc_100k_p = '') or ((real)c_inc_100k_p <= 8) => 4,
							  (real)c_inc_100k_p <= 11                                 => 3,
							  (real)c_inc_100k_p <= 15                                 => 2,
																							 1);

		c_larceny1 :=  map((c_larceny = '') or ((real)c_larceny >= 164) => 4,
						   (real)c_larceny <= 38                                => 1,
						   (real)c_larceny <= 143                               => 2,
																					  3);

		c_low_hval1 :=  map((c_low_hval = '') or ((real)c_low_hval < 0) => 4,
							(real)c_low_hval <= 2                               => 1,
							(real)c_low_hval <= 13                              => 2,
							(real)c_low_hval <= 44                              => 3,
																					  4);

		c_lux_prod1 :=  map((c_lux_prod = '') or ((real)c_lux_prod <= 33) => 4,
							(real)c_lux_prod <= 100                               => 3,
							(real)c_lux_prod <= 152                               => 2,
																						1);

		c_med_hhinc1 :=  map((c_med_hhinc = '') or ((real)c_med_hhinc <= 40000) => 4,
							 (real)c_med_hhinc <= 47000                                 => 3,
							 (real)c_med_hhinc <= 70000                                 => 2,
																							  1);

		c_med_hval1 :=  map((c_med_hval = '') or ((real)c_med_hval <= 82000) => 4,
							(real)c_med_hval <= 115000                               => 3,
							(real)c_med_hval <= 145000                               => 2,
																						   1);

		c_med_inc1 :=  map((c_med_inc = '') or ((real)c_med_inc <= 58) => 3,
						   (real)c_med_inc <= 96                               => 2,
																					 1);

		c_no_move1 :=  map((c_no_move = '') or ((real)c_no_move <= 29) => 4,
						   (real)c_no_move <= 42                               => 3,
						   (real)c_no_move <= 122                              => 2,
																					 1);

		c_old_homes1 :=  map((c_old_homes = '') or ((real)c_old_homes <= 34) => 4,
							 (real)c_old_homes <= 83                                 => 3,
							 (real)c_old_homes <= 117                                => 2,
																						   1);

		c_span_lang1 :=  map(c_span_lang = ''    => 3,
							 (real)c_span_lang <= 82  => 1,
							 (real)c_span_lang <= 135 => 2,
															3);

		c_cpiall1 :=  map((c_cpiall = '') or ((real)c_cpiall <= 187) => 4,
						  (real)c_cpiall <= 195                              => 3,
						  (real)c_cpiall <= 205                              => 2,
																				   1);

		c_no_labfor1 :=  map(c_no_labfor = ''    => 3,
							 (real)c_no_labfor <= 23  => 1,
							 (real)c_no_labfor <= 151 => 2,
															3);

		c_housingcpi1 :=  map((c_housingcpi = '') or ((real)c_housingcpi <= 180) => 4,
							  (real)c_housingcpi <= 196                                  => 3,
							  (real)c_housingcpi <= 216                                  => 2,
																						   1);

		N0_5 := if(((real)c_assault1 < 3.5), -0.0901462, -0.104794);
		N0_4 := if(((real)c_hval_200k_p1 < 3.5), N0_5, -0.10541);
		N0_3 := if(((real)source_tot_tu < 0.5), -0.111804, -0.0832487);
		N0_2 := if(((real)years_in_dob1 < 1.5), -0.0698683, N0_3);
		N0_1 := if(((real)c_burglary1 < 1.5), N0_2, N0_4);

		N1_5 := if(((real)rc_hphonetypeflag1 < 1.5), 0.000814428, -0.026922);
		N1_4 := if(((real)lien_flag < 0.5), N1_5, -0.0124114);
		N1_3 := if((estimated_income < 29500), -0.0216991, N1_4);
		N1_2 := if((estimated_income < 39500), 0.00187428, 0.0183953);
		N1_1 := if(((real)c_easiqlife1 < 1.5), N1_2, N1_3);

		N2_5 := if(((real)lien_flag < 0.5), 0.00556356, -0.0102632);
		N2_4 := if((estimated_income < 42500), -0.0113729, N2_5);
		N2_3 := if(((real)c_low_hval1 < 2.5), 0.0140695, -0.00758638);
		N2_2 := if((estimated_income < 38500), N2_3, 0.0137176);
		N2_1 := if(((real)c_easiqlife1 < 2.5), N2_2, N2_4);

		N3_5 := if(((real)rel_criminal_total1 < 2.5), -0.00488882, -0.0170949);
		N3_4 := if(((real)disposition1 < 1.5), 0.00432309, N3_5);
		N3_3 := if(((real)c_burglary1 < 1.5), 0.00812276, N3_4);
		N3_2 := if(((real)ssn_issued18 < 0.5), 0.00547679, 0.0204125);
		N3_1 := if(((real)c_easiqlife1 < 1.5), N3_2, N3_3);

		N4_5 := if(((real)rc_phonevalflag1 < 1.5), 1.72735e-005, -0.0110063);
		N4_4 := if(((real)crim_rel_within25miles1 < 1.5), 0.0210947, 0.0019762);
		N4_3 := if(((real)lien_rec_unrel_flag < 0.5), N4_4, -0.00459465);
		N4_2 := if((estimated_income < 31500), -0.00175251, N4_3);
		N4_1 := if(((real)c_easiqlife1 < 2.5), N4_2, N4_5);

		N5_5 := if(((real)c_larceny1 < 2.5), 0.0187227, -0.00135067);
		N5_4 := if(((real)infutor_flag < 0.5), 0.00808957, -0.00322823);
		N5_3 := if(((real)rc_hphonetypeflag1 < 1.5), N5_4, -0.0242534);
		N5_2 := if(((integer)add1_family_owned < 0.5), N5_3, N5_5);
		N5_1 := if(((real)rel_criminal_total1 < 2.5), N5_2, -0.00680365);

		N6_5 := if(((real)years_in_dob1 < 1.5), 0.00386765, -0.00590182);
		N6_4 := if(((real)c_cpiall1 < 3.5), N6_5, -0.0164193);
		N6_3 := if(((real)c_larceny1 < 2.5), 0.0160474, -0.00115907);
		N6_2 := if(((real)rel_criminal_total1 < 3.5), N6_3, -0.0046932);
		N6_1 := if(((real)c_easiqlife1 < 1.5), N6_2, N6_4);

		N7_5 := if(((real)crim_rel_within25miles1 < 2.5), -0.00406242, -0.0205863);
		N7_4 := if(((real)c_old_homes1 < 1.5), 0.00675421, -0.00599529);
		N7_3 := if((estimated_income < 67500), N7_4, 0.026962);
		N7_2 := if(((real)c_burglary1 < 1.5), 0.0193057, N7_3);
		N7_1 := if(((real)c_easiqlife1 < 2.5), N7_2, N7_5);

		N8_5 := if(((real)c_burglary1 < 3.5), -0.00635908, -0.0222065);
		N8_4 := if(((real)crim_rel_within25miles1 < 0.5), 0.000620309, N8_5);
		N8_3 := if(((real)rel_prop_owned_assessed_total1 < 2.5), 0.0147933, -0.00393656);
		N8_2 := if(((real)rc_phoneaddr_lnamecount < 0.5), N8_3, 0.0173089);
		N8_1 := if(((real)c_easiqlife1 < 1.5), N8_2, N8_4);

		N9_5 := if(((real)adls_per_addr1 < 2.5), 0.0107096, -0.00245435);
		N9_4 := if(((real)rc_hphonetypeflag1 < 1.5), N9_5, -0.0276198);
		N9_3 := if(((real)rel_criminal_total1 < 2.5), N9_4, -0.0136577);
		N9_2 := if(((real)c_burglary1 < 1.5), 0.0183709, 0.00250407);
		N9_1 := if(((real)years_in_dob1 < 1.5), N9_2, N9_3);

		N10_5 := if(((real)disposition1 < 1.5), 0.0024494, -0.0148194);
		N10_4 := if(((real)rel_criminal_total1 < 1.5), 0.000508809, N10_5);
		N10_3 := if(((real)c_med_hval1 < 3.5), 0.00724652, -0.0109161);
		N10_2 := if(((real)add1_naprop1 < 2.5), N10_3, 0.013761);
		N10_1 := if(((real)c_easiqlife1 < 2.5), N10_2, N10_4);

		N11_5 := if(((real)disposition1 < 1.5), 0.00646945, -0.00545038);
		N11_4 := if(((real)crim_rel_within25miles1 < 3.5), N11_5, -0.0195924);
		N11_3 := if(((real)c_assault1 < 2.5), 0.0257249, 0.00772803);
		N11_2 := if(((integer)lname_eda_sourced < 0.5), 0.000412267, N11_3);
		N11_1 := if(((real)rel_criminal_total1 < 0.5), N11_2, N11_4);

		N12_5 := if(((real)years_in_dob1 < 2.5), -0.00523492, -0.0291148);
		N12_4 := if(((real)lien_flag < 0.5), 0.0139427, 0.00053223);
		N12_3 := if(((real)c_larceny1 < 3.5), 0.00264393, -0.0140527);
		N12_2 := if(((real)add1_naprop1 < 2.5), N12_3, N12_4);
		N12_1 := if(((real)rel_criminal_total1 < 3.5), N12_2, N12_5);

		N13_5 := if(((real)c_ab_av_edu1 < 3.5), 0.0120965, -0.00547506);
		N13_4 := if(((real)addrs_5yr_cap < 3.5), -0.00123286, -0.0137493);
		N13_3 := if(((integer)add1_family_owned < 0.5), N13_4, N13_5);
		N13_2 := if(((real)rc_phonevalflag1 < 2.5), N13_3, -0.0269908);
		N13_1 := if(((real)c_cpiall1 < 1.5), 0.0245378, N13_2);

		N14_5 := if(((real)max_lres1 < 1.5), 0.0212729, 0.00273655);
		N14_4 := if(((real)c_med_hval1 < 2.5), N14_5, -0.00521932);
		N14_3 := if(((real)lien_flag < 0.5), N14_4, -0.0110322);
		N14_2 := if((estimated_income < 34500), -0.00334983, 0.0146353);
		N14_1 := if(((real)c_old_homes1 < 1.5), N14_2, N14_3);

		N15_5 := if(((real)criminal_count1 < 1.5), 0.00519632, -0.0154724);
		N15_4 := if((estimated_income < 45500), -0.00763577, N15_5);
		N15_3 := if(((real)c_burglary1 < 1.5), 0.0191983, 0.00594233);
		N15_2 := if(((real)wealth_index < 1.5), -0.0156157, N15_3);
		N15_1 := if(((real)c_easiqlife1 < 1.5), N15_2, N15_4);

		N16_5 := if(((real)disposition1 < 1.5), 0.0110374, -0.000971139);
		N16_4 := if(((real)diff_source_tot_pos_neg1 < 3.5), 0.0028701, 0.0214675);
		N16_3 := if(((real)c_old_homes1 < 1.5), N16_4, N16_5);
		N16_2 := if(((real)c_larceny1 < 2.5), N16_3, -0.00572012);
		N16_1 := if(((real)rel_criminal_total1 < 5.5), N16_2, -0.0103545);

		N17_5 := if(((real)addrs_5yr_cap < 2.5), 0.00461025, -0.0057676);
		N17_4 := if(((real)c_med_hval1 < 3.5), N17_5, -0.00992147);
		N17_3 := if(((real)dist_a1toa21 < 1.5), 0.0202999, N17_4);
		N17_2 := if(((real)c_old_homes1 < 1.5), 0.0129139, N17_3);
		N17_1 := if((estimated_income < 29500), -0.0140829, N17_2);

		N18_5 := if(((real)c_low_hval1 < 2.5), 0.0098801, -0.00441563);
		N18_4 := if(((real)years_in_dob1 < 1.5), N18_5, -0.00752928);
		N18_3 := if(((real)c_burglary1 < 3.5), N18_4, -0.0154574);
		N18_2 := if(((real)rc_hphonetypeflag1 < 1.5), 0.00729842, -0.0167249);
		N18_1 := if(((real)rel_criminal_total1 < 0.5), N18_2, N18_3);

		N19_5 := if(((real)c_old_homes1 < 2.5), 0.00025447, -0.0108864);
		N19_4 := if(((real)source_tot_em < 0.5), N19_5, 0.0117805);
		N19_3 := if(((real)c_med_hhinc1 < 2.5), 0.0057925, N19_4);
		N19_2 := if(((real)criminal_count1 < 1.5), N19_3, -0.0142017);
		N19_1 := if(((real)rc_phonevalflag1 < 2.5), N19_2, -0.0256283);

		N20_5 := if(((real)c_low_hval1 < 2.5), 0.0100372, -0.0028844);
		N20_4 := if(((real)ssns_per_addr_c61 < 0.5), N20_5, -0.00735943);
		N20_3 := if(((real)c_old_homes1 < 1.5), 0.0119308, N20_4);
		N20_2 := if((estimated_income < 29500), -0.00944057, N20_3);
		N20_1 := if(((real)rc_phonevalflag1 < 2.5), N20_2, -0.0207864);

		N21_5 := if(((real)c_assault1 < 3.5), -0.00243404, -0.0171921);
		N21_4 := if(((real)lien_flag < 0.5), 0.00217556, -0.00980707);
		N21_3 := if(((real)c_easiqlife1 < 1.5), 0.00818725, N21_4);
		N21_2 := if(((real)attr_addrs_last361 < 1.5), N21_3, N21_5);
		N21_1 := if(((real)c_cpiall1 < 1.5), 0.021265, N21_2);

		N22_5 := if(((real)c_cpiall1 < 3.5), -0.00481314, -0.0179188);
		N22_4 := if(((real)dist_a2toa31 < 1.5), 0.0112292, N22_5);
		N22_3 := if(((real)c_ab_av_edu1 < 4.5), 0.00414786, -0.0131037);
		N22_2 := if(((real)c_span_lang1 < 2.5), N22_3, N22_4);
		N22_1 := if(((real)c_cpiall1 < 1.5), 0.0183101, N22_2);

		N23_5 := if(((real)c_housingcpi1 < 3.5), -0.000227397, -0.0187963);
		N23_4 := if(((real)c_assault1 < 2.5), 0.0323997, 0.00941509);
		N23_3 := if(((real)current_count1 < 1.5), 0.00171392, N23_4);
		N23_2 := if(((real)c_easiqlife1 < 2.5), N23_3, N23_5);
		N23_1 := if(((real)years_in_dob1 < 3.5), N23_2, -0.0196873);

		N24_5 := if(((real)c_old_homes1 < 3.5), -0.00398256, -0.0202577);
		N24_4 := if(((real)crim_rel_within25miles1 < 0.5), 0.0101866, -0.00202393);
		N24_3 := if(((real)source_tot_tu < 0.5), -0.00678374, N24_4);
		N24_2 := if(((real)attr_total_number_derogs1 < 0.5), N24_3, N24_5);
		N24_1 := if(((real)disposition1 < 1.5), 0.00752114, N24_2);

		N25_5 := if(((real)c_bel_edu1 < 3.5), -0.0042923, -0.0172416);
		N25_4 := if(((real)infutor_flag < 0.5), 0.00116351, N25_5);
		N25_3 := if(((real)c_highinc1 < 1.5), 0.0120582, -0.00350994);
		N25_2 := if(((real)ssn_issued18 < 0.5), N25_3, 0.0169268);
		N25_1 := if(((real)c_easiqlife1 < 1.5), N25_2, N25_4);

		N26_5 := if(((real)source_tot_tu < 0.5), -0.012167, 0.00689998);
		N26_4 := if(((real)c_old_homes1 < 2.5), N26_5, -0.00738623);
		N26_3 := if(((real)phn_cellpager < 0.5), N26_4, 0.0125146);
		N26_2 := if(((real)addrs_5yr_cap < 2.5), 0.00989002, -0.0012839);
		N26_1 := if(((real)dist_a1toa31 < 2.5), N26_2, N26_3);

		N27_5 := if(((real)current_count1 < 0.5), -0.0094851, -0.000260878);
		N27_4 := if(((real)c_cpiall1 < 2.5), 0.0127344, N27_5);
		N27_3 := if(((real)dist_a1toa31 < 2.5), 0.0133128, 0.00306657);
		N27_2 := if(((real)rel_criminal_total1 < 0.5), N27_3, N27_4);
		N27_1 := if(((real)rc_hphonetypeflag1 < 1.5), N27_2, -0.0196002);

		N28_5 := if(((real)c_easiqlife1 < 2.5), 0.00561363, -0.0051506);
		N28_4 := if(((real)dist_a1toa31 < 1.5), 0.0205935, N28_5);
		N28_3 := if(((real)addr_stability1 < 1.5), 0.0139622, N28_4);
		N28_2 := if(((real)crim_rel_within25miles1 < 0.5), N28_3, -0.00467246);
		N28_1 := if(((real)rc_phonevalflag1 < 2.5), N28_2, -0.0235039);

		N29_5 := if((estimated_income < 40500), -0.00160724, 0.0142292);
		N29_4 := if(((real)attr_total_number_derogs1 < 1.5), N29_5, -0.0113106);
		N29_3 := if(((real)rel_prop_owned_count1 < 0.5), -0.00915095, N29_4);
		N29_2 := if(((real)years_in_dob1 < 1.5), 0.00601668, N29_3);
		N29_1 := if(((real)crim_rel_within25miles1 < 1.5), N29_2, -0.00848975);

		N30_5 := if(((real)c_med_hhinc1 < 3.5), 0.00664932, -0.00874923);
		N30_4 := if(((real)add1_naprop1 < 0.5), -0.0125775, N30_5);
		N30_3 := if(((real)ssn_issued18 < 0.5), N30_4, 0.0134872);
		N30_2 := if(((real)c_span_lang1 < 2.5), N30_3, -0.00561612);
		N30_1 := if(((real)dist_a2toa31 < 1.5), 0.0175795, N30_2);

		N31_5 := if(((real)c_cpiall1 < 1.5), 0.0172677, -0.00448728);
		N31_4 := if(((real)c_span_lang1 < 2.5), 0.00534721, N31_5);
		N31_3 := if(((real)attr_addrs_last361 < 3.5), N31_4, -0.0126344);
		N31_2 := if(((real)c_no_labfor1 < 1.5), 0.0153925, N31_3);
		N31_1 := if(((real)criminal_count1 < 1.5), N31_2, -0.0112725);

		N32_5 := if(((real)c_famotf18_p1 < 1.5), 0.00517613, -0.0117578);
		N32_4 := if(((real)c_burglary1 < 1.5), 0.0104595, N32_5);
		N32_3 := if(((real)c_no_move1 < 2.5), 0.00720015, -0.000862787);
		N32_2 := if(((real)ssns_per_adl1 < 1.5), N32_3, N32_4);
		N32_1 := if(((real)c_larceny1 < 3.5), N32_2, -0.00976649);

		N33_5 := if(((real)c_housingcpi1 < 3.5), -0.000768014, -0.0166936);
		N33_4 := if(((real)wealth_index < 2.5), -0.00222243, 0.00862931);
		N33_3 := if(((real)c_span_lang1 < 2.5), N33_4, N33_5);
		N33_2 := if(((real)lien_rec_unrel_flag < 0.5), N33_3, -0.0102989);
		N33_1 := if(((real)criminal_count1 < 1.5), N33_2, -0.0149803);

		N34_5 := if(((real)c_easiqlife1 < 2.5), 0.013945, -0.000180093);
		N34_4 := if(((real)c_fammar_p1 < 3.5), 0.00648151, -0.00704397);
		N34_3 := if(((real)lien_flag < 0.5), N34_4, -0.00493588);
		N34_2 := if(((real)wealth_index < 2.5), -0.00969181, N34_3);
		N34_1 := if(((real)ssn_issued18 < 0.5), N34_2, N34_5);

		N35_5 := if(((real)c_old_homes1 < 2.5), 0.00492288, -0.00945237);
		N35_4 := if(((real)nap_status1 < 1.5), 0.00871643, N35_5);
		N35_3 := if(((real)lien_flag < 0.5), -0.000901591, -0.00963158);
		N35_2 := if(((real)rc_hphonetypeflag1 < 1.5), N35_3, -0.0185305);
		N35_1 := if((estimated_income < 42500), N35_2, N35_4);

		N36_5 := if(((real)c_assault1 < 2.5), 0.00898871, -0.00799519);
		N36_4 := if(((real)addrs_5yr_cap < 3.5), 0.0127173, -0.00193304);
		N36_3 := if(((real)attr_total_number_derogs1 < 0.5), N36_4, 0.00067517);
		N36_2 := if(((real)ssns_per_addr_c61 < 0.5), N36_3, N36_5);
		N36_1 := if((estimated_income < 29500), -0.0104848, N36_2);

		N37_5 := if(((real)ssns_per_adl1 < 1.5), -0.00261303, -0.0127449);
		N37_4 := if((estimated_income < 41500), -0.00734404, 0.0109041);
		N37_3 := if(((real)ssn_issued18 < 0.5), N37_4, 0.0188985);
		N37_2 := if(((real)c_old_homes1 < 1.5), N37_3, N37_5);
		N37_1 := if(((real)disposition1 < 1.5), 0.00716562, N37_2);

		N38_5 := if(((real)c_fammar_p1 < 3.5), -0.00276499, -0.0160697);
		N38_4 := if(((real)rel_criminal_total1 < 1.5), 0.00298245, -0.00437112);
		N38_3 := if(((real)rc_hphonetypeflag1 < 1.5), N38_4, -0.017245);
		N38_2 := if(((real)ssn_issued18 < 0.5), N38_3, 0.00838227);
		N38_1 := if(((real)c_larceny1 < 3.5), N38_2, N38_5);

		N39_5 := if(((real)phn_cellpager < 0.5), -0.00822633, 0.00609716);
		N39_4 := if(((real)source_tot_em < 0.5), -0.000324493, 0.0173968);
		N39_3 := if(((real)years_in_dob1 < 1.5), N39_4, N39_5);
		N39_2 := if(((real)c_fammar_p1 < 1.5), 0.0178701, 0.00396116);
		N39_1 := if(((real)rel_prop_owned_assessed_total1 < 2.5), N39_2, N39_3);

		N40_5 := if(((real)ssns_per_adl1 < 1.5), -0.00522004, -0.0222576);
		N40_4 := if((estimated_income < 47500), -0.00516014, 0.00556551);
		N40_3 := if(((real)addrs_per_adl_c6 < 0.5), N40_4, 0.0104512);
		N40_2 := if(((real)crime_flag < 0.5), N40_3, N40_5);
		N40_1 := if(((real)c_burglary1 < 1.5), 0.00691511, N40_2);

		N41_5 := if(((real)out_addr_type1 < 1.5), -0.00898586, 0.00159585);
		N41_4 := if(((real)attr_addrs_last361 < 2.5), 0.000424909, -0.0210281);
		N41_3 := if(((real)rel_prop_owned_assessed_total1 < 2.5), 0.014146, N41_4);
		N41_2 := if(((real)c_easiqlife1 < 1.5), N41_3, N41_5);
		N41_1 := if(((real)c_assault1 < 2.5), 0.00541005, N41_2);

		N42_5 := if(((real)c_cpiall1 < 3.5), 0.00733302, -0.0127416);
		N42_4 := if(((real)ssn_issued18 < 0.5), -0.00586568, N42_5);
		N42_3 := if(((real)attr_addrs_last361 < 2.5), 0.00345237, -0.0114509);
		N42_2 := if(((real)years_in_dob1 < 1.5), 0.0114405, N42_3);
		N42_1 := if(((real)rel_criminal_total1 < 0.5), N42_2, N42_4);

		N43_5 := if(((real)crim_rel_within25miles1 < 2.5), 0.00549731, -0.0119736);
		N43_4 := if(((real)rel_prop_owned_assessed_total1 < 2.5), N43_5, -0.00524282);
		N43_3 := if(((real)c_burglary1 < 1.5), 0.0203343, 0.003492);
		N43_2 := if(((real)c_hh2_p1 < 1.5), N43_3, N43_4);
		N43_1 := if(((real)c_cpiall1 < 1.5), 0.0169052, N43_2);

		N44_5 := if((estimated_income < 31500), -0.00694219, 0.00942435);
		N44_4 := if(((real)c_old_homes1 < 1.5), N44_5, -0.0051478);
		N44_3 := if(((real)c_easiqlife1 < 2.5), 0.00797698, -0.000901405);
		N44_2 := if(((real)dist_a2toa31 < 1.5), 0.01763, N44_3);
		N44_1 := if(((real)c_low_hval1 < 2.5), N44_2, N44_4);

		N45_5 := if(((real)addrs_per_adl_c6 < 0.5), -0.00557065, 0.00805861);
		N45_4 := if(((real)c_cpiall1 < 3.5), 0.000341937, -0.0158886);
		N45_3 := if(((real)add1_naprop1 < 0.5), -0.00490665, 0.0102083);
		N45_2 := if(((real)c_span_lang1 < 2.5), N45_3, N45_4);
		N45_1 := if(((real)c_low_hval1 < 2.5), N45_2, N45_5);

		N46_5 := if(((real)estimated_income1 < 1.5), 0.0129389, -0.00525177);
		N46_4 := if(((real)ssn_issued18 < 0.5), N46_5, 0.0239938);
		N46_3 := if(((real)add1_naprop1 < 0.5), -0.0116096, 0.00274945);
		N46_2 := if(((real)current_count1 < 1.5), N46_3, N46_4);
		N46_1 := if(((real)c_span_lang1 < 2.5), N46_2, -0.00517984);

		N47_5 := if(((real)crim_rel_within25miles1 < 0.5), 0.0166908, -0.00349477);
		N47_4 := if(((real)add1_naprop1 < 1.5), -0.011411, -0.00150286);
		N47_3 := if(((real)current_count1 < 0.5), N47_4, 0.000576449);
		N47_2 := if(((real)addrs_per_adl_c6 < 0.5), N47_3, N47_5);
		N47_1 := if((estimated_income < 70500), N47_2, 0.0108933);

		N48_5 := if(((real)years_in_dob1 < 1.5), -0.00384077, -0.016462);
		N48_4 := if(((real)ssns_per_adl1 < 1.5), -0.0015981, N48_5);
		N48_3 := if(((real)dist_a1toa31 < 2.5), 0.00636838, -0.0137218);
		N48_2 := if(((real)c_med_inc1 < 2.5), 0.00605644, N48_3);
		N48_1 := if(((real)rel_criminal_total1 < 0.5), N48_2, N48_4);

		N49_5 := if(((real)c_burglary1 < 3.5), 0.000925202, -0.0169025);
		N49_4 := if(((real)adls_per_addr1 < 2.5), 0.00810377, 0.00124957);
		N49_3 := if(((real)rel_criminal_total1 < 2.5), N49_4, N49_5);
		N49_2 := if(((real)rc_phonevalflag1 < 2.5), N49_3, -0.0151656);
		N49_1 := if(((real)acc_flag < 0.5), N49_2, -0.0147065);

		N50_5 := if(((real)addrs_5yr_cap < 1.5), 0.00624491, -0.0114414);
		N50_4 := if(((real)dist_a1toa31 < 2.5), 0.0106337, 0.000842313);
		N50_3 := if(((real)ssns_per_addr_c61 < 0.5), N50_4, N50_5);
		N50_2 := if(((real)lien_flag < 0.5), N50_3, -0.00616545);
		N50_1 := if(((real)c_cpiall1 < 1.5), 0.0162459, N50_2);

		N51_5 := if(((real)c_old_homes1 < 1.5), 0.0139394, 0.0013405);
		N51_4 := if((estimated_income < 35500), -0.00663928, N51_5);
		N51_3 := if(((real)nap_status1 < 1.5), N51_4, -0.00613604);
		N51_2 := if(((real)ams_college_tier1 < 0.5), N51_3, 0.0114936);
		N51_1 := if(((real)c_cpiall1 < 2.5), 0.0098737, N51_2);

		N52_5 := if(((real)rel_prop_sold_count1 < 0.5), 0.00239435, 0.023798);
		N52_4 := if(((real)disposition1 < 1.5), 0.00563486, -0.00935147);
		N52_3 := if(((real)current_count1 < 1.5), -0.001385, 0.00845044);
		N52_2 := if(((real)addrs_5yr_cap < 2.5), N52_3, N52_4);
		N52_1 := if(((real)phn_cellpager < 0.5), N52_2, N52_5);

		N53_5 := if(((real)c_easiqlife1 < 1.5), 0.00107146, -0.00913995);
		N53_4 := if((estimated_income < 70500), -0.000316515, 0.0157128);
		N53_3 := if(((real)dist_a1toa31 < 2.5), 0.0123244, N53_4);
		N53_2 := if(((real)crim_rel_within25miles1 < 1.5), N53_3, -0.00477476);
		N53_1 := if(((real)lien_flag < 0.5), N53_2, N53_5);

		N54_5 := if(((real)c_old_homes1 < 1.5), 0.0011349, -0.00697318);
		N54_4 := if(((real)disposition1 < 1.5), 0.0041384, N54_5);
		N54_3 := if(((real)attr_total_number_derogs1 < 2.5), 0.0144113, -0.00377583);
		N54_2 := if(((real)source_tot_tu < 0.5), -0.00691986, N54_3);
		N54_1 := if(((real)c_hval_200k_p1 < 1.5), N54_2, N54_4);

		N55_5 := if(((real)dist_a2toa31 < 1.5), 0.0113465, -0.00348603);
		N55_4 := if(((real)c_bel_edu1 < 1.5), 0.0203588, 0.00450213);
		N55_3 := if(((real)ssns_per_adl1 < 1.5), 0.00114992, -0.0116127);
		N55_2 := if(((real)rc_phonelnamecount < 0.5), N55_3, N55_4);
		N55_1 := if(((real)infutor_flag < 0.5), N55_2, N55_5);

		N56_5 := if(((real)ssn_issued18 < 0.5), 0.0049777, 0.0166573);
		N56_4 := if(((real)current_count1 < 0.5), -0.000746179, N56_5);
		N56_3 := if(((real)ssns_per_addr_c61 < 1.5), N56_4, -0.0104893);
		N56_2 := if(((real)c_fammar_p1 < 3.5), N56_3, -0.00550803);
		N56_1 := if(((real)lien_rec_unrel_flag < 0.5), N56_2, -0.00921203);

		N57_5 := if(((real)c_lux_prod1 < 2.5), 0.024044, 1.02598e-005);
		N57_4 := if(((real)rel_prop_owned_assessed_total1 < 2.5), 0.00900956, -0.00312572);
		N57_3 := if(((real)c_med_hval1 < 2.5), N57_4, -0.00550438);
		N57_2 := if(((real)phn_cellpager < 0.5), N57_3, N57_5);
		N57_1 := if(((real)c_old_homes1 < 1.5), 0.00704028, N57_2);

		N58_5 := if(((real)source_tot_em < 0.5), 0.00239619, 0.021146);
		N58_4 := if(((real)disposition1 < 1.5), 0.00498174, -0.00472218);
		N58_3 := if(((real)phn_cellpager < 0.5), N58_4, 0.0115912);
		N58_2 := if(((real)ssn_issued18 < 0.5), N58_3, N58_5);
		N58_1 := if(((real)c_larceny1 < 3.5), N58_2, -0.00654739);

		N59_5 := if(((real)lien_hist_unrel_flag < 0.5), -0.00318212, -0.0206284);
		N59_4 := if(((real)addrs_5yr_cap < 3.5), 0.00826803, -0.00723395);
		N59_3 := if(((real)c_old_homes1 < 3.5), N59_4, -0.00368093);
		N59_2 := if(((real)lien_rec_unrel_flag < 0.5), N59_3, -0.010058);
		N59_1 := if(((real)max_lres1 < 2.5), N59_2, N59_5);

		N60_5 := if(((real)adls_per_addr1 < 2.5), 0.00208145, -0.0169672);
		N60_4 := if(((real)estimated_income1 < 2.5), 0.00181647, N60_5);
		N60_3 := if(((real)c_larceny1 < 2.5), N60_4, 0.00947873);
		N60_2 := if(((real)c_assault1 < 3.5), N60_3, -0.00981074);
		N60_1 := if(((real)rel_criminal_total1 < 0.5), 0.00516446, N60_2);

		N61_5 := if(((real)dist_a2toa31 < 1.5), 0.013258, -0.00226036);
		N61_4 := if(((real)veradd_p < 0.5), 0.011206, 0.00299541);
		N61_3 := if(((real)infutor_flag < 0.5), N61_4, N61_5);
		N61_2 := if(((real)rc_hphonetypeflag1 < 1.5), N61_3, -0.00992777);
		N61_1 := if(((real)crim_rel_within25miles1 < 2.5), N61_2, -0.00845853);

		N62_5 := if(((real)c_old_homes1 < 1.5), 0.0109856, -0.00462957);
		N62_4 := if(((real)current_count1 < 0.5), -0.0107011, N62_5);
		N62_3 := if(((real)ssn_issued18 < 0.5), N62_4, 0.002932);
		N62_2 := if(((integer)bankrupt < 0.5), 0.000794207, 0.0147854);
		N62_1 := if(((real)rel_criminal_total1 < 0.5), N62_2, N62_3);

		N63_5 := if(((real)c_cpiall1 < 3.5), 0.00846645, -0.00766065);
		N63_4 := if(((real)c_bel_edu1 < 1.5), 0.00437026, -0.0152811);
		N63_3 := if(((real)crime_flag < 0.5), 0.000163625, N63_4);
		N63_2 := if(((real)ssn_issued18 < 0.5), N63_3, N63_5);
		N63_1 := if((estimated_income < 30500), -0.0089384, N63_2);

		N64_5 := if(((real)c_lux_prod1 < 2.5), 0.0175389, 0.00250133);
		N64_4 := if(((real)c_med_hhinc1 < 2.5), -0.00115349, 0.0160192);
		N64_3 := if(((real)source_tot_em < 0.5), -0.00197126, N64_4);
		N64_2 := if(((real)addrs_per_adl_c6 < 0.5), N64_3, N64_5);
		N64_1 := if(((real)criminal_count1 < 1.5), N64_2, -0.0114368);

		N65_5 := if(((real)addrs_5yr_cap < 1.5), 0.000644373, -0.00684185);
		N65_4 := if(((real)dist_a2toa31 < 2.5), 0.0130768, -0.000528694);
		N65_3 := if(((real)prop_sold_flag < 0.5), N65_4, 0.0142619);
		N65_2 := if(((real)crim_rel_within25miles1 < 2.5), N65_3, -0.00521857);
		N65_1 := if(((real)rel_prop_owned_assessed_total1 < 2.5), N65_2, N65_5);

		N66_5 := if(((real)c_assault1 < 2.5), 0.01252, -0.00113143);
		N66_4 := if(((real)years_in_dob1 < 1.5), N66_5, -0.00693277);
		N66_3 := if(((real)current_count1 < 0.5), -0.00748961, 0.00423983);
		N66_2 := if(((real)c_med_hval1 < 2.5), 0.00803386, N66_3);
		N66_1 := if(((real)rel_prop_owned_assessed_total1 < 2.5), N66_2, N66_4);

		N67_5 := if((estimated_income < 66500), 0.00217027, 0.0234389);
		N67_4 := if(((real)attr_addrs_last361 < 2.5), N67_5, -0.00891251);
		N67_3 := if(((real)current_count1 < 0.5), -0.00532159, N67_4);
		N67_2 := if(((real)rc_phonevalflag1 < 2.5), 0.0057114, -0.0128039);
		N67_1 := if(((real)infutor_flag < 0.5), N67_2, N67_3);

		N68_5 := if(((real)c_no_move1 < 3.5), 0.00822524, -0.00979447);
		N68_4 := if(((real)adls_per_addr1 < 3.5), -0.00208294, -0.0102104);
		N68_3 := if(((real)addrs_per_adl_c6 < 0.5), N68_4, N68_5);
		N68_2 := if(((real)lien_hist_unrel_flag < 0.5), 0.00391669, -0.00548464);
		N68_1 := if(((real)addrs_5yr_cap < 1.5), N68_2, N68_3);

		N69_5 := if(((real)years_in_dob1 < 1.5), 0.00400654, -0.0120126);
		N69_4 := if((estimated_income < 42500), -0.000551845, 0.00546459);
		N69_3 := if(((real)attr_addrs_last361 < 2.5), N69_4, N69_5);
		N69_2 := if(((real)phn_cellpager < 0.5), N69_3, 0.0119037);
		N69_1 := if(((real)years_in_dob1 < 3.5), N69_2, -0.0138495);

		N70_5 := if(((real)attr_addrs_last361 < 1.5), 0.00686652, -0.0153399);
		N70_4 := if(((real)rc_phonevalflag1 < 1.5), N70_5, -0.012436);
		N70_3 := if(((real)c_exp_prod1 < 2.5), -0.000304668, N70_4);
		N70_2 := if(((real)c_ab_av_edu1 < 2.5), -0.00397466, 0.00705539);
		N70_1 := if(((real)dist_a1toa21 < 2.5), N70_2, N70_3);

		N71_5 := if(((real)c_larceny1 < 2.5), 5.80161e-005, -0.0121362);
		N71_4 := if(((integer)add1_family_owned < 0.5), -0.00236798, 0.00445436);
		N71_3 := if((estimated_income < 72500), N71_4, 0.0166532);
		N71_2 := if(((real)dist_a1toa31 < 1.5), 0.0206622, N71_3);
		N71_1 := if(((real)lien_flag < 0.5), N71_2, N71_5);

		N72_5 := if(((real)max_lres1 < 2.5), 0.0121805, -0.008362);
		N72_4 := if(((real)disposition1 < 1.5), N72_5, -0.004987);
		N72_3 := if(((real)dist_a1toa31 < 2.5), 0.00714291, -0.00553165);
		N72_2 := if(((real)current_count1 < 0.5), N72_3, 0.00798914);
		N72_1 := if(((real)addrs_5yr_cap < 1.5), N72_2, N72_4);

		N73_5 := if(((real)ssn_issued18 < 0.5), -0.00413971, 0.00638172);
		N73_4 := if(((integer)add1_applicant_owned < 0.5), N73_5, 0.00536037);
		N73_3 := if(((real)ams_college_tier1 < 0.5), N73_4, 0.0141824);
		N73_2 := if(((real)c_no_labfor1 < 1.5), 0.0109282, N73_3);
		N73_1 := if(((real)c_burglary1 < 3.5), N73_2, -0.00518608);

		N74_5 := if(((integer)lname_eda_sourced < 0.5), -0.000518617, 0.0189046);
		N74_4 := if(((integer)add1_eda_sourced < 0.5), -0.00517821, -0.0192832);
		N74_3 := if(((real)addrs_5yr_cap < 0.5), 0.00641407, N74_4);
		N74_2 := if(((real)rel_prop_owned_count1 < 0.5), N74_3, 0.000795264);
		N74_1 := if(((real)ams_college_tier1 < 0.5), N74_2, N74_5);

		N75_5 := if(((real)rel_prop_owned_count1 < 0.5), -0.0211097, -0.00534118);
		N75_4 := if(((real)veradd_p < 0.5), 0.000835985, N75_5);
		N75_3 := if(((real)attr_addrs_last361 < 2.5), 0.00676131, -0.00652037);
		N75_2 := if((estimated_income < 36500), N75_3, N75_4);
		N75_1 := if(((real)years_in_dob1 < 1.5), 0.00316921, N75_2);

		N76_5 := if(((real)c_inc_100k_p1 < 1.5), -0.0122897, 0.00515309);
		N76_4 := if(((real)c_span_lang1 < 2.5), N76_5, -0.0134291);
		N76_3 := if(((real)c_inc_100k_p1 < 1.5), 0.0144499, -0.000259413);
		N76_2 := if((estimated_income < 68500), -0.000283503, N76_3);
		N76_1 := if(((real)lien_hist_unrel_flag < 0.5), N76_2, N76_4);

		N77_5 := if((estimated_income < 38500), 0.00903565, -0.00102889);
		N77_4 := if(((real)c_no_move1 < 3.5), N77_5, -0.00588134);
		N77_3 := if(((real)c_low_hval1 < 3.5), N77_4, -0.00645675);
		N77_2 := if(((real)nap_summary1 < 2.5), N77_3, -0.013349);
		N77_1 := if(((real)c_cpiall1 < 2.5), 0.00754381, N77_2);

		N78_5 := if(((real)attr_total_number_derogs1 < 3.5), -0.0011858, -0.0139689);
		N78_4 := if(((real)adls_per_addr1 < 2.5), 0.0246504, 0.000518685);
		N78_3 := if(((real)rel_criminal_total1 < 0.5), N78_4, -0.00205677);
		N78_2 := if(((real)addrs_per_adl_c6 < 0.5), N78_3, 0.0188901);
		N78_1 := if(((real)disposition1 < 1.5), N78_2, N78_5);

		N79_5 := if(((real)phn_cellpager < 0.5), -0.00285879, 0.00645676);
		N79_4 := if(((real)dist_a1toa31 < 2.5), 0.00931099, -0.0021121);
		N79_3 := if((estimated_income < 34500), -0.00791086, N79_4);
		N79_2 := if(((real)c_assault1 < 2.5), 0.0158729, N79_3);
		N79_1 := if(((real)dist_a2toa31 < 2.5), N79_2, N79_5);

		N80_5 := if(((integer)rc_fnamessnmatch < 0.5), 0.0104196, -0.00399087);
		N80_4 := if(((real)c_inc_100k_p1 < 1.5), -0.00329448, 0.0100913);
		N80_3 := if(((real)c_burglary1 < 1.5), N80_4, N80_5);
		N80_2 := if(((real)dist_a2toa31 < 1.5), 0.0088142, N80_3);
		N80_1 := if(((integer)prof_license_flag < 0.5), N80_2, 0.0114689);

		N81_5 := if(((real)c_famotf18_p1 < 3.5), -0.0170612, 0.000590031);
		N81_4 := if(((real)c_span_lang1 < 1.5), -0.00204405, 0.0135525);
		N81_3 := if(((real)c_assault1 < 2.5), N81_4, 0.000403221);
		N81_2 := if(((real)c_low_hval1 < 3.5), N81_3, -0.00498545);
		N81_1 := if(((real)lien_rec_unrel_flag < 0.5), N81_2, N81_5);

		N82_5 := if(((real)dist_a2toa31 < 2.5), 0.0164786, 0.00145412);
		N82_4 := if(((integer)lname_eda_sourced < 0.5), -0.00232149, -0.0194439);
		N82_3 := if(((real)c_med_inc1 < 1.5), 0.000548353, N82_4);
		N82_2 := if(((real)ssns_per_adl1 < 1.5), 0.0011344, N82_3);
		N82_1 := if(((real)addrs_per_adl_c6 < 0.5), N82_2, N82_5);

		N83_5 := if(((real)c_born_usa1 < 3.5), 0.000956269, -0.0111802);
		N83_4 := if(((real)lien_flag < 0.5), N83_5, -0.00677735);
		N83_3 := if(((real)c_cpiall1 < 2.5), 0.0089916, N83_4);
		N83_2 := if(((real)add1_naprop1 < 0.5), -0.00907741, 0.00897411);
		N83_1 := if(((real)c_burglary1 < 1.5), N83_2, N83_3);

		N84_5 := if(((real)rel_criminal_total1 < 4.5), -6.46064e-005, -0.00730301);
		N84_4 := if(((real)c_cpiall1 < 3.5), 0.00784719, -0.00471833);
		N84_3 := if(((real)lien_rec_unrel_flag < 0.5), N84_4, -0.00781656);
		N84_2 := if(((real)c_fammar_p1 < 2.5), N84_3, N84_5);
		N84_1 := if(((integer)rc_fnamessnmatch < 0.5), 0.0129116, N84_2);

		N85_5 := if(((integer)add1_applicant_owned < 0.5), 0.0163542, -0.00255264);
		N85_4 := if(((real)attr_addrs_last361 < 0.5), N85_5, 0.022499);
		N85_3 := if(((real)attr_addrs_last361 < 1.5), N85_4, -0.00208423);
		N85_2 := if(((real)rel_criminal_total1 < 0.5), N85_3, -0.000800854);
		N85_1 := if(((real)dist_a1toa31 < 2.5), N85_2, -0.00230549);

		N86_5 := if(((real)dist_a2toa31 < 2.5), 0.00903374, -0.00959467);
		N86_4 := if(((real)c_inc_100k_p1 < 3.5), N86_5, -0.0205911);
		N86_3 := if(((real)rc_hphonetypeflag1 < 1.5), 0.0023627, -0.0086185);
		N86_2 := if(((real)crim_rel_within25miles1 < 2.5), N86_3, -0.00649204);
		N86_1 := if(((real)addrs_5yr_cap < 4.5), N86_2, N86_4);

		N87_5 := if(((real)attr_addrs_last361 < 2.5), 0.0142247, -0.00411184);
		N87_4 := if(((real)adls_per_addr1 < 2.5), 0.000974113, -0.00609573);
		N87_3 := if(((real)addrs_per_adl_c6 < 0.5), N87_4, N87_5);
		N87_2 := if(((real)criminal_count1 < 1.5), 0.00540629, -0.00984861);
		N87_1 := if(((real)rel_prop_owned_assessed_total1 < 2.5), N87_2, N87_3);

		N88_5 := if(((real)c_assault1 < 3.5), -0.00126871, -0.0106197);
		N88_4 := if(((real)c_cpiall1 < 2.5), 0.00956664, N88_5);
		N88_3 := if(((real)dist_a1toa31 < 2.5), 0.0046593, N88_4);
		N88_2 := if(((real)addrs_5yr_cap < 4.5), N88_3, -0.011704);
		N88_1 := if(((real)phn_cellpager < 0.5), N88_2, 0.00979056);

		N89_5 := if(((real)c_fammar_p1 < 1.5), -0.0169434, 0.000410986);
		N89_4 := if(((real)ssns_per_addr_c61 < 0.5), N89_5, -0.0145002);
		N89_3 := if(((real)prop_owned_flag < 0.5), 0.00993182, 0.00040577);
		N89_2 := if(((real)c_bel_edu1 < 2.5), N89_3, -0.00217748);
		N89_1 := if(((real)c_old_homes1 < 3.5), N89_2, N89_4);

		N90_5 := if(((real)addrs_5yr_cap < 2.5), 0.0145389, -0.00527587);
		N90_4 := if(((real)dist_a2toa31 < 2.5), 0.0183878, N90_5);
		N90_3 := if(((real)max_lres1 < 1.5), 0.00292119, -0.0110765);
		N90_2 := if(((real)c_lux_prod1 < 3.5), 0.000469736, N90_3);
		N90_1 := if(((real)addrs_per_adl_c6 < 0.5), N90_2, N90_4);

		N91_5 := if(((real)infutor_flag < 0.5), 0.0123117, -0.00640609);
		N91_4 := if(((real)dist_a2toa31 < 2.5), 0.0178848, N91_5);
		N91_3 := if(((real)addrs_per_adl_c6 < 0.5), 0.000397943, N91_4);
		N91_2 := if(((real)acc_flag < 0.5), N91_3, -0.0124724);
		N91_1 := if(((real)wealth_index < 1.5), -0.00811418, N91_2);

		N92_5 := if(((real)c_fammar_p1 < 2.5), 0.00376632, -0.0061467);
		N92_4 := if(((real)veradd_p < 0.5), 0.00351401, N92_5);
		N92_3 := if(((real)c_housingcpi1 < 3.5), N92_4, -0.0105377);
		N92_2 := if(((real)c_no_move1 < 1.5), 0.019281, 0.000710468);
		N92_1 := if(((real)rel_prop_owned_assessed_total1 < 1.5), N92_2, N92_3);

		N93_5 := if(((real)disposition1 < 1.5), 0.0105278, -0.0121504);
		N93_4 := if(((real)c_low_hval1 < 2.5), 0.00257294, N93_5);
		N93_3 := if(((real)infutor_flag < 0.5), 0.00331074, N93_4);
		N93_2 := if(((real)rc_phonevalflag1 < 2.5), N93_3, -0.0138155);
		N93_1 := if(((real)attr_eviction_flag < 0.5), N93_2, -0.0124072);

		N94_5 := if(((real)c_easiqlife1 < 1.5), 0.00522706, -0.0109262);
		N94_4 := if(((real)attr_total_number_derogs1 < 0.5), 0.00501696, -0.000552969);
		N94_3 := if(((real)years_in_dob1 < 3.5), N94_4, -0.0109832);
		N94_2 := if(((integer)rc_fnamessnmatch < 0.5), 0.0121591, N94_3);
		N94_1 := if(((real)c_housingcpi1 < 3.5), N94_2, N94_5);

		N95_5 := if(((real)c_larceny1 < 2.5), -0.00179245, -0.0123619);
		N95_4 := if(((real)c_hh2_p1 < 2.5), -0.00598777, 0.00968369);
		N95_3 := if(((real)rel_prop_sold_count1 < 0.5), N95_4, -0.0103279);
		N95_2 := if(((real)c_inc_100k_p1 < 2.5), 0.00285961, N95_3);
		N95_1 := if(((real)lien_flag < 0.5), N95_2, N95_5);

		N96_5 := if(((integer)lname_eda_sourced < 0.5), -0.0137711, -0.000436781);
		N96_4 := if(((real)infutor_flag < 0.5), 0.00415926, -0.00129887);
		N96_3 := if(((real)add1_avm_med_geo11_lvl < 2.5), N96_4, N96_5);
		N96_2 := if(((real)dist_a1toa21 < 1.5), 0.0102516, N96_3);
		N96_1 := if(((real)adls_per_addr1 < 1.5), 0.0140475, N96_2);

		N97_5 := if(((real)addr_stability1 < 1.5), -0.0265072, -0.00771375);
		N97_4 := if(((real)c_exp_prod1 < 2.5), N97_5, -0.00284706);
		N97_3 := if(((real)rel_prop_owned_count1 < 0.5), -0.00752818, 0.00892534);
		N97_2 := if(((real)c_old_homes1 < 1.5), N97_3, N97_4);
		N97_1 := if(((real)c_low_hval1 < 2.5), 0.00247716, N97_2);

		N98_5 := if(((real)addrs_5yr_cap < 0.5), 0.0135183, 0.000802975);
		N98_4 := if(((real)attr_total_number_derogs1 < 0.5), N98_5, -0.00360135);
		N98_3 := if(((real)c_med_hval1 < 2.5), 0.0185283, 0.00512189);
		N98_2 := if(((real)lien_flag < 0.5), N98_3, -0.000694769);
		N98_1 := if(((real)max_lres1 < 1.5), N98_2, N98_4);

		N99_5 := if(((real)lien_rec_unrel_flag < 0.5), -0.00240759, -0.0109838);
		N99_4 := if(((real)c_hh2_p1 < 2.5), 0.0138887, -0.00777704);
		N99_3 := if(((real)c_no_labfor1 < 1.5), N99_4, N99_5);
		N99_2 := if(((real)c_cpiall1 < 1.5), 0.0114961, N99_3);
		N99_1 := if(((real)adls_per_addr1 < 1.5), 0.0127767, N99_2);

		N100_5 := if((estimated_income < 61500), 0.0129871, -0.00659964);
		N100_4 := if(((real)c_burglary1 < 3.5), -0.00909649, 0.00603952);
		N100_3 := if((estimated_income < 72500), -0.000740636, 0.0127129);
		N100_2 := if(((real)ssns_per_adl1 < 1.5), N100_3, N100_4);
		N100_1 := if(((real)addrs_per_adl_c6 < 0.5), N100_2, N100_5);

		N101_5 := if(((real)c_exp_prod1 < 1.5), 0.00313068, -0.0126805);
		N101_4 := if(((real)addrs_5yr_cap < 2.5), N101_5, 0.0062628);
		N101_3 := if(((real)attr_eviction_flag < 0.5), 0.00364578, -0.0098187);
		N101_2 := if(((real)crim_rel_within25miles1 < 1.5), N101_3, N101_4);
		N101_1 := if(((real)rc_hphonetypeflag1 < 1.5), N101_2, -0.0105971);

		N102_5 := if(((real)crime_flag < 0.5), -0.0035791, -0.0207202);
		N102_4 := if(((real)ssns_per_adl1 < 1.5), 0.00051816, N102_5);
		N102_3 := if(((real)c_old_homes1 < 2.5), -0.012404, 0.00559278);
		N102_2 := if(((real)rc_phonelnamecount < 0.5), 0.0122235, N102_3);
		N102_1 := if(((real)disposition1 < 1.5), N102_2, N102_4);

		N103_5 := if(((real)c_old_homes1 < 3.5), 0.00349175, -0.0114998);
		N103_4 := if(((real)c_easiqlife1 < 2.5), 0.0116583, N103_5);
		N103_3 := if(((real)c_housingcpi1 < 1.5), -0.0168898, -0.00236373);
		N103_2 := if(((real)ssn_issued18 < 0.5), N103_3, N103_4);
		N103_1 := if(((real)addrs_5yr_cap < 0.5), 0.00365882, N103_2);

		N104_5 := if(((real)addrs_5yr_cap < 1.5), 0.00161721, -0.00415685);
		N104_4 := if(((real)ssn_adl_prob < 0.5), N104_5, -0.0137564);
		N104_3 := if(((real)c_ab_av_edu1 < 1.5), 0.0119356, N104_4);
		N104_2 := if(((real)c_old_homes1 < 1.5), 0.0171135, 0.00284368);
		N104_1 := if(((real)c_assault1 < 2.5), N104_2, N104_3);

		N105_5 := if((estimated_income < 84500), -0.000743093, -0.016002);
		N105_4 := if((estimated_income < 32500), -0.0133369, 0.0041235);
		N105_3 := if(((real)c_low_hval1 < 3.5), 0.00672281, 0.0203443);
		N105_2 := if(((real)infutor_flag < 0.5), N105_3, N105_4);
		N105_1 := if(((real)c_old_homes1 < 1.5), N105_2, N105_5);

		N106_5 := if(((real)c_old_homes1 < 2.5), -0.00251663, 0.0163349);
		N106_4 := if(((real)c_burglary1 < 1.5), 0.0113657, -0.00119771);
		N106_3 := if(((real)ssns_per_addr_c61 < 1.5), N106_4, 0.0197811);
		N106_2 := if(((real)c_old_homes1 < 2.5), N106_3, -0.00309155);
		N106_1 := if(((real)phn_cellpager < 0.5), N106_2, N106_5);

		N107_5 := if(((real)lien_hist_unrel_flag < 0.5), 0.000367969, -0.0151789);
		N107_4 := if((estimated_income < 44500), 0.0258369, 0.00952398);
		N107_3 := if(((real)rel_prop_owned_assessed_total1 < 2.5), N107_4, 0.00333122);
		N107_2 := if(((real)c_low_hval1 < 2.5), N107_3, 0.000706318);
		N107_1 := if(((real)c_old_homes1 < 3.5), N107_2, N107_5);

		N108_5 := if(((real)c_fammar_p1 < 3.5), 0.00323681, -0.0145492);
		N108_4 := if(((real)addr_stability1 < 2.5), -0.0194436, N108_5);
		N108_3 := if(((real)ssns_per_addr_c61 < 0.5), 0.00240363, -0.00444775);
		N108_2 := if(((real)addrs_5yr_cap < 3.5), N108_3, N108_4);
		N108_1 := if(((real)ssn_adl_prob < 0.5), N108_2, -0.012701);

		N109_5 := if(((real)addrs_5yr_cap < 1.5), 0.00958884, -0.00902523);
		N109_4 := if((estimated_income < 41500), N109_5, -0.0149345);
		N109_3 := if(((real)c_assault1 < 2.5), 0.00809252, N109_4);
		N109_2 := if(((real)contrary_phn < 0.5), 0.00338689, -0.00990186);
		N109_1 := if(((real)ssns_per_addr_c61 < 0.5), N109_2, N109_3);

		N110_5 := if(((real)dist_a1toa31 < 2.5), 0.0111049, -0.00220238);
		N110_4 := if(((real)add1_avm_hit < 0.5), -0.00549241, N110_5);
		N110_3 := if(((real)ssn_adl_prob < 0.5), 0.00568437, -0.00947383);
		N110_2 := if(((real)name_change_flag < 0.5), N110_3, -0.00913121);
		N110_1 := if(((real)infutor_flag < 0.5), N110_2, N110_4);

		N111_5 := if(((real)c_no_move1 < 3.5), 0.010522, -0.00907331);
		N111_4 := if(((real)wealth_index < 2.5), -0.00570485, 0.000921305);
		N111_3 := if(((real)addrs_per_adl_c6 < 0.5), N111_4, N111_5);
		N111_2 := if((estimated_income < 72500), N111_3, 0.0121498);
		N111_1 := if((estimated_income < 78500), N111_2, -0.00944961);

		N112_5 := if(((real)max_lres1 < 1.5), -0.00806421, 0.0132132);
		N112_4 := if(((real)diff_source_tot_pos_neg1 < 2.5), -0.00637546, N112_5);
		N112_3 := if(((real)c_famotf18_p1 < 2.5), -0.0220134, -0.00380816);
		N112_2 := if(((real)nap_summary1 < 2.5), -0.00105822, N112_3);
		N112_1 := if(((real)out_addr_type1 < 1.5), N112_2, N112_4);

		N113_5 := if(((real)c_old_homes1 < 2.5), 0.0107636, -0.00234698);
		N113_4 := if(((real)max_lres1 < 1.5), 0.00231527, -0.00717283);
		N113_3 := if(((real)current_count1 < 1.5), N113_4, N113_5);
		N113_2 := if((estimated_income < 37500), 0.00313441, N113_3);
		N113_1 := if(((real)dist_a1toa21 < 1.5), 0.009929, N113_2);

		N114_5 := if(((real)c_inc_100k_p1 < 3.5), 0.00622515, 0.0237868);
		N114_4 := if(((real)prop_sold_flag < 0.5), N114_5, -0.00709884);
		N114_3 := if(((real)addrs_5yr_cap < 4.5), -0.00145916, -0.0122951);
		N114_2 := if(((real)addrs_per_adl_c6 < 0.5), N114_3, 0.0054232);
		N114_1 := if(((real)source_tot_em < 0.5), N114_2, N114_4);

		N115_5 := if(((real)c_med_hval1 < 2.5), 0.00215583, 0.0207877);
		N115_4 := if(((real)c_ab_av_edu1 < 3.5), N115_5, -0.00457293);
		N115_3 := if(((real)crim_rel_within25miles1 < 3.5), -0.00257985, -0.0144603);
		N115_2 := if(((real)ssn_issued18 < 0.5), N115_3, 0.00250316);
		N115_1 := if(((real)phn_cellpager < 0.5), N115_2, N115_4);

		N116_5 := if(((real)current_count1 < 0.5), -0.022598, -0.0034402);
		N116_4 := if(((real)c_ab_av_edu1 < 3.5), N116_5, 0.00208412);
		N116_3 := if(((real)rc_phoneaddr_lnamecount < 0.5), N116_4, 0.00251075);
		N116_2 := if(((real)c_born_usa1 < 3.5), 0.000279726, 0.00687034);
		N116_1 := if(((real)c_larceny1 < 3.5), N116_2, N116_3);

		N117_5 := if(((real)verphn_p < 0.5), 0.00539789, -0.0111551);
		N117_4 := if(((real)c_easiqlife1 < 2.5), N117_5, -0.011572);
		N117_3 := if(((real)c_med_inc1 < 1.5), 0.000620768, N117_4);
		N117_2 := if(((real)rc_phonephonecount < 0.5), -0.00226486, 0.00544469);
		N117_1 := if(((real)dist_a1toa31 < 2.5), N117_2, N117_3);

		N118_5 := if(((real)c_assault1 < 2.5), 0.0171408, 0.0025544);
		N118_4 := if(((real)c_fammar_p1 < 1.5), 0.00899215, -0.00281799);
		N118_3 := if(((real)rel_prop_sold_count1 < 0.5), -0.00355205, 0.0104288);
		N118_2 := if(((real)c_med_hhinc1 < 1.5), N118_3, N118_4);
		N118_1 := if(((real)current_count1 < 1.5), N118_2, N118_5);

		N119_5 := if(((real)out_addr_type1 < 1.5), -0.00849425, 0.00325068);
		N119_4 := if(((real)c_old_homes1 < 1.5), 0.0107699, -0.000162339);
		N119_3 := if(((real)max_lres1 < 3.5), N119_4, 0.0194654);
		N119_2 := if(((real)current_count1 < 0.5), -0.00415788, N119_3);
		N119_1 := if(((real)attr_addrs_last361 < 1.5), N119_2, N119_5);

		N120_5 := if((estimated_income < 40500), 0.000884038, 0.0173951);
		N120_4 := if(((real)c_burglary1 < 1.5), 0.00838173, -0.00498974);
		N120_3 := if(((real)dist_a1toa21 < 2.5), 0.00739933, N120_4);
		N120_2 := if(((real)source_tot_wp < 0.5), -0.00291989, N120_3);
		N120_1 := if(((real)ams_college_tier1 < 0.5), N120_2, N120_5);

		N121_5 := if(((real)c_hh2_p1 < 2.5), -0.0145031, 0.00364022);
		N121_4 := if(((real)c_lux_prod1 < 3.5), 0.00201466, -0.00441041);
		N121_3 := if(((real)nap_summary1 < 2.5), N121_4, N121_5);
		N121_2 := if((estimated_income < 78500), N121_3, -0.0113247);
		N121_1 := if(((real)phn_cellpager < 0.5), N121_2, 0.00695983);

		N122_5 := if(((real)c_med_inc1 < 2.5), -0.00778988, 0.00898198);
		N122_4 := if(((real)c_larceny1 < 2.5), N122_5, -0.0164906);
		N122_3 := if(((real)c_cpiall1 < 2.5), 0.00906741, N122_4);
		N122_2 := if((estimated_income < 29500), 0.015124, N122_3);
		N122_1 := if(((real)lien_flag < 0.5), 0.00290305, N122_2);

		N123_5 := if(((real)addrs_5yr_cap < 2.5), 0.0165076, -0.00466971);
		N123_4 := if((estimated_income < 34500), 0.00911698, -0.00495519);
		N123_3 := if(((real)prop_sold_flag < 0.5), N123_4, N123_5);
		N123_2 := if(((real)rel_prop_owned_assessed_total1 < 2.5), N123_3, -0.00339372);
		N123_1 := if(((real)dist_a2toa31 < 1.5), 0.00853722, N123_2);

		N124_5 := if(((real)adls_per_addr1 < 3.5), 0.00628779, -0.0129784);
		N124_4 := if(((real)ssn_issued18 < 0.5), N124_5, -0.0199269);
		N124_3 := if(((real)c_housingcpi1 < 3.5), 0.00447183, -0.00587786);
		N124_2 := if(((real)c_no_labfor1 < 2.5), N124_3, N124_4);
		N124_1 := if(((real)c_housingcpi1 < 2.5), -0.00535635, N124_2);

		N125_5 := if(((real)attr_total_number_derogs1 < 2.5), 0.00186468, -0.0177647);
		N125_4 := if(((real)max_lres1 < 1.5), 0.00653777, -0.00653269);
		N125_3 := if(((real)phn_cellpager < 0.5), N125_4, 0.0147847);
		N125_2 := if(((real)c_no_move1 < 2.5), 0.00403918, N125_3);
		N125_1 := if(((real)lien_rec_unrel_flag < 0.5), N125_2, N125_5);

		N126_5 := if(((real)max_lres1 < 1.5), -0.00147314, -0.0159234);
		N126_4 := if(((real)c_old_homes1 < 1.5), 0.000960739, N126_5);
		N126_3 := if(((real)prop_sold_flag < 0.5), -0.00387165, 0.0131944);
		N126_2 := if(((real)c_hval_200k_p1 < 2.5), N126_3, N126_4);
		N126_1 := if(((real)attr_addrs_last361 < 0.5), N126_2, 0.0024362);

		N127_5 := if(((real)current_count1 < 0.5), -0.0178648, 0.00111446);
		N127_4 := if(((real)add1_naprop1 < 1.5), -0.0192575, 0.00474014);
		N127_3 := if(((real)ssn_adl_prob < 0.5), 0.00188447, N127_4);
		N127_2 := if((estimated_income < 78500), N127_3, N127_5);
		N127_1 := if(((real)ams_college_tier1 < 0.5), N127_2, 0.0104581);

		N128_5 := if(((real)c_med_hval1 < 2.5), 0.0140215, -0.0162588);
		N128_4 := if(((real)max_lres1 < 1.5), N128_5, -0.00880326);
		N128_3 := if(((real)c_no_move1 < 2.5), 0.000318109, N128_4);
		N128_2 := if(((real)dist_a2toa31 < 1.5), 0.00907099, N128_3);
		N128_1 := if((estimated_income < 27500), 0.0113157, N128_2);

		N129_5 := if(((real)addr_stability1 < 1.5), -0.0176737, -0.000261432);
		N129_4 := if(((real)c_lux_prod1 < 2.5), N129_5, 0.00753973);
		N129_3 := if(((real)c_low_hval1 < 2.5), N129_4, -0.00767258);
		N129_2 := if(((real)infutor_flag < 0.5), 0.00198642, N129_3);
		N129_1 := if(((real)disposition1 < 1.5), 0.00414555, N129_2);

		N130_5 := if(((real)wealth_index < 2.5), -0.00751478, 0.00472597);
		N130_4 := if(((real)dist_a2toa31 < 2.5), -0.00685655, N130_5);
		N130_3 := if(((real)infutor_flag < 0.5), 0.00367421, N130_4);
		N130_2 := if(((real)crim_rel_within25miles1 < 3.5), N130_3, -0.00802448);
		N130_1 := if(((real)rc_phonevalflag1 < 2.5), N130_2, -0.0179223);

		N131_5 := if(((integer)add1_family_owned < 0.5), -0.0142292, 0.00846376);
		N131_4 := if(((real)rc_phonelnamecount < 0.5), 0.00527206, N131_5);
		N131_3 := if(((real)c_larceny1 < 3.5), N131_4, -0.00752431);
		N131_2 := if(((real)c_fammar_p1 < 1.5), -0.0108038, N131_3);
		N131_1 := if(((real)infutor_flag < 0.5), 0.00417008, N131_2);

		N132_5 := if(((real)ssns_per_addr_c61 < 1.5), -0.00625997, -0.0265102);
		N132_4 := if(((real)prop_owned_flag < 0.5), 0.00396353, -0.013715);
		N132_3 := if(((real)c_fammar_p1 < 3.5), N132_4, 0.00985056);
		N132_2 := if(((real)rel_criminal_total1 < 3.5), N132_3, N132_5);
		N132_1 := if(((real)ssns_per_addr_c61 < 0.5), 0.000987789, N132_2);

		N133_5 := if(((real)addrs_5yr_cap < 1.5), 0.0098376, -0.00104475);
		N133_4 := if(((real)rc_phonevalflag1 < 1.5), 0.0134759, 0.000786944);
		N133_3 := if(((real)out_addr_type1 < 1.5), -0.00165042, N133_4);
		N133_2 := if(((real)rc_phonevalflag1 < 2.5), N133_3, -0.0173103);
		N133_1 := if(((real)current_count1 < 1.5), N133_2, N133_5);

		N134_5 := if(((real)c_inc_100k_p1 < 3.5), 0.0126895, -0.0115049);
		N134_4 := if(((real)c_burglary1 < 2.5), -0.00967759, N134_5);
		N134_3 := if(((real)addrs_5yr_cap < 3.5), 0.00477853, N134_4);
		N134_2 := if(((real)years_in_dob1 < 1.5), 0.0027772, -0.00640283);
		N134_1 := if(((real)c_exp_prod1 < 1.5), N134_2, N134_3);

		N135_5 := if(((real)c_old_homes1 < 2.5), 0.0043739, -0.00671792);
		N135_4 := if(((real)rc_phonephonecount < 0.5), 0.0174807, -0.00116012);
		N135_3 := if(((real)add1_avm_med_geo11_lvl < 1.5), N135_4, N135_5);
		N135_2 := if(((integer)bankrupt < 0.5), N135_3, 0.015347);
		N135_1 := if(((real)verlst_p < 0.5), N135_2, -0.00180094);

		N136_5 := if(((real)rel_criminal_total1 < 1.5), -0.00824712, 0.010548);
		N136_4 := if(((real)dist_a1toa31 < 2.5), 0.0128001, N136_5);
		N136_3 := if(((real)c_assault1 < 3.5), N136_4, -0.00598466);
		N136_2 := if(((real)source_tot_em < 0.5), N136_3, 0.0180233);
		N136_1 := if(((real)ssn_issued18 < 0.5), -0.00260572, N136_2);

		N137_5 := if(((real)c_assault1 < 1.5), -0.00822688, 0.00755465);
		N137_4 := if(((real)c_burglary1 < 1.5), N137_5, -0.00139789);
		N137_3 := if(((real)add1_avm_med_geo11_lvl < 1.5), -0.0152701, -0.000686744);
		N137_2 := if(((real)diff_source_tot_pos_neg1 < 1.5), N137_3, N137_4);
		N137_1 := if(((real)adls_per_addr1 < 1.5), 0.0143867, N137_2);

		N138_5 := if(((real)addrs_5yr_cap < 1.5), 0.0053099, -0.00332744);
		N138_4 := if(((real)dist_a2toa31 < 2.5), 0.00270847, 0.018929);
		N138_3 := if(((real)c_old_homes1 < 1.5), N138_4, N138_5);
		N138_2 := if(((real)dist_a1toa21 < 1.5), 0.0114591, -0.00133946);
		N138_1 := if(((real)current_count1 < 1.5), N138_2, N138_3);

		N139_5 := if(((real)dist_a2toa31 < 2.5), 0.0140539, -0.000170223);
		N139_4 := if(((real)adls_per_addr1 < 1.5), 0.0126884, -0.00350529);
		N139_3 := if(((real)max_lres1 < 1.5), -0.00411623, 0.00790994);
		N139_2 := if(((real)addrs_5yr_cap < 0.5), N139_3, N139_4);
		N139_1 := if(((real)addrs_per_adl_c6 < 0.5), N139_2, N139_5);

		N140_5 := if(((real)c_highinc1 < 1.5), -0.0190863, -0.00103597);
		N140_4 := if(((real)ams_college_tier1 < 0.5), 0.00192417, 0.0162388);
		N140_3 := if(((real)c_larceny1 < 1.5), -0.00356635, N140_4);
		N140_2 := if(((real)acc_flag < 0.5), N140_3, -0.0114103);
		N140_1 := if(((real)c_housingcpi1 < 3.5), N140_2, N140_5);

		N141_5 := if((estimated_income < 30500), 0.00645193, -0.00671109);
		N141_4 := if(((real)add1_naprop1 < 2.5), N141_5, 0.00194067);
		N141_3 := if(((real)rel_prop_sold_count1 < 0.5), 0.00859969, -0.00295464);
		N141_2 := if(((real)veradd_p < 0.5), N141_3, N141_4);
		N141_1 := if(((real)watercraft_flag < 0.5), N141_2, 0.0121965);

		N142_5 := if(((real)c_inc_100k_p1 < 1.5), -0.00455611, 0.00425365);
		N142_4 := if(((real)rel_criminal_total1 < 4.5), N142_5, 0.00956967);
		N142_3 := if(((real)criminal_count1 < 1.5), N142_4, -0.0104174);
		N142_2 := if(((real)c_cpiall1 < 1.5), 0.0112418, -0.00361189);
		N142_1 := if(((real)source_tot_wp < 0.5), N142_2, N142_3);

		N143_5 := if(((real)lien_flag < 0.5), 0.00185164, -0.0118765);
		N143_4 := if(((real)c_born_usa1 < 3.5), N143_5, 0.012945);
		N143_3 := if((estimated_income < 38500), -0.00731516, N143_4);
		N143_2 := if(((real)years_in_dob1 < 1.5), 0.00223111, N143_3);
		N143_1 := if(((real)disposition1 < 1.5), 0.00525122, N143_2);

		N144_5 := if((estimated_income < 72500), -0.00458724, 0.00862927);
		N144_4 := if(((integer)bankrupt < 0.5), N144_5, 0.00386074);
		N144_3 := if(((real)addrs_5yr_cap < 0.5), 0.00382505, N144_4);
		N144_2 := if(((real)dist_a2toa31 < 1.5), 0.00841121, N144_3);
		N144_1 := if(((real)c_ab_av_edu1 < 1.5), 0.0120065, N144_2);

		N145_5 := if(((real)diff_source_tot_pos_neg1 < 3.5), 0.00449273, -0.0131916);
		N145_4 := if(((real)source_tot_em < 0.5), 0.00109186, 0.0100033);
		N145_3 := if(((real)nap_summary1 < 2.5), N145_4, -0.00911236);
		N145_2 := if(((real)lien_rec_unrel_flag < 0.5), N145_3, -0.00722252);
		N145_1 := if(((real)crim_rel_within25miles1 < 2.5), N145_2, N145_5);

		N146_5 := if(((real)c_old_homes1 < 1.5), 0.00490586, -0.00694468);
		N146_4 := if((estimated_income < 30500), -0.00544688, 0.00695674);
		N146_3 := if(((real)lien_flag < 0.5), N146_4, -0.00231219);
		N146_2 := if(((real)c_housingcpi1 < 3.5), N146_3, -0.0076423);
		N146_1 := if(((real)ssns_per_addr_c61 < 0.5), N146_2, N146_5);

		N147_5 := if(((real)max_lres1 < 3.5), -0.000391514, 0.012543);
		N147_4 := if(((real)rel_prop_sold_count1 < 0.5), -0.00492858, 0.00964003);
		N147_3 := if(((integer)add1_family_owned < 0.5), -0.00621817, N147_4);
		N147_2 := if(((real)c_ab_av_edu1 < 3.5), N147_3, N147_5);
		N147_1 := if(((real)rel_prop_owned_assessed_total1 < 2.5), 0.00403298, N147_2);

		N148_5 := if(((real)c_lux_prod1 < 3.5), -0.00539836, -0.0201211);
		N148_4 := if(((real)c_assault1 < 3.5), N148_5, 0.00279124);
		N148_3 := if(((integer)add1_family_owned < 0.5), N148_4, 0.00106938);
		N148_2 := if(((real)attr_eviction_flag < 0.5), 0.00330741, -0.0111075);
		N148_1 := if(((real)verphn_p < 0.5), N148_2, N148_3);

		N149_5 := if(((real)addr_stability1 < 1.5), -0.0166491, 0.00152061);
		N149_4 := if(((real)lien_hist_unrel_flag < 0.5), N149_5, 0.0146057);
		N149_3 := if(((real)crim_rel_within25miles1 < 0.5), -0.00616626, N149_4);
		N149_2 := if(((real)add1_avm_hit < 0.5), N149_3, 0.00129996);
		N149_1 := if(((integer)rc_fnamessnmatch < 0.5), 0.0101835, N149_2);

		N150_5 := if(((real)c_bel_edu1 < 2.5), -0.00880318, 0.00603084);
		N150_4 := if(((real)diff_source_tot_pos_neg1 < 1.5), -0.00652238, 0.00297796);
		N150_3 := if(((real)acc_flag < 0.5), N150_4, -0.0151051);
		N150_2 := if(((real)c_old_homes1 < 3.5), N150_3, N150_5);
		N150_1 := if(((real)rc_hphonetypeflag1 < 1.5), N150_2, -0.0107411);

		N151_5 := if(((real)rc_hphonetypeflag1 < 1.5), -0.0008569, -0.0116576);
		N151_4 := if(((real)dist_a1toa31 < 2.5), 0.0163287, -4.17788e-005);
		N151_3 := if(((real)nap_summary1 < 1.5), -0.00809897, N151_4);
		N151_2 := if(((real)current_count1 < 1.5), N151_3, 0.0134187);
		N151_1 := if(((real)c_assault1 < 2.5), N151_2, N151_5);

		N152_5 := if(((real)diff_source_tot_pos_neg1 < 2.5), -0.0116812, 0.000802123);
		N152_4 := if(((real)wealth_index < 4.5), 0.00896557, -0.00362122);
		N152_3 := if(((real)c_burglary1 < 3.5), N152_4, -0.00728165);
		N152_2 := if(((real)c_lux_prod1 < 3.5), N152_3, N152_5);
		N152_1 := if(((real)attr_addrs_last361 < 0.5), -0.00272028, N152_2);

		N153_5 := if(((real)adls_per_phone1 < 2.5), 0.00568134, -0.0130114);
		N153_4 := if(((real)c_inc_100k_p1 < 1.5), -0.0193386, N153_5);
		N153_3 := if(((real)phn_cellpager < 0.5), -7.35842e-005, 0.00824842);
		N153_2 := if(((real)lien_rec_unrel_flag < 0.5), N153_3, N153_4);
		N153_1 := if(((real)c_cpiall1 < 1.5), 0.0112303, N153_2);

		N154_5 := if(((integer)add1_family_owned < 0.5), -0.00736652, 0.0088314);
		N154_4 := if(((real)current_count1 < 1.5), N154_5, 0.0169007);
		N154_3 := if(((real)c_low_hval1 < 3.5), N154_4, -0.0109531);
		N154_2 := if(((real)c_span_lang1 < 1.5), N154_3, -0.00522537);
		N154_1 := if(((real)infutor_flag < 0.5), 0.00180046, N154_2);

		N155_5 := if(((real)add1_avm_med_geo11_lvl < 1.5), 0.000540954, 0.0166994);
		N155_4 := if(((real)c_hval_200k_p1 < 1.5), 0.0129094, 0.00182794);
		N155_3 := if(((real)name_change_flag < 0.5), N155_4, -0.0117471);
		N155_2 := if(((real)current_count1 < 0.5), -0.00244518, N155_3);
		N155_1 := if(((real)phn_cellpager < 0.5), N155_2, N155_5);

		N156_5 := if(((real)attr_addrs_last361 < 3.5), -0.00161199, 0.00770278);
		N156_4 := if(((real)addr_stability1 < 2.5), 0.0083051, -0.00917218);
		N156_3 := if((estimated_income < 59500), N156_4, -0.014431);
		N156_2 := if(((real)rel_criminal_total1 < 0.5), 0.0129779, N156_3);
		N156_1 := if(((real)c_hh2_p1 < 1.5), N156_2, N156_5);

		N157_5 := if(((real)rc_phonelnamecount < 0.5), -0.000586671, 0.00855149);
		N157_4 := if(((real)addrs_per_adl_c6 < 0.5), N157_5, 0.0138711);
		N157_3 := if((estimated_income < 50500), N157_4, -0.00257446);
		N157_2 := if(((real)c_born_usa1 < 1.5), -0.00297624, N157_3);
		N157_1 := if(((real)acc_flag < 0.5), N157_2, -0.0145482);

		N158_5 := if((estimated_income < 31500), -0.00327393, 0.0109695);
		N158_4 := if(((real)addr_stability1 < 1.5), -0.0058893, N158_5);
		N158_3 := if(((real)c_lux_prod1 < 1.5), -0.00777624, N158_4);
		N158_2 := if(((real)wealth_index < 1.5), 0.00636562, -0.00232352);
		N158_1 := if(((real)rel_criminal_total1 < 3.5), N158_2, N158_3);

		N159_5 := if(((real)dist_a1toa31 < 1.5), 0.0123202, 0.000218741);
		N159_4 := if(((real)c_bel_edu1 < 3.5), -0.00386752, 0.00741447);
		N159_3 := if(((real)c_hh2_p1 < 3.5), N159_4, -0.0158111);
		N159_2 := if(((real)c_old_homes1 < 1.5), N159_3, N159_5);
		N159_1 := if(((real)rc_hphonetypeflag1 < 1.5), N159_2, -0.00890294);

		N160_5 := if(((real)c_larceny1 < 3.5), 0.0121517, -0.0068578);
		N160_4 := if(((real)crim_rel_within25miles1 < 3.5), -0.00301974, 0.014528);
		N160_3 := if(((real)c_larceny1 < 2.5), N160_4, 0.00387082);
		N160_2 := if(((real)rc_hphonetypeflag1 < 1.5), N160_3, -0.0134497);
		N160_1 := if(((real)c_born_usa1 < 3.5), N160_2, N160_5);

		N161_5 := if((estimated_income < 31500), -0.00615084, 0.00740122);
		N161_4 := if(((real)add1_avm_hit < 0.5), -0.000270152, N161_5);
		N161_3 := if(((real)rc_phoneaddr_lnamecount < 0.5), 0.000158083, -0.0138719);
		N161_2 := if(((real)c_housingcpi1 < 2.5), N161_3, N161_4);
		N161_1 := if((estimated_income < 81500), N161_2, -0.0129064);

		N162_5 := if((estimated_income < 39500), 0.0128995, -0.00442955);
		N162_4 := if(((real)addrs_5yr_cap < 0.5), 0.002803, -0.00535653);
		N162_3 := if(((real)adls_per_addr1 < 2.5), 0.00131483, N162_4);
		N162_2 := if(((real)phn_cellpager < 0.5), N162_3, N162_5);
		N162_1 := if((estimated_income < 24500), 0.0140445, N162_2);

		N163_5 := if(((real)add1_naprop1 < 1.5), 0.0211644, 0.00418435);
		N163_4 := if(((real)c_bel_edu1 < 2.5), 0.0169772, -0.00293156);
		N163_3 := if(((real)phn_cellpager < 0.5), -0.000611629, N163_4);
		N163_2 := if(((real)years_in_dob1 < 3.5), N163_3, -0.00865623);
		N163_1 := if(((real)ams_college_tier1 < 0.5), N163_2, N163_5);

		N164_5 := if(((real)prop_owned_flag < 0.5), -0.012922, 0.00548758);
		N164_4 := if(((real)max_lres1 < 3.5), 0.00539563, -0.00269046);
		N164_3 := if(((real)c_inc_100k_p1 < 3.5), N164_4, N164_5);
		N164_2 := if(((real)attr_addrs_last361 < 0.5), -0.00301588, N164_3);
		N164_1 := if(((real)c_assault1 < 1.5), -0.0119139, N164_2);

		N165_5 := if(((real)rc_phoneaddrcount < 0.5), 0.0160606, -0.00297085);
		N165_4 := if(((real)c_famotf18_p1 < 3.5), -0.004371, N165_5);
		N165_3 := if(((real)infutor_flag < 0.5), N165_4, -0.00526434);
		N165_2 := if(((real)rc_hphonetypeflag1 < 1.5), N165_3, -0.02063);
		N165_1 := if(((real)c_low_hval1 < 2.5), 0.000964068, N165_2);

		N166_5 := if(((real)rc_phonevalflag1 < 1.5), 0.0122407, -0.00556087);
		N166_4 := if(((real)rel_criminal_total1 < 2.5), 0.00290278, 0.0228064);
		N166_3 := if(((real)c_assault1 < 3.5), N166_4, N166_5);
		N166_2 := if(((real)lien_flag < 0.5), N166_3, -0.00569361);
		N166_1 := if(((real)c_larceny1 < 2.5), -0.00227698, N166_2);

		N167_5 := if(((real)ssns_per_adl1 < 1.5), -0.000544758, -0.0184617);
		N167_4 := if(((real)disposition1 < 1.5), 0.0125036, 0.0012644);
		N167_3 := if(((real)c_no_move1 < 3.5), N167_4, N167_5);
		N167_2 := if((estimated_income < 35500), 0.00775375, N167_3);
		N167_1 := if(((real)verphn_p < 0.5), N167_2, -0.00244136);

		N168_5 := if(((real)c_hval_200k_p1 < 2.5), 0.00349504, -0.0191311);
		N168_4 := if(((real)phn_zipmismatch < 0.5), 0.00470281, N168_5);
		N168_3 := if(((real)add1_avm_hit < 0.5), -0.00418689, N168_4);
		N168_2 := if(((real)adls_per_addr1 < 2.5), 0.0122076, -0.000833701);
		N168_1 := if(((real)disposition1 < 1.5), N168_2, N168_3);

		N169_5 := if(((real)rel_criminal_total1 < 3.5), 0.00886287, -0.00950262);
		N169_4 := if(((real)c_bel_edu1 < 1.5), 0.0166833, N169_5);
		N169_3 := if(((real)adls_per_addr1 < 2.5), -0.0109761, N169_4);
		N169_2 := if(((real)add1_avm_hit < 0.5), -0.0056656, -0.000325954);
		N169_1 := if(((real)out_addr_type1 < 1.5), N169_2, N169_3);

		N170_5 := if(((real)c_famotf18_p1 < 3.5), 0.00999567, -0.0113773);
		N170_4 := if(((real)diff_source_tot_pos_neg1 < 3.5), N170_5, -0.0143371);
		N170_3 := if(((real)addrs_5yr_cap < 3.5), -0.00051605, N170_4);
		N170_2 := if(((real)addrs_per_adl_c6 < 0.5), N170_3, 0.0041454);
		N170_1 := if((estimated_income < 26500), 0.0104184, N170_2);

		N171_5 := if(((real)c_low_hval1 < 3.5), 0.00840214, -0.00481124);
		N171_4 := if(((real)max_lres1 < 1.5), 0.00303197, -0.00326924);
		N171_3 := if(((real)phn_cellpager < 0.5), N171_4, 0.00816105);
		N171_2 := if(((real)out_addr_type1 < 1.5), N171_3, N171_5);
		N171_1 := if(((integer)rc_fnamessnmatch < 0.5), 0.0115426, N171_2);

		N172_5 := if(((real)c_med_inc1 < 2.5), -0.00530239, 0.0100505);
		N172_4 := if(((real)c_hval_200k_p1 < 2.5), 0.00187802, 0.0157281);
		N172_3 := if(((real)c_span_lang1 < 2.5), N172_4, N172_5);
		N172_2 := if(((real)ssns_per_addr_c61 < 0.5), 0.00105361, -0.00581473);
		N172_1 := if(((real)ssn_issued18 < 0.5), N172_2, N172_3);

		N173_5 := if(((real)c_inc_100k_p1 < 3.5), 0.00342458, -0.00621332);
		N173_4 := if(((real)rc_phonevalflag1 < 1.5), 0.0116261, -0.0100562);
		N173_3 := if(((real)c_hval_200k_p1 < 3.5), -0.0158776, N173_4);
		N173_2 := if(((real)max_lres1 < 1.5), N173_3, N173_5);
		N173_1 := if((estimated_income < 42500), N173_2, 0.00298427);

		N174_5 := if(((real)current_count1 < 0.5), -0.00240481, 0.0171646);
		N174_4 := if(((real)c_fammar_p1 < 3.5), N174_5, -0.00690699);
		N174_3 := if(((real)out_addr_type1 < 1.5), -0.00256901, N174_4);
		N174_2 := if(((real)adls_per_addr1 < 1.5), 0.00902823, N174_3);
		N174_1 := if(((real)c_cpiall1 < 1.5), 0.0118157, N174_2);

		N175_5 := if(((real)rc_phoneaddr_lnamecount < 0.5), -0.00721081, 0.00164536);
		N175_4 := if(((real)adls_per_addr1 < 2.5), 0.0113996, 0.000180553);
		N175_3 := if(((real)diff_source_tot_pos_neg1 < 3.5), N175_4, N175_5);
		N175_2 := if(((real)c_bel_edu1 < 3.5), N175_3, 0.00709888);
		N175_1 := if(((real)c_lux_prod1 < 3.5), N175_2, -0.00482787);

		N176_5 := if(((real)veradd_p < 0.5), -0.0197457, -0.00228024);
		N176_4 := if(((real)years_in_dob1 < 2.5), 0.00106017, -0.0146827);
		N176_3 := if(((real)c_assault1 < 1.5), -0.0186266, N176_4);
		N176_2 := if(((real)c_easiqlife1 < 1.5), N176_3, 0.00307262);
		N176_1 := if(((real)c_housingcpi1 < 3.5), N176_2, N176_5);

		N177_5 := if(((real)c_ab_av_edu1 < 3.5), -0.00882145, -0.0223517);
		N177_4 := if(((real)add1_avm_hit < 0.5), N177_5, 0.00176302);
		N177_3 := if((estimated_income < 29500), 0.00639612, N177_4);
		N177_2 := if(((real)phn_zipmismatch < 0.5), N177_3, 0.00651373);
		N177_1 := if(((real)c_born_usa1 < 1.5), N177_2, 0.000500419);

		N178_5 := if(((real)addrs_5yr_cap < 3.5), 0.00390708, -0.00329453);
		N178_4 := if(((real)ssns_per_addr_c61 < 0.5), N178_5, -0.003768);
		N178_3 := if((estimated_income < 85500), N178_4, -0.0107574);
		N178_2 := if(((real)dist_a1toa31 < 2.5), 0.00657483, -0.0138562);
		N178_1 := if((estimated_income < 29500), N178_2, N178_3);

		N179_5 := if(((real)crim_rel_within25miles1 < 1.5), 0.00977644, -0.0067933);
		N179_4 := if(((real)infutor_flag < 0.5), N179_5, -0.00172835);
		N179_3 := if(((real)c_hval_200k_p1 < 3.5), 0.00333984, -0.00704502);
		N179_2 := if(((real)rel_prop_sold_count1 < 0.5), -0.00635823, N179_3);
		N179_1 := if(((real)c_famotf18_p1 < 3.5), N179_2, N179_4);

		N180_5 := if(((real)add1_avm_med_geo11_lvl < 1.5), -0.00497282, 0.0059546);
		N180_4 := if((estimated_income < 40500), -0.0059086, N180_5);
		N180_3 := if(((real)c_bel_edu1 < 2.5), -0.0136991, 0.00263441);
		N180_2 := if(((real)c_hh2_p1 < 2.5), 0.00654681, N180_3);
		N180_1 := if(((real)rc_phonephonecount < 0.5), N180_2, N180_4);

		N181_5 := if(((real)acc_flag < 0.5), 0.000352274, -0.00994962);
		N181_4 := if((estimated_income < 50500), 0.0126329, -0.00509909);
		N181_3 := if(((real)c_no_labfor1 < 1.5), N181_4, N181_5);
		N181_2 := if(((real)ams_college_tier1 < 0.5), N181_3, 0.00813243);
		N181_1 := if(((real)years_in_dob1 < 3.5), N181_2, -0.00939741);

		N182_5 := if(((real)crim_rel_within25miles1 < 0.5), 0.011172, -0.00062271);
		N182_4 := if(((real)rel_prop_sold_count1 < 0.5), 0.00899491, -0.00697915);
		N182_3 := if(((real)c_famotf18_p1 < 2.5), 0.00083512, -0.00722559);
		N182_2 := if(((real)c_fammar_p1 < 3.5), N182_3, N182_4);
		N182_1 := if(((real)addrs_per_adl_c6 < 0.5), N182_2, N182_5);

		N183_5 := if(((real)c_lux_prod1 < 2.5), -0.0154649, 0.00384741);
		N183_4 := if(((real)attr_total_number_derogs1 < 0.5), 0.0100809, N183_5);
		N183_3 := if(((real)c_no_move1 < 3.5), N183_4, 0.0202581);
		N183_2 := if((estimated_income < 37500), 0.00174115, -0.00272028);
		N183_1 := if(((real)source_tot_em < 0.5), N183_2, N183_3);

		N184_5 := if(((real)c_born_usa1 < 2.5), -0.00735192, 0.00348789);
		N184_4 := if(((real)addrs_5yr_cap < 2.5), 0.000162308, N184_5);
		N184_3 := if(((real)ams_college_tier1 < 0.5), N184_4, 0.00698652);
		N184_2 := if(((real)adls_per_addr1 < 1.5), 0.0101071, N184_3);
		N184_1 := if(((real)c_ab_av_edu1 < 1.5), 0.0131769, N184_2);

		N185_5 := if(((real)c_no_move1 < 1.5), -0.0101926, 0.000933826);
		N185_4 := if(((real)rel_criminal_total1 < 3.5), 0.00430628, 0.0210061);
		N185_3 := if(((real)current_count1 < 0.5), -0.00088099, N185_4);
		N185_2 := if(((real)rel_prop_owned_assessed_total1 < 2.5), N185_3, N185_5);
		N185_1 := if(((real)lien_flag < 0.5), N185_2, -0.00486428);

		N186_5 := if(((real)rel_prop_owned_assessed_total1 < 2.5), 0.00812182, -0.0027533);
		N186_4 := if(((integer)add1_family_owned < 0.5), N186_5, -0.0121797);
		N186_3 := if(((integer)prof_license_flag < 0.5), 0.00288455, 0.014163);
		N186_2 := if(((real)phn_zipmismatch < 0.5), N186_3, -0.0035034);
		N186_1 := if(((real)max_lres1 < 2.5), N186_2, N186_4);

		N187_5 := if(((real)source_tot_wp < 0.5), -0.00937955, 0.00949717);
		N187_4 := if(((real)attr_total_number_derogs1 < 1.5), N187_5, 0.0143655);
		N187_3 := if(((real)c_assault1 < 2.5), 0.00269163, -0.00498719);
		N187_2 := if(((real)crim_rel_within25miles1 < 1.5), N187_3, N187_4);
		N187_1 := if(((real)rel_prop_owned_assessed_total1 < 2.5), 0.00199926, N187_2);

		N188_5 := if(((real)prop_owned_flag < 0.5), 0.00762248, -0.00310787);
		N188_4 := if(((real)lien_rec_unrel_flag < 0.5), -0.00696212, 0.00489589);
		N188_3 := if(((real)add1_avm_med_geo11_lvl < 2.5), -0.0016343, 0.0110186);
		N188_2 := if(((real)adls_per_addr1 < 2.5), N188_3, N188_4);
		N188_1 := if(((real)out_addr_type1 < 1.5), N188_2, N188_5);

		N189_5 := if(((integer)add1_applicant_owned < 0.5), 0.00105276, -0.0129508);
		N189_4 := if(((real)add1_avm_med_geo11_lvl < 2.5), 0.00219029, 0.0136943);
		N189_3 := if(((real)c_med_hhinc1 < 3.5), 0.00203158, -0.00839483);
		N189_2 := if(((real)current_count1 < 0.5), N189_3, N189_4);
		N189_1 := if(((real)crime_flag < 0.5), N189_2, N189_5);

		N190_5 := if(((real)add1_avm_med_geo11_lvl < 1.5), 0.0177416, 0.000331175);
		N190_4 := if(((real)infutor_flag < 0.5), N190_5, -0.00517356);
		N190_3 := if(((real)attr_total_number_derogs1 < 1.5), N190_4, 0.0127452);
		N190_2 := if(((real)lien_rec_unrel_flag < 0.5), -0.0010623, -0.0105931);
		N190_1 := if(((real)ssn_issued18 < 0.5), N190_2, N190_3);

		N191_5 := if(((real)c_born_usa1 < 3.5), 0.00412086, 0.0197254);
		N191_4 := if(((real)c_hh2_p1 < 2.5), 0.00495371, -0.013443);
		N191_3 := if(((real)c_highinc1 < 1.5), N191_4, N191_5);
		N191_2 := if(((real)c_no_labfor1 < 2.5), N191_3, -0.00920723);
		N191_1 := if(((real)ssn_issued18 < 0.5), -0.00329914, N191_2);

		N192_5 := if(((real)ssn_adl_prob < 0.5), 0.00407886, -0.0117513);
		N192_4 := if(((real)rel_prop_owned_count1 < 0.5), -0.00377198, N192_5);
		N192_3 := if(((real)c_cpiall1 < 3.5), -0.000264629, -0.0109842);
		N192_2 := if(((real)max_lres1 < 2.5), N192_3, -0.0123926);
		N192_1 := if(((real)attr_addrs_last361 < 0.5), N192_2, N192_4);

		N193_5 := if(((real)addrs_5yr_cap < 3.5), 0.004867, 0.0200405);
		N193_4 := if(((real)diff_source_tot_pos_neg1 < 2.5), -0.00372803, N193_5);
		N193_3 := if(((real)current_count1 < 1.5), N193_4, -0.00532467);
		N193_2 := if(((real)addrs_per_adl_c6 < 0.5), -0.00215348, N193_3);
		N193_1 := if((estimated_income < 26500), 0.0075474, N193_2);


		tnscore := sum(N0_1, N1_1, N2_1, N3_1, N4_1, N5_1, N6_1, N7_1, N8_1, N9_1, N10_1, N11_1, N12_1, N13_1, N14_1, N15_1, N16_1, N17_1, N18_1, N19_1, N20_1, N21_1, N22_1, N23_1, N24_1, N25_1, N26_1, N27_1, N28_1, N29_1, N30_1, N31_1, N32_1, N33_1, N34_1, N35_1, N36_1, N37_1, N38_1, N39_1, N40_1, N41_1, N42_1, N43_1, N44_1, N45_1, N46_1, N47_1, N48_1, N49_1, N50_1, N51_1, N52_1, N53_1, N54_1, N55_1, N56_1, N57_1, N58_1, N59_1, N60_1, N61_1, N62_1, N63_1, N64_1, N65_1, N66_1, N67_1, N68_1, N69_1, N70_1, N71_1, N72_1, N73_1, N74_1, N75_1, N76_1, N77_1, N78_1, N79_1, N80_1, N81_1, N82_1, N83_1, N84_1, N85_1, N86_1, N87_1, N88_1, N89_1, N90_1, N91_1, N92_1, N93_1, N94_1, N95_1, N96_1, N97_1, N98_1, N99_1, N100_1, N101_1, N102_1, N103_1, N104_1, N105_1, N106_1, N107_1, N108_1, N109_1, N110_1, N111_1, N112_1, N113_1, N114_1, N115_1, N116_1, N117_1, N118_1, N119_1, N120_1, N121_1, N122_1, N123_1, N124_1, N125_1, N126_1, N127_1, N128_1, N129_1, N130_1, N131_1, N132_1, N133_1, N134_1, N135_1, N136_1, N137_1, N138_1, N139_1, N140_1, N141_1, N142_1, N143_1, N144_1, N145_1, N146_1, N147_1, N148_1, N149_1, N150_1, N151_1, N152_1, N153_1, N154_1, N155_1, N156_1, N157_1, N158_1, N159_1, N160_1, N161_1, N162_1, N163_1, N164_1, N165_1, N166_1, N167_1, N168_1, N169_1, N170_1, N171_1, N172_1, N173_1, N174_1, N175_1, N176_1, N177_1, N178_1, N179_1, N180_1, N181_1, N182_1, N183_1, N184_1, N185_1, N186_1, N187_1, N188_1, N189_1, N190_1, N191_1, N192_1, N193_1);

		// expsum = 0.0;
		class_threshold := 0.5;

		// link TN0; /* PAID = 1 */
		score1 := exp(-tnscore); /* PAID = 0 */
		expsum1 := score1;
		score0 := exp(tnscore); /* PAID = 1 */
		expsum := expsum1 + score0;

		/***************************************/
		/* Probabilities for each target class */
		/***************************************/

		prob0 := score0 / expsum; /* PAID = 1 */
		prob1 := score1 / expsum; /* PAID = 0 */
		RSN1009_1_0_nocap := round(-40*(log(prob1/(1-prob1)) - log(1/20))/log(2) + 680);
		RSN1009_1_0 := map(
			RSN1009_1_0_nocap <= 250 => 250,
			RSN1009_1_0_nocap >= 999 => 999,
			RSN1009_1_0_nocap
		);
		/*********************/
		pred := if( prob0 > class_threshold, 1, 0 );
		
		#if(RSN_DEBUG)
			self.clam := le;
			self.out_addr_type := out_addr_type;
			self.in_dob := in_dob;
			self.nap_summary := nap_summary;
			self.nap_status := nap_status;
			self.rc_hriskphoneflag := rc_hriskphoneflag;
			self.rc_hphonetypeflag := rc_hphonetypeflag;
			self.rc_phonevalflag := rc_phonevalflag;
			self.rc_phonezipflag := rc_phonezipflag;
			self.rc_pwphonezipflag := rc_pwphonezipflag;
			self.rc_pwssnvalflag := rc_pwssnvalflag;
			self.rc_sources := rc_sources;
			self.rc_phonelnamecount := rc_phonelnamecount;
			self.rc_phoneaddrcount := rc_phoneaddrcount;
			self.rc_phonephonecount := rc_phonephonecount;
			self.rc_phoneaddr_lnamecount := rc_phoneaddr_lnamecount;
			self.rc_altlname1_flag := rc_altlname1_flag;
			self.rc_altlname2_flag := rc_altlname2_flag;
			self.rc_fnamessnmatch := rc_fnamessnmatch;
			self.lname_eda_sourced := lname_eda_sourced;
			self.add1_avm_land_use := add1_avm_land_use;
			self.add1_avm_med_geo11 := add1_avm_med_geo11;
			self.add1_eda_sourced := add1_eda_sourced;
			self.add1_applicant_owned := add1_applicant_owned;
			self.add1_family_owned := add1_family_owned;
			self.add1_naprop := add1_naprop;
			self.property_owned_total := property_owned_total;
			self.property_sold_total := property_sold_total;
			self.dist_a1toa2 := dist_a1toa2;
			self.dist_a1toa3 := dist_a1toa3;
			self.dist_a2toa3 := dist_a2toa3;
			self.max_lres := max_lres;
			self.addrs_5yr := addrs_5yr;
			self.ssns_per_adl := ssns_per_adl;
			self.adls_per_addr := adls_per_addr;
			self.adls_per_phone := adls_per_phone;
			self.ssns_per_adl_c6 := ssns_per_adl_c6;
			self.addrs_per_adl_c6 := addrs_per_adl_c6;
			self.ssns_per_addr_c6 := ssns_per_addr_c6;
			self.infutor_first_seen := infutor_first_seen;
			self.attr_addrs_last36 := attr_addrs_last36;
			self.attr_total_number_derogs := attr_total_number_derogs;
			self.attr_eviction_count := attr_eviction_count;
			self.bankrupt := bankrupt;
			self.disposition := disposition;
			self.liens_recent_unreleased_count := liens_recent_unreleased_count;
			self.liens_historical_unreleased_ct := liens_historical_unreleased_ct;
			self.criminal_count := criminal_count;
			self.rel_criminal_total := rel_criminal_total;
			self.crim_rel_within25miles := crim_rel_within25miles;
			self.rel_prop_owned_count := rel_prop_owned_count;
			self.rel_prop_owned_assessed_total := rel_prop_owned_assessed_total;
			self.rel_prop_sold_count := rel_prop_sold_count;
			self.current_count := current_count;
			self.watercraft_count := watercraft_count;
			self.acc_count := acc_count;
			self.ams_college_tier := ams_college_tier;
			self.prof_license_flag := prof_license_flag;
			self.wealth_index := wealth_index;
			self.addr_stability := addr_stability;
			self.estimated_income := estimated_income;
			self.archive_date := archive_date;
			self.c_ab_av_edu := c_ab_av_edu;
			self.c_assault := c_assault;
			self.c_bel_edu := c_bel_edu;
			self.c_born_usa := c_born_usa;
			self.c_burglary := c_burglary;
			self.c_easiqlife := c_easiqlife;
			self.c_exp_prod := c_exp_prod;
			self.c_fammar_p := c_fammar_p;
			self.c_famotf18_p := c_famotf18_p;
			self.c_hh2_p := c_hh2_p;
			self.c_highinc := c_highinc;
			self.c_hval_200k_p := c_hval_200k_p;
			self.c_inc_100k_p := c_inc_100k_p;
			self.c_larceny := c_larceny;
			self.c_low_hval := c_low_hval;
			self.c_lux_prod := c_lux_prod;
			self.c_med_hhinc := c_med_hhinc;
			self.c_med_hval := c_med_hval;
			self.c_med_inc := c_med_inc;
			self.c_no_move := c_no_move;
			self.c_old_homes := c_old_homes;
			self.c_span_lang := c_span_lang;
			self.c_cpiall := c_cpiall;
			self.c_no_labfor := c_no_labfor;
			self.c_housingcpi := c_housingcpi;
			self.sysdate := sysdate;
			self.sysyear := sysyear;
			self.lien_rec_unrel_flag := lien_rec_unrel_flag;
			self.lien_hist_unrel_flag := lien_hist_unrel_flag;
			self.lien_flag := lien_flag;
			self.source_tot_L2 := source_tot_L2;
			self.source_tot_LI := source_tot_LI;
			self.watercraft_flag := watercraft_flag;
			self.verlst_p := verlst_p;
			self.veradd_p := veradd_p;
			self.verphn_p := verphn_p;
			self.contrary_phn := contrary_phn;
			self.name_change_flag := name_change_flag;
			self.phn_cellpager := phn_cellpager;
			self.phn_zipmismatch := phn_zipmismatch;
			self.ssn_issued18 := ssn_issued18;
			self.ssn_adl_prob := ssn_adl_prob;
			self.add1_AVM_hit := add1_AVM_hit;
			self.prop_owned_flag := prop_owned_flag;
			self.prop_sold_flag := prop_sold_flag;
			self._daycap_b1 := _daycap_b1;
			self.infutor_first_seen2 := infutor_first_seen2;
			self.years_infutor_first_seen := years_infutor_first_seen;
			self.infutor_flag := infutor_flag;
			self.attr_eviction_flag := attr_eviction_flag;
			self.crime_flag := crime_flag;
			self.acc_flag := acc_flag;
			self.out_addr_type1 := out_addr_type1;
			self.in_dob2 := in_dob2;
			self.years_in_dob := years_in_dob;
			self.years_in_dob1 := years_in_dob1;
			self.nap_summary1 := nap_summary1;
			self.nap_status1 := nap_status1;
			self.rc_hphonetypeflag1 := rc_hphonetypeflag1;
			self.rc_phonevalflag1 := rc_phonevalflag1;
			self.source_tot_AM := source_tot_AM;
			self.source_tot_AR := source_tot_AR;
			self.source_tot_CY := source_tot_CY;
			self.source_tot_D := source_tot_D;
			self.source_tot_DL := source_tot_DL;
			self.source_tot_EB := source_tot_EB;
			self.source_tot_EM := source_tot_EM;
			self.source_tot_VO := source_tot_VO;
			self.source_tot_EQ := source_tot_EQ;
			self.source_tot_MW := source_tot_MW;
			self.source_tot_P := source_tot_P;
			self.source_tot_PL := source_tot_PL;
			self.source_tot_SL := source_tot_SL;
			self.source_tot_TU := source_tot_TU;
			self.source_tot_V := source_tot_V;
			self.source_tot_W := source_tot_W;
			self.source_tot_WP := source_tot_WP;
			self.source_tot_AK := source_tot_AK;
			self.source_tot_BA := source_tot_BA;
			self.source_tot_CG := source_tot_CG;
			self.source_tot_CO := source_tot_CO;
			self.source_tot_DA := source_tot_DA;
			self.source_tot_DS := source_tot_DS;
			self.source_tot_FF := source_tot_FF;
			self.source_tot_FR := source_tot_FR;
			self.source_tot_NT := source_tot_NT;
			self.source_tot_count_pos := source_tot_count_pos;
			self.source_tot_count_neg := source_tot_count_neg;
			self.diff_source_tot_pos_neg := diff_source_tot_pos_neg;
			self.diff_source_tot_pos_neg1 := diff_source_tot_pos_neg1;
			self.add1_avm_med_geo11_lvl := add1_avm_med_geo11_lvl;
			self.add1_naprop1 := add1_naprop1;
			self.addrs_5yr_cap := addrs_5yr_cap;
			self.ssns_per_adl1 := ssns_per_adl1;
			self.adls_per_addr1 := adls_per_addr1;
			self.adls_per_phone1 := adls_per_phone1;
			self.ssns_per_addr_c61 := ssns_per_addr_c61;
			self.attr_addrs_last361 := attr_addrs_last361;
			self.attr_total_number_derogs1 := attr_total_number_derogs1;
			self.disposition1 := disposition1;
			self.criminal_count1 := criminal_count1;
			self.rel_prop_owned_count1 := rel_prop_owned_count1;
			self.rel_prop_sold_count1 := rel_prop_sold_count1;
			self.ams_college_tier1 := ams_college_tier1;
			self.addr_stability1 := addr_stability1;
			self.estimated_income1 := estimated_income1;
			self.dist_a1toa21 := dist_a1toa21;
			self.dist_a1toa31 := dist_a1toa31;
			self.dist_a2toa31 := dist_a2toa31;
			self.rel_criminal_total1 := rel_criminal_total1;
			self.rel_prop_owned_assessed_total1 := rel_prop_owned_assessed_total1;
			self.crim_rel_within25miles1 := crim_rel_within25miles1;
			self.current_count1 := current_count1;
			self.max_lres1 := max_lres1;
			self.c_ab_av_edu1 := c_ab_av_edu1;
			self.c_assault1 := c_assault1;
			self.c_bel_edu1 := c_bel_edu1;
			self.c_born_usa1 := c_born_usa1;
			self.c_burglary1 := c_burglary1;
			self.c_easiqlife1 := c_easiqlife1;
			self.c_exp_prod1 := c_exp_prod1;
			self.c_fammar_p1 := c_fammar_p1;
			self.c_famotf18_p1 := c_famotf18_p1;
			self.c_hh2_p1 := c_hh2_p1;
			self.c_highinc1 := c_highinc1;
			self.c_hval_200k_p1 := c_hval_200k_p1;
			self.c_inc_100k_p1 := c_inc_100k_p1;
			self.c_larceny1 := c_larceny1;
			self.c_low_hval1 := c_low_hval1;
			self.c_lux_prod1 := c_lux_prod1;
			self.c_med_hhinc1 := c_med_hhinc1;
			self.c_med_hval1 := c_med_hval1;
			self.c_med_inc1 := c_med_inc1;
			self.c_no_move1 := c_no_move1;
			self.c_old_homes1 := c_old_homes1;
			self.c_span_lang1 := c_span_lang1;
			self.c_cpiall1 := c_cpiall1;
			self.c_no_labfor1 := c_no_labfor1;
			self.c_housingcpi1 := c_housingcpi1;
			self.N0_1 := N0_1;
			self.N1_1 := N1_1;
			self.N2_1 := N2_1;
			self.N3_1 := N3_1;
			self.N4_1 := N4_1;
			self.N5_1 := N5_1;
			self.N6_1 := N6_1;
			self.N7_1 := N7_1;
			self.N8_1 := N8_1;
			self.N9_1 := N9_1;
			self.N10_1 := N10_1;
			self.N11_1 := N11_1;
			self.N12_1 := N12_1;
			self.N13_1 := N13_1;
			self.N14_1 := N14_1;
			self.N15_1 := N15_1;
			self.N16_1 := N16_1;
			self.N17_1 := N17_1;
			self.N18_1 := N18_1;
			self.N19_1 := N19_1;
			self.N20_1 := N20_1;
			self.N21_1 := N21_1;
			self.N22_1 := N22_1;
			self.N23_1 := N23_1;
			self.N24_1 := N24_1;
			self.N25_1 := N25_1;
			self.N26_1 := N26_1;
			self.N27_1 := N27_1;
			self.N28_1 := N28_1;
			self.N29_1 := N29_1;
			self.N30_1 := N30_1;
			self.N31_1 := N31_1;
			self.N32_1 := N32_1;
			self.N33_1 := N33_1;
			self.N34_1 := N34_1;
			self.N35_1 := N35_1;
			self.N36_1 := N36_1;
			self.N37_1 := N37_1;
			self.N38_1 := N38_1;
			self.N39_1 := N39_1;
			self.N40_1 := N40_1;
			self.N41_1 := N41_1;
			self.N42_1 := N42_1;
			self.N43_1 := N43_1;
			self.N44_1 := N44_1;
			self.N45_1 := N45_1;
			self.N46_1 := N46_1;
			self.N47_1 := N47_1;
			self.N48_1 := N48_1;
			self.N49_1 := N49_1;
			self.N50_1 := N50_1;
			self.N51_1 := N51_1;
			self.N52_1 := N52_1;
			self.N53_1 := N53_1;
			self.N54_1 := N54_1;
			self.N55_1 := N55_1;
			self.N56_1 := N56_1;
			self.N57_1 := N57_1;
			self.N58_1 := N58_1;
			self.N59_1 := N59_1;
			self.N60_1 := N60_1;
			self.N61_1 := N61_1;
			self.N62_1 := N62_1;
			self.N63_1 := N63_1;
			self.N64_1 := N64_1;
			self.N65_1 := N65_1;
			self.N66_1 := N66_1;
			self.N67_1 := N67_1;
			self.N68_1 := N68_1;
			self.N69_1 := N69_1;
			self.N70_1 := N70_1;
			self.N71_1 := N71_1;
			self.N72_1 := N72_1;
			self.N73_1 := N73_1;
			self.N74_1 := N74_1;
			self.N75_1 := N75_1;
			self.N76_1 := N76_1;
			self.N77_1 := N77_1;
			self.N78_1 := N78_1;
			self.N79_1 := N79_1;
			self.N80_1 := N80_1;
			self.N81_1 := N81_1;
			self.N82_1 := N82_1;
			self.N83_1 := N83_1;
			self.N84_1 := N84_1;
			self.N85_1 := N85_1;
			self.N86_1 := N86_1;
			self.N87_1 := N87_1;
			self.N88_1 := N88_1;
			self.N89_1 := N89_1;
			self.N90_1 := N90_1;
			self.N91_1 := N91_1;
			self.N92_1 := N92_1;
			self.N93_1 := N93_1;
			self.N94_1 := N94_1;
			self.N95_1 := N95_1;
			self.N96_1 := N96_1;
			self.N97_1 := N97_1;
			self.N98_1 := N98_1;
			self.N99_1 := N99_1;
			self.N100_1 := N100_1;
			self.N101_1 := N101_1;
			self.N102_1 := N102_1;
			self.N103_1 := N103_1;
			self.N104_1 := N104_1;
			self.N105_1 := N105_1;
			self.N106_1 := N106_1;
			self.N107_1 := N107_1;
			self.N108_1 := N108_1;
			self.N109_1 := N109_1;
			self.N110_1 := N110_1;
			self.N111_1 := N111_1;
			self.N112_1 := N112_1;
			self.N113_1 := N113_1;
			self.N114_1 := N114_1;
			self.N115_1 := N115_1;
			self.N116_1 := N116_1;
			self.N117_1 := N117_1;
			self.N118_1 := N118_1;
			self.N119_1 := N119_1;
			self.N120_1 := N120_1;
			self.N121_1 := N121_1;
			self.N122_1 := N122_1;
			self.N123_1 := N123_1;
			self.N124_1 := N124_1;
			self.N125_1 := N125_1;
			self.N126_1 := N126_1;
			self.N127_1 := N127_1;
			self.N128_1 := N128_1;
			self.N129_1 := N129_1;
			self.N130_1 := N130_1;
			self.N131_1 := N131_1;
			self.N132_1 := N132_1;
			self.N133_1 := N133_1;
			self.N134_1 := N134_1;
			self.N135_1 := N135_1;
			self.N136_1 := N136_1;
			self.N137_1 := N137_1;
			self.N138_1 := N138_1;
			self.N139_1 := N139_1;
			self.N140_1 := N140_1;
			self.N141_1 := N141_1;
			self.N142_1 := N142_1;
			self.N143_1 := N143_1;
			self.N144_1 := N144_1;
			self.N145_1 := N145_1;
			self.N146_1 := N146_1;
			self.N147_1 := N147_1;
			self.N148_1 := N148_1;
			self.N149_1 := N149_1;
			self.N150_1 := N150_1;
			self.N151_1 := N151_1;
			self.N152_1 := N152_1;
			self.N153_1 := N153_1;
			self.N154_1 := N154_1;
			self.N155_1 := N155_1;
			self.N156_1 := N156_1;
			self.N157_1 := N157_1;
			self.N158_1 := N158_1;
			self.N159_1 := N159_1;
			self.N160_1 := N160_1;
			self.N161_1 := N161_1;
			self.N162_1 := N162_1;
			self.N163_1 := N163_1;
			self.N164_1 := N164_1;
			self.N165_1 := N165_1;
			self.N166_1 := N166_1;
			self.N167_1 := N167_1;
			self.N168_1 := N168_1;
			self.N169_1 := N169_1;
			self.N170_1 := N170_1;
			self.N171_1 := N171_1;
			self.N172_1 := N172_1;
			self.N173_1 := N173_1;
			self.N174_1 := N174_1;
			self.N175_1 := N175_1;
			self.N176_1 := N176_1;
			self.N177_1 := N177_1;
			self.N178_1 := N178_1;
			self.N179_1 := N179_1;
			self.N180_1 := N180_1;
			self.N181_1 := N181_1;
			self.N182_1 := N182_1;
			self.N183_1 := N183_1;
			self.N184_1 := N184_1;
			self.N185_1 := N185_1;
			self.N186_1 := N186_1;
			self.N187_1 := N187_1;
			self.N188_1 := N188_1;
			self.N189_1 := N189_1;
			self.N190_1 := N190_1;
			self.N191_1 := N191_1;
			self.N192_1 := N192_1;
			self.N193_1 := N193_1;
			self.tnscore := tnscore;
			self.class_threshold := class_threshold;
			self.score1 := score1;
			self.expsum1 := expsum1;
			self.score0 := score0;
			self.expsum := expsum;
			self.prob0 := prob0;
			self.prob1 := prob1;
			self.RSN1009_1_0_nocap := RSN1009_1_0_nocap;
			self.RSN1009_1_0 := RSN1009_1_0;
			self.pred := pred;
		#end;
		self.seq := (string)le.seq;
		self.recover_score := (string3)RSN1009_1_0;
		self := [];

	END;
	
	scores := join(clam, easi.key_easi_census, 
		keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
		doModel(LEFT, right), left outer, atmost(riskwise.max_atmost), keep(1));

	return scores;
END;