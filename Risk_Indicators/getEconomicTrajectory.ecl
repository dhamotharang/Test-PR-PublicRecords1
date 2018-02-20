import ut, models, std;

EXPORT getEconomicTrajectory(GROUPED DATASET (Layout_Boca_Shell) clam) := function

	MODEL_DEBUG := FALSE;

	#if(MODEL_DEBUG)
		Layout_Debug := RECORD
			string curr_addr_addr_type;
			unsigned Curr_Addr_avm_automated_valuation; // le.avm.address_history_1.avm_automated_valuation; //        AVM: Overall Valuation
			unsigned 	Curr_Addr_avm_med_fips; // le.avm.address_history_1.avm_median_fips_level; //                   AVM: Median AVM for County
			unsigned 	Curr_Addr_avm_med_geo11; // le.avm.address_history_1.avm_median_geo11_level; //                AVM: Median AVM for Census Tract
			unsigned 	Curr_Addr_avm_med_geo12; // le.avm.address_history_1.avm_median_geo12_level;  //                  AVM: Median AVM for Census Block
			unsigned 	Curr_Addr_market_total_value; // le.address_verification.address_history_1.assessed_amount; //             Address Market Value Amount
			unsigned	Curr_Addr_pop; // if(trim(le.address_verification.address_history_1.zip5) <> '', 1, 0); //                           Address Populated Indicator

			string	Prev_Addr_addr_type; // le.address_verification.addr_type3;  //                      Address Type Indicator from Address Standardization
			unsigned	Prev_Addr_avm_automated_valuation; // le.avm.address_history_2.avm_automated_valuation; //        AVM: Overall Valuation
			unsigned	Prev_Addr_market_total_value; // le.address_verification.address_history_2.assessed_amount; //            Address Market Value Amount
			unsigned	Prev_Addr_pop; // if(trim(le.address_verification.address_history_2.zip5) <> '', 1, 0);  // Address Populated Indicator
			unsigned	Prev_Addr_avm_med_fips; // le.avm.address_history_2.avm_median_fips_level; //                   AVM: Median AVM for County
			unsigned	Prev_Addr_avm_med_geo11; // le.avm.address_history_2.avm_median_geo11_level; //                 AVM: Median AVM for Census Tract
			unsigned	Prev_Addr_avm_med_geo12; // le.avm.address_history_2.avm_median_geo12_level; //  
			
			unsigned addrs_5yr;  // added 2/13/2015
			// unsigned4 reported_dob;  // added 2/13/2015
			
			string economic_trajectory_string; 
			string economic_trajectory_index_string; 
			risk_indicators.Layout_Boca_Shell;	
		end;
		Layout_Debug append_trajectory(risk_indicators.Layout_Boca_Shell le) := transform
	#else
		Layout_Boca_Shell append_trajectory(risk_indicators.Layout_Boca_Shell le) := transform
	#end

	// in shell 5.0 current address is always in history_1, previous address is always address_history_2
	Curr_Addr_addr_type := le.address_verification.addr_type2; // Address Type Indicator from Address Standardization
	Curr_Addr_avm_automated_valuation := le.avm.address_history_1.avm_automated_valuation; //        AVM: Overall Valuation
	Curr_Addr_avm_med_fips := le.avm.address_history_1.avm_median_fips_level; //                   AVM: Median AVM for County
	Curr_Addr_avm_med_geo11 := le.avm.address_history_1.avm_median_geo11_level; //                AVM: Median AVM for Census Tract
	Curr_Addr_avm_med_geo12 := le.avm.address_history_1.avm_median_geo12_level;  //                  AVM: Median AVM for Census Block
	Curr_Addr_market_total_value := le.address_verification.address_history_1.assessed_amount; //             Address Market Value Amount
	Curr_Addr_pop := if(le.addrPop2, 1, 0); //                           Address Populated Indicator

	Prev_Addr_addr_type := le.address_verification.addr_type3;  //                      Address Type Indicator from Address Standardization
	Prev_Addr_avm_automated_valuation := le.avm.address_history_2.avm_automated_valuation; //        AVM: Overall Valuation
	Prev_Addr_market_total_value := le.address_verification.address_history_2.assessed_amount; //            Address Market Value Amount
	Prev_Addr_pop := if(le.addrPop3, 1, 0);  // Address Populated Indicator
	Prev_Addr_avm_med_fips := le.avm.address_history_2.avm_median_fips_level; //                   AVM: Median AVM for County
	Prev_Addr_avm_med_geo11 := le.avm.address_history_2.avm_median_geo11_level; //                 AVM: Median AVM for Census Tract
	Prev_Addr_avm_med_geo12 := le.avm.address_history_2.avm_median_geo12_level; //                  AVM: Median AVM for Census Block
  
	addrs_5yr := le.Other_Address_Info.addrs_last_5years;
	archive_date                     := if( le.historydate=999999, (unsigned3)((STRING)Std.Date.Today())[1..6], le.historydate );
	NULL := -999999999;
	_reported_dob := models.common.sas_date((string)(le.reported_dob));
	sysdate := models.common.sas_date((string)(archive_date));
	reported_age := if(min(sysdate, _reported_dob) = NULL, NULL, truncate((sysdate - _reported_dob) / 365.25));
		
	/* Code Starts Here */
   minval := 50000;    /* Set Minimum Acceptable Value to Use for AVM */

   // *** Current Value ***;
	curr_apt_flag := map(
										trim(Curr_Addr_addr_type)='H' =>  1,      /* Apt   */
										trim(Curr_Addr_addr_type) in ['S', 'R', 'G'] => 0,     /* SFDU  */
										-1);     /* Other */

	curr_value_sfdu := map(
			Curr_Addr_avm_automated_valuation > minval =>  Curr_Addr_avm_automated_valuation, 
			Curr_Addr_market_total_value      > minval =>  Curr_Addr_market_total_value,      
			Curr_Addr_avm_med_geo12           > minval =>  Curr_Addr_avm_med_geo12,           
			Curr_Addr_avm_med_geo11           > minval =>  Curr_Addr_avm_med_geo11,           
			Curr_Addr_avm_med_fips            > minval =>  Curr_Addr_avm_med_fips,            
			-1);
			
	curr_value_apt := map(
			Curr_Addr_avm_med_geo12           > minval =>  Curr_Addr_avm_med_geo12,  
			Curr_Addr_avm_med_geo11           > minval =>  Curr_Addr_avm_med_geo11,  
			Curr_Addr_avm_med_fips            > minval =>  Curr_Addr_avm_med_fips,   
			-1);
																																
	curr_value := map(curr_apt_flag=0 => curr_value_sfdu,
									curr_apt_flag=1 => curr_value_apt,
									-1); /* Other */


   // *** Previous Value ***;
	Prev_Apt_Flag := map(
			trim(Prev_Addr_addr_type) = 'H' => 1,     /* Apt   */
			trim(Prev_Addr_addr_type) in ['S', 'R', 'G'] => 0,     /* SFDU  */
			-1);     /* Other */


	prev_value_sfdu := map(
			Prev_Addr_avm_automated_valuation > minval  => Prev_Addr_avm_automated_valuation,
			Prev_Addr_market_total_value      > minval  => Prev_Addr_market_total_value     ,
			Prev_Addr_avm_med_geo12           > minval  => Prev_Addr_avm_med_geo12          ,
			Prev_Addr_avm_med_geo11           > minval  => Prev_Addr_avm_med_geo11          ,
			Prev_Addr_avm_med_fips            > minval  => Prev_Addr_avm_med_fips           ,
			-1);
						
	prev_value_apt := map(
			Prev_Addr_avm_med_geo12           > minval  => Prev_Addr_avm_med_geo12 ,
			Prev_Addr_avm_med_geo11           > minval  => Prev_Addr_avm_med_geo11 ,
			Prev_Addr_avm_med_fips            > minval  => Prev_Addr_avm_med_fips  ,
			-1);

	prev_value := map(prev_apt_flag=0 => prev_value_sfdu,
										prev_apt_flag=1 => prev_value_apt,
										-1);
									
