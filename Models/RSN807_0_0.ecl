import Risk_Indicators, std;

import ut, Risk_Indicators, RiskWise, easi;


export RSN807_0_0(
	grouped dataset(Risk_Indicators.Layout_Boca_Shell) clam) := 
	
	
	
	FUNCTION

		layout_bseasi := RECORD 
			Risk_Indicators.Layout_Boca_Shell  bs;
			Easi.layout_census  ea;
		END;

		layout_bseasi join2recs(clam le, Easi.Key_Easi_Census ri) := TRANSFORM
			self.bs := le;
			self.ea := ri;
			self := [];
		END; 				 
		
		results := join(clam, Easi.Key_Easi_Census,
					 keyed(right.geolink = left.shell_input.st+left.shell_input.county+left.shell_input.geo_blk),
					 join2recs(left, right),
					 left outer, atmost(10000), keep(1));



		sysyear := (integer)(ut.GetDate[1..4]);
			
		Layout_RecoverScore doModel(results le) := TRANSFORM


 /************************************************************************************/
 /* Fields from Modeling Shell                                                       */
 /************************************************************************************/
		out_unit_desig									:=  le.bs.Shell_Input.unit_desig;
		out_addr_type										:=  le.bs.Shell_Input.addr_type;
		out_addr_status									:=  le.bs.Shell_Input.addr_status;
		nap_summary                     :=  le.bs.iid.nap_summary;
		nap_status                      :=  le.bs.iid.nap_status;
		rc_hriskphoneflag               :=  le.bs.iid.hriskphoneflag;
		rc_hphonetypeflag               :=  le.bs.iid.hphonetypeflag;
		rc_phonevalflag                 :=  le.bs.iid.phonevalflag;
		rc_hphonevalflag                :=  le.bs.iid.hphonevalflag;
		rc_phonezipflag                 :=  le.bs.iid.phonezipflag;
		rc_pwphonezipflag               :=  le.bs.iid.PWphonezipflag;
		rc_hriskaddrflag                :=  (INTEGER)le.bs.iid.hriskaddrflag;
		rc_decsflag                     :=  le.bs.ssn_verification.validation.deceased;
		rc_dwelltype                    :=  trim(le.bs.address_validation.dwelling_type);
		rc_sources_tmp                  :=  le.bs.iid.sources;
		rc_sources 											:=  rc_sources_tmp + ',';  // add a comma
		rc_addrcount                    :=  le.bs.iid.addrcount;
		rc_utiliaddr_lnamecount					:=  le.bs.iid.utiliaddr_lastcount;
		rc_utiliaddr_addrcount          :=  le.bs.iid.utiliaddr_addrcount;
		rc_utiliaddr_phonecount         :=  le.bs.iid.utiliaddr_phonecount;
		rc_addrcommflag                 :=  le.bs.iid.addrcommflag;
		rc_hrisksic                     :=  (INTEGER)le.bs.iid.hrisksic;
		rc_hrisksicphone                :=  le.bs.iid.hrisksicphone;
		rc_disthphoneaddr               :=  le.bs.iid.disthphoneaddr;
		rc_phonetype                    :=  le.bs.iid.phonetype;
		combo_hphonescore               :=  le.bs.iid.combo_hphonescore;
		combo_hphonecount               :=  le.bs.iid.combo_hphonecount;
		rc_watchlist_flag               :=  le.bs.iid.watchlistHit;
		EQ_count												:=  le.bs.Source_Verification.eq_count;
		TU_count												:=  le.bs.Source_Verification.tu_count;
		DL_count												:=  le.bs.Source_Verification.dl_count;
		PR_count                        :=  le.bs.source_verification.pr_count;
		V_count													:=  le.bs.source_verification.v_count;
		EM_count												:=  le.bs.source_verification.em_count;
		W_count													:=  le.bs.source_verification.w_count;
		adl_EQ_first_seen								:=  le.bs.source_verification.adl_EQfs_first_seen;	
		adl_TU_first_seen								:=  le.bs.source_verification.adl_TU_first_seen;	
		adl_DL_first_seen								:=  le.bs.source_verification.adl_DL_first_seen;	
		adl_PR_first_seen								:=  le.bs.source_verification.adl_PR_first_seen;	
		adl_V_first_seen								:=  le.bs.source_verification.adl_V_first_seen;	
		adl_EM_first_seen								:=  le.bs.source_verification.adl_EM_first_seen;	
		adl_W_first_seen								:=  le.bs.source_verification.adl_W_first_seen;	
		dl_avail                        :=  (integer)le.bs.Available_Sources.dl;
		ssnlength                       :=  le.bs.input_validation.ssn_length;
		dobpop                          :=  (INTEGER)le.bs.input_validation.dateofbirth;
		hphnpop                         :=  (INTEGER)le.bs.input_validation.homephone;
		lname_change_date               :=  le.bs.name_verification.lname_change_date;
		source_count										:=  le.bs.Name_Verification.source_count;
		add1_avm_land_use               :=  le.bs.AVM.Input_Address_Information.avm_land_use_code;
		add1_avm_automated_valuation		:=  le.bs.AVM.Input_Address_Information.avm_automated_valuation;
		add1_avm_med_fips								:=  le.bs.AVM.Input_Address_Information.avm_median_fips_level;
		add1_avm_med_geo11							:=  le.bs.AVM.Input_Address_Information.avm_median_geo11_level;
		add1_avm_med_geo12							:=  le.bs.AVM.Input_Address_Information.avm_median_geo12_level;
		add1_source_count               :=  le.bs.address_verification.input_address_information.source_count;
		add1_naprop                     :=  le.bs.address_verification.input_address_information.naprop;
		add1_date_first_seen            :=  le.bs.address_verification.input_address_information.date_first_seen;
		add1_pop												:=  (integer)le.bs.addrpop;
		add1_census_home_value          :=  (integer)le.bs.address_verification.input_address_information.census_home_value;
		property_owned_total            :=  le.bs.address_verification.owned.property_total;
		property_owned_purchase_total		:=  le.bs.address_verification.owned.property_owned_purchase_total; 
		property_owned_purchase_count		:=  le.bs.address_verification.owned.property_owned_purchase_count;
		property_sold_total             :=  le.bs.address_verification.sold.property_total;
		add2_naprop                     :=  le.bs.address_verification.address_history_1.naprop;
		add2_date_first_seen						:=  le.bs.address_verification.address_history_1.date_first_seen;
		add2_pop												:=  (integer)le.bs.addrpop2;
		add2_census_home_value					:=  (integer)le.bs.address_verification.address_history_1.census_home_value;
		add3_naprop                     :=  le.bs.address_verification.address_history_2.naprop;
		add3_date_first_seen						:=  le.bs.address_verification.address_history_2.date_first_seen;
		add3_pop												:=  (integer)le.bs.addrpop3;
		add3_census_home_value					:=  (integer)le.bs.address_verification.address_history_2.census_home_value;
		addrs_15yr                      :=  le.bs.other_address_info.addrs_last_15years;
		telcordia_type                  :=  le.bs.phone_verification.telcordia_type;
		recent_disconnects              :=  le.bs.phone_verification.recent_disconnects;
		bk_sourced											:=  (integer)le.bs.SSN_Verification.bk_sourced;
		addrs_per_adl                   :=  le.bs.velocity_counters.addrs_per_adl;
		addrs_per_adl_c6                :=  le.bs.velocity_counters.addrs_per_adl_created_6months;
		bankrupt                        :=  (integer)le.bs.bjl.bankrupt;
		disposition                     :=  le.bs.bjl.disposition;
		bk_recent_count                 :=  le.bs.bjl.bk_recent_count;
		liens_recent_unreleased_count   :=  le.bs.bjl.liens_recent_unreleased_count;
		liens_historical_unreleased_ct  :=  le.bs.bjl.liens_historical_unreleased_count;
		criminal_count                  :=  le.bs.bjl.criminal_count;
		rel_count                       :=  le.bs.relatives.relative_count;
		rel_bankrupt_count              :=  le.bs.relatives.relative_bankrupt_count;
		rel_criminal_count              :=  le.bs.relatives.relative_criminal_count;
		rel_prop_owned_count            :=  le.bs.relatives.owned.relatives_property_count;
		rel_prop_owned_total						:=  le.bs.relatives.owned.relatives_property_total;
		rel_within25miles_count         :=  le.bs.relatives.relative_within25miles_count;
		rel_incomeunder25_count         :=  le.bs.relatives.relative_incomeUnder25_count;
		rel_incomeunder50_count         :=  le.bs.relatives.relative_incomeUnder50_count;
		rel_incomeunder75_count         :=  le.bs.relatives.relative_incomeUnder75_count;
		rel_incomeunder100_count        :=  le.bs.relatives.relative_incomeUnder100_count;
		rel_incomeover100_count         :=  le.bs.relatives.relative_incomeOver100_count;
		rel_homeunder50_count           :=  le.bs.relatives.relative_homeUnder50_count;
		rel_homeunder100_count          :=  le.bs.relatives.relative_homeUnder100_count;
		rel_homeunder150_count          :=  le.bs.relatives.relative_homeUnder150_count;
		rel_homeunder200_count          :=  le.bs.relatives.relative_homeUnder200_count;
		rel_homeunder300_count          :=  le.bs.relatives.relative_homeUnder300_count;
		rel_homeunder500_count          :=  le.bs.relatives.relative_homeUnder500_count;
		rel_homeover500_count           :=  le.bs.relatives.relative_homeOver500_count;
		rel_vehicle_owned_count         :=  le.bs.relatives.relative_vehicle_owned_count;
		rel_count_addr									:=  le.bs.relatives.relatives_at_input_address;
		current_count                   :=  le.bs.vehicles.current_count;
		watercraft_count								:=  le.bs.watercraft.watercraft_count;
		ams_file_type										:=  le.bs.student.file_type;
		prof_license_flag               :=  (INTEGER)le.bs.professional_license.professional_license_flag;
		archive_date										:=  if(le.bs.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.bs.historydate);	
		
		
 /************************************************************************************/
 /* Fields from ADL Append Process                                                   */
 /************************************************************************************/

		in_addrpop 				:= le.bs.ADL_Shell_Flags.in_addrpop;				//  was address populated on input from consumer
		adl_addr 					:= le.bs.ADL_Shell_Flags.adl_addr;      		//  results of ADL search on address
		in_addrpop_found 	:= le.bs.ADL_Shell_Flags.in_addrpop_found; //  did input address match database address
		in_hphnpop 				:= le.bs.ADL_Shell_Flags.in_hphnpop;				//  was hphone populated on input from consumer
		adl_hphn 					:= le.bs.ADL_Shell_Flags.adl_hphn;      		//  results of ADL search on hphone
		in_hphnpop_found 	:= le.bs.ADL_Shell_Flags.in_hphnpop_found; //  did input hphone match database hphone
		in_ssnpop 				:= le.bs.ADL_Shell_Flags.in_ssnpop;				//  was ssn populated on input from consumer
		adl_ssn 					:= le.bs.ADL_Shell_Flags.adl_ssn;				  //  results of ADL search on ssn 

 /************************************************************************************/
 /* Fields from EASI CENSUS                                                          */
 /************************************************************************************/

		C_HHSIZE 			:= le.ea.hhsize;  	     //#10 , Households - Median Size
		C_MED_AGE 		:= le.ea.med_age;        //#11 , Median Age
		C_MED_HVAL 		:= le.ea.med_hval;       //#13 , Median Home Value
		C_MED_HHINC		:= le.ea.med_hhinc;      //#15 , Median Household Income
		C_HIGHRENT 		:= le.ea.highrent;       //#58 , Housing - Median Rent
		c_HIGHINC 		:= le.ea.highinc;        //#91 , High Income Average
		C_INCOLLEGE 	:= le.ea.incollege;      //#96 , Percent Enrollment in College
		c_totcrime 		:= le.ea.totcrime;       //#109, Total Crime Index 
		c_easiqlife 	:= le.ea.easiqlife;      //#110, Quality of Life Index 
		c_housingcpi 	:= le.ea.housingcpi;     //#112, Housing CPI
		c_edu_indx 		:= le.ea.edu_indx;       //#133, Education Index
		c_ab_av_edu 	:= le.ea.ab_av_edu;      //#138, Percent Above Average Education
		c_bel_edu 		:= le.ea.bel_edu;        //#142, Percent Below Average Education
		C_UNEMPL 			:= le.ea.unempl;         //#164, Percent Unemployed
		c_totsales 		:= le.ea.totsales;       //#176, Total Retail Sales		
		           
		
		//***ASSIGNING SEGMENTS ****;
		INTEGER mdy( integer month, integer day, integer year ) := ut.DaysSince1900( (string4)year, (string2)month, '01' ) + (day - 1);		

		
		//****source flags ****;
		INTEGER contains_i( string haystack, string needle ) := (INTEGER)(StringLib.StringFind(haystack, needle, 1) > 0);

		lname_gong_sourced := (integer)(nap_summary in [2, 5, 7, 8, 9, 11, 12]);
		address_gong_sourced := (integer)(nap_summary in [3, 5, 6, 8, 10, 11, 12]);
		notsourced_gong := (integer)((lname_gong_sourced = 0) and (address_gong_sourced = 0));
		source_PL_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'PL,') > 0);
		source_L2_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'L2,') > 0);
		source_LI_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'LI,') > 0);
		source_BA_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'BA,') > 0);
		source_P_tot :=  (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'P ,') > 0);
		source_EM_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'EM,') > 0);
		source_EB_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'EB,') > 0);
		source_V_tot :=  (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'V ,') > 0);
		source_W_tot :=  (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'W ,') > 0);
		source_DS_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'DS,') > 0);
	
		notsourced_EM := (integer)(source_em_tot = 0);
		notsourced_P := (integer)(source_p_tot = 0);
		notsourced_V := (integer)(source_v_tot = 0);
		notSourced_GEMPV := (integer)(notsourced_gong=1 and (notsourced_em=1 and (notsourced_p=1 and notsourced_v=1)));
		
		watercraft_source_flag := (integer)(source_eb_tot=1 or source_w_tot=1);
		prof_license_flag2 :=  if((prof_license_flag > 0) or (source_pl_tot > 0), 1, 0);

		//***derogs ****;
		bankrupt2 :=  if((source_ba_tot > 0) or ((bankrupt > 0) or ((bk_sourced > 0) or (bk_recent_count > 0))), 1, 0);
		lien_flag :=  if((liens_historical_unreleased_ct > 0) or ((liens_recent_unreleased_count > 0) or ((source_l2_tot > 0) or 
											(source_li_tot > 0))), 1, 0);

		//***defining NO Content ****;
		noContent2 := (notsourced_gempv=1 and ((add1_naprop < 3) and ((prof_license_flag2 = 0) and ((add1_avm_land_use = '') and 
										((trim(ams_file_type, LEFT, RIGHT) = '') and ((criminal_count = 0) and ((lien_flag = 0) and 
										((bankrupt2 = 0) and ((watercraft_source_flag = 0) and (watercraft_count = 0))))))))));

		//****defining property owners ****;
		propertyOwner := (source_p_tot =1 OR ((add1_naprop = 4) OR ((add2_naprop = 4) OR (add3_naprop = 4))));

		//****calculating number of addresses ****;
		num_addresses_populated := 0;
		num_addresses_populated_2 :=  if(add1_pop=1, (num_addresses_populated + 1), num_addresses_populated);
		num_addresses_populated_3 :=  if(add2_pop=1, (num_addresses_populated_2 + 1), num_addresses_populated_2);
		num_addresses_populated_4 :=  if(add3_pop=1, (num_addresses_populated_3 + 1), num_addresses_populated_3);

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
		
		
    ty   := ((integer)((string)archive_date)[1..4])+0;
    tm_2 := if( ((integer)((string)archive_date)[5..6]) = 0, 1, ((integer)((string)archive_date)[5..6])+0);
    td   := 1;

 
		min_residence := min(if(add1_months_residence = -9999, 9999, add1_months_residence), 
													if(add2_months_residence = -9999, 9999, add2_months_residence),
													if(add3_months_residence = -9999, 9999, add3_months_residence));
												 
		max_residence := max(add1_months_residence, add2_months_residence, add3_months_residence);

		previous_address_known := (num_addresses_populated_4 > 1);

		recent_mover := (0 <= min_residence AND min_residence <= 12);
		
		moving_segment :=  map(previous_address_known and recent_mover       => 1,
													 previous_address_known and ~recent_mover			 => 2,
																																					  3);

		segment :=  map(nocontent2                           => 1,
										propertyowner                        => 6,
										rel_count > 0 and moving_segment = 1 => 5,
										rel_count > 0 and moving_segment = 2 => 4,
										rel_count > 0 and moving_segment = 3 => 3,
																													  2);


		naprop := ((add1_naprop = 4) OR ((add2_naprop = 4) OR (add3_naprop = 4)));

		source := source_p_tot;

		prop := ((property_owned_total > 0) OR (property_sold_total > 0));

		property_source := ((string)(integer)naprop + ((string)source + (string)(integer)prop));

		property_source_m :=  Map(property_source = '010' => 0.3051536336,
															property_source = '011'=> 0.2693920335,
															property_source = '100'=> 0.2710727969,
															property_source = '101'=> 0.2434509256,
															property_source = '110'=> 0.3403656821,
															property_source = '111'=> 0.321970373,
															-9999);

    property_owned_total_b := min(property_owned_total,2);
    property_sold_total_b := min(property_sold_total,2);
   
	  property_owned_sold := ((STRING)property_owned_total_b)[1] + ((STRING)property_sold_total_b)[1];

		property_owned_sold_m := Map(property_owned_sold = '00' => 0.3119822658,
																 property_owned_sold = '01' => 0.2333637192,
		  													 property_owned_sold = '02' => 0.2717391304,
		   													 property_owned_sold = '10' => 0.3044650182,
		   													 property_owned_sold = '11' => 0.3307823129,
		   													 property_owned_sold = '12' => 0.3359580052,
		   													 property_owned_sold = '20' => 0.3306737589,
		   													 property_owned_sold = '21' => 0.3216168717,
		   													 property_owned_sold = '22' => 0.3922018349,
																 -9999);
																
		

    avg_purchase_price := if(property_owned_purchase_count>0, property_owned_purchase_total/property_owned_purchase_count, -9999);
	 
		anomaly_high_property_purchase := (integer)(avg_purchase_price > 145000);

		avm_hit := (integer)(add1_avm_land_use in ['1', '2']);

		median :=  map(add1_avm_med_geo12 > 0 => add1_avm_med_geo12,
									 add1_avm_med_geo11 > 0 => add1_avm_med_geo11,
									 add1_avm_med_fips > 0  => add1_avm_med_fips,
																						 165000);

		ratio := (add1_avm_automated_valuation / median);

		ratio_2 :=  if(add1_avm_automated_valuation = 0, 1, ratio);

		avm_ratio_c :=  map(avm_hit = 0             					 => -1,
												0.9 <= ratio_2 and ratio_2 <= 1.1  => 2,
												ratio_2 >= 1.1          					 => 3,
												0.5 <= ratio_2 and ratio_2 < 0.9   => 1,
																															0);

		avm_ratio_c_m :=  Map(avm_ratio_c = -1 => 0.3026612539,
													avm_ratio_c = 0 => 0.2502857143, 
													avm_ratio_c = 1 => 0.2867477803, 
													avm_ratio_c = 2 => 0.323564737,
													avm_ratio_c = 3 => 0.3323943662,
													-9999);

		logit_b1 := -4.776694549 +
				(property_owned_sold_m * 3.9403507204) +
				(property_source_m * 4.6607236059) +
				(anomaly_high_property_purchase * 0.2153886372) +
				(avm_ratio_c_m * 4.2714534725);

		phat_b1 := (exp(logit_b1) / (1 + exp(logit_b1)));

		propmod_b1 := round(((50 * ((ln((phat_b1 / (1 - phat_b1))) - ln((.126 / .874))) / ln(2))) + 700));

		propmod_b2 := 0;

		propmod := if(segment = 6, propmod_b1, propmod_b2);

		phat := if(segment = 6, phat_b1, -9999);

		logit := if(segment = 6, logit_b1, -9999);

		rel_proximity := 0;

		rel_proximity_2 :=  if(rel_count > 0, (rel_within25miles_count / rel_count), rel_proximity);

		total_income := sum(rel_incomeover100_count, rel_incomeunder100_count, rel_incomeunder25_count, rel_incomeunder50_count, rel_incomeunder75_count);

		high_income := sum(rel_incomeover100_count, rel_incomeunder100_count);

		
		
    //****CHI-SQUARE Values ****;		
		income_chisq := 0;
		nohits := (total_income - high_income);
		cell1_b1 := (((nohits - ((1 - 0.10) * total_income)) * (nohits - ((1 - 0.10) * total_income))) / ((1 - 0.10) * total_income));
		cell2_b1 := (((high_income - (0.10 * total_income)) * (high_income - (0.10 * total_income))) / (0.10 * total_income));
		income_chisq_b1 := sum(cell1_b1, cell2_b1);
		pct_b1 := (high_income / total_income);
		income_chisq_b1_2 := (income_chisq_b1 * -1);
		income_chisq_b1_3 := if(pct_b1 < 0.10, income_chisq_b1_2, income_chisq_b1);
		pct := if(total_income > 0, pct_b1, -9999);
		cell2 := if(total_income > 0, cell2_b1, -9999);
		income_chisq_2 := if(total_income > 0, income_chisq_b1_3, income_chisq);
  	cell1 := if(total_income > 0, cell1_b1, -9999);
		
	
		criminal_chisq := 0;
		nohits_2 := (rel_count - rel_criminal_count);
		cell1_b1_2 := (((nohits_2 - ((1 - 0.15) * rel_count)) * (nohits_2 - ((1 - 0.15) * rel_count))) / ((1 - 0.15) * rel_count));
		cell2_b1_2 := (((rel_criminal_count - (0.15 * rel_count)) * (rel_criminal_count - (0.15 * rel_count))) / (0.15 * rel_count));
		criminal_chisq_b1 := sum(cell1_b1_2, cell2_b1_2);
		pct_b1_2 := (rel_criminal_count / rel_count);
		criminal_chisq_b1_2 := (criminal_chisq_b1 * -1);
		criminal_chisq_b1_3 := if(pct_b1_2 < 0.15, criminal_chisq_b1_2, criminal_chisq_b1);
		pct_2 := if(rel_count > 0, pct_b1_2, -9999);
		criminal_chisq_2 := if(rel_count > 0, criminal_chisq_b1_3, criminal_chisq);
		cell2_2 := if(rel_count > 0, cell2_b1_2, cell2);
		cell1_2 := if(rel_count > 0, cell1_b1_2, cell1);


		bankrupt_chisq := 0;
		nohits_3 := (rel_count - rel_bankrupt_count);
		cell1_b1_3 := (((nohits_3 - ((1 - 0.10) * rel_count)) * (nohits_3 - ((1 - 0.10) * rel_count))) / ((1 - 0.10) * rel_count));
		cell2_b1_3 := (((rel_bankrupt_count - (0.10 * rel_count)) * (rel_bankrupt_count - (0.10 * rel_count))) / (0.10 * rel_count));
		bankrupt_chisq_b1 := sum(cell1_b1_3, cell2_b1_3);
		pct_b1_3 := (rel_bankrupt_count / rel_count);
		bankrupt_chisq_b1_2 := (bankrupt_chisq_b1 * -1);
		bankrupt_chisq_b1_3 := if(pct_b1_3 < 0.10, bankrupt_chisq_b1_2, bankrupt_chisq_b1);
		pct_3 := if(rel_count > 0, pct_b1_3, -9999);
		bankrupt_chisq_2 := if(rel_count > 0, bankrupt_chisq_b1_3, bankrupt_chisq);
		cell2_3 := if(rel_count > 0, cell2_b1_3, -9999);
		cell1_3 := if(rel_count > 0, cell1_b1_3, -9999);


		cohabit_chisq := 0;
		nohits_4 := (rel_count - rel_count_addr);
		cell1_b1_4 := (((nohits_4 - ((1 - 0.30) * rel_count)) * (nohits_4 - ((1 - 0.30) * rel_count))) / ((1 - 0.30) * rel_count));
		cell2_b1_4 := (((rel_count_addr - (0.30 * rel_count)) * (rel_count_addr - (0.30 * rel_count))) / (0.30 * rel_count));
		cohabit_chisq_b1 := sum(cell1_b1_4, cell2_b1_4);
		pct_b1_4 := (rel_count_addr / rel_count);
		cohabit_chisq_b1_2 := (cohabit_chisq_b1 * -1);
		cohabit_chisq_b1_3 := if(pct_b1_4 < 0.30, cohabit_chisq_b1_2, cohabit_chisq_b1);
		pct_4 := if(rel_count > 0, pct_b1_4, -9999);
		cell2_4 := if(rel_count > 0, cell2_b1_4, -9999);
		cohabit_chisq_2 := if(rel_count > 0, cohabit_chisq_b1_3, cohabit_chisq);
		cell1_4 := if(rel_count > 0, cell1_b1_4, -9999);
		

	

		rel_count_c_b1_c2_b1 := 0;
		rel_count_c_b1_c2_b2 := 1;
		rel_count_c_b1_c2_b3 := 2;

		rel_count_c_b1 := map(rel_count in [0] => rel_count_c_b1_c2_b1,
													rel_count in [1] => rel_count_c_b1_c2_b2,
													rel_count >= 2   => rel_count_c_b1_c2_b3,
																							-9999);

		rel_count_c_c2_b2_c3_b1 := 0;
		rel_count_c_c2_b2_c3_b2 := 1;
		rel_count_c_c2_b2_c3_b3 := 2;
		rel_count_c_c2_b2 := map(rel_count in [1, 2]    => rel_count_c_c2_b2_c3_b1,
														 rel_count in [3, 4, 5] => rel_count_c_c2_b2_c3_b2,
														 rel_count >= 6         => rel_count_c_c2_b2_c3_b3,
																											 -9999);

		rel_count_c_c3_b3_c4_b1 := 0;
		rel_count_c_c3_b3_c4_b2 := 1;
		rel_count_c_c3_b3_c4_b3 := 2;
		rel_count_c_c3_b3 := map(rel_count in [1, 2]    => rel_count_c_c3_b3_c4_b1,
														 rel_count in [3, 4, 5] => rel_count_c_c3_b3_c4_b2,
														 rel_count >= 6         => rel_count_c_c3_b3_c4_b3,
																											 -9999);

		rel_count_c_c4_b4_c5_b1 := 0;
		rel_count_c_c4_b4_c5_b2 := 1;
		rel_count_c_c4_b4_c5_b3 := 2;
		rel_count_c_c4_b4 := map(rel_count in [1]                      => rel_count_c_c4_b4_c5_b1,
														 rel_count in [2, 3, 4, 5, 6, 7, 8, 9] => rel_count_c_c4_b4_c5_b2,
														 rel_count >= 10                       => rel_count_c_c4_b4_c5_b3,
																																			-9999);

		rel_count_c_c5_b5_c6_b1 := 0;
		rel_count_c_c5_b5_c6_b2 := 1;
		rel_count_c_c5_b5_c6_b3 := 2;
		rel_count_c_c5_b5 := map(rel_count in [0, 1, 2]             => rel_count_c_c5_b5_c6_b1,
														 rel_count in [3, 4, 5, 6, 7, 8, 9] => rel_count_c_c5_b5_c6_b2,
														 rel_count >= 10                    => rel_count_c_c5_b5_c6_b3,
																																	 -9999);

		rel_count_c := map(segment = 1 => rel_count_c_b1,
											 segment = 3 => rel_count_c_c2_b2,
											 segment = 4 => rel_count_c_c3_b3,
											 segment = 5 => rel_count_c_c4_b4,
																			rel_count_c_c5_b5);

		rel_count_c_m := Map(rel_count_c =0 and segment=1 => 0.1095315024 ,
												 rel_count_c =1 and segment=1 => 0.1342090234 ,
												 rel_count_c =2 and segment=1 => 0.1599404565 ,
												 rel_count_c =0 and segment=3 => 0.155788914 ,
												 rel_count_c =1 and segment=3 => 0.2061522774 ,
												 rel_count_c =2 and segment=3 => 0.1837370242 ,
												 rel_count_c =0 and segment=4 => 0.1598429613 ,
												 rel_count_c =1 and segment=4 => 0.1961617546 ,
												 rel_count_c =2 and segment=4 => 0.1692434419 ,
												 rel_count_c =0 and segment=5 => 0.1598240469 ,
												 rel_count_c =1 and segment=5 => 0.2061431971 ,
												 rel_count_c =2 and segment=5 => 0.1725405044 ,
												 rel_count_c =0 and segment=6 => 0.2836787565 ,
												 rel_count_c =1 and segment=6 => 0.3199907806 ,
												 rel_count_c =2 and segment=6 => 0.293319169 ,
												 -9999);


		anomaly_propertyowned_relative := (rel_prop_owned_total > 0);

		anomaly_vehicle_relative := (rel_vehicle_owned_count > 0);

    //***cross vehicle and property ***;
    relative_property_vehicle_tmp := (string)(integer)anomaly_propertyowned_relative + (string)(integer)anomaly_vehicle_relative;
    relative_property_vehicle := if(rel_count=0, '-1', relative_property_vehicle_tmp);

	 relative_property_vehicle_m := Map(relative_property_vehicle = '-1' and segment=1 => 0,
																			relative_property_vehicle = '00' and segment=1 => 0.1495504023,
																			relative_property_vehicle = '01' and segment=1 => 0.145663632,
																			relative_property_vehicle = '10' and segment=1 => 0.1879194631,
																			relative_property_vehicle = '11' and segment=1 => 0.1705006766,
																		  relative_property_vehicle = '-1' and segment=2 => 0,
																	 	  relative_property_vehicle = '00' and segment=3 => 0.1506624606,
																	 		relative_property_vehicle = '01' and segment=3 => 0.1844605925,
																	 		relative_property_vehicle = '10' and segment=3 => 0.2141608392,
																	 		relative_property_vehicle = '11' and segment=3 => 0.2282521947,
																			relative_property_vehicle = '00' and segment=4 => 0.158392435,
																			relative_property_vehicle = '01' and segment=4 => 0.1663776159,
																			relative_property_vehicle = '10' and segment=4 => 0.2011251758,
																			relative_property_vehicle = '11' and segment=4 => 0.194470478,
																			relative_property_vehicle = '00' and segment=5 => 0.1742198526,
																			relative_property_vehicle = '01' and segment=5 => 0.1835768398 ,
																			relative_property_vehicle = '10' and segment=5 => 0.2205462699,
																			relative_property_vehicle = '11' and segment=5 => 0.2202881152,
																			relative_property_vehicle = '-1' and segment=6 => 0,
																			relative_property_vehicle = '00' and segment=6 => 0.2770724421,
																			relative_property_vehicle = '01' and segment=6 => 0.2865329513,
																			relative_property_vehicle = '10' and segment=6 => 0.3221997301,
																			relative_property_vehicle = '11' and segment=6 => 0.3206220707,
																			-9999);


		logit_b1_2 := -3.045059479 +
				(rel_count_c_m * 8.6228168662) +
				(bankrupt_chisq_2 * 0.0318024307) +
				(cohabit_chisq_2 * 0.0221839266) +
				(income_chisq_2 * 0.0277273797);

		phat_b1_2 := (exp(logit_b1_2) / (1 + exp(logit_b1_2)));

		relmod_b1 := round(((50 * ((ln((phat_b1_2 / (1 - phat_b1_2))) - ln((.126 / .874))) / ln(2))) + 700));

		phat_2 := if(segment = 1, phat_b1_2, -9999);

		logit_2 := if(segment = 1, logit_b1_2, -9999);

		relmod := if(segment = 1, relmod_b1, -9999);

		relmod_2 :=  if(segment = 2, 0, relmod);

		logit_b1_3 := -3.452177862 +
				(rel_count_c_m * 4.5019864326) +
				(rel_proximity_2 * 0.2684020817) +
				(criminal_chisq_2 * -0.035799781) +
				(bankrupt_chisq_2 * 0.0173119378) +
				(income_chisq_2 * 0.015417545) +
				(relative_property_vehicle_m * 4.993632336);

		phat_b1_3 := (exp(logit_b1_3) / (1 + exp(logit_b1_3)));

		relmod_b1_2 := round(((50 * ((ln((phat_b1_3 / (1 - phat_b1_3))) - ln((.126 / .874))) / ln(2))) + 700));

		phat_3 := if(segment = 3, phat_b1_3, -9999);

		logit_3 := if(segment = 3, logit_b1_3, -9999);

		relmod_3 := if(segment = 3, relmod_b1_2, -9999);

		logit_b1_4 := -3.655296003 +
				(rel_count_c_m * 5.3837321294) +
				(criminal_chisq_2 * -0.021803537) +
				(cohabit_chisq_2 * 0.0271573359) +
				(income_chisq_2 * 0.0164583692) +
				(relative_property_vehicle_m * 6.84080296);

		phat_b1_4 := (exp(logit_b1_4) / (1 + exp(logit_b1_4)));

		relmod_b1_3 := round(((50 * ((ln((phat_b1_4 / (1 - phat_b1_4))) - ln((.126 / .874))) / ln(2))) + 700));

		phat_4 := if(segment = 4, phat_b1_4, -9999);

		logit_4 := if(segment = 4, logit_b1_4, -9999);

		relmod_4 := if(segment = 4, relmod_b1_3, -9999);

		logit_b1_5 := -3.716913057 +
				(rel_count_c_m * 5.5227396654) +
				(criminal_chisq_2 * -0.010164641) +
				(cohabit_chisq_2 * 0.0130288172) +
				(income_chisq_2 * 0.0219115011) +
				(relative_property_vehicle_m * 6.3957313992);

		phat_b1_5 := (exp(logit_b1_5) / (1 + exp(logit_b1_5)));

		relmod_b1_4 := round(((50 * ((ln((phat_b1_5 / (1 - phat_b1_5))) - ln((.126 / .874))) / ln(2))) + 700));

		phat_5 := if(segment = 5, phat_b1_5, -9999);

		logit_5 := if(segment = 5, logit_b1_5, -9999);

		relmod_5 := if(segment = 5, relmod_b1_4, -9999);

		logit_b1_6 := -2.160449624 +
				(rel_count_c_m * 3.6091383039) +
				(criminal_chisq_2 * -0.015392679) +
				(bankrupt_chisq_2 * -0.010900492) +
				(income_chisq_2 * 0.0136056865) +
				(relative_property_vehicle_m * 0.8276568345);

		phat_b1_6 := (exp(logit_b1_6) / (1 + exp(logit_b1_6)));

		relmod_b1_5 := round(((50 * ((ln((phat_b1_6 / (1 - phat_b1_6))) - ln((.126 / .874))) / ln(2))) + 700));

		phat_6 := if(segment = 6, phat_b1_6, -9999);

		logit_6 := if(segment = 6, logit_b1_6, -9999);

		relmod_6 := if(segment = 6, relmod_b1_5, -9999);
		
		
		relmod_final := map(segment = 1 => relmod,
												 segment = 2 => relmod_2,
												 segment = 3 => relmod_3,
												 segment = 4 => relmod_4,
												 segment = 5 => relmod_5,
												 segment = 6 => relmod_6,
												 -9999);		
		

		c_totcrime_m := 105.560;

		c_totcrime_s := 43.4602;

		c_easiqlife_m := 102.704;

		c_easiqlife_s := 32.2313;

		c_housingcpi_m := 188.110;

		c_housingcpi_s := 10.7416;

		c_edu_indx_m := 102.339;

		c_edu_indx_s := 14.3969;

		c_bel_edu_m := 113.820;

		c_bel_edu_s := 54.3898;

		c_ab_av_edu_m := 84.7424;

		c_ab_av_edu_s := 52.3491;

		c_totsales_m := 39364.79;

		c_totsales_s := 128939.35;

		C_HHSIZE_m := 2.66586;

		C_HHSIZE_s := 0.50137;

		c_HIGHINC_m := 6.68435;

		c_HIGHINC_s := 8.20918;

		C_HIGHRENT_m := 2.06430;

		C_HIGHRENT_s := 8.71033;

		C_MED_HHINC_m := 45459.05;

		C_MED_HHINC_s := 19887.82;

		C_MED_HVAL_m := 99228.39;

		C_MED_HVAL_s := 70498.81;

		C_MED_AGE_m := 80.1123;

		C_MED_AGE_s := 55.3865;

		C_INCOLLEGE_m := 5.41847;

		C_INCOLLEGE_s := 6.44925;

		C_UNEMPL_m := 110.794;

		C_UNEMPL_s := 43.6541;

		c_totcrime_z := 0;

		c_totcrime_z_2 :=  if(trim(c_totcrime) != '', (((real)c_totcrime - c_totcrime_m) / c_totcrime_s), c_totcrime_z);

		c_easiqlife_z := 0;

		c_easiqlife_z_2 :=  if(trim(c_easiqlife) != '', (((real)c_easiqlife - c_easiqlife_m) / c_easiqlife_s), c_easiqlife_z);

		c_housingcpi_z := 0;

		c_housingcpi_z_2 :=  if(trim(c_housingcpi) != '', (((real)c_housingcpi - c_housingcpi_m) / c_housingcpi_s), c_housingcpi_z);

		c_edu_indx_z := 0;

		c_edu_indx_z_2 :=  if(trim(c_edu_indx) != '', (((real)c_edu_indx - c_edu_indx_m) / c_edu_indx_s), c_edu_indx_z);

		c_bel_edu_z := 0;

		c_bel_edu_z_2 :=  if(trim(c_bel_edu) != '', (((real)c_bel_edu - c_bel_edu_m) / c_bel_edu_s), c_bel_edu_z);

		c_ab_av_edu_z := 0;

		c_ab_av_edu_z_2 :=  if(trim(c_ab_av_edu) != '', (((real)c_ab_av_edu - c_ab_av_edu_m) / c_ab_av_edu_s), c_ab_av_edu_z);

		c_totsales_z := 0;

		c_totsales_z_2 :=  if(trim(c_totsales) != '', (((real)c_totsales - c_totsales_m) / c_totsales_s), c_totsales_z);

		C_HHSIZE_z := 0;

		c_hhsize_z_2 :=  if(trim(c_hhsize) != '', (((real)c_hhsize - c_hhsize_m) / c_hhsize_s), c_hhsize_z);

		c_HIGHINC_z := 0;

		c_highinc_z_2 :=  if(trim(c_highinc) != '', (((real)c_highinc - c_highinc_m) / c_highinc_s), c_highinc_z);

		C_HIGHRENT_z := 0;

		c_highrent_z_2 :=  if(trim(c_highrent) != '', (((real)c_highrent - c_highrent_m) / c_highrent_s), c_highrent_z);

		C_MED_HHINC_z := 0;

		c_med_hhinc_z_2 :=  if(trim(c_med_hhinc) != '', (((real)c_med_hhinc - c_med_hhinc_m) / c_med_hhinc_s), c_med_hhinc_z);

		C_MED_HVAL_z := 0;

		c_med_hval_z_2 :=  if(trim(c_med_hval) != '', (((real)c_med_hval - c_med_hval_m) / c_med_hval_s), c_med_hval_z);

		C_MED_AGE_z := 0;

		c_med_age_z_2 :=  if(trim(c_med_age) != '', (((real)c_med_age - c_med_age_m) / c_med_age_s), c_med_age_z);

		C_INCOLLEGE_z := 0;

		c_incollege_z_2 :=  if(trim(c_incollege) != '', (((real)c_incollege - c_incollege_m) / c_incollege_s), c_incollege_z);

		C_UNEMPL_z := 0;

		c_unempl_z_2 :=  if(trim(c_unempl) != '', (((real)c_unempl - c_unempl_m) / c_unempl_s), c_unempl_z);

		logit_b1_7 := -1.791433734 +
				(c_totcrime_z_2 * -0.106335612) +
				(c_easiqlife_z_2 * -0.077254524) +
				(c_housingcpi_z_2 * 0.042213705) +
				(c_bel_edu_z_2 * -0.127993634);

		phat_b1_7 := (exp(logit_b1_7) / (1 + exp(logit_b1_7)));

		censmod_b1 := round(((50 * ((ln((phat_b1_7 / (1 - phat_b1_7))) - ln((.126 / .874))) / ln(2))) + 700));

		censmod := if(segment = 1, censmod_b1, -9999);

		phat_7 := if(segment = 1, phat_b1_7, -9999);

		logit_7 := if(segment = 1, logit_b1_7, -9999);

		logit_b1_8 := -1.89087572 +
				(c_totcrime_z_2 * -0.06163296) +
				(c_easiqlife_z_2 * -0.089958369) +
				(c_bel_edu_z_2 * -0.103431357) +
				(c_med_hval_z_2 * -0.050415116) +
				(c_med_age_z_2 * 0.0854905438);

		phat_b1_8 := (exp(logit_b1_8) / (1 + exp(logit_b1_8)));

		censmod_b1_2 := round(((50 * ((ln((phat_b1_8 / (1 - phat_b1_8))) - ln((.126 / .874))) / ln(2))) + 700));

		censmod_2 := if(segment = 2, censmod_b1_2, -9999);

		phat_8 := if(segment = 2, phat_b1_8, -9999);

		logit_8 := if(segment = 2, logit_b1_8, -9999);

		logit_b1_9 := -1.539850466 +
				(c_totcrime_z_2 * -0.029578931) +
				(c_easiqlife_z_2 * -0.14316117) +
				(c_edu_indx_z_2 * 0.0774269296) +
				(c_bel_edu_z_2 * -0.088955874) +
				(c_med_hhinc_z_2 * 0.0730928411) +
				(c_med_age_z_2 * 0.1074934507) +
				(c_unempl_z_2 * -0.051693785);

		phat_b1_9 := (exp(logit_b1_9) / (1 + exp(logit_b1_9)));

		censmod_b1_3 := round(((50 * ((ln((phat_b1_9 / (1 - phat_b1_9))) - ln((.126 / .874))) / ln(2))) + 700));

		censmod_3 := if(segment = 3, censmod_b1_3, -9999);

		phat_9 := if(segment = 3, phat_b1_9, -9999);

		logit_9 := if(segment = 3, logit_b1_9, -9999);

		logit_b1_10 := -1.557866356 +
				(c_totcrime_z_2 * -0.031418235) +
				(c_easiqlife_z_2 * -0.110157648) +
				(c_edu_indx_z_2 * 0.0300503831) +
				(c_bel_edu_z_2 * -0.120633438) +
				(c_med_hhinc_z_2 * 0.0320688717) +
				(c_med_age_z_2 * 0.1046601089) +
				(c_incollege_z_2 * 0.0320244826) +
				(c_unempl_z_2 * -0.036483209);

		phat_b1_10 := (exp(logit_b1_10) / (1 + exp(logit_b1_10)));

		censmod_b1_4 := round(((50 * ((ln((phat_b1_10 / (1 - phat_b1_10))) - ln((.126 / .874))) / ln(2))) + 700));

		censmod_4 := if(segment = 4, censmod_b1_4, -9999);

		phat_10 := if(segment = 4, phat_b1_10, -9999);

		logit_10 := if(segment = 4, logit_b1_10, -9999);

		logit_b1_11 := -1.466561824 +
				(c_totcrime_z_2 * -0.054286154) +
				(c_easiqlife_z_2 * -0.128702188) +
				(c_bel_edu_z_2 * -0.156462887) +
				(c_totsales_z_2 * 0.036113034) +
				(c_med_hhinc_z_2 * 0.0399625716) +
				(c_incollege_z_2 * 0.0475947056) +
				(c_unempl_z_2 * -0.045357482);

		phat_b1_11 := (exp(logit_b1_11) / (1 + exp(logit_b1_11)));

		censmod_b1_5 := round(((50 * ((ln((phat_b1_11 / (1 - phat_b1_11))) - ln((.126 / .874))) / ln(2))) + 700));

		censmod_5 := if(segment = 5, censmod_b1_5, -9999);

		phat_11 := if(segment = 5, phat_b1_11, -9999);

		logit_11 := if(segment = 5, logit_b1_11, -9999);

		logit_b1_12 := -0.866771331 +
				(c_totcrime_z_2 * -0.068069328) +
				(c_easiqlife_z_2 * -0.16131142) +
				(c_housingcpi_z_2 * 0.0241769175) +
				(c_edu_indx_z_2 * 0.0586318821) +
				(c_bel_edu_z_2 * -0.122776763) +
				(c_med_hval_z_2 * 0.0565944224) +
				(c_med_age_z_2 * 0.0665316487) +
				(c_incollege_z_2 * 0.0397470422) +
				(c_unempl_z_2 * -0.029083621);

		phat_b1_12 := (exp(logit_b1_12) / (1 + exp(logit_b1_12)));

		censmod_b1_6 := round(((50 * ((ln((phat_b1_12 / (1 - phat_b1_12))) - ln((.126 / .874))) / ln(2))) + 700));

		censmod_6 := if(segment = 6, censmod_b1_6, -9999);

		phat_12 := if(segment = 6, phat_b1_12, -9999);

		logit_12 := if(segment = 6, logit_b1_12, -9999);
		
		censmod_final := map(segment = 1 => censmod,
												 segment = 2 => censmod_2,
												 segment = 3 => censmod_3,
												 segment = 4 => censmod_4,
												 segment = 5 => censmod_5,
												 segment = 6 => censmod_6,
												 -9999);


    //***CRIMINAL COUNTS ***;
		criminal_count_c := min(criminal_count,2);

		criminal_count_m := Map(criminal_count_c =0 and segment=2 => 0.1289194545,
														criminal_count_c =1 and segment=2 => 0.0804597701,
														criminal_count_c =2 and segment=2 => 0.0712250712,
														criminal_count_c =0 and segment=3 => 0.1782594198,
														criminal_count_c =1 and segment=3 => 0.1386138614,
														criminal_count_c =2 and segment=3 => 0.150084317,
														criminal_count_c =0 and segment=4 => 0.1932729625,
														criminal_count_c =1 and segment=4 => 0.1419753086,
														criminal_count_c =2 and segment=4 => 0.1155209072,
														criminal_count_c =0 and segment=5 => 0.2064966644,
														criminal_count_c =1 and segment=5 => 0.1609987086,
														criminal_count_c =2 and segment=5 => 0.1408547009,
														criminal_count_c =0 and segment=6 => 0.3159180418,
														criminal_count_c =1 and segment=6 => 0.2542613636,
														criminal_count_c =2 and segment=6 => 0.2430870821,
														-9999);
														

    //***Current vehicle count ****;
    current_count_c := if(segment in [2,3,5], min(current_count,1), min(current_count,2));

    current_count_c_m := Map(current_count_c =0 and segment=1 => 0.1397635491,
														 current_count_c =1 and segment=1 => 0.1490312966,
														 current_count_c =2 and segment=1 => 0.1459781529,
														 current_count_c =0 and segment=2 => 0.1280431787,
														 current_count_c =1 and segment=2 => 0.1411992263,
														 current_count_c =0 and segment=3 => 0.1692088128,
														 current_count_c =1 and segment=3 => 0.2003539127,
														 current_count_c =0 and segment=4 => 0.1736495389,
														 current_count_c =1 and segment=4 => 0.1745408884,
														 current_count_c =2 and segment=4 => 0.1814611155,
														 current_count_c =0 and segment=5 => 0.1939590614,
														 current_count_c =1 and segment=5 => 0.1933275375,														 
														 current_count_c =0 and segment=6 => 0.3005886942,
														 current_count_c =1 and segment=6 => 0.3037433155,
														 current_count_c =2 and segment=6 => 0.3254571605,
														 -9999);

    //***AMS ***; 
  	 ams_file_type_m := Map(ams_file_type in ['C','H'] and segment=2 => 0.2127659574,
														ams_file_type = 'M' and segment=2 => 0.1785714286,
														ams_file_type in ['C','H'] and segment=3 => 0.350877193,
														ams_file_type = 'M' and segment=3 => 0.2191780822,
														ams_file_type in ['C','H'] and segment=4 => 0.2697547684,
														ams_file_type = 'M' and segment=4 => 0.1965397924,
														ams_file_type in ['C','H'] and segment=5 => 0.3170134639,
														ams_file_type = 'M' and segment=5 => 0.2230556652,
														ams_file_type in ['C','H'] and segment=6 => 0.3894899536,
														ams_file_type = 'M' and segment=6 => 0.2940793754,
														0);


		watercraft_flag := (watercraft_count > 0);

		flagmod :=  if(segment = 1, 0, -9999);

		logit_b1_13 := -3.119392126 +
				(ams_file_type_m * 2.5973252194) +
				(criminal_count_m * 9.4921094651) +
				((integer)watercraft_flag * 1.2008548165);

		phat_b1_13 := (exp(logit_b1_13) / (1 + exp(logit_b1_13)));

		flagmod_b1 := round(((50 * ((ln((phat_b1_13 / (1 - phat_b1_13))) - ln((.126 / .874))) / ln(2))) + 700));

		flagmod_2 := if(segment = 2, flagmod_b1, -9999);

		phat_13 := if(segment = 2, phat_b1_13, -9999);

		logit_13 := if(segment = 2, logit_b1_13, -9999);

		logit_b1_14 := -4.504736879 +
				(lien_flag * -0.244245963) +
				(ams_file_type_m * 2.1350287271) +
				(criminal_count_m * 10.861875511) +
				((integer)watercraft_flag * 0.8989173552) +
				(current_count_c_m * 5.7917176941);

		phat_b1_14 := (exp(logit_b1_14) / (1 + exp(logit_b1_14)));

		flagmod_b1_2 := round(((50 * ((ln((phat_b1_14 / (1 - phat_b1_14))) - ln((.126 / .874))) / ln(2))) + 700));

		flagmod_3 := if(segment = 3, flagmod_b1_2, -9999);

		phat_14 := if(segment = 3, phat_b1_14, -9999);

		logit_14 := if(segment = 3, logit_b1_14, -9999);

		logit_b1_15 := -2.876250822 +
				(lien_flag * -0.174394626) +
				(prof_license_flag2 * 0.1873425698) +
				(ams_file_type_m * 1.1906535843) +
				(criminal_count_m * 7.5551445353) +
				((integer)watercraft_flag * 0.4467922911);

		phat_b1_15 := (exp(logit_b1_15) / (1 + exp(logit_b1_15)));

		flagmod_b1_3 := round(((50 * ((ln((phat_b1_15 / (1 - phat_b1_15))) - ln((.126 / .874))) / ln(2))) + 700));

		flagmod_4 := if(segment = 4, flagmod_b1_3, -9999);

		phat_15 := if(segment = 4, phat_b1_15, -9999);

		logit_15 := if(segment = 4, logit_b1_15, -9999);

		logit_b1_16 := -2.714594403 +
				(lien_flag * -0.20060275) +
				(ams_file_type_m * 1.6450559267) +
				(criminal_count_m * 6.5500215238) +
				((integer)watercraft_flag * 0.3050084353);

		phat_b1_16 := (exp(logit_b1_16) / (1 + exp(logit_b1_16)));

		flagmod_b1_4 := round(((50 * ((ln((phat_b1_16 / (1 - phat_b1_16))) - ln((.126 / .874))) / ln(2))) + 700));

		flagmod_5 := if(segment = 5, flagmod_b1_4, -9999);

		phat_16 := if(segment = 5, phat_b1_16, -9999);

		logit_16 := if(segment = 5, logit_b1_16, -9999);

		logit_b1_17 := -3.443463538 +
				(lien_flag * -0.158322171) +
				(prof_license_flag2 * 0.3360600361) +
				(ams_file_type_m * 0.4402794476) +
				(criminal_count_m * 4.717403269) +
				((integer)watercraft_flag * 0.2836781944) +
				(current_count_c_m * 3.9015835431);

		phat_b1_17 := (exp(logit_b1_17) / (1 + exp(logit_b1_17)));

		flagmod_b1_5 := round(((50 * ((ln((phat_b1_17 / (1 - phat_b1_17))) - ln((.126 / .874))) / ln(2))) + 700));

		flagmod_6 := if(segment = 6, flagmod_b1_5, -9999);

		phat_17 := if(segment = 6, phat_b1_17, -9999);

		logit_17 := if(segment = 6, logit_b1_17, -9999);
		
		
		flagmod_final := map(segment = 1 => flagmod,
												 segment = 2 => flagmod_2,
												 segment = 3 => flagmod_3,
												 segment = 4 => flagmod_4,
												 segment = 5 => flagmod_5,
												 segment = 6 => flagmod_6,
												 -9999);			
		

		source_D_tot :=  (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'D ,') > 0);
		source_AK_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'AK,') > 0);
		source_AM_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'AM,') > 0);
		source_CG_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'CG,') > 0);
		source_DA_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'DA,') > 0);
		source_WP_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'WP,') > 0);
		source_SL_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'SL,') > 0);
		source_EQ_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'EQ,') > 0);
		source_TU_tot := (integer)(contains_i(StringLib.StringToUpperCase(rc_sources), 'TU,') > 0);

		bureau_flag := (string)(integer)source_EQ_tot + (string)(integer)source_TU_tot;
		bureau_flag_m := Map(bureau_flag = '00' and segment=1 => 0.116091954,
												 bureau_flag = '01' and segment=1 => 0.1533477322,
												 bureau_flag = '10' and segment=1 => 0.1484928181,
												 bureau_flag = '11' and segment=1 => 0.1425520555,
												 bureau_flag = '00' and segment=2 => 0.1354166667,
												 bureau_flag = '01' and segment=2 => 0.1095890411,
												 bureau_flag = '10' and segment=2 => 0.1289636504,
												 bureau_flag = '11' and segment=2 => 0.1095596133,
												 bureau_flag = '00' and segment=3 => 0.1894313403,
												 bureau_flag = '01' and segment=3 => 0.1498559078,
												 bureau_flag = '10' and segment=3 => 0.1753063148,
												 bureau_flag = '11' and segment=3 => 0.1652360515,
												 bureau_flag = '00' and segment=4 => 0.2134078212,
												 bureau_flag = '01' and segment=4 => 0.2039355993,
												 bureau_flag = '10' and segment=4 => 0.1834144278,
												 bureau_flag = '11' and segment=4 => 0.1710487733,
												 bureau_flag = '00' and segment=5 => 0.2052023121,
												 bureau_flag = '01' and segment=5 => 0.1587301587,
												 bureau_flag = '10' and segment=5 => 0.2077871002,
												 bureau_flag = '11' and segment=5 => 0.1844222723,
												 bureau_flag = '00' and segment=6 => 0.2455334354,
												 bureau_flag = '01' and segment=6 => 0.2280701754,
												 bureau_flag = '10' and segment=6 => 0.2711124961,
												 bureau_flag = '11' and segment=6 => 0.3200589195,
												 -9999);


		rare_sources := (integer)((source_ak_tot > 0) OR ((source_am_tot > 0) OR ((source_cg_tot > 0) OR (source_da_tot > 0))));

		anomaly_rare_source := (integer)(rare_sources > 0);

		positive_sources := sum(source_d_tot, source_wp_tot, source_em_tot, source_sl_tot, source_v_tot, rare_sources);

    positive_sources_c := Map(segment=1 => min(positive_sources,1),
															segment in [2,5,6] => min(positive_sources,2),
                              segment in [3,4] => min(positive_sources,3),
															-9999);

    positive_sources_c_m := Map(positive_sources_c =0 and segment=1 => 0.1389590702,
																positive_sources_c =1 and segment=1 => 0.1664994985,
																positive_sources_c =0 and segment=2 => 0.1265604821,
																positive_sources_c =1 and segment=2 => 0.1232876712,
																positive_sources_c =2 and segment=2 => 0.1785714286,
																positive_sources_c =0 and segment=3 => 0.1669908062,
																positive_sources_c =1 and segment=3 => 0.1880093132,
																positive_sources_c =2 and segment=3 => 0.2387351779,
																positive_sources_c =3 and segment=3 => 0.2781690141,
																positive_sources_c =0 and segment=4 => 0.1649442341,
																positive_sources_c =1 and segment=4 => 0.1741104294,
																positive_sources_c =2 and segment=4 => 0.1796598754,
																positive_sources_c =3 and segment=4 => 0.2064005753,
																positive_sources_c =0 and segment=5 => 0.1811012332,
																positive_sources_c =1 and segment=5 => 0.1843636936,
																positive_sources_c =2 and segment=5 => 0.2123209532,
																positive_sources_c =0 and segment=6 => 0.2855852239,
																positive_sources_c =1 and segment=6 => 0.3112128146,
																positive_sources_c =2 and segment=6 => 0.3277081524,
																-9999);


