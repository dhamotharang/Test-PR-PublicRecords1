import incomeRisk_services, ut, address,Business_Risk, iesp;
export functions := module

    export checkSalary(integer borrowerSalary,
		                    string marketSalary25Percent,
		                    string marketSalary75Percent) := function
												
					  belowMarket  := borrowerSalary < (integer) marketSalary25Percent;
						withinMarket := borrowerSalary >= (integer) marketSalary25Percent and borrowerSalary <= (integer) marketSalary75Percent;
						aboveMarket  := borrowerSalary > (integer) marketSalary75Percent;
						
						belowMarketCode  := if (belowMarket, dataset([{incomeRisk_services.constants.BORROWER_SALARY_UNDER_MARKET_CODE,
											   incomeRisk_services.constants.BORROWER_SALARY_UNDER_MARKET_MSG}
												 ], iesp.share.t_riskIndicator));
            withinMarketCode := if (withinMarket, dataset([{incomeRisk_services.constants.BORROWER_SALARY_WITHIN_MARKET_CODE,
											   incomeRisk_services.constants.BORROWER_SALARY_WITHIN_MARKET_MSG}
												 ], iesp.share.t_riskIndicator));
						aboveMarketCode  := if (aboveMarket, dataset([{incomeRisk_services.constants.BORROWER_SALARY_ABOVE_MARKET_CODE,
											   incomeRisk_services.constants.BORROWER_SALARY_ABOVE_MARKET_MSG}
												 ], iesp.share.t_riskIndicator));
            												              												 
           return(belowMarketCode + withinMarketCode + aboveMarketCode);																		 
		end;						
		
    export checkMiles(integer miles_in) := function
		  // business rule: If over 100 miles between home address and work address return the risk code.
       milesOver := if (miles_in > incomeRisk_services.constants.mile_threshold,
			         			  dataset([{incomeRisk_services.constants.MILES_BETWEEN_HOME_WORK_RISKCODE,
											   incomeRisk_services.constants.MILES_BETWEEN_HOME_WORK_RISKCODE_MESSAGE}
											],iesp.share.t_RiskIndicator));
       return milesOver;
		end;
		
    export checkDOB(unsigned8 dob_in, unsigned8 age_in,                                        
																					integer yearsInProfession) := function
    // business rule: If DOB was entered, add 18 to current years in profession, flag if its greater that current age.
      val := if (dob_in <> 0,
			          if (incomeRisk_services.constants.age_threshold + yearsInProfession > age_in, 			          
								dataset([{incomeRisk_services.constants.DOB_RISKCODE,
								          incomeRisk_services.constants.DOB_RISKCODE_MESSAGE}],iesp.share.t_RiskIndicator)							
								));								
       return(val);								
    end;
    export distance_between_addr( dataset (Business_Risk.Layout_Input_Moxie_2) in_df) := function
	  		 
			addr_part1_1   := in_df[1].street_addr;
			prim_range_1   := in_df[1].prim_range;
			predir_1       := in_df[1].predir;
			prim_name_1    := in_df[1].prim_name;
			addr_suffix_1  := in_df[1].addr_suffix;
			postdir_1      := in_df[1].postdir;
			sec_range_1    := in_df[1].sec_range;
			city_1         := in_df[1].p_city_name;
			state_1        := in_df[1].st;
			zip_1          := in_df[1].z5;
			// person
			addr_part1_2   := in_df[1].street_addr2;
			prim_range_2   := in_df[1].prim_range_2;
			predir_2       := in_df[1].predir_2;
			prim_name_2    := in_df[1].prim_name_2;
			addr_suffix_2  := in_df[1].addr_suffix_2;
			postdir_2      := in_df[1].postdir_2;
			sec_range_2    := in_df[1].sec_range_2;
			city_2         := in_df[1].p_city_name_2;
			state_2        := in_df[1].st_2;
			zip_2          := in_df[1].z5_2;
			 
			//string addr_part1_2 := in_df[1].street_addr2;
		 
			unsigned1 region := address.Components.Country.US;
		 
			addr1_1 := if (addr_part1_1 = '', Address.Addr1FromComponents(prim_range_1, predir_1, prim_name_1,
		                                     addr_suffix_1, postdir_1, 
																				 '', sec_range_1), addr_part1_1);
		
			addr2_1 := if (addr_part1_2 = '', Address.Addr1FromComponents(prim_range_2, predir_2, prim_name_2,
		                                     addr_suffix_2, postdir_2, 
																				 '', sec_range_2), addr_part1_2);
																				 
			addr1_2 := Address.Addr2FromComponents(city_1, state_1, zip_1);
			addr2_2 := Address.Addr2FromComponents(city_2, state_2, zip_2);
		
			// use this ut.LL_Dist to pass in lat long.
			// requirement 4.3.060
			// obtain data fields (module) from "results" structure of address cleaner.
			addr1 := Address.GetCleanAddress(addr1_1, addr1_2, region).results;
			addr2 := Address.GetCleanAddress(addr2_1, addr2_2, region).results;
		
			lat1  := (real) addr1.latitude;
			long1 := (real) addr1.longitude;
		
			lat2 := (real) addr2.latitude;
			long2 := (real) addr2.longitude;
		
			//pick off the lat/long from each component
			// pass these values into ut.LL_Dist
		
			miles_apart := ut.LL_Dist(lat1, long1, lat2, long2);
			return miles_apart;
		end;

		end; // module