Economic_Trajectory := map(
	addrs_5yr=0 => '01 - No Move in Past 5 Years',
	Curr_Addr_Pop = 0 or Prev_Addr_Pop = 0 or
	trim(Curr_Addr_addr_type) = '' or trim(Prev_Addr_addr_type) = '' or
	Curr_Apt_Flag = -1 or 
	(Prev_Apt_Flag = -1 and Curr_Apt_Flag = 1) => '00 - Unable to Calculate',
	
	reported_age >= 62 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',
	
	Prev_Apt_Flag = 1 and Curr_Apt_Flag = 1          =>  '02 - APT-APT',                      /* APT-APT  */
	Prev_Apt_Flag = 0 and Curr_Apt_Flag = 1          =>  '03 - SFDU-APT',                     /* SFDU-APT */
	Prev_Apt_Flag = 1 and Curr_Apt_Flag = 0          =>  '04 - APT-SFDU',                     /* APT-SFDU */
	Curr_Value <= 0                                  =>  '07 - SFDU-SFDU - Curr Val = 0',     /* SFDU-SFDU - Curr Value 0 */

	Prev_Value <= 0 and Curr_Value <= 150000 =>  '05 - SFDU-SFDU - Prev Val = 0 - Curr Val <= 150K', /* Should Catch NR-SFDU     */
	Prev_Value <= 0 => '06 - SFDU-SFDU - Prev Val = 0 - Curr Val 150K+',
	Prev_Value <=  75000 and Curr_Value <= 150000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	Prev_Value <=  75000 and Curr_Value <= 450000 =>  '11 - SFDU-SFDU - Moved Up',
	Prev_Value <=  75000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	Prev_Value <= 150000 and Curr_Value <= 150000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	Prev_Value <= 150000 and Curr_Value <= 450000 =>  '11 - SFDU-SFDU - Moved Up',
	Prev_Value <= 150000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	Prev_Value <= 300000 and Curr_Value <=  75000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	Prev_Value <= 300000 and Curr_Value <= 150000 =>  '09 - SFDU-SFDU - Moved Down',
	Prev_Value <= 300000 and Curr_Value <= 300000 =>  '10 - SFDU-SFDU - Stayed the Same',
	Prev_Value <= 300000 and Curr_Value <= 450000 =>  '11 - SFDU-SFDU - Moved Up',
	Prev_Value <= 300000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	Prev_Value <= 450000 and Curr_Value <=  75000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	Prev_Value <= 450000 and Curr_Value <= 300000 =>  '09 - SFDU-SFDU - Moved Down',
	Prev_Value <= 450000 and Curr_Value <= 450000 =>  '10 - SFDU-SFDU - Stayed the Same',
	Prev_Value <= 450000 and Curr_Value <= 600000 =>  '11 - SFDU-SFDU - Moved Up',
	Prev_Value <= 450000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	Prev_Value <= 600000 and Curr_Value <=  75000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	Prev_Value <= 600000 and Curr_Value <= 450000 =>  '09 - SFDU-SFDU - Moved Down',
	Prev_Value <= 600000 and Curr_Value <= 600000 =>  '10 - SFDU-SFDU - Stayed the Same',
	Prev_Value <= 600000 => '12 - SFDU-SFDU - Moved Way Up / Stayed Up',

	Curr_Value <=  75000 =>  '08 - SFDU-SFDU - Move Way Down / Stayed Down',
	Curr_Value <= 600000 =>  '09 - SFDU-SFDU - Moved Down',
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
		self.curr_addr_addr_type := curr_addr_addr_type;
		self.Curr_Addr_avm_automated_valuation := Curr_Addr_avm_automated_valuation; 
		self.Curr_Addr_avm_med_fips := curr_addr_avm_med_fips; 
		self.Curr_Addr_avm_med_geo11 := curr_addr_avm_med_geo11; 
		self.Curr_Addr_avm_med_geo12 := curr_addr_avm_med_geo12; 
		self.Curr_Addr_market_total_value := curr_addr_market_total_value; 
		self.Curr_Addr_pop := curr_addr_pop; 
		self.Prev_Addr_addr_type := prev_addr_addr_type; 
		self.Prev_Addr_avm_automated_valuation := prev_addr_avm_automated_valuation; 
		self.Prev_Addr_market_total_value := prev_addr_market_total_value; 
		self.Prev_Addr_pop := prev_addr_pop; 
		self.Prev_Addr_avm_med_fips := prev_addr_avm_med_fips; 
		self.Prev_Addr_avm_med_geo11 := prev_addr_avm_med_geo11; 
		self.Prev_Addr_avm_med_geo12 := prev_addr_avm_med_geo12; 
		self.economic_trajectory_string := economic_trajectory;
		self.economic_trajectory_index_string := economic_trajectory_index;
	#else
		self.economic_trajectory := (integer)economic_trajectory[1..2];
		self.economic_trajectory_index := (integer)economic_trajectory_index[1..2];
	#end
	self := le;
end;

with_trajectory := project(clam, append_trajectory(left));

return with_trajectory;

end;