// NO TRIPLE SUM
		// nonbureau_sources_count := sum(dl_count, v_count, em_count, w_count);
		// bureau_sources_count := sum(eq_count, tu_count);
		// total_count := sum(nonbureau_sources_count, bureau_sources_count, pr_count);
		
		nonbureau_sources_count := dl_count + v_count + em_count + w_count;
		bureau_sources_count := eq_count + tu_count;
		total_count := nonbureau_sources_count + bureau_sources_count + pr_count;		

    fy4 := (integer)((STRING)adl_EQ_first_seen)[1..4];
    fm4 := (integer)((STRING)adl_EQ_first_seen)[5..6];

		fd4 := 1;

		fm4_2 :=  if(fm4 = 0, 1, fm4);


		EQ_years := if((integer)adl_EQ_first_seen > 0, 
										(integer)((mdy(tm_2, td, ty) - mdy(fm4_2, fd4, fy4)) / 365.25),
										0);

		fy5 := (integer)((STRING)adl_tu_first_seen)[1..4];

		fm5 := (integer)((STRING)adl_tu_first_seen)[5..6];

		fd5 := 1;

		fm5_2 :=  if(fm5 = 0, 1, fm5);


		TU_years := if((integer)adl_tu_first_seen > 0, 
										(integer)((mdy(tm_2, td, ty) - mdy(fm5_2, fd5, fy5)) / 365.25),
										0);

		fy6 := (integer)((STRING)adl_dl_first_seen)[1..4];

		fm6 := (integer)((STRING)adl_dl_first_seen)[5..6];

		fd6 := 1;

		fm6_2 :=  if(fm6 = 0, 1, fm6);


		DL_years := if((integer)adl_dl_first_seen > 0,
										(integer)((mdy(tm_2, td, ty) - mdy(fm6_2, fd6, fy6)) / 365.25),
										0);

		fy7 := (integer)((STRING)adl_pr_first_seen)[1..4];

		fm7 := (integer)((STRING)adl_pr_first_seen)[5..6];

		fd7 := 1;

		fm7_2 :=  if(fm7 = 0, 1, fm7);


		PR_years := if((integer)adl_pr_first_seen > 0,
										(integer)((mdy(tm_2, td, ty) - mdy(fm7_2, fd7, fy7)) / 365.25),
										0);

		fy8 := (integer)((STRING)adl_v_first_seen)[1..4];

		fm8 := (integer)((STRING)adl_v_first_seen)[5..6];

		fd8 := 1;

		fm8_2 :=  if(fm8 = 0, 1, fm8);


		V_years := if((integer)adl_v_first_seen > 0,
									(integer)((mdy(tm_2, td, ty) - mdy(fm8_2, fd8, fy8)) / 365.25),
									0);

		fy9 := (integer)((STRING)adl_em_first_seen)[1..4];

		fm9 := (integer)((STRING)adl_em_first_seen)[5..6];

		fd9 := 1;

		fm9_2 :=  if(fm9 = 0, 1, fm9);


		EM_years := if((integer)adl_em_first_seen > 0,
									 (integer)((mdy(tm_2, td, ty) - mdy(fm9_2, fd9, fy9)) / 365.25),
									 0);

		fy10 := (integer)((STRING)adl_w_first_seen)[1..4];

		fm10 := (integer)((STRING)adl_w_first_seen)[5..6];

		fd10 := 1;

		fm10_2 :=  if(fm10 = 0, 1, fm10);


		W_years := if((integer)adl_w_first_seen > 0, 
									(integer)((mdy(tm_2, td, ty) - mdy(fm10_2, fd10, fy10)) / 365.25),
									0);

		oldest_source := max(eq_years, tu_years, dl_years, pr_years, v_years, em_years, w_years);

		source_density :=  if(oldest_source > 0, (total_count / oldest_source), 0);

		source_density_c :=  map(source_density > 0 and source_density <= 0.5 => 1,
														 source_density > 0.5 and source_density <= 1 => 2,
														 source_density > 1 and source_density <= 2   => 3,
														 source_density > 2    									      => 4,
																											                      -1);

		log_source_density :=  if(source_density > 0, ln(source_density), 0);

		
    source_density_c_m := Map(source_density_c =-1 and segment=1 => 0.1232394366,
														  source_density_c =1  and segment=1 => 0.1280397022 ,
														  source_density_c =2  and segment=1 => 0.1415270019 ,
														  source_density_c =3  and segment=1 => 0.1458612975 ,
														  source_density_c =4  and segment=1 => 0.2032229185 ,
															source_density_c =-1 and segment=2 => 0.1264641652 ,
															source_density_c =1  and segment=2 => 0.1244493392 ,
															source_density_c =2  and segment=2 => 0.128959276 ,
															source_density_c =3  and segment=2 => 0.1305220884 ,
															source_density_c =4  and segment=2 => 0.1550387597 ,
															source_density_c =-1 and segment=3 => 0.1734681877 ,
															source_density_c =1  and segment=3 => 0.1660323501 ,
															source_density_c =2  and segment=3 => 0.1853727145 ,
															source_density_c =3  and segment=3 => 0.196538937 ,
															source_density_c =4  and segment=3 => 0.2215799615 ,
															source_density_c =-1 and segment=4 => 0.210982659 ,
															source_density_c =1  and segment=4 => 0.1902522445 ,
															source_density_c =2  and segment=4 => 0.1675311203 ,
															source_density_c =3  and segment=4 => 0.1733626857 ,
															source_density_c =4  and segment=4 => 0.1818862275 ,
															source_density_c =-1 and segment=5 => 0.2243589744 ,
															source_density_c =1  and segment=5 => 0.1493848858 ,
															source_density_c =2  and segment=5 => 0.1743936138 ,
															source_density_c =3  and segment=5 => 0.1832759235 ,
															source_density_c =4  and segment=5 => 0.2119666625 ,
															source_density_c =-1 and segment=6 => 0.2517662171 ,
															source_density_c =1  and segment=6 => 0.27079566 ,
															source_density_c =2  and segment=6 => 0.304735376 ,
															source_density_c =3  and segment=6 => 0.3136825987 ,
															source_density_c =4  and segment=6 => 0.3226628444 ,
															-9999);

	 
	 
   //***SSN/DOB FLAG ****;
		ssnpop := ((integer)ssnlength = 9);

		sd_flag := (string)(integer)ssnpop + (string)(integer)dobpop;

	  sd_flag_m := Map(sd_flag = '00' and segment=1 => 0.1143270622,
										 sd_flag = '01' and segment=1 => 0.1156626506 ,
										 sd_flag = '10' and segment=1 => 0.1470980019 ,
										 sd_flag = '11' and segment=1 => 0.153382026 ,
										 sd_flag = '00' and segment=2 => 0.14066918 ,
										 sd_flag = '01' and segment=2 => 0.119047619 ,
										 sd_flag = '10' and segment=2 => 0.1140981557 ,
										 sd_flag = '11' and segment=2 => 0.1331300813 ,
										 sd_flag = '00' and segment=3 => 0.1695387734 ,
										 sd_flag = '01' and segment=3 => 0.2035214915 ,
										 sd_flag = '10' and segment=3 => 0.1765047641 ,
										 sd_flag = '11' and segment=3 => 0.1846747519 ,
										 sd_flag = '00' and segment=4 => 0.1584938704 ,
										 sd_flag = '01' and segment=4 => 0.1803713528 ,
										 sd_flag = '10' and segment=4 => 0.1645153126 ,
										 sd_flag = '11' and segment=4 => 0.1781184191 ,
										 sd_flag = '00' and segment=5 => 0.1606714628 ,
										 sd_flag = '01' and segment=5 => 0.1719383617 ,
										 sd_flag = '10' and segment=5 => 0.1972453664 ,
										 sd_flag = '11' and segment=5 => 0.1973551147 ,
										 sd_flag = '00' and segment=6 => 0.2574438846 ,
										 sd_flag = '01' and segment=6 => 0.2292768959 ,
										 sd_flag = '10' and segment=6 => 0.2695547533 ,
										 sd_flag = '11' and segment=6 => 0.3209382769 ,
										 -9999);



		dl_flag := (source_d_tot > 0);

		dl_flag_2 :=  if(dl_avail != 1, -1, (integer)dl_flag);

		anomaly_no_DL_info := (integer)(dl_flag_2 = 0);

		util_flag := (integer)((rc_utiliaddr_lnamecount > 0) OR ((rc_utiliaddr_addrcount > 0) OR (rc_utiliaddr_phonecount > 0)));

		anomaly_no_UTIL_info := (integer)(util_flag = 0);

		logit_b1_18 := -3.368941319 +
				(anomaly_no_dl_info * -0.147057416) +
				(anomaly_no_util_info * 0.1403901523) +
				(sd_flag_m * 4.4800455484) +
				(source_density_c_m * 6.2531690195);

		phat_b1_18 := (exp(logit_b1_18) / (1 + exp(logit_b1_18)));

		sourcemod_b1 := round(((50 * ((ln((phat_b1_18 / (1 - phat_b1_18))) - ln((.126 / .874))) / ln(2))) + 700));

		sourcemod := if(segment = 1, sourcemod_b1, -9999);

		phat_18 := if(segment = 1, phat_b1_18, -9999);

		logit_18 := if(segment = 1, logit_b1_18, -9999);

		logit_b1_19 := -6.47427706 +
				(anomaly_no_util_info * 0.1644160594) +
				(anomaly_rare_source * 1.0750004931) +
				(positive_sources_c_m * 6.6135416952) +
				(bureau_flag_m * 9.7389008331) +
				(sd_flag_m * 9.1849001688) +
				(source_density_c_m * 9.539503406);

		phat_b1_19 := (exp(logit_b1_19) / (1 + exp(logit_b1_19)));

		sourcemod_b1_2 := round(((50 * ((ln((phat_b1_19 / (1 - phat_b1_19))) - ln((.126 / .874))) / ln(2))) + 700));

		sourcemod_2 := if(segment = 2, sourcemod_b1_2, -9999);

		phat_19 := if(segment = 2, phat_b1_19, -9999);

		logit_19 := if(segment = 2, logit_b1_19, -9999);

		logit_b1_20 := -3.741362546 +
				(anomaly_no_dl_info * -0.162023979) +
				(anomaly_no_util_info * 0.2224875926) +
				(anomaly_rare_source * 0.5701959528) +
				(positive_sources_c_m * 4.1638732336) +
				(bureau_flag_m * 4.6588105555) +
				(source_density_c_m * 3.5872329291);

		phat_b1_20 := (exp(logit_b1_20) / (1 + exp(logit_b1_20)));

		sourcemod_b1_3 := round(((50 * ((ln((phat_b1_20 / (1 - phat_b1_20))) - ln((.126 / .874))) / ln(2))) + 700));

		sourcemod_3 := if(segment = 3, sourcemod_b1_3, -9999);

		phat_20 := if(segment = 3, phat_b1_20, -9999);

		logit_20 := if(segment = 3, logit_b1_20, -9999);

		logit_b1_21 := -5.43631731 +
				(anomaly_no_dl_info * -0.111345582) +
				(anomaly_no_util_info * 0.1622931951) +
				(positive_sources_c_m * 5.1618724811) +
				(bureau_flag_m * 5.8704669008) +
				(sd_flag_m * 6.1058324941) +
				(source_density_c_m * 4.8559467781);

		phat_b1_21 := (exp(logit_b1_21) / (1 + exp(logit_b1_21)));

		sourcemod_b1_4 := round(((50 * ((ln((phat_b1_21 / (1 - phat_b1_21))) - ln((.126 / .874))) / ln(2))) + 700));

		sourcemod_4 := if(segment = 4, sourcemod_b1_4, -9999);

		phat_21 := if(segment = 4, phat_b1_21, -9999);

		logit_21 := if(segment = 4, logit_b1_21, -9999);

		logit_b1_22 := -6.292967291 +
				(anomaly_no_dl_info * -0.079727524) +
				(anomaly_no_util_info * 0.1940135511) +
				(anomaly_rare_source * 0.4654453943) +
				(positive_sources_c_m * 5.2124282892) +
				(bureau_flag_m * 5.9314520496) +
				(sd_flag_m * 8.8109662812) +
				(source_density_c_m * 4.9524214253);

		phat_b1_22 := (exp(logit_b1_22) / (1 + exp(logit_b1_22)));

		sourcemod_b1_5 := round(((50 * ((ln((phat_b1_22 / (1 - phat_b1_22))) - ln((.126 / .874))) / ln(2))) + 700));

		sourcemod_5 := if(segment = 5, sourcemod_b1_5, -9999);

		phat_22 := if(segment = 5, phat_b1_22, -9999);

		logit_22 := if(segment = 5, logit_b1_22, -9999);

		logit_b1_23 := -2.203127566 +
				(anomaly_no_dl_info * -0.286655249) +
				(anomaly_no_util_info * 0.221736625) +
				(anomaly_rare_source * 0.5110833737) +
				(bureau_flag_m * 2.041822169) +
				((integer)rc_watchlist_flag * -0.467324586) +
				(sd_flag_m * 2.3744546771) +
				(log_source_density * 0.069271706);

		phat_b1_23 := (exp(logit_b1_23) / (1 + exp(logit_b1_23)));

		sourcemod_b1_6 := round(((50 * ((ln((phat_b1_23 / (1 - phat_b1_23))) - ln((.126 / .874))) / ln(2))) + 700));

		sourcemod_6 := if(segment = 6, sourcemod_b1_6, -9999);

		phat_23 := if(segment = 6, phat_b1_23, -9999);

		logit_23 := if(segment = 6, logit_b1_23, -9999);
		
		sourcemod_final := map(segment = 1 => sourcemod,
														segment = 2 => sourcemod_2,
														segment = 3 => sourcemod_3,
														segment = 4 => sourcemod_4,
														segment = 5 => sourcemod_5,
														segment = 6 => sourcemod_6,
														-9999);

  //***ADDRESSMOD ****;

   //***ADDRESS ISSUES ****;
   //***home value quartile ***;
		add1_home_quartile :=  map(add1_census_home_value <= 5000   => -1,
															 add1_census_home_value <= 53443  => 1,
															 add1_census_home_value <= 75741  => 2,
															 add1_census_home_value <= 112827 => 3,
																																	 4);

	  add1_home_quartile_m := Map(add1_home_quartile =-1 and segment=1 => 0.1530172414,
																add1_home_quartile =1  and segment=1 => 0.1306868867 ,
																add1_home_quartile =2  and segment=1 => 0.1203501094 ,
																add1_home_quartile =3  and segment=1 => 0.1526446574 ,
																add1_home_quartile =4  and segment=1 => 0.1527224436 ,
																add1_home_quartile =-1 and segment=2 => 0.0760869565 ,
																add1_home_quartile =1  and segment=2 => 0.1134081512 ,
																add1_home_quartile =2  and segment=2 => 0.1329837941 ,
																add1_home_quartile =3  and segment=2 => 0.1183087665 ,
																add1_home_quartile =4  and segment=2 => 0.135412844 ,
																add1_home_quartile =-1 and segment=3 => 0.1568627451 ,
																add1_home_quartile =1  and segment=3 => 0.1484523057 ,
																add1_home_quartile =2  and segment=3 => 0.1542795814 ,
																add1_home_quartile =3  and segment=3 => 0.184595525 ,
																add1_home_quartile =4  and segment=3 => 0.2053206003 ,
																add1_home_quartile =-1 and segment=4 => 0.168241966 ,
																add1_home_quartile =1  and segment=4 => 0.1457367107 ,
																add1_home_quartile =2  and segment=4 => 0.1667186039 ,
																add1_home_quartile =3  and segment=4 => 0.1834639287 ,
																add1_home_quartile =4  and segment=4 => 0.1986229606 ,
																add1_home_quartile =-1 and segment=5 => 0.2252252252 ,
																add1_home_quartile =1  and segment=5 => 0.1526287554 ,
																add1_home_quartile =2  and segment=5 => 0.1758087201 ,
																add1_home_quartile =3  and segment=5 => 0.1968085106 ,
																add1_home_quartile =4  and segment=5 => 0.2246376812 ,
																add1_home_quartile =-1 and segment=6 => 0.2853333333 ,
																add1_home_quartile =1  and segment=6 => 0.2321336761 ,
																add1_home_quartile =2  and segment=6 => 0.2802046438 ,
																add1_home_quartile =3  and segment=6 => 0.3115902965 ,
																add1_home_quartile =4  and segment=6 => 0.3471317235 ,
																-9999);


		num_addresses := 0;

		num_addresses_2 :=  if((string)add1_date_first_seen != '0', (num_addresses + 1), num_addresses);

		num_addresses_3 :=  if((string)add2_date_first_seen != '0', (num_addresses_2 + 1), num_addresses_2);

		num_addresses_4 :=  if((string)add3_date_first_seen != '0', (num_addresses_3 + 1), num_addresses_3);

		most_recent_address :=  map((add1_months_residence = min_residence) and (min_residence >= 0) => 1,
																(add2_months_residence = min_residence) and (min_residence >= 0) => 2,
																(add3_months_residence = min_residence) and (min_residence >= 0) => 3,
																																																	0);

		least_recent_address :=  map(add3_months_residence = max_residence                         => 3,
																 (add2_months_residence = max_residence) and (max_residence > 0) => 2,
																 (add1_months_residence = max_residence) and (min_residence > 0) => 1,
																																																	0);

		second_most_recent_address := 0;

		second_most_recent_address_b1_c2_b1 := least_recent_address;

		second_most_recent_address_b1_c2_b2_c3_b1 := 1;

		second_most_recent_address_b1_c2_b2_c3_b2 := 2;

		second_most_recent_address_b1_c2_b2_c3_b3 := 3;

		second_most_recent_address_b1_c2_b2 := map((most_recent_address != 1) and (least_recent_address != 1) => second_most_recent_address_b1_c2_b2_c3_b1,
																							 (most_recent_address != 2) and (least_recent_address != 2) => second_most_recent_address_b1_c2_b2_c3_b2,
																							 (most_recent_address != 3) and (least_recent_address != 3) => second_most_recent_address_b1_c2_b2_c3_b3,
																																																					 second_most_recent_address);

		second_most_recent_address_b1 := if(num_addresses_4 = 2, second_most_recent_address_b1_c2_b1, second_most_recent_address_b1_c2_b2);

		second_most_recent_address_2 := if(num_addresses_4 > 1, second_most_recent_address_b1, -9999);

		add1_home_quantile :=  map(add1_census_home_value <= 5000   => -1,
															 add1_census_home_value <= 16087  => 1,
															 add1_census_home_value <= 22500  => 2,
															 add1_census_home_value <= 28246  => 3,
															 add1_census_home_value <= 30482  => 4,
															 add1_census_home_value <= 32188  => 5,
															 add1_census_home_value <= 33796  => 6,
															 add1_census_home_value <= 35161  => 7,
															 add1_census_home_value <= 36500  => 8,
															 add1_census_home_value <= 37670  => 9,
															 add1_census_home_value <= 38621  => 10,
															 add1_census_home_value <= 39841  => 11,
															 add1_census_home_value <= 41429  => 12,
															 add1_census_home_value <= 42703  => 13,
															 add1_census_home_value <= 43846  => 14,
															 add1_census_home_value <= 44884  => 15,
															 add1_census_home_value <= 45963  => 16,
															 add1_census_home_value <= 46939  => 17,
															 add1_census_home_value <= 47778  => 18,
															 add1_census_home_value <= 48729  => 19,
															 add1_census_home_value <= 49506  => 20,
															 add1_census_home_value <= 50114  => 21,
															 add1_census_home_value <= 51053  => 22,
															 add1_census_home_value <= 51860  => 23,
															 add1_census_home_value <= 52576  => 24,
															 add1_census_home_value <= 53443  => 25,
															 add1_census_home_value <= 54194  => 26,
															 add1_census_home_value <= 55000  => 27,
															 add1_census_home_value <= 55968  => 28,
															 add1_census_home_value <= 56869  => 29,
															 add1_census_home_value <= 57800  => 30,
															 add1_census_home_value <= 58563  => 31,
															 add1_census_home_value <= 59538  => 32,
															 add1_census_home_value <= 60500  => 33,
															 add1_census_home_value <= 61449  => 34,
															 add1_census_home_value <= 62520  => 35,
															 add1_census_home_value <= 63509  => 36,
															 add1_census_home_value <= 64302  => 37,
															 add1_census_home_value <= 65106  => 38,
															 add1_census_home_value <= 65889  => 39,
															 add1_census_home_value <= 67000  => 40,
															 add1_census_home_value <= 67875  => 41,
															 add1_census_home_value <= 68696  => 42,
															 add1_census_home_value <= 69592  => 43,
															 add1_census_home_value <= 70135  => 44,
															 add1_census_home_value <= 70893  => 45,
															 add1_census_home_value <= 71831  => 46,
															 add1_census_home_value <= 72706  => 47,
															 add1_census_home_value <= 73750  => 48,
															 add1_census_home_value <= 74667  => 49,
															 add1_census_home_value <= 75741  => 50,
															 add1_census_home_value <= 76875  => 51,
															 add1_census_home_value <= 78067  => 52,
															 add1_census_home_value <= 79333  => 53,
															 add1_census_home_value <= 80500  => 54,
															 add1_census_home_value <= 81783  => 55,
															 add1_census_home_value <= 82803  => 56,
															 add1_census_home_value <= 84311  => 57,
															 add1_census_home_value <= 85376  => 58,
															 add1_census_home_value <= 86497  => 59,
															 add1_census_home_value <= 87625  => 60,
															 add1_census_home_value <= 88889  => 61,
															 add1_census_home_value <= 89867  => 62,
															 add1_census_home_value <= 90781  => 63,
															 add1_census_home_value <= 92085  => 64,
															 add1_census_home_value <= 93478  => 65,
															 add1_census_home_value <= 95000  => 66,
															 add1_census_home_value <= 96559  => 67,
															 add1_census_home_value <= 98045  => 68,
															 add1_census_home_value <= 99759  => 69,
															 add1_census_home_value <= 102344 => 70,
															 add1_census_home_value <= 104891 => 71,
															 add1_census_home_value <= 106585 => 72,
															 add1_census_home_value <= 108828 => 73,
															 add1_census_home_value <= 110897 => 74,
															 add1_census_home_value <= 112827 => 75,
															 add1_census_home_value <= 115046 => 76,
															 add1_census_home_value <= 117170 => 77,
															 add1_census_home_value <= 119569 => 78,
															 add1_census_home_value <= 122532 => 79,
															 add1_census_home_value <= 125980 => 80,
															 add1_census_home_value <= 129337 => 81,
															 add1_census_home_value <= 132378 => 82,
															 add1_census_home_value <= 135923 => 83,
															 add1_census_home_value <= 138964 => 84,
															 add1_census_home_value <= 143243 => 85,
															 add1_census_home_value <= 147105 => 86,
															 add1_census_home_value <= 151613 => 87,
															 add1_census_home_value <= 156136 => 88,
															 add1_census_home_value <= 161830 => 89,
															 add1_census_home_value <= 168491 => 90,
															 add1_census_home_value <= 174063 => 91,
															 add1_census_home_value <= 182000 => 92,
															 add1_census_home_value <= 192056 => 93,
															 add1_census_home_value <= 203409 => 94,
															 add1_census_home_value <= 221667 => 95,
															 add1_census_home_value <= 245455 => 96,
															 add1_census_home_value <= 274679 => 97,
															 add1_census_home_value <= 323810 => 98,
															 add1_census_home_value <= 407143 => 99,
																																	 100);

		add2_home_quantile :=  map(add2_census_home_value <= 5000   => -1,
															 add2_census_home_value <= 16087  => 1,
															 add2_census_home_value <= 22500  => 2,
															 add2_census_home_value <= 28246  => 3,
															 add2_census_home_value <= 30482  => 4,
															 add2_census_home_value <= 32188  => 5,
															 add2_census_home_value <= 33796  => 6,
															 add2_census_home_value <= 35161  => 7,
															 add2_census_home_value <= 36500  => 8,
															 add2_census_home_value <= 37670  => 9,
															 add2_census_home_value <= 38621  => 10,
															 add2_census_home_value <= 39841  => 11,
															 add2_census_home_value <= 41429  => 12,
															 add2_census_home_value <= 42703  => 13,
															 add2_census_home_value <= 43846  => 14,
															 add2_census_home_value <= 44884  => 15,
															 add2_census_home_value <= 45963  => 16,
															 add2_census_home_value <= 46939  => 17,
															 add2_census_home_value <= 47778  => 18,
															 add2_census_home_value <= 48729  => 19,
															 add2_census_home_value <= 49506  => 20,
															 add2_census_home_value <= 50114  => 21,
															 add2_census_home_value <= 51053  => 22,
															 add2_census_home_value <= 51860  => 23,
															 add2_census_home_value <= 52576  => 24,
															 add2_census_home_value <= 53443  => 25,
															 add2_census_home_value <= 54194  => 26,
															 add2_census_home_value <= 55000  => 27,
															 add2_census_home_value <= 55968  => 28,
															 add2_census_home_value <= 56869  => 29,
															 add2_census_home_value <= 57800  => 30,
															 add2_census_home_value <= 58563  => 31,
															 add2_census_home_value <= 59538  => 32,
															 add2_census_home_value <= 60500  => 33,
															 add2_census_home_value <= 61449  => 34,
															 add2_census_home_value <= 62520  => 35,
															 add2_census_home_value <= 63509  => 36,
															 add2_census_home_value <= 64302  => 37,
															 add2_census_home_value <= 65106  => 38,
															 add2_census_home_value <= 65889  => 39,
															 add2_census_home_value <= 67000  => 40,
															 add2_census_home_value <= 67875  => 41,
															 add2_census_home_value <= 68696  => 42,
															 add2_census_home_value <= 69592  => 43,
															 add2_census_home_value <= 70135  => 44,
															 add2_census_home_value <= 70893  => 45,
															 add2_census_home_value <= 71831  => 46,
															 add2_census_home_value <= 72706  => 47,
															 add2_census_home_value <= 73750  => 48,
															 add2_census_home_value <= 74667  => 49,
															 add2_census_home_value <= 75741  => 50,
															 add2_census_home_value <= 76875  => 51,
															 add2_census_home_value <= 78067  => 52,
															 add2_census_home_value <= 79333  => 53,
															 add2_census_home_value <= 80500  => 54,
															 add2_census_home_value <= 81783  => 55,
															 add2_census_home_value <= 82803  => 56,
															 add2_census_home_value <= 84311  => 57,
															 add2_census_home_value <= 85376  => 58,
															 add2_census_home_value <= 86497  => 59,
															 add2_census_home_value <= 87625  => 60,
															 add2_census_home_value <= 88889  => 61,
															 add2_census_home_value <= 89867  => 62,
															 add2_census_home_value <= 90781  => 63,
															 add2_census_home_value <= 92085  => 64,
															 add2_census_home_value <= 93478  => 65,
															 add2_census_home_value <= 95000  => 66,
															 add2_census_home_value <= 96559  => 67,
															 add2_census_home_value <= 98045  => 68,
															 add2_census_home_value <= 99759  => 69,
															 add2_census_home_value <= 102344 => 70,
															 add2_census_home_value <= 104891 => 71,
															 add2_census_home_value <= 106585 => 72,
															 add2_census_home_value <= 108828 => 73,
															 add2_census_home_value <= 110897 => 74,
															 add2_census_home_value <= 112827 => 75,
															 add2_census_home_value <= 115046 => 76,
															 add2_census_home_value <= 117170 => 77,
															 add2_census_home_value <= 119569 => 78,
															 add2_census_home_value <= 122532 => 79,
															 add2_census_home_value <= 125980 => 80,
															 add2_census_home_value <= 129337 => 81,
															 add2_census_home_value <= 132378 => 82,
															 add2_census_home_value <= 135923 => 83,
															 add2_census_home_value <= 138964 => 84,
															 add2_census_home_value <= 143243 => 85,
															 add2_census_home_value <= 147105 => 86,
															 add2_census_home_value <= 151613 => 87,
															 add2_census_home_value <= 156136 => 88,
															 add2_census_home_value <= 161830 => 89,
															 add2_census_home_value <= 168491 => 90,
															 add2_census_home_value <= 174063 => 91,
															 add2_census_home_value <= 182000 => 92,
															 add2_census_home_value <= 192056 => 93,
															 add2_census_home_value <= 203409 => 94,
															 add2_census_home_value <= 221667 => 95,
															 add2_census_home_value <= 245455 => 96,
															 add2_census_home_value <= 274679 => 97,
															 add2_census_home_value <= 323810 => 98,
															 add2_census_home_value <= 407143 => 99,
																																	 100);

		add3_home_quantile :=  map(add3_census_home_value <= 5000   => -1,
															 add3_census_home_value <= 16087  => 1,
															 add3_census_home_value <= 22500  => 2,
															 add3_census_home_value <= 28246  => 3,
															 add3_census_home_value <= 30482  => 4,
															 add3_census_home_value <= 32188  => 5,
															 add3_census_home_value <= 33796  => 6,
															 add3_census_home_value <= 35161  => 7,
															 add3_census_home_value <= 36500  => 8,
															 add3_census_home_value <= 37670  => 9,
															 add3_census_home_value <= 38621  => 10,
															 add3_census_home_value <= 39841  => 11,
															 add3_census_home_value <= 41429  => 12,
															 add3_census_home_value <= 42703  => 13,
															 add3_census_home_value <= 43846  => 14,
															 add3_census_home_value <= 44884  => 15,
															 add3_census_home_value <= 45963  => 16,
															 add3_census_home_value <= 46939  => 17,
															 add3_census_home_value <= 47778  => 18,
															 add3_census_home_value <= 48729  => 19,
															 add3_census_home_value <= 49506  => 20,
															 add3_census_home_value <= 50114  => 21,
															 add3_census_home_value <= 51053  => 22,
															 add3_census_home_value <= 51860  => 23,
															 add3_census_home_value <= 52576  => 24,
															 add3_census_home_value <= 53443  => 25,
															 add3_census_home_value <= 54194  => 26,
															 add3_census_home_value <= 55000  => 27,
															 add3_census_home_value <= 55968  => 28,
															 add3_census_home_value <= 56869  => 29,
															 add3_census_home_value <= 57800  => 30,
															 add3_census_home_value <= 58563  => 31,
															 add3_census_home_value <= 59538  => 32,
															 add3_census_home_value <= 60500  => 33,
															 add3_census_home_value <= 61449  => 34,
															 add3_census_home_value <= 62520  => 35,
															 add3_census_home_value <= 63509  => 36,
															 add3_census_home_value <= 64302  => 37,
															 add3_census_home_value <= 65106  => 38,
															 add3_census_home_value <= 65889  => 39,
															 add3_census_home_value <= 67000  => 40,
															 add3_census_home_value <= 67875  => 41,
															 add3_census_home_value <= 68696  => 42,
															 add3_census_home_value <= 69592  => 43,
															 add3_census_home_value <= 70135  => 44,
															 add3_census_home_value <= 70893  => 45,
															 add3_census_home_value <= 71831  => 46,
															 add3_census_home_value <= 72706  => 47,
															 add3_census_home_value <= 73750  => 48,
															 add3_census_home_value <= 74667  => 49,
															 add3_census_home_value <= 75741  => 50,
															 add3_census_home_value <= 76875  => 51,
															 add3_census_home_value <= 78067  => 52,
															 add3_census_home_value <= 79333  => 53,
															 add3_census_home_value <= 80500  => 54,
															 add3_census_home_value <= 81783  => 55,
															 add3_census_home_value <= 82803  => 56,
															 add3_census_home_value <= 84311  => 57,
															 add3_census_home_value <= 85376  => 58,
															 add3_census_home_value <= 86497  => 59,
															 add3_census_home_value <= 87625  => 60,
															 add3_census_home_value <= 88889  => 61,
															 add3_census_home_value <= 89867  => 62,
															 add3_census_home_value <= 90781  => 63,
															 add3_census_home_value <= 92085  => 64,
															 add3_census_home_value <= 93478  => 65,
															 add3_census_home_value <= 95000  => 66,
															 add3_census_home_value <= 96559  => 67,
															 add3_census_home_value <= 98045  => 68,
															 add3_census_home_value <= 99759  => 69,
															 add3_census_home_value <= 102344 => 70,
															 add3_census_home_value <= 104891 => 71,
															 add3_census_home_value <= 106585 => 72,
															 add3_census_home_value <= 108828 => 73,
															 add3_census_home_value <= 110897 => 74,
															 add3_census_home_value <= 112827 => 75,
															 add3_census_home_value <= 115046 => 76,
															 add3_census_home_value <= 117170 => 77,
															 add3_census_home_value <= 119569 => 78,
															 add3_census_home_value <= 122532 => 79,
															 add3_census_home_value <= 125980 => 80,
															 add3_census_home_value <= 129337 => 81,
															 add3_census_home_value <= 132378 => 82,
															 add3_census_home_value <= 135923 => 83,
															 add3_census_home_value <= 138964 => 84,
															 add3_census_home_value <= 143243 => 85,
															 add3_census_home_value <= 147105 => 86,
															 add3_census_home_value <= 151613 => 87,
															 add3_census_home_value <= 156136 => 88,
															 add3_census_home_value <= 161830 => 89,
															 add3_census_home_value <= 168491 => 90,
															 add3_census_home_value <= 174063 => 91,
															 add3_census_home_value <= 182000 => 92,
															 add3_census_home_value <= 192056 => 93,
															 add3_census_home_value <= 203409 => 94,
															 add3_census_home_value <= 221667 => 95,
															 add3_census_home_value <= 245455 => 96,
															 add3_census_home_value <= 274679 => 97,
															 add3_census_home_value <= 323810 => 98,
															 add3_census_home_value <= 407143 => 99,
																																	 100);

		recent_quantile :=  map(most_recent_address = 1 => add1_home_quantile,
														most_recent_address = 2 => add2_home_quantile,
														most_recent_address = 3 => add3_home_quantile,
														-9999);

		second_recent_quantile :=  map(second_most_recent_address_2 = 1 => add1_home_quantile,
																	 second_most_recent_address_2 = 2 => add2_home_quantile,
																	 second_most_recent_address_2 = 3 => add3_home_quantile,
																	 -9999);

		mover_quantile := (recent_quantile - second_recent_quantile);
	 
	  mover_status_tmp := Map(mover_quantile >= -10 and mover_quantile <= 10 => 0,
													  mover_quantile > 10 and mover_quantile <= 25   => 1,
													  mover_quantile > 25                            => 2,
													  mover_quantile < -10 and mover_quantile >= -25 => -1,
													  mover_quantile < -25                           => -2,
														0);
														
		mover_status := if(num_addresses_4 < 2, -99, mover_status_tmp);
		
	 
	  mover_status_m := Map(mover_status =-2 and segment=1 => 0.1380897583 ,
													mover_status =-1 and segment=1 => 0.1477104874 ,
													mover_status =0  and segment=1 => 0.1593385945 ,
													mover_status =1  and segment=1 => 0.1714285714 ,
													mover_status =2  and segment=1 => 0.1606519208 ,
													mover_status =-2 and segment=2 => 0.15625 ,
													mover_status =-1 and segment=2 => 0.1102362205 ,
													mover_status =0  and segment=2 => 0.1307106599 ,
													mover_status =1  and segment=2 => 0.1697247706 ,
													mover_status =2  and segment=2 => 0.0962732919 ,
																							 segment=3 => 0,
													mover_status =-2 and segment=4 => 0.1723350254 ,
													mover_status =-1 and segment=4 => 0.1766513057 ,
													mover_status =0  and segment=4 => 0.1770776256 ,
													mover_status =1  and segment=4 => 0.1737674985 ,
													mover_status =2  and segment=4 => 0.1638965836 ,
													mover_status =-2 and segment=5 => 0.1880122951 ,
													mover_status =-1 and segment=5 => 0.1966542751 ,
													mover_status =0  and segment=5 => 0.1959736548 ,
													mover_status =1  and segment=5 => 0.181712963 ,
													mover_status =2  and segment=5 => 0.197875166 ,
													mover_status =-2 and segment=6 => 0.2993219244 ,
													mover_status =-1 and segment=6 => 0.3098265896 ,
													mover_status =0  and segment=6 => 0.3239496694 ,
													mover_status =1  and segment=6 => 0.3208846991 ,
													mover_status =2  and segment=6 => 0.3062027231 ,
													mover_status = -99 						 => 0,
													-9999);

