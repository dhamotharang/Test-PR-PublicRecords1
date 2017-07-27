import ut, models;

EXPORT getBSTSEconomicTrajectory(GROUPED DATASET (Risk_Indicators.Layout_boca_shell) clam) := function

	ungroup_clam:= ungroup(clam);
	//bill to information (the previous address information) 
	bt_clam := project(ungroup_clam(seq % 2 = 0),
		transform(Risk_Indicators.Layout_BocaShell_BtSt.Econ_Traj,
		self.seq := left.seq;
		self.BT_Addr_addr_type := left.address_verification.addr_type2;
		self.BT_Addr_avm_automated_valuation := left.avm.address_history_1.avm_automated_valuation;
		self.BT_Addr_market_total_value := left.address_verification.address_history_1.assessed_amount;
		self.BT_Addr_pop := left.addrPop2;	
		self.BT_Addr_avm_med_fips := left.avm.address_history_1.avm_median_fips_level; //                   AVM: Median AVM for County
		self.BT_Addr_avm_med_geo11 := left.avm.address_history_1.avm_median_geo11_level; 
		self.BT_Addr_avm_med_geo12 := left.avm.address_history_1.avm_median_geo12_level; 
		self := []));//making the ST fields empty until the next transform
//ship to information (the current address information for this model)
	st_clam := project(ungroup_clam(seq % 2 != 0),
		transform(Risk_Indicators.Layout_BocaShell_BtSt.Econ_Traj,
			self.seq := left.seq;
			self.ST_addr_addr_type := left.address_verification.addr_type2;
			self.ST_Addr_avm_automated_valuation := left.avm.address_history_1.avm_automated_valuation;
			self.ST_Addr_avm_med_fips := left.avm.address_history_1.avm_median_fips_level;
			self.ST_Addr_avm_med_geo11 := left.avm.address_history_1.avm_median_geo11_level;
			self.ST_Addr_avm_med_geo12 := left.avm.address_history_1.avm_median_geo12_level;
			self.ST_Addr_market_total_value := left.address_verification.address_history_1.assessed_amount;
			self.ST_Addr_pop  := left.addrPop2;
			self.reported_dob := left.reported_dob;
			self.historydate := left.historydate;
			self.ST_addrs_5yr := left.Other_Address_Info.addrs_last_5years;
			self := []));

	btst_clam := join(bt_clam, st_clam, 
		left.seq = right.seq -1, 
		transform(Risk_Indicators.Layout_BocaShell_BtSt.Econ_Traj,
			self.seq := left.seq;
			self.BT_Addr_addr_type := left.BT_Addr_addr_type;
			self.BT_Addr_avm_automated_valuation := left.BT_Addr_avm_automated_valuation;
			self.BT_Addr_market_total_value := left.BT_Addr_market_total_value;
			self.BT_Addr_pop := left.BT_Addr_pop; 	
			self.BT_Addr_avm_med_fips := left.BT_Addr_avm_med_fips; //                   AVM: Median AVM for County
			self.BT_Addr_avm_med_geo11 := left.BT_Addr_avm_med_geo11; 
			self.BT_Addr_avm_med_geo12 := left.BT_Addr_avm_med_geo12; 
			SELF := RIGHT),
			LEFT OUTER);
			
	btst_clam_grpd := group(sort(project(btst_clam, 
		transform(Risk_Indicators.Layout_BocaShell_BtSt.Econ_Traj, self := left)), seq), seq);

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			string ST__addr_addr_type;
			unsigned ST__Addr_avm_automated_valuation; // le.avm.address_history_1.avm_automated_valuation; //        AVM: Overall Valuation
			unsigned 	ST__Addr_avm_med_fips; // le.avm.address_history_1.avm_median_fips_level; //                   AVM: Median AVM for County
			unsigned 	ST__Addr_avm_med_geo11; // le.avm.address_history_1.avm_median_geo11_level; //                AVM: Median AVM for Census Tract
			unsigned 	ST__Addr_avm_med_geo12; // le.avm.address_history_1.avm_median_geo12_level;  //                  AVM: Median AVM for Census Block
			unsigned 	ST__Addr_market_total_value; // le.address_verification.address_history_1.assessed_amount; //             Address Market Value Amount
			unsigned	ST__Addr_pop; // if(trim(le.address_verification.address_history_1.zip5) <> '', 1, 0); //                           Address Populated Indicator

			string	BT__Addr_addr_type; // le.address_verification.addr_type3;  //                      Address Type Indicator from Address Standardization
			unsigned	BT__Addr_avm_automated_valuation; // le.avm.address_history_2.avm_automated_valuation; //        AVM: Overall Valuation
			unsigned	BT__Addr_market_total_value; // le.address_verification.address_history_2.assessed_amount; //            Address Market Value Amount
			unsigned	BT__Addr_pop; // if(trim(le.address_verification.address_history_2.zip5) <> '', 1, 0);  // Address Populated Indicator
			unsigned	BT__Addr_avm_med_fips; // le.avm.address_history_2.avm_median_fips_level; //                   AVM: Median AVM for County
			unsigned	BT__Addr_avm_med_geo11; // le.avm.address_history_2.avm_median_geo11_level; //                 AVM: Median AVM for Census Tract
			unsigned	BT__Addr_avm_med_geo12; // le.avm.address_history_2.avm_median_geo12_level; //  
			
			unsigned addrs_5yr;  // added 2/13/2015
			// unsigned4 reported_dob;  // added 2/13/2015
			
			string economic_trajectory_string; 
			string economic_trajectory_index_string; 
				
			Risk_Indicators.Layout_BocaShell_BtSt.Econ_Traj
		end;
		Layout_Debug append_trajectory(Risk_Indicators.Layout_BocaShell_BtSt.Econ_Traj le) := transform
	#else
		Risk_Indicators.Layout_BocaShell_BtSt.Econ_Traj append_trajectory(risk_indicators.Layout_BocaShell_BtSt.Econ_Traj le) := transform
	#end

	// in shell 5.0 current address is always in history_1, previous address is always address_history_2
	ST__Addr_addr_type := le.ST_addr_addr_type; // Address Type Indicator from Address Standardization
	ST__Addr_avm_automated_valuation := le.ST_Addr_avm_automated_valuation; //        AVM: Overall Valuation
	ST__Addr_avm_med_fips := le.ST_Addr_avm_med_fips; //                   AVM: Median AVM for County
	ST__Addr_avm_med_geo11 := le.ST_Addr_avm_med_geo11; //                AVM: Median AVM for Census Tract
	ST__Addr_avm_med_geo12 := le.ST_Addr_avm_med_geo12;  //                  AVM: Median AVM for Census Block
	ST__Addr_market_total_value := le.ST_Addr_market_total_value; //             Address Market Value Amount
	ST__Addr_pop := if(le.ST_Addr_pop, 1, 0); //                           Address Populated Indicator

	BT__Addr_addr_type := le.BT_Addr_addr_type;  //                      Address Type Indicator from Address Standardization
	BT__Addr_avm_automated_valuation := le.BT_Addr_avm_automated_valuation; //        AVM: Overall Valuation
	BT__Addr_market_total_value := le.BT_Addr_market_total_value; //            Address Market Value Amount
	BT__Addr_pop := if(le.BT_Addr_pop, 1, 0);  // Address Populated Indicator
	BT__Addr_avm_med_fips := le.BT_Addr_avm_med_fips; //                   AVM: Median AVM for County
	BT__Addr_avm_med_geo11 := le.BT_Addr_avm_med_geo11; //                 AVM: Median AVM for Census Tract
	BT__Addr_avm_med_geo12 := le.BT_Addr_avm_med_geo12; //                  AVM: Median AVM for Census Block
  
	addrs_5yr := le.ST_addrs_5yr;
	archive_date                     := if( le.historydate=999999, (unsigned3)ut.getdate[1..6], le.historydate );
	NULL := -999999999;
	_reported_dob := models.common.sas_date((string)(le.reported_dob));
	sysdate := models.common.sas_date((string)(archive_date));
	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));
		
	/* Code Starts Here */
   minval := 50000;    /* Set Minimum Acceptable Value to Use for AVM */

   // *** Current Value ***;
	ST__apt_flag := map(
										trim(ST__Addr_addr_type)='H' =>  1,      /* Apt   */
										trim(ST__Addr_addr_type) in ['S', 'R', 'G'] => 0,     /* SFDU  */
										-1);     /* Other */

	ST__value_sfdu := map(
			ST__Addr_avm_automated_valuation > minval =>  ST__Addr_avm_automated_valuation, 
			ST__Addr_market_total_value      > minval =>  ST__Addr_market_total_value,      
			ST__Addr_avm_med_geo12           > minval =>  ST__Addr_avm_med_geo12,           
			ST__Addr_avm_med_geo11           > minval =>  ST__Addr_avm_med_geo11,           
			ST__Addr_avm_med_fips            > minval =>  ST__Addr_avm_med_fips,            
			-1);
			
	ST__value_apt := map(
			ST__Addr_avm_med_geo12           > minval =>  ST__Addr_avm_med_geo12,  
			ST__Addr_avm_med_geo11           > minval =>  ST__Addr_avm_med_geo11,  
			ST__Addr_avm_med_fips            > minval =>  ST__Addr_avm_med_fips,   
			-1);
																																
	ST__value := map(ST__apt_flag=0 => ST__value_sfdu,
									ST__apt_flag=1 => ST__value_apt,
									-1); /* Other */


   // *** Previous Value ***;
	BT__Apt_Flag := map(
			trim(BT__Addr_addr_type) = 'H' => 1,     /* Apt   */
			trim(BT__Addr_addr_type) in ['S', 'R', 'G'] => 0,     /* SFDU  */
			-1);     /* Other */


	BT__value_sfdu := map(
			BT__Addr_avm_automated_valuation > minval  => BT__Addr_avm_automated_valuation,
			BT__Addr_market_total_value      > minval  => BT__Addr_market_total_value     ,
			BT__Addr_avm_med_geo12           > minval  => BT__Addr_avm_med_geo12          ,
			BT__Addr_avm_med_geo11           > minval  => BT__Addr_avm_med_geo11          ,
			BT__Addr_avm_med_fips            > minval  => BT__Addr_avm_med_fips           ,
			-1);
						
	BT__value_apt := map(
			BT__Addr_avm_med_geo12           > minval  => BT__Addr_avm_med_geo12 ,
			BT__Addr_avm_med_geo11           > minval  => BT__Addr_avm_med_geo11 ,
			BT__Addr_avm_med_fips            > minval  => BT__Addr_avm_med_fips  ,
			-1);

	BT__value := map(BT__apt_flag=0 => BT__value_sfdu,
										BT__apt_flag=1 => BT__value_apt,
										-1);
									
