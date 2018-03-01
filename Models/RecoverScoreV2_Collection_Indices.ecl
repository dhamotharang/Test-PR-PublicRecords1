import ut, risk_indicators, std;

export RecoverScoreV2_Collection_Indices(
	grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam) := FUNCTION

	sysyear := (integer)(((STRING)Std.Date.Today())[1..4]);


	Layout_RecoverScore doIndices( clam le ) := TRANSFORM
 /************************************************************************************/
 /* Fields from Modeling Shell                                                       */
 /************************************************************************************/
		out_unit_desig									:=  le.Shell_Input.unit_desig;
		out_addr_type										:=  le.Shell_Input.addr_type;
		out_addr_status									:=  le.Shell_Input.addr_status;
		nap_summary                     :=  le.iid.nap_summary;
		nap_status                      :=  le.iid.nap_status;
		rc_hriskphoneflag               :=  le.iid.hriskphoneflag;
		rc_hphonetypeflag               :=  le.iid.hphonetypeflag;
		rc_phonevalflag                 :=  le.iid.phonevalflag;
		rc_hphonevalflag                :=  le.iid.hphonevalflag;
		rc_phonezipflag                 :=  le.iid.phonezipflag;
		rc_pwphonezipflag               :=  le.iid.PWphonezipflag;
		rc_hriskaddrflag                :=  (INTEGER)le.iid.hriskaddrflag;
		rc_decsflag                     :=  le.ssn_verification.validation.deceased;
		rc_dwelltype                    :=  trim(le.address_validation.dwelling_type);
		rc_sources_tmp                  :=  le.iid.sources;
		rc_sources 											:=  rc_sources_tmp + ',';  // add a comma		
		rc_addrcount                    :=  le.iid.addrcount;
		rc_utiliaddr_lnamecount					:=  le.iid.utiliaddr_lastcount;
		rc_utiliaddr_addrcount          :=  le.iid.utiliaddr_addrcount;
		rc_utiliaddr_phonecount         :=  le.iid.utiliaddr_phonecount;
		rc_addrcommflag                 :=  le.iid.addrcommflag;
		rc_hrisksic                     :=  (INTEGER)le.iid.hrisksic;
		rc_hrisksicphone                :=  le.iid.hrisksicphone;
		rc_disthphoneaddr               :=  le.iid.disthphoneaddr;
		rc_phonetype                    :=  le.iid.phonetype;
		combo_hphonescore               :=  le.iid.combo_hphonescore;
		combo_hphonecount               :=  le.iid.combo_hphonecount;
		rc_watchlist_flag               :=  le.iid.watchlistHit;
		EQ_count												:=  le.Source_Verification.eq_count;
		TU_count												:=  le.Source_Verification.tu_count;
		DL_count												:=  le.Source_Verification.dl_count;
		PR_count                        :=  le.source_verification.pr_count;
		V_count													:=  le.source_verification.v_count;
		EM_count												:=  le.source_verification.em_count;
		W_count													:=  le.source_verification.w_count;
		adl_EQ_first_seen								:=  le.source_verification.adl_EQfs_first_seen;	
		adl_TU_first_seen								:=  le.source_verification.adl_TU_first_seen;	
		adl_DL_first_seen								:=  le.source_verification.adl_DL_first_seen;	
		adl_PR_first_seen								:=  le.source_verification.adl_PR_first_seen;	
		adl_V_first_seen								:=  le.source_verification.adl_V_first_seen;	
		adl_EM_first_seen								:=  le.source_verification.adl_EM_first_seen;	
		adl_W_first_seen								:=  le.source_verification.adl_W_first_seen;	
		dl_avail                        :=  (integer)le.Available_Sources.dl;
		ssnlength                       :=  le.input_validation.ssn_length;
		dobpop                          :=  (INTEGER)le.input_validation.dateofbirth;
		hphnpop                         :=  (INTEGER)le.input_validation.homephone;
		lname_change_date               :=  le.name_verification.lname_change_date;
		source_count										:=  le.Name_Verification.source_count;
		add1_avm_land_use               :=  le.AVM.Input_Address_Information.avm_land_use_code;
		add1_avm_automated_valuation		:=  le.AVM.Input_Address_Information.avm_automated_valuation;
		add1_avm_med_fips								:=  le.AVM.Input_Address_Information.avm_median_fips_level;
		add1_avm_med_geo11							:=  le.AVM.Input_Address_Information.avm_median_geo11_level;
		add1_avm_med_geo12							:=  le.AVM.Input_Address_Information.avm_median_geo12_level;
		add1_source_count               :=  le.address_verification.input_address_information.source_count;
		add1_naprop                     :=  le.address_verification.input_address_information.naprop;
		add1_date_first_seen            :=  le.address_verification.input_address_information.date_first_seen;
		add1_pop												:=  (integer)le.address_verification.input_address_information.HR_Address;
		add1_census_home_value          :=  (integer)le.address_verification.input_address_information.census_home_value;
		property_owned_total            :=  le.address_verification.owned.property_total;
		property_owned_purchase_total		:=  le.address_verification.owned.property_owned_purchase_total; 
		property_owned_purchase_count		:=  le.address_verification.owned.property_owned_purchase_count;
		property_sold_total             :=  le.address_verification.sold.property_total;
		add2_naprop                     :=  le.address_verification.address_history_1.naprop;
		add2_date_first_seen						:=  le.address_verification.address_history_1.date_first_seen;
		add2_pop												:=  (integer)le.address_verification.address_history_1.HR_Address;
		add2_census_home_value					:=  (integer)le.address_verification.address_history_1.census_home_value;
		add3_naprop                     :=  le.address_verification.address_history_2.naprop;
		add3_date_first_seen						:=  le.address_verification.address_history_2.date_first_seen;
		add3_pop												:=  (integer)le.address_verification.address_history_2.HR_Address;
		add3_census_home_value					:=  (integer)le.address_verification.address_history_2.census_home_value;
		addrs_15yr                      :=  le.other_address_info.addrs_last_15years;
		telcordia_type                  :=  le.phone_verification.telcordia_type;
		recent_disconnects              :=  le.phone_verification.recent_disconnects;
		bk_sourced											:=  (integer)le.SSN_Verification.bk_sourced;
		addrs_per_adl                   :=  le.velocity_counters.addrs_per_adl;
		addrs_per_adl_c6                :=  le.velocity_counters.addrs_per_adl_created_6months;
		bankrupt                        :=  (integer)le.bjl.bankrupt;
		disposition                     :=  le.bjl.disposition;
		bk_recent_count                 :=  le.bjl.bk_recent_count;
		liens_recent_unreleased_count   :=  le.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bjl.criminal_count;
		rel_count                       :=  le.relatives.relative_count;
		rel_bankrupt_count              :=  le.relatives.relative_bankrupt_count;
		rel_criminal_count              :=  le.relatives.relative_criminal_count;
		rel_prop_owned_count            :=  le.relatives.owned.relatives_property_count;
		rel_prop_owned_total						:=  le.relatives.owned.relatives_property_total;
		rel_within25miles_count         :=  le.relatives.relative_within25miles_count;
		rel_incomeunder25_count         :=  le.relatives.relative_incomeUnder25_count;
		rel_incomeunder50_count         :=  le.relatives.relative_incomeUnder50_count;
		rel_incomeunder75_count         :=  le.relatives.relative_incomeUnder75_count;
		rel_incomeunder100_count        :=  le.relatives.relative_incomeUnder100_count;
		rel_incomeover100_count         :=  le.relatives.relative_incomeOver100_count;
		rel_homeunder50_count           :=  le.relatives.relative_homeUnder50_count;
		rel_homeunder100_count          :=  le.relatives.relative_homeUnder100_count;
		rel_homeunder150_count          :=  le.relatives.relative_homeUnder150_count;
		rel_homeunder200_count          :=  le.relatives.relative_homeUnder200_count;
		rel_homeunder300_count          :=  le.relatives.relative_homeUnder300_count;
		rel_homeunder500_count          :=  le.relatives.relative_homeUnder500_count;
		rel_homeover500_count           :=  le.relatives.relative_homeOver500_count;
		rel_vehicle_owned_count         :=  le.relatives.relative_vehicle_owned_count;
		rel_count_addr									:=  le.relatives.relatives_at_input_address;
		current_count                   :=  le.vehicles.current_count;
		watercraft_count								:=  le.watercraft.watercraft_count;
		ams_file_type										:=  le.student.file_type;
		prof_license_flag               :=  (INTEGER)le.professional_license.professional_license_flag;
		archive_date										:=  if(le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate);			

 /************************************************************************************/
 /* Fields from ADL Append Process                                                   */
 /************************************************************************************/

		in_addrpop 				:= le.ADL_Shell_Flags.in_addrpop;				//  was address populated on input from consumer
		adl_addr 					:= le.ADL_Shell_Flags.adl_addr;      		//  results of ADL search on address
		in_addrpop_found 	:= le.ADL_Shell_Flags.in_addrpop_found; //  did input address match database address
		in_hphnpop 				:= le.ADL_Shell_Flags.in_hphnpop;				//  was hphone populated on input from consumer
		adl_hphn 					:= le.ADL_Shell_Flags.adl_hphn;      		//  results of ADL search on hphone
		in_hphnpop_found 	:= le.ADL_Shell_Flags.in_hphnpop_found; //  did input hphone match database hphone
		in_ssnpop 				:= le.ADL_Shell_Flags.in_ssnpop;				//  was ssn populated on input from consumer
		adl_ssn 					:= le.ADL_Shell_Flags.adl_ssn;				  //  results of ADL search on ssn 
		
		
		
		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);
		
		/***************************************************
		 * BEGIN CALCULATION OF ITEMS NEEDED TO GET INDICES*
		 ***************************************************/
		 
		//****calculate time since address first seen *****;
		arch_date_age := ut.DaysSince1900( ((string)archive_date)[1..4], ((string)archive_date)[5..6], '01' ); 

		add1_dt_first_seen_age := if((integer)add1_date_first_seen > 0, ut.DaysSince1900( ((string)add1_date_first_seen)[1..4], 
																if(((string)add1_date_first_seen)[5..6] = '00','01', 
																	 ((string)add1_date_first_seen)[5..6]), '01' ), -9999);
																	 
		add1_months_residence := if(add1_dt_first_seen_age >= 0, (integer)((arch_date_age - add1_dt_first_seen_age) / 30.5), -9999);


		add2_dt_first_seen_age := if((integer)add2_date_first_seen > 0, ut.DaysSince1900( ((string)add2_date_first_seen)[1..4], 
																if(((string)add2_date_first_seen)[5..6] = '00','01', 
																	 ((string)add2_date_first_seen)[5..6]), '01' ), -9999);
																	 
		add2_months_residence := if(add2_dt_first_seen_age >= 0, (integer)((arch_date_age - add2_dt_first_seen_age) / 30.5), -9999);
		
		
		add3_dt_first_seen_age := if((integer)add3_date_first_seen > 0, ut.DaysSince1900( ((string)add3_date_first_seen)[1..4], 
																if(((string)add3_date_first_seen)[5..6] = '00','01', 
																	 ((string)add3_date_first_seen)[5..6]), '01' ), -9999);			
																	 
		add3_months_residence := if(add3_dt_first_seen_age >= 0, (integer)((arch_date_age - add3_dt_first_seen_age) / 30.5), -9999);	
	
		
		min_residence := min( if(add1_months_residence = -9999, 9999, add1_months_residence), 
													if(add2_months_residence = -9999, 9999, add2_months_residence),
													if(add3_months_residence = -9999, 9999, add3_months_residence));	
		
			
    is_apartment := Map(rc_dwelltype='H' or out_addr_type='H' => 1,
											 trim(out_unit_desig) in ['#','APT','APTS','UNIT','STE','FL'] => 1,
											 0);

		adl_addr_c :=  map(((integer)in_addrpop = 0) and ((adl_addr = 0) and (in_addrpop_found = 0)) => 1,
											 ((integer)in_addrpop = 0) and ((adl_addr = 1) and (in_addrpop_found = 0)) => 2,
											 ((integer)in_addrpop = 1) and (adl_addr = 0)                            => 3,
											 ((integer)in_addrpop = 1) and ((adl_addr = 2) and (in_addrpop_found = 1)) => 4,
											 ((integer)in_addrpop = 1) and ((adl_addr = 3) and (in_addrpop_found = 0)) => 5,
																																											 6);

		adl_addr_c_m := Map(adl_addr_c =1 => 0.0420560748 ,
												 adl_addr_c =2 => 0.0780195049,
												 adl_addr_c =3 => 0.1052025341 ,
												 adl_addr_c =4 => 0.1836859289 ,
												 adl_addr_c =5 => 0.1165875454 ,
												 adl_addr_c =6 => 0.1295172778 ,
												 -9999);

			
												 
   //***PHONE ISSUES ***;
     //****Nap Summary  ****;
		verfst_p := 0;
		verlst_p := 0;
		veradd_p := 0;
		verphn_p := 0;
		contrary_phone := 0;
		contrary_phone_b2 := 1;
		verfst_p_b3 := 1;
		verlst_p_b3 := 1;
		verfst_p_b4 := 1;
		veradd_p_b4 := 1;
		verfst_p_b5 := 1;
		verphn_p_b5 := 1;
		verlst_p_b6 := 1;
		veradd_p_b6 := 1;
		veradd_p_b7 := 1;
		verphn_p_b7 := 1;
		verlst_p_b8 := 1;
		verphn_p_b8 := 1;
		verfst_p_b9 := 1;
		verlst_p_b9 := 1;
		veradd_p_b9 := 1;
		verfst_p_b10 := 1;
		verlst_p_b10 := 1;
		verphn_p_b10 := 1;
		verfst_p_b11 := 1;
		veradd_p_b11 := 1;
		verphn_p_b11 := 1;
		verlst_p_b12 := 1;
		veradd_p_b12 := 1;
		verphn_p_b12 := 1;
		verfst_p_b13 := 1;
		verlst_p_b13 := 1;
		veradd_p_b13 := 1;
		verphn_p_b13 := 1;

		verphn_p_2 := map(nap_summary = 0  => verphn_p,
 		  								nap_summary = 1  => verphn_p,
			  							nap_summary = 2  => verphn_p,
	 										nap_summary = 3  => verphn_p,
											nap_summary = 4  => verphn_p_b5,
											nap_summary = 5  => verphn_p,
											nap_summary = 6  => verphn_p_b7,
											nap_summary = 7  => verphn_p_b8,
											nap_summary = 8  => verphn_p,
											nap_summary = 9  => verphn_p_b10,
											nap_summary = 10 => verphn_p_b11,
											nap_summary = 11 => verphn_p_b12,
											nap_summary = 12 => verphn_p_b13,
																					-9999);

		verlst_p_2 := map(nap_summary = 0  => verlst_p,
											nap_summary = 1  => verlst_p,
											nap_summary = 2  => verlst_p_b3,
											nap_summary = 3  => verlst_p,
											nap_summary = 4  => verlst_p,
											nap_summary = 5  => verlst_p_b6,
											nap_summary = 6  => verlst_p,
											nap_summary = 7  => verlst_p_b8,
											nap_summary = 8  => verlst_p_b9,
											nap_summary = 9  => verlst_p_b10,
											nap_summary = 10 => verlst_p,
											nap_summary = 11 => verlst_p_b12,
											nap_summary = 12 => verlst_p_b13,
																					-9999);

		veradd_p_2 := map(nap_summary = 0  => veradd_p,
											nap_summary = 1  => veradd_p,
											nap_summary = 2  => veradd_p,
											nap_summary = 3  => veradd_p_b4,
											nap_summary = 4  => veradd_p,
											nap_summary = 5  => veradd_p_b6,
											nap_summary = 6  => veradd_p_b7,
											nap_summary = 7  => veradd_p,
											nap_summary = 8  => veradd_p_b9,
											nap_summary = 9  => veradd_p,
											nap_summary = 10 => veradd_p_b11,
											nap_summary = 11 => veradd_p_b12,
											nap_summary = 12 => veradd_p_b13,
																					-9999);

		verfst_p_2 := map(nap_summary = 0  => verfst_p,
											nap_summary = 1  => verfst_p,
											nap_summary = 2  => verfst_p_b3,
											nap_summary = 3  => verfst_p_b4,
											nap_summary = 4  => verfst_p_b5,
											nap_summary = 5  => verfst_p,
											nap_summary = 6  => verfst_p,
											nap_summary = 7  => verfst_p,
											nap_summary = 8  => verfst_p_b9,
											nap_summary = 9  => verfst_p_b10,
											nap_summary = 10 => verfst_p_b11,
											nap_summary = 11 => verfst_p,
											nap_summary = 12 => verfst_p_b13,
																					-9999);

		contrary_phone_2 := map(nap_summary = 0  => contrary_phone,
														nap_summary = 1  => contrary_phone_b2,
														nap_summary = 2  => contrary_phone,
														nap_summary = 3  => contrary_phone,
														nap_summary = 4  => contrary_phone,
														nap_summary = 5  => contrary_phone,
														nap_summary = 6  => contrary_phone,
														nap_summary = 7  => contrary_phone,
														nap_summary = 8  => contrary_phone,
														nap_summary = 9  => contrary_phone,
														nap_summary = 10 => contrary_phone,
														nap_summary = 11 => contrary_phone,
														nap_summary = 12 => contrary_phone,
																								-9999);
																								

		phone_highrisk :=  map(hphnpop = 0  => -1,
													 ((integer)rc_hriskphoneflag = 6) OR ((rc_hphonetypeflag = '5') OR 
													 (((integer)rc_hphonevalflag = 3) OR (rc_hrisksicphone = '2225'))) => 1,
													 0);
								
		phone_mismatch :=  map(hphnpop = 0  => -1,
													 ((integer)rc_phonezipflag in [1]) OR (((integer)rc_pwphonezipflag in [1, 2, 3, 4]) OR 
													 (rc_disthphoneaddr > 500 and rc_disthphoneaddr < 9999)) => 1,
														0);
														
		phone_invalid1 :=  map(hphnpop = 0        => -1,
													 (integer)rc_phonevalflag = 0 => 2,
													 (integer)rc_phonevalflag = 1 => 1,
																									0);

		phone_invalid2 :=  map(hphnpop = 0         => -1,
													 (integer)rc_hphonevalflag = 0 => 2,
													 (integer)rc_hphonevalflag = 1 => 1,
																									 0);														
														
		phone_invalid :=  map(hphnpop = 0                                                       => -1,
													(phone_invalid1 = 2) OR ((phone_invalid2 = 2) OR ((integer)rc_phonetype = 5)) => 2,
													(phone_invalid1 = 1) OR (phone_invalid2 = 1)                        => 1,
																																																0);		
																																																
		phone_disconnect :=  map(hphnpop = 0                                 => -1,
														 (nap_status = 'D') OR ((integer)rc_hriskphoneflag = 5) => 1,
																																						 0);	
																																						 
		adl_hphn_c :=  map((in_hphnpop = 0) and ((adl_hphn = 0) and (in_hphnpop_found = 0)) => 1,
											 (in_hphnpop = 0) and ((adl_hphn = 1) and (in_hphnpop_found = 0)) => 2,
											 (in_hphnpop = 1) and (adl_hphn = 0)                            => 3,
											 (in_hphnpop = 1) and ((adl_hphn = 2) and (in_hphnpop_found = 1)) => 4,
											 (in_hphnpop = 1) and ((adl_hphn = 3) and (in_hphnpop_found = 0)) => 5,
																																											 6);																																						 
																																						 
    adl_hphn_c_m := Map(adl_hphn_c =1 => 0.077951703 ,
												adl_hphn_c =2 => 0.155479382 ,
												adl_hphn_c =3 => 0.1739501375 ,
												adl_hphn_c =4 => 0.1904910366 ,
												adl_hphn_c =5 => 0.1543282656 ,
												adl_hphn_c =6 => 0.1942281264 ,
												-9999);																																						 
																																						 
																																						 
		source_PL_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'PL,') > 0);	
		source_DS_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'DS,') > 0);
		prof_license_flag2 :=  if((prof_license_flag > 0) or (source_pl_tot > 0), 1, 0);				

		source_ba_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'BA,') > 0);
		bankrupt2 :=  if((source_ba_tot > 0) or ((bankrupt > 0) or ((bk_sourced > 0) or (bk_recent_count > 0))), 1, 0);		

		watercraft_flag := (watercraft_count > 0);	
		recent_mover := (0 <= min_residence AND min_residence <= 12);
		
    property_owned_total_b := min(property_owned_total,2);

		
		/*************************************************
		 * END CALCULATION OF ITEMS NEEDED TO GET INDICES*
		 *************************************************/
																					
		/*******************************
		* Collections Indices          *
		********************************/
				
		lres_years := (integer)(min_residence / 12);

		lres_years_2 :=  if(min_residence = 9999, -1, lres_years);

		lres_years_c :=  map(lres_years_2 = -1              => 1,
												 lres_years_2 = 0               => 2,
												 lres_years_2 = 1               => 3,
												 lres_years_2 in [2, 3, 4]      => 4,
												 lres_years_2 in [5, 6, 7]      => 5,
												 lres_years_2 in [8, 9, 10, 11] => 6,
																													 7);

		lres_years_c_m := Map(lres_years_c =1 => 0.1027674129 ,
													 lres_years_c =2 => 0.1320060867 ,
													 lres_years_c =3 => 0.1373396177 ,
													 lres_years_c =4 => 0.1445633699 ,
													 lres_years_c =5 => 0.164767506 ,
													 lres_years_c =6 => 0.1919276503 ,
													 lres_years_c =7 => 0.2537906137 ,
													 -9999);

		add1_source_count_c := min(add1_source_count, 4);

    add1_source_count_c_m := Map(add1_source_count_c =0 => 0.1148521082 ,
																 add1_source_count_c =1 => 0.0545702592 ,
																 add1_source_count_c =2 => 0.119803814 ,
																 add1_source_count_c =3 => 0.1479943983 ,
																 add1_source_count_c =4 => 0.1848057917 ,
																 -9999);

		address_commercial := 0;

		address_commercial_2 :=  if(((integer)rc_addrcommflag in [1, 2]) OR (((integer)rc_hriskaddrflag = 4) OR ((string)rc_hrisksic = '2225')), 1, address_commercial);

		address_type_c :=  map((address_commercial_2 = 1) and (is_apartment = 1) => 1,
													 (address_commercial_2 = 1) and (is_apartment = 0) => 2,
													 (address_commercial_2 = 0) and (is_apartment = 1) => 3,
																																								4);

    address_type_c_m := Map(address_type_c =1 => 0.1652065081 ,
														address_type_c =2 => 0.1311953353 ,
														address_type_c =3 => 0.1189731108 ,
														address_type_c =4 => 0.1569189711 ,
														-9999);

		logit_38 := -4.598273313 +
				(adl_addr_c_m * 6.1043184449) +
				(add1_source_count_c_m * 3.4432367983) +
				(lres_years_c_m * 4.2609826215) +
				(address_type_c_m * 5.0356026453);

		phat_38 := (exp(logit_38) / (1 + exp(logit_38)));

		address_index_tmp := round(((30 * ((ln((phat_38 / (1 - phat_38))) - ln((.12 / .88))) / ln(2))) + 55));

		address_index := Map(address_index_tmp > 100 => 100,
												 address_index_tmp < 0 => 0,
												 address_index_tmp);
												 

		eda_ver_level :=  map(verfst_p_2=1 and (verlst_p_2=1 and (veradd_p_2=1 and verphn_p_2=1))  => 3,
													verlst_p_2=1 and (veradd_p_2=1 and verphn_p_2=1)                     => 2,
													verfst_p_2=0 and verlst_p_2=0 and veradd_p_2=0 and verphn_p_2=0      => 0,
													verfst_p_2=0 and verlst_p_2=0 and (veradd_p_2=1 and verphn_p_2=1)    => -1,
																																																  1);

		eda_ver_level_m := Map(eda_ver_level =-1 => 0.1678895123 ,
													 eda_ver_level =0 => 0.1092038835 ,
													 eda_ver_level =1 => 0.1435250464 ,
													 eda_ver_level =2 => 0.2347905282 ,
													 eda_ver_level =3 => 0.1982503538 ,
													 -9999);

		phone_bads := ((phone_highrisk = 1) OR (phone_mismatch = 1));

		phone_quality :=  map((phone_invalid = 0) and (phone_disconnect = 0) => 1,
													(phone_invalid = 0) and (phone_disconnect = 1) => 2,
													(phone_invalid = 1) and (phone_disconnect = 0) => 3,
													(phone_invalid = 1) and (phone_disconnect = 1) => 4,
																																					5);

		phone_quality_c :=  map(((integer)phone_quality = 1) and ((integer)phone_bads = 0) => 1,
														((integer)phone_quality = 1) and ((integer)phone_bads = 1) => 2,
														((integer)phone_quality = 2) and ((integer)phone_bads = 0) => 3,
														((integer)phone_quality = 2) and ((integer)phone_bads = 1) => 4,
														((integer)phone_quality = 3) and ((integer)phone_bads = 0) => 5,
														((integer)phone_quality = 3) and ((integer)phone_bads = 1) => 6,
														((integer)phone_quality = 4) and ((integer)phone_bads = 0) => 7,
														((integer)phone_quality = 4) and ((integer)phone_bads = 1) => 8,
																																													9);

		phone_quality_c_m := Map(phone_quality_c =1 => 0.1985377979 ,
														 phone_quality_c =2 => 0.1461285425 ,
														 phone_quality_c =3 => 0.1196954494 ,
														 phone_quality_c =4 => 0.1303401361 ,
														 phone_quality_c =5 => 0.1842475387 ,
														 phone_quality_c =6 => 0.1376146789 ,
														 phone_quality_c =7 => 0.1289978678 ,
														 phone_quality_c =8 => 0.0978172999 ,
														 phone_quality_c =9 => 0.108348135 ,
														 -9999);

																																 

    logit_39 := -3.872944772
                  + adl_hphn_c_m  * 3.3568584237
                  + eda_ver_level_m  * 4.2219527541
                  + phone_quality_c_m  * 6.1832327058;
									
    phat_39 := (exp(logit_39 )) / (1+exp(logit_39 ));
		 
    Phone_Index_tmp := if(hphnpop=1, round(55*(log(phat_39/(1-phat_39)) - log(.12/.88))/log(2) + 60), -9999);

    Phone_Index := Map(hphnpop=0 and eda_ver_level=1 => 41,
											 hphnpop=0 and eda_ver_level=0 => 29,
											 Phone_Index_tmp < 0           => 0,
											 Phone_Index_tmp > 100         => 100,
											 Phone_Index_tmp);
											 
																 

		logit_40 := -3.788496022 +
				(address_index * 0.0164816516) +
				(Phone_Index * 0.0126446204);

		phat_40 := (exp(logit_40) / (1 + exp(logit_40)));

		Contactibility_Index := round(((28 * ((ln((phat_40 / (1 - phat_40))) - ln((.12 / .88))) / ln(2))) + 58));
		contactibility_index_2 :=  if(contactibility_index > 100, 100, contactibility_index);
		contactibility_index_3 :=  if(contactibility_index_2 < 0, 0, contactibility_index_2);

		rel_criminal_c :=  map(rel_count = 0          => -1,
													 rel_criminal_count = 0 => 0,
													 rel_criminal_count = 1 => 1,
																										 2);

    rel_criminal_c_m := Map(rel_criminal_c =-1 => 0.1026934329 ,
														rel_criminal_c =0 => 0.1746359362 ,
														rel_criminal_c =1 => 0.1445829444 ,
														rel_criminal_c =2 => 0.1184336199 ,
														-9999);
												
		
		

		ams_file_type_c := ((ams_file_type = 'C') OR (ams_file_type = 'H'));

		rel_prop_owned_count_c :=  if(rel_count = 0, -1, min(rel_prop_owned_count, 2));

    property_owned_total_m := Map(property_owned_total_b =0 => 0.1299343842 ,
																	property_owned_total_b =1 => 0.2008717539 ,
																	property_owned_total_b =2 => 0.2142857143 ,
																	-9999);

		rel_home_val :=  map(rel_homeover500_count > 0  => 501,
												 rel_homeunder500_count > 0 => 500,
												 rel_homeunder300_count > 0 => 300,
												 rel_homeunder200_count > 0 => 200,
												 rel_homeunder150_count > 0 => 150,
												 rel_homeunder100_count > 0 => 100,
												 rel_homeunder50_count > 0  => 50,
																											 0);

		rel_home_val_c :=  if(rel_count = 0, -1, rel_home_val);

		rel_home_property_c :=  map((rel_prop_owned_count_c = 0) and (rel_home_val_c in [50, 100])       => 1,
																(rel_prop_owned_count_c = 0) and (rel_home_val_c in [150, 200])      => 2,
																(rel_prop_owned_count_c = 0) and (rel_home_val_c in [300])           => 3,
																(rel_prop_owned_count_c = 0) and (rel_home_val_c in [500])           => 4,
																(rel_prop_owned_count_c = 0) and (rel_home_val_c in [501])           => 5,
																(rel_prop_owned_count_c = 1) and (rel_home_val_c in [50])            => 6,
																(rel_prop_owned_count_c = 1) and (rel_home_val_c in [100])           => 7,
																(rel_prop_owned_count_c = 1) and (rel_home_val_c in [200, 300, 500]) => 8,
																(rel_prop_owned_count_c = 1) and (rel_home_val_c in [501])           => 9,
																(rel_prop_owned_count_c = 2) and (rel_home_val_c in [50, 100])       => 10,
																(rel_prop_owned_count_c = 2) and (rel_home_val_c in [150, 200, 300]) => 11,
																(rel_prop_owned_count_c = 2) and (rel_home_val_c in [500, 501])      => 12,
																																																			0);
		rel_home_property_c_m := Map(rel_count=0 						=> 0,
																 rel_home_property_c =0 => 0.1269545074 ,
																 rel_home_property_c =1 => 0.1158571159 ,
																 rel_home_property_c =2 => 0.1327733465 ,
																 rel_home_property_c =3 => 0.1465016418 ,
																 rel_home_property_c =4 => 0.1509209745 ,
																 rel_home_property_c =5 => 0.1678082192 ,
																 rel_home_property_c =6 => 0.1427203065 ,
																 rel_home_property_c =7 => 0.1581448705 ,
																 rel_home_property_c =8 => 0.1853360489 ,
																 rel_home_property_c =9 => 0.2022792023 ,
																 rel_home_property_c =10 => 0.1621713316 ,
																 rel_home_property_c =11 => 0.1890560511 ,
																 rel_home_property_c =12 => 0.2030415125 ,
																 -9999);
																 

   //***home value quartile ***;
		add1_home_quartile :=  map(add1_census_home_value <= 5000   => -1,
															 add1_census_home_value <= 53443  => 1,
															 add1_census_home_value <= 75741  => 2,
															 add1_census_home_value <= 112827 => 3,
																																	 4);

		add1_home_quartile_m2 := Map(add1_home_quartile =-1 => 0.1208930076 ,
																	add1_home_quartile =1 => 0.1069774072 ,
																	add1_home_quartile =2 => 0.1312064705 ,
																	add1_home_quartile =3 => 0.1530165552 ,
																	add1_home_quartile =4 => 0.1790268623 ,
																	-9999);

		logit_41 := -5.828039704 +
				(rel_home_property_c_m * 0.787054884) +
				(rel_criminal_c_m * 7.0163689027) +
				(address_type_c_m * 6.4251531818) +
				(property_owned_total_m * 5.5269738147) +
				(prof_license_flag2 * 0.0576092286) +
				((integer)watercraft_flag * 0.1835165509) +
				((integer)ams_file_type_c * 0.3194254539) +
				(add1_home_quartile_m2 * 7.2259277874);

		phat_41 := (exp(logit_41) / (1 + exp(logit_41)));

		Asset_Index := round(((28 * ((ln((phat_41 / (1 - phat_41))) - ln((.12 / .88))) / ln(2))) + 55));
		asset_index_2 :=  if(asset_index > 100, 100, asset_index);
		asset_index_3 :=  if(asset_index_2 < 0, 0, asset_index_2);

		liens_c :=  map(liens_historical_unreleased_ct = 0          => 0,
										liens_historical_unreleased_ct in [1, 2, 3] => 1,
																																	 2);

		bankrupt_type := 0;

		x := contains_i(StringLib.StringToUpperCase(disposition), 'DISCHARGE');
		y := contains_i(StringLib.StringToUpperCase(disposition), 'DISMISS');

		bankrupt_type_2 :=  map(x=1 => 1,
														y=1 => 3,
														bankrupt2 = 1 => 2,
														bankrupt_type);

		rel_bankrupt_flag := (rel_bankrupt_count > 0);

		lname_change_year := truncate((lname_change_date / 100));

		ecent_name_change_b1 := 1;

		recent_name_change_b2 := 0;

		ecent_name_change := if(((integer)sysyear - lname_change_year) < 3, ecent_name_change_b1, -9999);

		recent_name_change := if(((integer)sysyear - lname_change_year) < 3, -9999, recent_name_change_b2);

		deceased2 := ((source_ds_tot > 0) OR ((integer)rc_decsflag = 1));

		LifeStress_Index := 0;
		lifestress_index_2  :=  if(rel_criminal_c = -1, (lifestress_index + 60), lifestress_index);
		lifestress_index_3  :=  if(criminal_count >= 2, (lifestress_index_2 + 40), lifestress_index_2);
		lifestress_index_4  :=  if((integer)deceased2 = 1, (lifestress_index_3 + 37), lifestress_index_3);
		lifestress_index_5  :=  if(bankrupt_type_2 = 3, (lifestress_index_4 + 28), lifestress_index_4);
		lifestress_index_6  :=  if(criminal_count = 1, (lifestress_index_5 + 27), lifestress_index_5);
		lifestress_index_7  :=  if(rel_criminal_c = 2, (lifestress_index_6 + 25), lifestress_index_6);
		lifestress_index_8  :=  if(liens_c = 2, (lifestress_index_7 + 24), lifestress_index_7);
		lifestress_index_9  :=  if(bankrupt_type_2 = 2, (lifestress_index_8 + 19), lifestress_index_8);
		lifestress_index_10 :=  if(liens_c = 1, (lifestress_index_9 + 17), lifestress_index_9);
		lifestress_index_11 :=  if(rel_criminal_c = 1, (lifestress_index_10 + 16), lifestress_index_10);
		lifestress_index_12 :=  if(recent_name_change=1, (lifestress_index_11 + 10), lifestress_index_11);
		lifestress_index_13 :=  if(rel_bankrupt_count > 0, (lifestress_index_12 + 8), lifestress_index_12);
		lifestress_index_14 :=  if(recent_mover, (lifestress_index_13 + 5), lifestress_index_13);
		lifestress_index_15 :=  if(lifestress_index_14 > 100, 100, lifestress_index_14);


     //****Liquidity Index *****;

    liens_c_m := Map(liens_c =0 => 0.1601465243 ,
										 liens_c =1 => 0.1148759616 ,
										 liens_c =2 => 0.1056608448 ,
										 -9999);

    bankrupt_type_m := Map(bankrupt_type_2 =0 => 0.1511163685 ,
													 bankrupt_type_2 =1 => 0.1534758863 ,
													 bankrupt_type_2 =2 => 0.1356340289 ,
													 bankrupt_type_2 =3 => 0.0988334413 ,
														-9999);

     
		criminal_count_m2 := Map(criminal_count =0 => 0.1572579056 ,
														 criminal_count =1 => 0.1113954741 ,
														 criminal_count >=2 => 0.0963754802 ,
														 -9999);

		logit_42 := -8.667332973 +
				(rel_home_property_c_m * 2.812534225) +
				(rel_criminal_c_m * 4.3594284058) +
				(address_type_c_m * 5.9329418867) +
				(property_owned_total_m * 5.2247767252) +
				(prof_license_flag2 * 0.0722958616) +
				((integer)watercraft_flag * 0.2348454699) +
				((integer)ams_file_type_c * 0.2921307962) +
				(add1_home_quartile_m2 * 6.2707714855) +
				(liens_c_m * 7.9620339915) +
				(criminal_count_m2 * 7.9247595108) +
				(bankrupt_type_m * 6.5291960839) +
				((integer)rel_bankrupt_flag * -0.234304622) +
				((integer)deceased2 * -0.122685343) +
				((integer)recent_mover * -0.133606507) +
				(recent_name_change * -0.079122033);

		phat_42 := (exp(logit_42) / (1 + exp(logit_42)));

		Liquidity_Index := round(((25 * ((ln((phat_42 / (1 - phat_42))) - ln((.12 / .88))) / ln(2))) + 57));

		liquidity_index_2 :=  if(liquidity_index > 100, 100, liquidity_index);

		liquidity_index_3 :=  if(liquidity_index_2 < 0, 0, liquidity_index_2);


		SELF.address_index := intformat(address_index,3,1);
		SELF.telephone_index := intformat(phone_index,3,1);
		SELF.contactability_score := intformat(contactibility_index_3,3,1);
		SELF.asset_index := intformat(asset_index_3,3,1);
		SELF.lifecycle_stress_index := intformat(lifestress_index_15,3,1);
		SELF.liquidity_score := intformat(liquidity_index_3,3,1);
		self.seq := (string)le.seq;
			
		self := []; // don't populate any of the scores
	END;

	indices := project( clam, doIndices(left) );
	return indices;
END;