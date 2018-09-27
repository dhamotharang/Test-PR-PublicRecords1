import risk_indicators, ut, riskwise, riskwisefcra, std, riskview;

IED_DEBUG := false;

export IED1106_1_0( dataset(risk_indicators.Layout_Boca_Shell) clam, boolean isCalifornia ) := FUNCTION

	#if(IED_DEBUG)
		layout_debug := record
			risk_indicators.Layout_Boca_Shell clam;
			String out_unit_desig;
			String out_sec_range;
			String out_addr_type;
			String in_dob;
			Integer NAS_Summary;
			Integer NAP_Summary;
			String rc_phonevalflag;
			String rc_dwelltype;
			String rc_bansflag;
			Integer combo_addrcount;
			qstring100 ver_sources;
			Boolean lname_eda_sourced;
			Integer add1_avm_automated_valuation;
			Integer add1_avm_med_fips;
			Integer add1_avm_med_geo11;
			Integer add1_avm_med_geo12;
			Integer add1_naprop;
			String add1_mortgage_type;
			Integer property_sold_assessed_total;
			Integer dist_a1toa2;
			Integer dist_a2toa3;
			Integer gong_did_phone_ct;
			Integer addrs_per_adl;
			Integer attr_num_watercraft60;
			Integer attr_total_number_derogs;
			Integer attr_eviction_count;
			Boolean Bankrupt;
			Integer filing_count;
			Integer bk_recent_count;
			String ams_college_code;
			String ams_income_level_code;
			String prof_license_category;
			String wealth_index;
			Integer inferred_age;
			Integer archive_date;
			Integer sysdate;
			Boolean bk_flag;
			Integer add1_avm_med;
			Integer ver_src_p_pos;
			Boolean ver_src_p;
			Integer ver_src_w_pos;
			Boolean ver_src_w;
			Integer ver_src_am_pos;
			Boolean ver_src_am;
			Integer ver_src_da_pos;
			Boolean ver_src_da;
			Boolean add_apt;
			Integer in_dob2;
			Integer yr_in_dob;
			Integer yr_in_dob_int;
			Integer age_estimate;
			Integer mw_age_estimate;
			Integer mw_wealth_index;
			Integer pk_bk_level;
			Integer rc_valid_res_phone;
			Integer add1_mortgage_type_ord;
			Real prof_license_category_ord;
			Integer pk_attr_total_number_derogs;
			Integer attr_total_number_derogs_cp3;
			Integer add1_avm_automated_valuation_rcd;
			Integer mw_add1_avm_med;
			Integer attr_num_watercraft60_cap;
			Integer combo_addrcount_cap;
			Integer gong_did_phone_ct_cap;
			Integer attr_eviction_count_cap2;
			Integer pk_dist_a1toa2;
			Integer pk_dist_a2toa3;
			Real new_dist_mod;
			Integer mw_ams_income_level_code;
			Real mw_wealth_index_cm;
			Real mw_ams_income_level_code_cm;
			Real ams_college_code_cm;
			Real predicted_inc;
			Integer predicted_income;
			Models.Layout_ModelOut;
		end;
		layout_debug doModel( clam le ) := TRANSFORM
	#else
		Models.Layout_ModelOut doModel( clam le ) := TRANSFORM
	#end

		out_unit_desig                   := le.shell_input.unit_desig;
		out_sec_range                    := le.shell_input.sec_range;
		out_addr_type                    := le.shell_input.addr_type;
		in_dob                           := le.shell_input.dob;
		nas_summary                      := le.iid.nas_summary;
		nap_summary                      := le.iid.nap_summary;
		rc_phonevalflag                  := le.iid.phonevalflag;
		rc_dwelltype                     := le.iid.dwelltype;
		rc_bansflag                      := le.iid.bansflag;
		combo_addrcount                  := le.iid.combo_addrcount;
		ver_sources                      := le.header_summary.ver_sources;
		lname_eda_sourced                := le.name_verification.lname_eda_sourced;
		add1_avm_automated_valuation     := le.avm.input_address_information.avm_automated_valuation;
		add1_avm_med_fips                := le.avm.input_address_information.avm_median_fips_level;
		add1_avm_med_geo11               := le.avm.input_address_information.avm_median_geo11_level;
		add1_avm_med_geo12               := le.avm.input_address_information.avm_median_geo12_level;
		add1_naprop                      := le.address_verification.input_address_information.naprop;
		add1_mortgage_type               := le.address_verification.input_address_information.mortgage_type;
		property_sold_assessed_total     := le.address_verification.sold.property_owned_assessed_total;
		dist_a1toa2                      := le.address_verification.distance_in_2_h1;
		dist_a2toa3                      := le.address_verification.distance_h1_2_h2;
		gong_did_phone_ct                := le.phone_verification.gong_did.gong_did_phone_ct;
		addrs_per_adl                    := le.velocity_counters.addrs_per_adl;
		attr_num_watercraft60            := le.watercraft.watercraft_count60;
		attr_total_number_derogs         := le.total_number_derogs;
		attr_eviction_count              := le.bjl.eviction_count;
		bankrupt                         := le.bjl.bankrupt;
		filing_count                     := le.bjl.filing_count;
		bk_recent_count                  := le.bjl.bk_recent_count;
		ams_college_code                 := le.student.college_code;
		ams_income_level_code            := le.student.income_level_code;
		prof_license_category            := le.professional_license.plcategory;
		wealth_index                     := le.wealth_indicator;
		inferred_age                     := le.inferred_age;
		archive_date                     := le.historydate;


		NULL := -999999999;

		INTEGER year(integer sas_date) :=
			if(sas_date = NULL, NULL, (integer)((ut.DateFrom_DaysSince1900(sas_date + ut.DaysSince1900('1960', '1', '1')))[1..4]));

		sysdate := map(
				trim((string)archive_date, LEFT, RIGHT) = '999999'  => models.common.sas_date(if(le.historydate=999999, (STRING)Std.Date.Today(), (string6)le.historydate+'01')),
				length(trim((string)archive_date, LEFT, RIGHT)) = 6 => (ut.DaysSince1900((trim((string)archive_date, LEFT))[1..4], (trim((string)archive_date, LEFT))[5..6], (string)1) - ut.DaysSince1900('1960', '1', '1')),
																															 NULL);

		bk_flag := (rc_bansflag in ['1', '2']) or (integer)bankrupt = 1 or filing_count > 0 or bk_recent_count > 0;

		add1_avm_med := map(
				ADD1_AVM_MED_GEO12 > 0 => ADD1_AVM_MED_GEO12,
				ADD1_AVM_MED_GEO11 > 0 => ADD1_AVM_MED_GEO11,
																	ADD1_AVM_MED_FIPS);

		ver_src_p_pos := Models.common.findw_cpp(ver_sources, 'P' , ' ,', 'ie');
		ver_src_p := ver_src_p_pos > 0;
		ver_src_w_pos := Models.common.findw_cpp(ver_sources, 'W' , ' ,', 'ie');
		ver_src_w := ver_src_w_pos > 0;
		ver_src_am_pos := Models.common.findw_cpp(ver_sources, 'AM' , ' ,', 'ie');
		ver_src_am := ver_src_am_pos > 0;
		ver_src_da_pos := Models.common.findw_cpp(ver_sources, 'DA' , ' ,', 'ie');
		ver_src_da := ver_src_da_pos > 0;

		add_apt := StringLib.StringToUpperCase(trim(rc_dwelltype, LEFT, RIGHT)) = 'A' or StringLib.StringToUpperCase(trim(out_addr_type, LEFT, RIGHT)) = 'H' or out_unit_desig != ' ' or out_sec_range != ' ';

		_y_c3_b1 := (real)(trim(in_dob, LEFT))[1..4];

		_m_c3_b1 := min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6])));

		_daycap_c4 := map(
				(_m_c3_b1 in [1, 3, 5, 7, 8, 10, 12]) => 31,
				(_m_c3_b1 in [4, 6, 9, 11])           => 30,
																								 28 + (integer)((_y_c3_b1 % 4) = 0 and (_y_c3_b1 % 100) > 0 or (_y_c3_b1 % 400) = 0));

		_d_c3_b1 := if(max(_daycap_c4, max(1, (integer)(trim(in_dob, LEFT))[7..8])) = NULL, NULL, min(if(_daycap_c4 = NULL, -NULL, _daycap_c4), if(max(1, (integer)(trim(in_dob, LEFT))[7..8]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[7..8]))));

		in_dob2 := map(
				length(trim(in_dob, LEFT, RIGHT)) = 8 and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((string)_y_c3_b1, (string)_m_c3_b1, (string)_d_c3_b1) - ut.DaysSince1900('1960', '1', '1')),
				length(trim(in_dob, LEFT, RIGHT)) = 6 and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(in_dob, LEFT))[1..4], (string)min(12, if(max(1, (integer)(trim(in_dob, LEFT))[5..6]) = NULL, -NULL, max(1, (integer)(trim(in_dob, LEFT))[5..6]))), (string)1) - ut.DaysSince1900('1960', '1', '1')),
				length(trim(in_dob, LEFT, RIGHT)) = 4 and ((trim(in_dob, LEFT))[1..2] in ['19', '20']) => (ut.DaysSince1900((trim(in_dob, LEFT))[1..4], (string)1, (string)1) - ut.DaysSince1900('1960', '1', '1')),
																																																	NULL);

		yr_in_dob := if(sysdate != NULL and in_dob2 != NULL, if ((sysdate - in_dob2) / 365.25 >= 0, roundup((sysdate - in_dob2) / 365.25), truncate((sysdate - in_dob2) / 365.25)), NULL);

		yr_in_dob_int := truncate(yr_in_dob);

		age_estimate := if(yr_in_dob_int > 0, yr_in_dob_int, inferred_age);

		mw_age_estimate := map(
				age_estimate < 25 => 1,
				age_estimate < 30 => 2,
				age_estimate < 35 => 3,
				age_estimate < 40 => 4,
				age_estimate < 45 => 5,
				age_estimate < 50 => 5,
				age_estimate < 55 => 6,
				age_estimate < 60 => 5,
				age_estimate < 62 => 4,
														 3);

		mw_wealth_index := map(
				wealth_index <= (string)1 => 1,
				wealth_index <= (string)3 => 2,
				wealth_index <= (string)4 => 3,
				wealth_index <= (string)6 => 4,
																		 5);

		pk_bk_level := map(
				bankrupt             => 2,
				(integer)bk_flag = 1 => 1,
																0);

		rc_valid_res_phone := if(rc_phonevalflag = (string)2, 1, 0);

		add1_mortgage_type_ord := map(
				(add1_mortgage_type in ['CNS', 'G', 'H', 'R', 'Z']) => 1,
				(add1_mortgage_type in ['1', 'U'])                  => 2,
				(add1_mortgage_type in ['FHA', '2', 'E'])           => 4,
				(add1_mortgage_type in ['N', 'VA'])                 => 5,
																															 3);

		prof_license_category_ord := map(
				prof_license_category = '0'          => 2,
				(prof_license_category in ['', ' ']) => 1.5,
																								(real)prof_license_category);

		pk_attr_total_number_derogs := attr_total_number_derogs;

		attr_total_number_derogs_cp3 := min(if(pk_attr_total_number_derogs = NULL, -NULL, pk_attr_total_number_derogs), 3);

		add1_avm_automated_valuation_rcd := map(
				add1_avm_automated_valuation = 0      => 100000,
				add1_avm_automated_valuation > 300000 => 300000,
																								 add1_avm_automated_valuation);

		mw_add1_avm_med := map(
				add1_avm_med = 0      => 300000,
				add1_avm_med > 250000 => 250000,
																 add1_avm_med);

		attr_num_watercraft60_cap := if(attr_num_watercraft60 > 2, 2, attr_num_watercraft60);

		combo_addrcount_cap := if(combo_addrcount > 6, 6, combo_addrcount);

		gong_did_phone_ct_cap := if(gong_did_phone_ct > 3, 3, gong_did_phone_ct);

		attr_eviction_count_cap2 := min(if(attr_eviction_count = NULL, -NULL, attr_eviction_count), 2);

		pk_dist_a1toa2 := map(
				dist_a1toa2 = 9999 => -1,
				dist_a1toa2 <= 0   => 0,
				dist_a1toa2 <= 9   => 1,
															2);

		pk_dist_a2toa3 := map(
				dist_a2toa3 = 9999 => -1,
				dist_a2toa3 <= 0   => 0,
				dist_a2toa3 <= 9   => 1,
				dist_a2toa3 <= 35  => 2,
															3);

		new_dist_mod := 38983 +
				pk_dist_a1toa2 * 370.07774 +
				pk_dist_a2toa3 * 2380.36039;

		mw_ams_income_level_code := map(
				ams_income_level_code = 'A' => 1,
				ams_income_level_code = 'B' => 1,
				ams_income_level_code = 'C' => 2,
				ams_income_level_code = 'D' => 4,
				ams_income_level_code = 'E' => 5,
				ams_income_level_code = 'F' => 5,
				ams_income_level_code = 'G' => 5,
				ams_income_level_code = 'H' => 6,
				ams_income_level_code = 'I' => 7,
				ams_income_level_code = 'J' => 7,
				ams_income_level_code = 'K' => 8,
																			 3);

		mw_wealth_index_cm := map(
				mw_wealth_index = 1 => 37865.27818,
				mw_wealth_index = 2 => 40156.628461,
				mw_wealth_index = 3 => 43792.772909,
				mw_wealth_index = 4 => 70012.368169,
															 42361.487536);

		mw_ams_income_level_code_cm := map(
				mw_ams_income_level_code = 1 => 37874.025421,
				mw_ams_income_level_code = 2 => 39385.34208,
				mw_ams_income_level_code = 3 => 41483.314742,
				mw_ams_income_level_code = 4 => 43464.198814,
				mw_ams_income_level_code = 5 => 45230.305328,
				mw_ams_income_level_code = 6 => 47700.365867,
				mw_ams_income_level_code = 7 => 52239.885063,
				mw_ams_income_level_code = 8 => 59307.812887,
																				42361.487536);

		ams_college_code_cm := map(
				trim(ams_college_code) = ''     => 41618.415972,
				ams_college_code = (string)1    => 47995.98,
				ams_college_code = (string)2    => 46589.108462,
				ams_college_code = (string)4    => 51684.027605,
																					 41618.415972);

		predicted_inc := -74026 +
				7864.03189 * (integer)ver_src_p +
				0.49578 * mw_wealth_index_cm +
				0.03687 * mw_add1_avm_med +
				1983.86885 * combo_addrcount_cap +
				411.35397 * addrs_per_adl +
				8447.97506 * (integer)ver_src_w +
				5312.00454 * prof_license_category_ord +
				-5466.82988 * (integer)add_apt +
				0.61898 * mw_ams_income_level_code_cm +
				1971.76762 * mw_age_estimate +
				-1104.43862 * attr_total_number_derogs_cp3 +
				1743.2266 * add1_mortgage_type_ord +
				0.52077 * ams_college_code_cm +
				15880 * (integer)ver_src_am +
				0.02137 * add1_avm_automated_valuation_rcd +
				1091.26463 * gong_did_phone_ct_cap +
				35298 * (integer)ver_src_da +
				-4110.69423 * attr_eviction_count_cap2 +
				-1840.16007 * pk_bk_level +
				0.01224 * property_sold_assessed_total +
				-3283.20204 * rc_valid_res_phone +
				3353.06802 * (integer)lname_eda_sourced +
				3252.13961 * attr_num_watercraft60_cap +
				0.18697 * new_dist_mod;

		predicted_income_1 := map(
				predicted_inc < 15000  => 14,
				predicted_inc > 100000 => 101,
																	round(predicted_inc/1000));

		predicted_income := if( riskview.constants.noscore(nas_summary,nap_summary, add1_naprop, le.truedid), 0, predicted_income_1);


		#if(IED_DEBUG)
			self.clam := le;
			self.out_unit_desig                    := out_unit_desig;
			self.out_sec_range                     := out_sec_range;
			self.out_addr_type                     := out_addr_type;
			self.in_dob                            := in_dob;
			self.nas_summary                       := nas_summary;
			self.nap_summary                       := nap_summary;
			self.rc_phonevalflag                   := rc_phonevalflag;
			self.rc_dwelltype                      := rc_dwelltype;
			self.rc_bansflag                       := rc_bansflag;
			self.combo_addrcount                   := combo_addrcount;
			self.ver_sources                       := ver_sources;
			self.lname_eda_sourced                 := lname_eda_sourced;
			self.add1_avm_automated_valuation      := add1_avm_automated_valuation;
			self.add1_avm_med_fips                 := add1_avm_med_fips;
			self.add1_avm_med_geo11                := add1_avm_med_geo11;
			self.add1_avm_med_geo12                := add1_avm_med_geo12;
			self.add1_naprop                       := add1_naprop;
			self.add1_mortgage_type                := add1_mortgage_type;
			self.property_sold_assessed_total      := property_sold_assessed_total;
			self.dist_a1toa2                       := dist_a1toa2;
			self.dist_a2toa3                       := dist_a2toa3;
			self.gong_did_phone_ct                 := gong_did_phone_ct;
			self.addrs_per_adl                     := addrs_per_adl;
			self.attr_num_watercraft60             := attr_num_watercraft60;
			self.attr_total_number_derogs          := attr_total_number_derogs;
			self.attr_eviction_count               := attr_eviction_count;
			self.bankrupt                          := bankrupt;
			self.filing_count                      := filing_count;
			self.bk_recent_count                   := bk_recent_count;
			self.ams_college_code                  := ams_college_code;
			self.ams_income_level_code             := ams_income_level_code;
			self.prof_license_category             := prof_license_category;
			self.wealth_index                      := wealth_index;
			self.inferred_age                      := inferred_age;
			self.archive_date                      := archive_date;


			self.sysdate                          := sysdate;
			self.bk_flag                          := bk_flag;
			self.add1_avm_med                     := add1_avm_med;
			self.ver_src_p_pos                    := ver_src_p_pos;
			self.ver_src_p                        := ver_src_p;
			self.ver_src_w_pos                    := ver_src_w_pos;
			self.ver_src_w                        := ver_src_w;
			self.ver_src_am_pos                   := ver_src_am_pos;
			self.ver_src_am                       := ver_src_am;
			self.ver_src_da_pos                   := ver_src_da_pos;
			self.ver_src_da                       := ver_src_da;
			self.add_apt                          := add_apt;
			self.in_dob2                          := in_dob2;
			self.yr_in_dob                        := yr_in_dob;
			self.yr_in_dob_int                    := yr_in_dob_int;
			self.age_estimate                     := age_estimate;
			self.mw_age_estimate                  := mw_age_estimate;
			self.mw_wealth_index                  := mw_wealth_index;
			self.pk_bk_level                      := pk_bk_level;
			self.rc_valid_res_phone               := rc_valid_res_phone;
			self.add1_mortgage_type_ord           := add1_mortgage_type_ord;
			self.prof_license_category_ord        := prof_license_category_ord;
			self.pk_attr_total_number_derogs      := pk_attr_total_number_derogs;
			self.attr_total_number_derogs_cp3     := attr_total_number_derogs_cp3;
			self.add1_avm_automated_valuation_rcd := add1_avm_automated_valuation_rcd;
			self.mw_add1_avm_med                  := mw_add1_avm_med;
			self.attr_num_watercraft60_cap        := attr_num_watercraft60_cap;
			self.combo_addrcount_cap              := combo_addrcount_cap;
			self.gong_did_phone_ct_cap            := gong_did_phone_ct_cap;
			self.attr_eviction_count_cap2         := attr_eviction_count_cap2;
			self.pk_dist_a1toa2                   := pk_dist_a1toa2;
			self.pk_dist_a2toa3                   := pk_dist_a2toa3;
			self.new_dist_mod                     := new_dist_mod;
			self.mw_ams_income_level_code         := mw_ams_income_level_code;
			self.mw_wealth_index_cm               := mw_wealth_index_cm;
			self.mw_ams_income_level_code_cm      := mw_ams_income_level_code_cm;
			self.ams_college_code_cm              := ams_college_code_cm;
			self.predicted_inc                    := predicted_inc;
			self.predicted_income                 := predicted_income;
		#end
		

		self.seq := le.seq;
		// self.score := (string)predicted_income;


		rcs := riskwise.Reasons(le, isCalifornia:=isCalifornia);
		corr := riskwisefcra.corrReasonCodes( le.consumerflags, 4 );

		// ie912_1 doesn't return 36. this model should do the same, so strip out 00 from corr and don't zero-pad other reasons
		ri := map(
			corr[1].hri != '00' => corr( hri != '00' ),
			rcs.rc35 => rcs.makeRC('35'), // CA in-person
			models.common.isRV3Unscorable(le) => rcs.makeRC('19'), // unscorable
			dataset( [], risk_indicators.Layout_Desc )
		);
		
		self.ri := ri;
		self.score := map(
			ri[1].hri in ['91','92','93','94','35','19'] => '0', // any exceptional cases get a score of 0
			predicted_income = 0 => '0',
			(string)predicted_income
		);
	end;
	
	model := project( clam, doModel(left) );
	
	return model;
end;