// dwelling type
   is_apartment := Map(rc_dwelltype='H' or out_addr_type='H' => 1,
											 trim(out_unit_desig) in ['#','APT','APTS','UNIT','STE','FL'] => 1,
											 0);

   addrs_15yr_c := Map(addrs_15yr = 0              and segment=1 => 0,
											 addrs_15yr in [1,2,3,4]     and segment=1 => 1,
											 addrs_15yr >=5              and segment=1 => 2,
											 addrs_15yr = 0              and segment=2 => 0,
											 addrs_15yr in [1,2]         and segment=2 => 1,
											 addrs_15yr in [3,4]         and segment=2 => 2,
											 addrs_15yr >=5              and segment=2 => 3,
											 addrs_15yr = 0              and segment=3 => 0,
											 addrs_15yr >=1              and segment=3 => 1,
											 addrs_15yr = 0              and segment=4 => 0,
											 addrs_15yr = 1              and segment=4 => 1,
											 addrs_15yr in [2,3,4,5,6]   and segment=4 => 2,
											 addrs_15yr >= 7             and segment=4 => 3,
											 addrs_15yr = 0              and segment=5 => 0,
											 addrs_15yr in [1,2,3]       and segment=5 => 1,
											 addrs_15yr in [4,5,6,7,8,9] and segment=5 => 2,
											 addrs_15yr >=10             and segment=5 => 3,
											 addrs_15yr in [0,1]         and segment=6 => 0,
											 addrs_15yr in [2,3,4,5]     and segment=6 => 1,
											 addrs_15yr >=6              and segment=6 => 2,
											 -9999);


   addrs_15yr_c_m := Map( addrs_15yr_c =0 and segment=1 => 0.1235194585 ,
													addrs_15yr_c =1 and segment=1 => 0.1413659794 ,
													addrs_15yr_c =2 and segment=1 => 0.1655629139 ,
													addrs_15yr_c =0 and segment=2 => 0.1352422907 ,
													addrs_15yr_c =1 and segment=2 => 0.12538325 ,
													addrs_15yr_c =2 and segment=2 => 0.1464285714 ,
													addrs_15yr_c =3 and segment=2 => 0.1111111111 ,
													addrs_15yr_c =0 and segment=3 => 0.1904481132 ,
													addrs_15yr_c =1 and segment=3 => 0.1736997056 ,
													addrs_15yr_c =0 and segment=4 => 0.222371065 ,
													addrs_15yr_c =1 and segment=4 => 0.1993464052 ,
													addrs_15yr_c =2 and segment=4 => 0.1729923629 ,
													addrs_15yr_c =3 and segment=4 => 0.1473533619 ,
													addrs_15yr_c =0 and segment=5 => 0.1609195402 ,
													addrs_15yr_c =1 and segment=5 => 0.2063077541 ,
													addrs_15yr_c =2 and segment=5 => 0.1869685374 ,
													addrs_15yr_c =3 and segment=5 => 0.1599286564 ,
													addrs_15yr_c =0 and segment=6 => 0.2935182564 ,
													addrs_15yr_c =1 and segment=6 => 0.3189395283 ,
													addrs_15yr_c =2 and segment=6 => 0.2976572529 ,
													-9999);


	  rc_addrcount_c := Map(segment in [1,2,3,4] => min(rc_addrcount,2), 
													segment in [5,6]     => min(rc_addrcount,3),
													-9999);

    rc_addrcount_c_m := Map(rc_addrcount_c =0 and segment=1 => 0.1379554298 ,
														rc_addrcount_c =1 and segment=1 => 0.1419966679 ,
														rc_addrcount_c =2 and segment=1 => 0.1641221374 ,
														rc_addrcount_c =0 and segment=2 => 0.1322849214 ,
														rc_addrcount_c =1 and segment=2 => 0.1245148771 ,
														rc_addrcount_c =2 and segment=2 => 0.1501706485 ,
														rc_addrcount_c =0 and segment=3 => 0.176096823 ,
														rc_addrcount_c =1 and segment=3 => 0.1740104556 ,
														rc_addrcount_c =2 and segment=3 => 0.2061403509 ,
														rc_addrcount_c =0 and segment=4 => 0.1864148645 ,
														rc_addrcount_c =1 and segment=4 => 0.1578507079 ,
														rc_addrcount_c =2 and segment=4 => 0.2054987212 ,
														rc_addrcount_c =0 and segment=5 => 0.2141833811 ,
														rc_addrcount_c =1 and segment=5 => 0.1861727716 ,
														rc_addrcount_c =2 and segment=5 => 0.202739726 ,
														rc_addrcount_c =3 and segment=5 => 0.2230437461 ,
														rc_addrcount_c =0 and segment=6 => 0.2804027885 ,
														rc_addrcount_c =1 and segment=6 => 0.2569905213 ,
														rc_addrcount_c =2 and segment=6 => 0.3184072126 ,
														rc_addrcount_c =3 and segment=6 => 0.3644006378 ,
														-9999);


		
		
   //***VELOCITY VARIABLES ****;		
		addrs_per_adl_gt6 := (addrs_per_adl - addrs_per_adl_c6);
		addrs_per_adl_gt6_2 := min(addrs_per_adl_gt6, 10);
		addrs_per_adl_c6_min := min(addrs_per_adl_c6, 1);
		

    addrs_per_adl_gt6_m := Map(addrs_per_adl_gt6_2 in [0,1]                  and segment=1 => 0,
															 addrs_per_adl_gt6_2 in [2,3,4,5,6,7]          and segment=1 => 1,
															 addrs_per_adl_gt6_2 in [8,9,10]               and segment=1 => 2,

															 addrs_per_adl_gt6_2 in [0]                    and segment=2 => 0,
															 addrs_per_adl_gt6_2 in [1,2,3,4]              and segment=2 => 1,
															 addrs_per_adl_gt6_2 in [5,6,7,8,9,10]         and segment=2 => 2,

															 addrs_per_adl_gt6_2 in [0]                    and segment=3 => 0,
															 addrs_per_adl_gt6_2 in [1,2,3,4,5,6,7,8,9,10] and segment=3 => 1,

															 addrs_per_adl_gt6_2 in [0,1,2,3]              and segment=4 => 0,
															 addrs_per_adl_gt6_2 in [4,5,6,7]              and segment=4 => 1,
															 addrs_per_adl_gt6_2 in [8,9,10]               and segment=4 => 2,

															 addrs_per_adl_gt6_2 in [0,1,2,3,4,5]          and segment=5 => 0,
															 addrs_per_adl_gt6_2 in [6,7,8]                and segment=5 => 1,
															 addrs_per_adl_gt6_2 in [9,10]                 and segment=5 => 2,

															 addrs_per_adl_gt6_2 in [0,1,2,3]              and segment=6 => 0,
															 addrs_per_adl_gt6_2 in [4,5,6,7,8,9]          and segment=6 => 1,
															 addrs_per_adl_gt6_2 in [10]                   and segment=6 => 2,
															 0);

	 
	  addrs_per_adl_6m := (string)(integer)addrs_per_adl_gt6_m + (string)(integer)addrs_per_adl_c6_min;
		
    addrs_per_adl_6m_m := Map(addrs_per_adl_6m = '00' and segment=1 => 0.1237756011 ,
															addrs_per_adl_6m = '01' and segment=1 => 0.1558441558 ,
															addrs_per_adl_6m = '10' and segment=1 => 0.1532352941 ,
															addrs_per_adl_6m = '11' and segment=1 => 0.1719298246 ,
															addrs_per_adl_6m = '20' and segment=1 => 0.1275327771 ,
															addrs_per_adl_6m = '21' and segment=1 => 0.1986754967 ,
															addrs_per_adl_6m = '00' and segment=2 => 0.1372093023 ,
															addrs_per_adl_6m = '01' and segment=2 => 0.1124790151 ,
															addrs_per_adl_6m = '10' and segment=2 => 0.1314332582 ,
															addrs_per_adl_6m = '11' and segment=2 => 0.1531914894 ,
															addrs_per_adl_6m = '20' and segment=2 => 0.1076923077 ,
															addrs_per_adl_6m = '21' and segment=2 => 0.0652173913 ,
															addrs_per_adl_6m = '00' and segment=3 => 0.1706364701 ,
															addrs_per_adl_6m = '01' and segment=3 => 0.1679884643 ,
															addrs_per_adl_6m = '10' and segment=3 => 0.1836343733 ,
															addrs_per_adl_6m = '11' and segment=3 => 0.1836343733 ,
															addrs_per_adl_6m = '00' and segment=4 => 0.1912810351 ,
															addrs_per_adl_6m = '01' and segment=4 => 0.2093023256 ,
															addrs_per_adl_6m = '10' and segment=4 => 0.1696173615 ,
															addrs_per_adl_6m = '11' and segment=4 => 0.1181818182 ,
															addrs_per_adl_6m = '20' and segment=4 => 0.16752693 ,
															addrs_per_adl_6m = '21' and segment=4 => 0.1270491803 ,
															addrs_per_adl_6m = '00' and segment=5 => 0.2164775897 ,
															addrs_per_adl_6m = '01' and segment=5 => 0.1919205658 ,
															addrs_per_adl_6m = '10' and segment=5 => 0.1962102689 ,
															addrs_per_adl_6m = '11' and segment=5 => 0.1789536266 ,
															addrs_per_adl_6m = '20' and segment=5 => 0.1770373344 ,
															addrs_per_adl_6m = '21' and segment=5 => 0.1759880686 ,
															addrs_per_adl_6m = '00' and segment=6 => 0.2665306816 ,
															addrs_per_adl_6m = '01' and segment=6 => 0.2753195674 ,
															addrs_per_adl_6m = '10' and segment=6 => 0.3327775925 ,
															addrs_per_adl_6m = '11' and segment=6 => 0.2907248636 ,
															addrs_per_adl_6m = '20' and segment=6 => 0.3200657895 ,
															addrs_per_adl_6m = '21' and segment=6 => 0.2773556231 ,
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

		combo_hphonescore_flag := (combo_hphonescore >= 95 and combo_hphonescore <= 100);

		phone_type1 :=  map(hphnpop = 0                         => -1,
												(integer)rc_hriskphoneflag = 1                => 2,
												(integer)rc_hriskphoneflag in [2, 3, 4, 5, 6] => 1,
																																0);

		phone_type2 :=  map(hphnpop = 0                      => -1,
												rc_hphonetypeflag in ['1', '3']   => 2,
												not((rc_hphonetypeflag in ['0'])) => 1,
																														 0);

		phone_type3 :=  map(hphnpop = 0                                            => -1,
												telcordia_type in ['04']                                => 2,
												not((telcordia_type in ['00', '50', '51', '52', '54'])) => 1,
																																									 0);

		phone_type :=  map(hphnpop = 0                                                => -1,
											 (phone_type1 = 2) OR ((phone_type2 = 2) OR (phone_type3 = 3)) => 2,
											 (phone_type1 = 1) OR ((phone_type2 = 1) OR (phone_type3 = 1)) => 1,
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

		phone_highrisk :=  map(hphnpop = 0                                                                                                   => -1,
													 ((integer)rc_hriskphoneflag = 6) OR ((rc_hphonetypeflag = '5') OR (((integer)rc_hphonevalflag = 3) OR (rc_hrisksicphone = '2225'))) => 1,
																																																																						 0);

		phone_disconnect :=  map(hphnpop = 0                                 => -1,
														 (nap_status = 'D') OR ((integer)rc_hriskphoneflag = 5) => 1,
																																						 0);

		anomaly_non_landline := (phone_type in [1, 2]);

		phone_mismatch :=  map(hphnpop = 0                                                                                          => -1,
													 ((integer)rc_phonezipflag in [1]) OR (((integer)rc_pwphonezipflag in [1, 2, 3, 4]) OR (rc_disthphoneaddr > 500 and rc_disthphoneaddr < 9999)) => 1,
																																																																		0);



		hp_confirmed_tmp := (integer)((verphn_p_2=1 OR (combo_hphonecount > 0)) and ((phone_invalid = 0) and ((phone_mismatch = 0) and ((phone_disconnect = 0) and combo_hphonescore_flag))));

		hp_confirmed :=  if(hphnpop = 0, -1, hp_confirmed_tmp);

    hp_confirmed_m := Map(hp_confirmed =-1 and segment=1 => 0.1368082061 ,
													hp_confirmed =0  and segment=1 => 0.1557971014 ,
													hp_confirmed =1  and segment=1 => 0.2916666667 ,
													hp_confirmed =-1 and segment=2 => 0.1265940489 ,
													hp_confirmed =0  and segment=2 => 0.1196754564 ,
													hp_confirmed =1  and segment=2 => 0.164556962 ,
													hp_confirmed =-1 and segment=3 => 0.1663410302 ,
													hp_confirmed =0  and segment=3 => 0.1593252109 ,
													hp_confirmed =1  and segment=3 => 0.2421632794 ,
													hp_confirmed =-1 and segment=4 => 0.1521904555 ,
													hp_confirmed =0  and segment=4 => 0.1669775363 ,
													hp_confirmed =1  and segment=4 => 0.2372384119 ,
													hp_confirmed =-1 and segment=5 => 0.1812066204 ,
													hp_confirmed =0  and segment=5 => 0.1918720853 ,
													hp_confirmed =1  and segment=5 => 0.2404352404 ,
													hp_confirmed =-1 and segment=6 => 0.2485734665 ,
													hp_confirmed =0  and segment=6 => 0.2919989484 ,
													hp_confirmed =1  and segment=6 => 0.3705174011 ,
													-9999);



   //****GONG Flag ***;
		gong_flag := (string)lname_gong_sourced + (string)address_gong_sourced;

    gong_flag_m := Map(gong_flag = '00' and segment=1 => 0.1414799853,
												gong_flag = '00' and segment=2 => 0.1223498233 ,
												gong_flag = '01' and segment=2 => 0.0859030837 ,
												gong_flag = '10' and segment=2 => 0.0941176471 ,
												gong_flag = '11' and segment=2 => 0.1345375273 ,
												gong_flag = '00' and segment=3 => 0.1519337017 ,
												gong_flag = '01' and segment=3 => 0.1873786408 ,
												gong_flag = '10' and segment=3 => 0.2169312169 ,
												gong_flag = '11' and segment=3 => 0.1822408182 ,
												gong_flag = '00' and segment=4 => 0.1443807224 ,
												gong_flag = '01' and segment=4 => 0.1804586241 ,
												gong_flag = '10' and segment=4 => 0.2372065021 ,
												gong_flag = '11' and segment=4 => 0.1903045179 ,
												gong_flag = '00' and segment=5 => 0.1794799719 ,
												gong_flag = '01' and segment=5 => 0.2099853157 ,
												gong_flag = '10' and segment=5 => 0.2275371687 ,
												gong_flag = '11' and segment=5 => 0.1960521615 ,
												gong_flag = '00' and segment=6 => 0.2647940666 ,
												gong_flag = '01' and segment=6 => 0.3179433368 ,
												gong_flag = '10' and segment=6 => 0.3622474125 ,
												gong_flag = '11' and segment=6 => 0.315086689 ,
												-9999);



   //****error handling ****;
		ec1 := ((string)trim(trim(out_addr_status, LEFT), LEFT, RIGHT))[1..1];

		casserror :=  map(trim(trim(out_addr_status, LEFT), LEFT, RIGHT) = 'E412' => 1,
											ec1 = 'E'                                               => 2,
																																								 0);

		logit_b1_24 := -3.730892862 +
				(hp_confirmed_m * 5.5621332279) +
				((integer)recent_mover * 0.2622924838) +
				(add1_home_quartile_m * 6.6234060419) +
				(mover_status_m * 1.2674649083);

		phat_b1_24 := (exp(logit_b1_24) / (1 + exp(logit_b1_24)));

		addressmod_b1 := round(((50 * ((ln((phat_b1_24 / (1 - phat_b1_24))) - ln((.126 / .874))) / ln(2))) + 700));

		addressmod := if(segment = 1, addressmod_b1, -9999);

		phat_24 := if(segment = 1, phat_b1_24, -9999);

		logit_24 := if(segment = 1, logit_b1_24, -9999);

		logit_b1_25 := -4.96293078 +
				((integer)anomaly_non_landline * -0.502803141) +
				(gong_flag_m * 11.440565409) +
				(phone_mismatch * 0.2886304215) +
				(add1_home_quartile_m * 5.425763262) +
				(addrs_per_adl_6m_m * 8.9284540024);

		phat_b1_25 := (exp(logit_b1_25) / (1 + exp(logit_b1_25)));

		addressmod_b1_2 := round(((50 * ((ln((phat_b1_25 / (1 - phat_b1_25))) - ln((.126 / .874))) / ln(2))) + 700));

		addressmod_2 := if(segment = 2, addressmod_b1_2, addressmod);

		phat_25 := if(segment = 2, phat_b1_25, -9999);

		logit_25 := if(segment = 2, logit_b1_25, -9999);

		logit_b1_26 := -6.866904969 +
				(hp_confirmed_m * 4.8314884699) +
				((integer)anomaly_non_landline * -0.237812361) +
				(gong_flag_m * 3.6519833866) +
				(is_apartment * -0.274222364) +
				(add1_home_quartile_m * 6.8990111474) +
				(addrs_per_adl_6m_m * 5.4142715999) +
				(rc_addrcount_c_m * 4.3438417741) +
				(addrs_15yr_c_m * 5.1046703806);

		phat_b1_26 := (exp(logit_b1_26) / (1 + exp(logit_b1_26)));

		addressmod_b1_3 := round(((50 * ((ln((phat_b1_26 / (1 - phat_b1_26))) - ln((.126 / .874))) / ln(2))) + 700));

		addressmod_3 := if(segment = 3, addressmod_b1_3, addressmod_2);

		phat_26 := if(segment = 3, phat_b1_26, -9999);

		logit_26 := if(segment = 3, logit_b1_26, -9999);

		logit_b1_27 := -6.303578128 +
				(hp_confirmed_m * 3.7318706288) +
				((integer)anomaly_non_landline * -0.092832114) +
				(gong_flag_m * 3.9785738116) +
				(phone_mismatch * 0.0942918755) +
				(is_apartment * -0.123282041) +
				(casserror * -0.12141163) +
				(add1_home_quartile_m * 5.8956272498) +
				(addrs_per_adl_6m_m * 3.6727847148) +
				(rc_addrcount_c_m * 5.1544144579) +
				(addrs_15yr_c_m * 4.9489695348);

		phat_b1_27 := (exp(logit_b1_27) / (1 + exp(logit_b1_27)));

		addressmod_b1_4 := round(((50 * ((ln((phat_b1_27 / (1 - phat_b1_27))) - ln((.126 / .874))) / ln(2))) + 700));

		addressmod_4 := if(segment = 4, addressmod_b1_4, addressmod_3);

		phat_27 := if(segment = 4, phat_b1_27, -9999);

		logit_27 := if(segment = 4, logit_b1_27, -9999);

		logit_b1_28 := -6.933707687 +
				(hp_confirmed_m * 4.1045096721) +
				(gong_flag_m * 2.5920254536) +
				(phone_mismatch * 0.0514856573) +
				(recent_disconnects * 0.1489148178) +
				(casserror * -0.124276445) +
				(add1_home_quartile_m * 6.1472750237) +
				(addrs_per_adl_6m_m * 4.4841666737) +
				(rc_addrcount_c_m * 5.9717084454) +
				(addrs_15yr_c_m * 5.130156199);

		phat_b1_28 := (exp(logit_b1_28) / (1 + exp(logit_b1_28)));

		addressmod_b1_5 := round(((50 * ((ln((phat_b1_28 / (1 - phat_b1_28))) - ln((.126 / .874))) / ln(2))) + 700));

		addressmod_5 := if(segment = 5, addressmod_b1_5, addressmod_4);

		phat_28 := if(segment = 5, phat_b1_28, -9999);

		logit_28 := if(segment = 5, logit_b1_28, -9999);

		logit_b1_29 := -5.579685329 +
				(hp_confirmed_m * 2.9052439053) +
				((integer)anomaly_non_landline * -0.129065181) +
				(gong_flag_m * 1.6808718351) +
				((integer)recent_mover * 0.0887943489) +
				(is_apartment * -0.149084513) +
				(add1_home_quartile_m * 4.9654789615) +
				(addrs_per_adl_6m_m * 2.8301169186) +
				(rc_addrcount_c_m * 3.2035644566);

		phat_b1_29 := (exp(logit_b1_29) / (1 + exp(logit_b1_29)));

		addressmod_b1_6 := round(((50 * ((ln((phat_b1_29 / (1 - phat_b1_29))) - ln((.126 / .874))) / ln(2))) + 700));

		addressmod_6 := if(segment = 6, addressmod_b1_6, addressmod_5);

		phat_29 := if(segment = 6, phat_b1_29, -9999);

		logit_29 := if(segment = 6, logit_b1_29, -9999);
		
		addressmod_final := map(segment = 1 => addressmod,
												 segment = 2 => addressmod_2,
												 segment = 3 => addressmod_3,
												 segment = 4 => addressmod_4,
												 segment = 5 => addressmod_5,
												 segment = 6 => addressmod_6,
												 -9999);				
		

		logit_b1_30 := -26.25887982 +
				(censmod_final * 0.0109077056) +
				(sourcemod_final * 0.0073033005) +
				(relmod_final * 0.0098390264) +
				(flagmod_final * 0) +
				(propmod * 0) +
				(addressmod_final * 0.006413064);

		phat_b1_30 := (exp(logit_b1_30) / (1 + exp(logit_b1_30)));

		model13_b1 := round(((50 * ((ln((phat_b1_30 / (1 - phat_b1_30))) - ln((.126 / .874))) / ln(2))) + 700));

		model13 := if(segment = 1, model13_b1, -9999);

		phat_30 := if(segment = 1, phat_b1_30, -9999);

		logit_30 := if(segment = 1, logit_b1_30, -9999);

		logit_b1_31 := -36.10731419 +
				(censmod_final * 0.0122837395) +
				(sourcemod_final * 0.0115474571) +
				(relmod_final * 0) +
				(flagmod_final * 0.012375743) +
				(propmod * 0) +
				(addressmod_final * 0.0125172191);

		phat_b1_31 := (exp(logit_b1_31) / (1 + exp(logit_b1_31)));

		model13_b1_2 := round(((50 * ((ln((phat_b1_31 / (1 - phat_b1_31))) - ln((.126 / .874))) / ln(2))) + 700));

		model13_2 := if(segment = 2, model13_b1_2, -9999);

		phat_31 := if(segment = 2, phat_b1_31, -9999);

		logit_31 := if(segment = 2, logit_b1_31, -9999);

		logit_b1_32 := -27.65144585 +
				(censmod_final * 0.0075011337) +
				(sourcemod_final * 0.0069536337) +
				(relmod_final * 0.0075330847) +
				(flagmod_final * 0.0065997923) +
				(propmod * 0) +
				(addressmod_final * 0.0072168665);

		phat_b1_32 := (exp(logit_b1_32) / (1 + exp(logit_b1_32)));

		model13_b1_3 := round(((50 * ((ln((phat_b1_32 / (1 - phat_b1_32))) - ln((.126 / .874))) / ln(2))) + 700));

		model13_3 := if(segment = 3, model13_b1_3, -9999);

		phat_32 := if(segment = 3, phat_b1_32, -9999);

		logit_32 := if(segment = 3, logit_b1_32, -9999);

		logit_b1_33 := -31.51070889 +
				(censmod_final * 0.0085715768) +
				(sourcemod_final * 0.0073011525) +
				(relmod_final * 0.0053627047) +
				(flagmod_final * 0.0102705974) +
				(propmod * 0) +
				(addressmod_final * 0.0096469147);

		phat_b1_33 := (exp(logit_b1_33) / (1 + exp(logit_b1_33)));

		model13_b1_4 := round(((50 * ((ln((phat_b1_33 / (1 - phat_b1_33))) - ln((.126 / .874))) / ln(2))) + 700));

		model13_4 := if(segment = 4, model13_b1_4, -9999);

		phat_33 := if(segment = 4, phat_b1_33, -9999);

		logit_33 := if(segment = 4, logit_b1_33, -9999);

		logit_b1_34 := -32.41873302 +
				(censmod_final * 0.0090003842) +
				(sourcemod_final * 0.0089896658) +
				(relmod_final * 0.006601579) +
				(flagmod_final * 0.0100079021) +
				(propmod * 0) +
				(addressmod_final * 0.0074662852);

		phat_b1_34 := (exp(logit_b1_34) / (1 + exp(logit_b1_34)));

		model13_b1_5 := round(((50 * ((ln((phat_b1_34 / (1 - phat_b1_34))) - ln((.126 / .874))) / ln(2))) + 700));

		model13_5 := if(segment = 5, model13_b1_5, -9999);

		phat_34 := if(segment = 5, phat_b1_34, -9999);

		logit_34 := if(segment = 5, logit_b1_34, -9999);

		logit_b1_35 := -36.73341579 +
				(censmod_final * 0.0074615182) +
				(sourcemod_final * 0.0077887804) +
				(relmod_final * 0.0026131624) +
				(flagmod_final * 0.0122622766) +
				(propmod * 0.007370432) +
				(addressmod_final * 0.0085106088);

		phat_b1_35 := (exp(logit_b1_35) / (1 + exp(logit_b1_35)));

		model13_b1_6 := round(((50 * ((ln((phat_b1_35 / (1 - phat_b1_35))) - ln((.126 / .874))) / ln(2))) + 700));

		model13_6 := if(segment = 6, model13_b1_6, -9999);

		phat_35 := if(segment = 6, phat_b1_35, -9999);

		logit_35 := if(segment = 6, logit_b1_35, -9999);




		adl_addr_c :=  map(((integer)in_addrpop = 0) and ((adl_addr = 0) and (in_addrpop_found = 0)) => 1,
											 ((integer)in_addrpop = 0) and ((adl_addr = 1) and (in_addrpop_found = 0)) => 2,
											 ((integer)in_addrpop = 1) and (adl_addr = 0)                            => 3,
											 ((integer)in_addrpop = 1) and ((adl_addr = 2) and (in_addrpop_found = 1)) => 4,
											 ((integer)in_addrpop = 1) and ((adl_addr = 3) and (in_addrpop_found = 0)) => 5,
																																											 6);

		adl_hphn_c :=  map((in_hphnpop = 0) and ((adl_hphn = 0) and (in_hphnpop_found = 0)) => 1,
											 (in_hphnpop = 0) and ((adl_hphn = 1) and (in_hphnpop_found = 0)) => 2,
											 (in_hphnpop = 1) and (adl_hphn = 0)                            => 3,
											 (in_hphnpop = 1) and ((adl_hphn = 2) and (in_hphnpop_found = 1)) => 4,
											 (in_hphnpop = 1) and ((adl_hphn = 3) and (in_hphnpop_found = 0)) => 5,
																																											 6);

		adl_ssn_c :=  map((in_ssnpop = 0) and (adl_ssn = 0) => 1,
											(in_ssnpop = 0) and (adl_ssn = 1) => 2,
											(in_ssnpop = 1) and (adl_ssn = 0) => 3,
											(in_ssnpop = 1) and (adl_ssn = 2) => 4,
																												 5);

		adl_addr_hphn_c :=  map((adl_addr_c = 1) and (adl_hphn_c = 1)                => 1,
														(adl_addr_c = 1) and (adl_hphn_c in [2, 3, 4, 5, 6]) => 2,
														(adl_addr_c in [2, 3]) and (adl_hphn_c in [1, 2])    => 3,
														(adl_addr_c = 2) and (adl_hphn_c in [3, 4])          => 4,
														(adl_addr_c = 2) and (adl_hphn_c in [5, 6])          => 5,
														(adl_addr_c = 3) and (adl_hphn_c in [3, 4, 5, 6])    => 6,
														(adl_addr_c = 4) and (adl_hphn_c in [1])             => 7,
														(adl_addr_c = 4) and (adl_hphn_c in [2, 3])          => 8,
														(adl_addr_c = 4) and (adl_hphn_c in [4])             => 9,
														(adl_addr_c = 4) and (adl_hphn_c in [5, 6])          => 10,
														(adl_addr_c = 5) and (adl_hphn_c in [1])             => 11,
														(adl_addr_c = 5) and (adl_hphn_c in [2])             => 12,
														(adl_addr_c = 5) and (adl_hphn_c in [3])             => 13,
														(adl_addr_c = 5) and (adl_hphn_c in [4, 5, 6])       => 14,
														(adl_addr_c = 6) and (adl_hphn_c in [1])             => 15,
														(adl_addr_c = 6) and (adl_hphn_c in [2])             => 16,
														(adl_addr_c = 6) and (adl_hphn_c in [3])             => 17,
														(adl_addr_c = 6) and (adl_hphn_c in [4])             => 18,
														(adl_addr_c = 6) and (adl_hphn_c in [5])             => 19,
																																									20);

		adl_addr_c_m := Map(adl_addr_c =1 => 0.0420560748 ,
												 adl_addr_c =2 => 0.0780195049,
												 adl_addr_c =3 => 0.1052025341 ,
												 adl_addr_c =4 => 0.1836859289 ,
												 adl_addr_c =5 => 0.1165875454 ,
												 adl_addr_c =6 => 0.1295172778 ,
												 -9999);
		
		
		

    adl_addr_hphn_c_m := Map(adl_addr_hphn_c =1 => 0.029082774 ,
														 adl_addr_hphn_c =2 => 0.0717948718 ,
														 adl_addr_hphn_c =3 => 0.0776490776 ,
														 adl_addr_hphn_c =4 => 0.1007633588 ,
														 adl_addr_hphn_c =5 => 0.0658513641 ,
														 adl_addr_hphn_c =6 => 0.1725752508 ,
														 adl_addr_hphn_c =7 => 0.101965602 ,
														 adl_addr_hphn_c =8 => 0.1935504844 ,
														 adl_addr_hphn_c =9 => 0.2084805654 ,
														 adl_addr_hphn_c =10 => 0.188278279 ,
														 adl_addr_hphn_c =11 => 0.0592185592 ,
														 adl_addr_hphn_c =12 => 0.1046622265 ,
														 adl_addr_hphn_c =13 => 0.1866521975 ,
														 adl_addr_hphn_c =14 => 0.1473417722 ,
														 adl_addr_hphn_c =15 => 0.0701248799 ,
														 adl_addr_hphn_c =16 => 0.1189903846 ,
														 adl_addr_hphn_c =17 => 0.1611271676 ,
														 adl_addr_hphn_c =18 => 0.1488033299 ,
														 adl_addr_hphn_c =19 => 0.1296137339 ,
														 adl_addr_hphn_c =20 => 0.1589347079 ,
														 -9999);
		

    adl_hphn_c_m := Map(adl_hphn_c =1 => 0.077951703 ,
												adl_hphn_c =2 => 0.155479382 ,
												adl_hphn_c =3 => 0.1739501375 ,
												adl_hphn_c =4 => 0.1904910366 ,
												adl_hphn_c =5 => 0.1543282656 ,
												adl_hphn_c =6 => 0.1942281264 ,
												-9999);
		

    adl_ssn_c_m := Map(adl_ssn_c =1 => 0.0605659878 ,
											 adl_ssn_c =2 => 0.1091553921 ,
											 adl_ssn_c =3 => 0.1325079031 ,
											 adl_ssn_c =4 => 0.1638827324 ,
											 adl_ssn_c =5 => 0.1566666667 ,
											 -9999);
	 
	  model_to_use := Map(segment=1 => model13,
												segment=2 => model13_2,
												segment=3 => model13_3,
												segment=4 => model13_4,
												segment=5 => model13_5,
												segment=6 => model13_6,
												-9999);
	 

		logit_36 := -11.35071274 +
				(model_to_use * 0.0106236159) +
				(adl_addr_c_m * 2.976843387) +
				(adl_hphn_c_m * 3.7248945249) +
				(adl_ssn_c_m * 3.6666698063);

		phat_36 := (exp(logit_36) / (1 + exp(logit_36)));

		adl_model1 := round(((50 * ((ln((phat_36 / (1 - phat_36))) - ln((.126 / .874))) / ln(2))) + 700));

		logit_37 := -11.00544582 +
				(model_to_use * 0.0104495852) +
				(adl_addr_hphn_c_m * 5.1318364006) +
				(adl_ssn_c_m * 3.7602671922);

		phat_37 := (exp(logit_37) / (1 + exp(logit_37)));

		adl_model2 := round(((50 * ((ln((phat_37 / (1 - phat_37))) - ln((.126 / .874))) / ln(2))) + 700));

		RSN807 :=   min(999,max(300,adl_model2));
		
    self.seq   := (string)le.bs.seq;
    self.recover_score := (string)RSN807;
		
  END;

	scores := project(results, doModel(left));
	
	
	// Get the indices
	indices := Models.RecoverScoreV2_Collection_Indices( clam );


	Layout_RecoverScore join_indices(scores le, indices ri) := TRANSFORM
		SELF.recover_score := le.recover_score;  // get score

		SELF := ri;  // get indices	
		self := [];
		
	END;


	withIndices := join( scores, indices, left.seq=right.seq, join_indices(left,right));    

	RETURN withIndices;

END;