Economic_Trajectory := map(
	//addrs_5yr=0 => '01 - No Move in Past 5 Years', //remove for the BTST shell
	ST__Addr_Pop = 0 or BT__Addr_Pop = 0 or
	trim(ST__Addr_addr_type) = '' or trim(BT__Addr_addr_type) = '' or
	ST__Apt_Flag = -1 or 
	(BT__Apt_Flag = -1 and ST__Apt_Flag = 1) => '00 - Unable to Calculate',
	
	reported_age >= 62 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',
	
	BT__Apt_Flag = 1 and ST__Apt_Flag = 1          =>  '02 - APT-APT',                      /* APT-APT  */
	BT__Apt_Flag = 0 and ST__Apt_Flag = 1          =>  '03 - SFDU-APT',                     /* SFDU-APT */
	BT__Apt_Flag = 1 and ST__Apt_Flag = 0          =>  '04 - APT-SFDU',                     /* APT-SFDU */
	ST__Value <= 0                                  =>  '07 - SFDU-SFDU - Curr Val = 0',     /* SFDU-SFDU - Curr Value 0 */

	BT__Value <= 0 and ST__Value <= 150000 =>  '05 - SFDU-SFDU - Prev Val = 0 - Curr Val <= 150K', /* Should Catch NR-SFDU     */
	BT__Value <= 0 => '06 - SFDU-SFDU - Prev Val = 0 - Curr Val 150K+',
	BT__Value <=  75000 and ST__Value <= 150000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	BT__Value <=  75000 and ST__Value <= 450000 =>  '11 - SFDU-SFDU - Moved Up',
	BT__Value <=  75000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	BT__Value <= 150000 and ST__Value <= 150000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	BT__Value <= 150000 and ST__Value <= 450000 =>  '11 - SFDU-SFDU - Moved Up',
	BT__Value <= 150000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	BT__Value <= 300000 and ST__Value <=  75000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	BT__Value <= 300000 and ST__Value <= 150000 =>  '09 - SFDU-SFDU - Moved Down',
	BT__Value <= 300000 and ST__Value <= 300000 =>  '10 - SFDU-SFDU - Stayed the Same',
	BT__Value <= 300000 and ST__Value <= 450000 =>  '11 - SFDU-SFDU - Moved Up',
	BT__Value <= 300000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	BT__Value <= 450000 and ST__Value <=  75000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	BT__Value <= 450000 and ST__Value <= 300000 =>  '09 - SFDU-SFDU - Moved Down',
	BT__Value <= 450000 and ST__Value <= 450000 =>  '10 - SFDU-SFDU - Stayed the Same',
	BT__Value <= 450000 and ST__Value <= 600000 =>  '11 - SFDU-SFDU - Moved Up',
	BT__Value <= 450000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	BT__Value <= 600000 and ST__Value <=  75000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	BT__Value <= 600000 and ST__Value <= 450000 =>  '09 - SFDU-SFDU - Moved Down',
	BT__Value <= 600000 and ST__Value <= 600000 =>  '10 - SFDU-SFDU - Stayed the Same',
	BT__Value <= 600000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	ST__Value <=  75000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	ST__Value <= 600000 =>  '09 - SFDU-SFDU - Moved Down',
	'12 - SFDU-SFDU - Moved Way Up / Stayed Up'
	);

Economic_Trajectory_Index := map(
trim(Economic_Trajectory) = '00 - Unable to Calculate'  => '0 - Unable to Calculate',

trim(Economic_Trajectory) in ['03 - SFDU-APT', 
'02 - APT-APT',  
'05 - SFDU-SFDU - Prev Val = 0 - Curr Val <= 150K'] => '1 - Moved to Apartment OR Prev Val=0 and Curr Val <= 150K',
															
trim(Economic_Trajectory) in ['08 - SFDU-SFDU - Move Way Down / Stayed Down',
'07 - SFDU-SFDU - Curr Val = 0',
'06 - SFDU-SFDU - Prev Val = 0 - Curr Val 150K+',
'04 - APT-SFDU'] => '2 - (SFDU-SFDU - Move Way Down / Stayed Down) OR (Curr Val = 0) OR (APT to SFDU) OR (Prev Val = 0 and Curr Val 150K+)',

trim(Economic_Trajectory) = '09 - SFDU-SFDU - Moved Down' => '3 - SFDU-SFDU - Moved Down',
trim(Economic_Trajectory) = '10 - SFDU-SFDU - Stayed the Same' => '4 - SFDU-SFDU - Stayed the Same',
trim(Economic_Trajectory) in ['01 - No Move in Past 5 Years', '11 - SFDU-SFDU - Moved Up'] => '5 - SFDU-SFDU - Moved Up / Did Not Move',
trim(Economic_Trajectory) = '12 - SFDU-SFDU - Moved Way Up / Stayed Up' => '6 - SFDU-SFDU - Moved Way Up / Stayed Up',

'0 - Unable to Calculate'  
);

	#if(MODEL_DEBUG)
		self.ST__addr_addr_type := ST__addr_addr_type;
		self.ST__Addr_avm_automated_valuation := ST__Addr_avm_automated_valuation; 
		self.ST__Addr_avm_med_fips := ST__addr_avm_med_fips; 
		self.ST__Addr_avm_med_geo11 := ST__addr_avm_med_geo11; 
		self.ST__Addr_avm_med_geo12 := ST__addr_avm_med_geo12; 
		self.ST__Addr_market_total_value := ST__addr_market_total_value; 
		self.ST__Addr_pop := ST__addr_pop; 
		self.BT__Addr_addr_type := BT__addr_addr_type; 
		self.BT__Addr_avm_automated_valuation := BT__addr_avm_automated_valuation; 
		self.BT__Addr_market_total_value := BT__addr_market_total_value; 
		self.BT__Addr_pop := BT__addr_pop; 
		self.BT__Addr_avm_med_fips := BT__addr_avm_med_fips; 
		self.BT__Addr_avm_med_geo11 := BT__addr_avm_med_geo11; 
		self.BT__Addr_avm_med_geo12 := BT__addr_avm_med_geo12; 
		self.economic_trajectory_string := economic_trajectory;
		self.economic_trajectory_index_string := economic_trajectory_index;
		self.addrs_5yr := addrs_5yr;
	#else
		self.economic_trajectory := (integer)economic_trajectory[1..2];
		self.economic_trajectory_index := (integer)economic_trajectory_index[1..2];
	#end
	self := le;
end;

with_trajectory := project(btst_clam_grpd, append_trajectory(left));

//output(with_trajectory, named('with_trajectory'));
 // output(clam, named('clamuy'));
 // output(btst_clam_grpd, named('btst_clam_grpd'));
// output(bt_clam, named('bt_clam'));
// output(btst_clam, named('btst_clam'));
return with_trajectory;

end;

