IMPORT BatchShare, FraudGovPlatform_Services, FraudShared, STD;

EXPORT Functions := MODULE
	
	EXPORT GetVelocityRules(FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION

		test_rulesFraudGov := DATASET([
																	{'LEXID', 'All Contributors', 20, 50, 1, 999, 1, 'Exceeds LEXID Velocity 1 in 2 day across All Contributors'},   //start of rules for customer 1
																	{'LEXID', 'All Contributors', 20, 50, 2, 999, 1, 'Exceeds LEXID Velocity 2 in 7 days across All Contributors'},
																	{'LEXID', 'All Contributors', 20, 50, 3, 999, 2, 'Exceeds LEXID Velocity 3 in 3 days across All Contributors'},
																	
																	{'LEXID', 'Customer', 10, 8, 1, 999, 1, 'Exceeds LEXID Velocity 1 in 1000 day across Customer'},   //start of rules for customer 1
																	{'LEXID', 'Customer', 10, 8, 2, 999, 1, 'Exceeds LEXID Velocity 2 in 7000 days across Customer'},
																	{'LEXID', 'Customer', 10, 8, 3, 999, 2, 'Exceeds LEXID Velocity 3 in 3000 days across Customer'},		
																	
																	{'LEXID', 'Customer Program', 10, 10, 1, 999, 1, 'Exceeds LEXID Velocity 1 in 1 day across Customer Program'},   //start of rules for customer 1
																	{'LEXID', 'Customer Program', 10, 10, 2, 999, 1, 'Exceeds LEXID Velocity 2 in 7 days across Customer Program'},
																	{'LEXID', 'Customer Program', 10, 10, 3, 999, 2, 'Exceeds LEXID Velocity 3 in 3 days across Customer Program'},			
																
																	{'LEXID', 'Customer Vertical', 10, 3, 1, 999, 1, 'Exceeds LEXID Velocity 1 in 1 day across Customer Vertical'},
																	{'LEXID', 'Customer Vertical', 10, 3, 2, 999, 1, 'Exceeds LEXID Velocity 2 in 7 days across Customer Vertical'},
																	{'LEXID', 'Customer Vertical', 10, 3, 3, 999, 2, 'Exceeds LEXID Velocity 3 in 6 day across Customer Vertical'},
																
																	{'LEXID','Transaction Type', 60, 60, 1, 999, 1, 'Exceeds LEXID Velocity 1 in 1 day by Transaction Type'},
																	{'LEXID','Transaction Type', 60, 60, 2, 999, 1, 'Exceeds LEXID Velocity 2 in 7 days by Transaction Type'},
																	{'LEXID','Transaction Type', 60, 60, 3, 999, 1, 'Exceeds LEXID Velocity 3 in 3 days by Transaction Type'},
																	
																	{'SSN', 'All Contributors', 50, 50, 1, 999, 1, 'Exceeds SSN Velocity 1 in 1 day across All Contributors'},
																	{'SSN', 'All Contributors', 50, 50, 2, 999, 2, 'Exceeds SSN Velocity 2 in 5 days across All Contributors'},
																	{'SSN', 'All Contributors', 50, 50, 3, 999, 3, 'Exceeds SSN Velocity 3 in 1 days across All Contributors'},
																	
																	{'SSN', 'Customer', 5, 8, 1, 999, 1, 'Exceeds SSN Velocity 1 in 1 day across Customer'},
																	{'SSN', 'Customer', 5, 8, 2, 999, 2, 'Exceeds SSN Velocity 2 in 2 days across Customer'},
																	{'SSN', 'Customer', 5, 8, 3, 999, 3, 'Exceeds SSN Velocity 3 in 3 days across Customer'},
																	
																	{'SSN', 'Customer Program', 5, 10, 1, 999, 1, 'Exceeds SSN Velocity 1 in 1 day across Customer Program'},
																	{'SSN', 'Customer Program', 5, 10, 2, 999, 2, 'Exceeds SSN Velocity 2 in 2 days across Customer Program'},
																	{'SSN', 'Customer Program', 5, 10, 3, 999, 3, 'Exceeds SSN Velocity 3 in 3 days across Customer Program'},
																	
																	{'SSN', 'Customer Vertical', 5, 3, 1, 999, 1, 'Exceeds SSN Velocity 1 in 1 day across Customer Vertical'},
																	{'SSN', 'Customer Vertical', 5, 3, 2, 999, 2, 'Exceeds SSN Velocity 2 in 2 days across Customer Vertical'},
																	{'SSN', 'Customer Vertical', 5, 3, 3, 999, 3, 'Exceeds SSN Velocity 3 in 3 days across Customer Vertical'},

																	{'SSN','Transaction Type', 60, 60, 1, 999, 1, 'Exceeds SSN Velocity 1 in 1 days by Transaction Type'},									
																	{'SSN','Transaction Type', 60, 60, 2, 999, 2, 'Exceeds SSN Velocity 2 in 7 days by Transaction Type'},									
																	{'SSN','Transaction Type', 60, 60, 3, 999, 3, 'Exceeds SSN Velocity 3 in 3 days by Transaction Type'}	,
																															
																	{'DEVICE_ID', 'Customer Program', 50, 10, 1, 999, 1, 'Exceeds Device ID Velocity 1 in 1 day across Customer Program'},
																	{'DEVICE_ID', 'Customer Program', 50, 10, 2, 999, 2, 'Exceeds Device ID Velocity 2 in 5 days across Customer Program'},
																	{'DEVICE_ID', 'Customer Program', 50, 10, 3, 999, 3, 'Exceeds Device ID Velocity 3 in 10 days across Customer Program'},
																								
																	{'DEVICE_ID','Transaction Type', 60, 60, 1, 999, 1, 'Exceeds Device ID Velocity 1 in 1 day by Transaction Type'},
																	{'DEVICE_ID','Transaction Type', 60, 60, 2, 999, 1, 'Exceeds Device ID Velocity 2 in 7 days by Transaction Type'},
																	{'DEVICE_ID','Transaction Type', 60, 60, 3, 999, 1, 'Exceeds Device ID Velocity 3 in 30 days by Transaction Type'},
																		
																	{'PHONE', 'Customer Program', 6, 10, 1, 999, 1, 'Exceeds Phone Velocity 1 in 1 day across Customer Program'},
																	{'PHONE', 'Customer Program', 6, 10, 2, 999, 2, 'Exceeds Phone Velocity 2 in 5 days across Customer Program'},
																	{'PHONE', 'Customer Program', 6, 10, 3, 999, 3, 'Exceeds Phone Velocity 3 in 10 days across Customer Program'},
																	
																	{'IP_ADDRESS', 'Customer Program', 7, 10, 1, 999, 1, 'Exceeds IP Address Velocity 1 in 1 day across Customer Program'},
																	{'IP_ADDRESS', 'Customer Program', 7, 10, 2, 999, 2, 'Exceeds IP Address Velocity 2 in 5 days across Customer Program'},
																	{'IP_ADDRESS', 'Customer Program', 7, 10, 3, 999, 3, 'Exceeds IP Address Velocity 3 in 10 days across Customer Program'},
														
																	{'BANK_ACCOUNT_NUMBER', 'Customer', 7, 10, 1, 999, 1, 'Exceeds Bank Account Number Velocity 1 in 1 day across Customer'},
																	{'BANK_ACCOUNT_NUMBER', 'Customer', 7, 10, 2, 999, 2, 'Exceeds Bank Account Number Velocity 2 in 5 days across Customer'},
																	{'BANK_ACCOUNT_NUMBER', 'Customer', 7, 10, 3, 999, 3, 'Exceeds Bank Account Number Velocity 3 in 10 days across Customer'},
																	
																	{'BANK_ACCOUNT_NUMBER', 'Customer Program', 7, 10, 1, 999, 1, 'Exceeds Bank Account Number Velocity 1 in 1 day across Customer Program'},
																	{'BANK_ACCOUNT_NUMBER', 'Customer Program', 7, 10, 2, 999, 2, 'Exceeds Bank Account Number Velocity 2 in 5 days across Customer Program'},
																	{'BANK_ACCOUNT_NUMBER', 'Customer Program', 7, 10, 3, 999, 3, 'Exceeds Bank Account Number Velocity 3 in 10 days across Customer Program'},
																																
																	{'BANK_ACCOUNT_NUMBER', 'All Contributors', 50, 50, 1, 999, 1, 'Exceeds Bank Account Number Velocity 1 in 2 day across All Contributors'},   //start of rules for customer 1
																	{'BANK_ACCOUNT_NUMBER', 'All Contributors', 50, 50, 2, 999, 1, 'Exceeds Bank Account Number Velocity 2 in 7 days across All Contributors'},
																	{'BANK_ACCOUNT_NUMBER', 'All Contributors', 50, 50, 3, 999, 2, 'Exceeds Bank Account Number Velocity 3 in 30 days across All Contributors'},
																		
																	{'BANK_ACCOUNT_NUMBER','Transaction Type', 30, 30, 1, 999, 1, 'Exceeds Bank Account Number Velocity 1 in 2 days by Transaction Type'},									
																	{'BANK_ACCOUNT_NUMBER','Transaction Type', 30, 30, 2, 999, 2, 'Exceeds Bank Account Number Velocity 2 in 7days by Transaction Type'},									
																	{'BANK_ACCOUNT_NUMBER','Transaction Type', 30, 30, 3, 999, 3, 'Exceeds Bank Account Number Velocity 3 in 30 days by Transaction Type'}	,
																
																	{'DRIVERS_LICENSE_NUMBER', 'Customer Program', 7, 10, 1, 999, 1, 'Exceeds Drivers License Number Velocity 1 in 1 day across Customer Program'},
																	{'DRIVERS_LICENSE_NUMBER', 'Customer Program', 7, 10, 2, 999, 2, 'Exceeds Drivers License Number Velocity 2 in 5 days across Customer Program'},
																	{'DRIVERS_LICENSE_NUMBER', 'Customer Program', 7, 10, 3, 999, 3, 'Exceeds Drivers License Number Velocity 3 in 10 days across Customer Program'},

																	{'PHYSICAL_ADDRESS', 'Customer Program', 7, 10, 1, 999, 1, 'Exceeds Physical Address Velocity 1 in 1 day across Customer Program'},
																	{'PHYSICAL_ADDRESS', 'Customer Program', 7, 10, 2, 999, 2, 'Exceeds Physical Address Velocity 2 in 5 days across Customer Program'},
																	{'PHYSICAL_ADDRESS', 'Customer Program', 7, 10, 3, 999, 3, 'Exceeds Physical Address Velocity 3 in 10 days across Customer Program'}

																	],FraudShared_Services.Layouts.layout_rules);
															
		actual_rulesFraudGov := DATASET([
																		{'LEXID', 'All Contributors', 20, 50, 1, 1, 1, 'Exceeds LEXID Velocity 1 in 1 day across All Contributors'},   //start of rules for customer 1
																		{'LEXID', 'All Contributors', 20, 50, 2, 7, 1, 'Exceeds LEXID Velocity 2 in 7 days across All Contributors'},
																		{'LEXID', 'All Contributors', 20, 50, 3, 30, 2, 'Exceeds LEXID Velocity 3 in 30 days across All Contributors'},
																		
																		{'LEXID', 'Customer', 10, 8, 1, 1, 1, 'Exceeds LEXID Velocity 1 in 1 day across Customer'},   //start of rules for customer 1
																		{'LEXID', 'Customer', 10, 8, 2, 7, 1, 'Exceeds LEXID Velocity 2 in 7 days across Customer'},
																		{'LEXID', 'Customer', 10, 8, 3, 30, 2, 'Exceeds LEXID Velocity 3 in 30 days across Customer'},		
																		
																		{'LEXID', 'Customer Program', 10, 10, 1, 1, 1, 'Exceeds LEXID Velocity 1 in 1 day across Customer Program'},   //start of rules for customer 1
																		{'LEXID', 'Customer Program', 10, 10, 2, 7, 1, 'Exceeds LEXID Velocity 2 in 7 days across Customer Program'},
																		{'LEXID', 'Customer Program', 10, 10, 3, 30, 2, 'Exceeds LEXID Velocity 3 in 30 days across Customer Program'},			
																	
																		{'LEXID', 'Customer Vertical', 10, 3, 1, 1, 1, 'Exceeds LEXID Velocity 1 in 1 day across Customer Vertical'},
																		{'LEXID', 'Customer Vertical', 10, 3, 2, 7, 1, 'Exceeds LEXID Velocity 2 in 7 days across Customer Vertical'},
																		{'LEXID', 'Customer Vertical', 10, 3, 3, 30, 2, 'Exceeds LEXID Velocity 3 in 30 day across Customer Vertical'},
																	
																		{'LEXID','Transaction Type', 60, 60, 1, 1, 1, 'Exceeds LEXID Velocity 1 in 1 day by Transaction Type'},
																		{'LEXID','Transaction Type', 60, 60, 2, 7, 1, 'Exceeds LEXID Velocity 2 in 7 days by Transaction Type'},
																		{'LEXID','Transaction Type', 60, 60, 3, 30, 1, 'Exceeds LEXID Velocity 3 in 30 days by Transaction Type'},
																		
																		{'SSN', 'All Contributors', 50, 50, 1, 1, 1, 'Exceeds SSN Velocity 1 in 1 day across All Contributors'},
																		{'SSN', 'All Contributors', 50, 50, 2, 7, 2, 'Exceeds SSN Velocity 2 in 7 days across All Contributors'},
																		{'SSN', 'All Contributors', 50, 50, 3, 30, 3, 'Exceeds SSN Velocity 3 in 1 days across All Contributors'},
																		
																		{'SSN', 'Customer', 5, 8, 1, 1, 1, 'Exceeds SSN Velocity 1 in 1 day across Customer'},
																		{'SSN', 'Customer', 5, 8, 2, 7, 2, 'Exceeds SSN Velocity 2 in 7 days across Customer'},
																		{'SSN', 'Customer', 5, 8, 3, 30, 3, 'Exceeds SSN Velocity 3 in 30 days across Customer'},
																		
																		{'SSN', 'Customer Program', 5, 10, 1, 1, 1, 'Exceeds SSN Velocity 1 in 1 day across Customer Program'},
																		{'SSN', 'Customer Program', 5, 10, 2, 7, 2, 'Exceeds SSN Velocity 2 in 7 days across Customer Program'},
																		{'SSN', 'Customer Program', 5, 10, 3, 30, 3, 'Exceeds SSN Velocity 3 in 3 days across Customer Program'},
																		
																		{'SSN', 'Customer Vertical', 5, 3, 1, 1, 1, 'Exceeds SSN Velocity 1 in 1 day across Customer Vertical'},
																		{'SSN', 'Customer Vertical', 5, 3, 2, 7, 2, 'Exceeds SSN Velocity 2 in 7 days across Customer Vertical'},
																		{'SSN', 'Customer Vertical', 5, 3, 3, 30, 3, 'Exceeds SSN Velocity 3 in 30 days across Customer Vertical'},

																		{'SSN','Transaction Type', 60, 60, 1, 1, 1, 'Exceeds SSN Velocity 1 in 1 days by Transaction Type'},									
																		{'SSN','Transaction Type', 60, 60, 2, 7, 2, 'Exceeds SSN Velocity 2 in 7 days by Transaction Type'},									
																		{'SSN','Transaction Type', 60, 60, 3, 30, 3, 'Exceeds SSN Velocity 3 in 30 days by Transaction Type'}	,
																																
																		{'DEVICE_ID', 'Customer Program', 50, 10, 1, 1, 1, 'Exceeds Device ID Velocity 1 in 1 day across Customer Program'},
																		{'DEVICE_ID', 'Customer Program', 50, 10, 2, 7, 2, 'Exceeds Device ID Velocity 2 in 7 days across Customer Program'},
																		{'DEVICE_ID', 'Customer Program', 50, 10, 3, 30, 3, 'Exceeds Device ID Velocity 3 in 30 days across Customer Program'},
																									
																		{'DEVICE_ID','Transaction Type', 60, 60, 1, 1, 1, 'Exceeds Device ID Velocity 1 in 1 day by Transaction Type'},
																		{'DEVICE_ID','Transaction Type', 60, 60, 2, 7, 1, 'Exceeds Device ID Velocity 2 in 7 days by Transaction Type'},
																		{'DEVICE_ID','Transaction Type', 60, 60, 3, 30, 1, 'Exceeds Device ID Velocity 3 in 30 days by Transaction Type'},
																			
																		{'PHONE', 'Customer Program', 6, 10, 1, 1, 1, 'Exceeds Phone Velocity 1 in 1 day across Customer Program'},
																		{'PHONE', 'Customer Program', 6, 10, 2, 7, 2, 'Exceeds Phone Velocity 2 in 7 days across Customer Program'},
																		{'PHONE', 'Customer Program', 6, 10, 3, 30, 3, 'Exceeds Phone Velocity 3 in 30 days across Customer Program'},
																		
																		{'IP_ADDRESS', 'Customer Program', 7, 10, 1, 1, 1, 'Exceeds IP Address Velocity 1 in 1 day across Customer Program'},
																		{'IP_ADDRESS', 'Customer Program', 7, 10, 2, 7, 2, 'Exceeds IP Address Velocity 2 in 7 days across Customer Program'},
																		{'IP_ADDRESS', 'Customer Program', 7, 10, 3, 30, 3, 'Exceeds IP Address Velocity 3 in 30 days across Customer Program'},
															
																		{'BANK_ACCOUNT_NUMBER', 'Customer', 7, 10, 1, 1, 1, 'Exceeds Bank Account Number Velocity 1 in 1 day across Customer'},
																		{'BANK_ACCOUNT_NUMBER', 'Customer', 7, 10, 2, 7, 2, 'Exceeds Bank Account Number Velocity 2 in 7 days across Customer'},
																		{'BANK_ACCOUNT_NUMBER', 'Customer', 7, 10, 3, 30, 3, 'Exceeds Bank Account Number Velocity 3 in 30 days across Customer'},
																		
																		{'BANK_ACCOUNT_NUMBER', 'Customer Program', 7, 10, 1, 1, 1, 'Exceeds Bank Account Number Velocity 1 in 1 day across Customer Program'},
																		{'BANK_ACCOUNT_NUMBER', 'Customer Program', 7, 10, 2, 7, 2, 'Exceeds Bank Account Number Velocity 2 in 7 days across Customer Program'},
																		{'BANK_ACCOUNT_NUMBER', 'Customer Program', 7, 10, 3, 30, 3, 'Exceeds Bank Account Number Velocity 3 in 30 days across Customer Program'},
																																	
																		{'BANK_ACCOUNT_NUMBER', 'All Contributors', 50, 50, 1, 1, 1, 'Exceeds Bank Account Number Velocity 1 in 2 day across All Contributors'},   //start of rules for customer 1
																		{'BANK_ACCOUNT_NUMBER', 'All Contributors', 50, 50, 2, 7, 1, 'Exceeds Bank Account Number Velocity 2 in 7 days across All Contributors'},
																		{'BANK_ACCOUNT_NUMBER', 'All Contributors', 50, 50, 3, 30, 2, 'Exceeds Bank Account Number Velocity 3 in 30 days across All Contributors'},
																			
																		{'BANK_ACCOUNT_NUMBER','Transaction Type', 30, 30, 1, 1, 1, 'Exceeds Bank Account Number Velocity 1 in 1 days by Transaction Type'},									
																		{'BANK_ACCOUNT_NUMBER','Transaction Type', 30, 30, 2, 7, 2, 'Exceeds Bank Account Number Velocity 2 in 7 days by Transaction Type'},									
																		{'BANK_ACCOUNT_NUMBER','Transaction Type', 30, 30, 3, 30, 3, 'Exceeds Bank Account Number Velocity 3 in 30 days by Transaction Type'}	,
																	
																		{'DRIVERS_LICENSE_NUMBER', 'Customer Program', 7, 10, 1, 1, 1, 'Exceeds Drivers License Number Velocity 1 in 1 day across Customer Program'},
																		{'DRIVERS_LICENSE_NUMBER', 'Customer Program', 7, 10, 2, 7, 2, 'Exceeds Drivers License Number Velocity 2 in 7 days across Customer Program'},
																		{'DRIVERS_LICENSE_NUMBER', 'Customer Program', 7, 10, 3, 30, 3, 'Exceeds Drivers License Number Velocity 3 in 30 days across Customer Program'},

																		{'PHYSICAL_ADDRESS', 'Customer Program', 7, 10, 1, 1, 1, 'Exceeds Physical Address Velocity 1 in 1 day across Customer Program'},
																		{'PHYSICAL_ADDRESS', 'Customer Program', 7, 10, 2, 7, 2, 'Exceeds Physical Address Velocity 2 in 7 days across Customer Program'},
																		{'PHYSICAL_ADDRESS', 'Customer Program', 7, 10, 3, 30, 3, 'Exceeds Physical Address Velocity 3 in 30 days across Customer Program'}

																	],FraudShared_Services.Layouts.layout_rules);
															
		// rulesFDN is not currently being used but it is expected to be used in the future.
		rulesFraudGov := if(batch_params.TestVelocityRules, test_rulesFraudGov, actual_rulesFraudGov);

		rulesFDN := DATASET([], FraudShared_Services.Layouts.layout_rules);

		rules := IF(batch_params.FraudPlatform = FraudGovPlatform_Services.Constants.FRAUD_PLATFORM, rulesFraudGov, rulesFDN);

		RETURN rules;

	END;
	
	EXPORT GetTopVelocityExceeded(DATASET(FraudShared_Services.Layouts.layout_buckets_found) ds_velocity_recs,
															  INTEGER max_velocities = 3) := FUNCTION
		
		ds_weighted_velocity_recs := PROJECT(ds_velocity_recs, 
																		TRANSFORM(FraudShared_Services.Layouts.layout_scored_buckets, 
																				SELF.velocity_score := (LEFT.fragment_weight * LEFT.category_weight * 
																															  LEFT.foundcnt)/LEFT.numDays;
																				SELF := LEFT));

		ds_weighted_velocity_recs_grp := GROUP(SORT(ds_weighted_velocity_recs, acctno, -velocity_score), acctno);
		
		ds_velocity_recs_top := TOPN(ds_weighted_velocity_recs_grp, max_velocities, acctno);
		// output(ds_weighted_velocity_recs,named('ds_weighted_velocity_recs'));
		RETURN UNGROUP(ds_velocity_recs_top);		
		
	END;
	
	EXPORT GetVelocityExceeded(DATASET(FraudShared_Services.Layouts.layout_velocity_in) ds_recs, 
														 DATASET(FraudShared_Services.Layouts.layout_rules) ds_rules) := FUNCTION
	
		//set today's date to be used in AGE calculation
		today := STD.Date.Today();

		// precalculate record's age and add to records to use going forward.
		ds_recs_age := PROJECT(ds_recs, 
										TRANSFORM(FraudShared_Services.Layouts.layout_velocity_in, 
												SELF.age := ABS(STD.Date.DaysBetween(today, LEFT.date));
												SELF := LEFT));

		//split rules into thoese based on bucket type and those for all transaction types.
		ds_rulestype := ds_rules(contributiontype <> 'Transaction Type');
		ds_rulestrans := ds_rules(contributiontype = 'Transaction Type');
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		get_buckets(ds_rules_in, useContributionType = FALSE, allContrib = FALSE) := FUNCTIONMACRO
			ds_buckets_contrib := JOIN(ds_recs_age, ds_rules_in,
															useContributionType AND
															LEFT.fragment = RIGHT.fragment AND
															LEFT.contributionType = RIGHT.contributionType AND
															LEFT.age < RIGHT.numDays, //this drops all tranactions that happen longer than the greatest 
																												//numDays in rules for that customer.
																	TRANSFORM(FraudShared_Services.Layouts.layout_buckets,
																			SELF := LEFT, 
																			SELF := RIGHT));
							
			ds_buckets_no_contrib := JOIN(ds_recs_age, ds_rules_in,
																	NOT useContributionType AND
																	LEFT.fragment = RIGHT.fragment AND
																	LEFT.age < RIGHT.numDays, //this drops all tranactions that happen longer than the greatest 
																														//numDays in rules for that customer.
																			TRANSFORM(FraudShared_Services.Layouts.layout_buckets,
																					SELF := LEFT, 
																					SELF := RIGHT));
																								
			ds_buckets_out := MAP(allContrib => ds_buckets_contrib,
													  useContributionType => ds_buckets_contrib, 
														ds_buckets_no_contrib);	

			ds_velocity_cands := MAP(allContrib =>
																	TABLE(ds_buckets_out,
																	// don't really need contributionType, description or maxCnt here
																	// but the datasets have to be the same size.
																		{acctno, fragment, contributionType, fragment_weight, category_weight, 
																		 ruleNum, maxCnt, numDays, description, foundCnt := COUNT(GROUP)},
																		 acctno, fragment, ruleNum),
																	TABLE(ds_buckets_out, 
																		{acctno, fragment, contributionType, fragment_weight, category_weight, 
																		 ruleNum, maxCnt, numDays, description, foundCnt := COUNT(GROUP)},
																		 acctno, fragment, contributionType, ruleNum));

			ds_velocity_cands_temp := PROJECT(ds_velocity_cands, 
																		TRANSFORM(FraudShared_Services.Layouts.layout_buckets_found,
																				SELF := LEFT, 
																				SELF := []));
																			
			FraudShared_Services.Layouts.layout_buckets_found xdenorm_w_rec_ids(FraudShared_Services.Layouts.layout_buckets_found l, 
																        DATASET(FraudShared_Services.Layouts.layout_buckets) r) := TRANSFORM
																			
				SELF.ds_record_ids := PROJECT(r, TRANSFORM({UNSIGNED8 record_id}, SELF := LEFT));
				SELF := l;
			END;
			
			// Roll By Transaction Type records back up
			ds_contrib_w_rec_ids := DENORMALIZE(ds_velocity_cands_temp, ds_buckets_out,
																					useContributionType AND
																					LEFT.acctno = RIGHT.acctno AND
																					LEFT.fragment = RIGHT.fragment AND
																					LEFT.contributionType = RIGHT.contributionType AND
																					LEFT.ruleNum = RIGHT.ruleNum,
																					GROUP,
																							xdenorm_w_rec_ids(LEFT,ROWS(RIGHT))); 		

			ds_no_contrib_w_rec_ids := DENORMALIZE(ds_velocity_cands_temp, ds_buckets_out,
																						NOT useContributionType AND
																						LEFT.acctno = RIGHT.acctno AND
																						LEFT.fragment = RIGHT.fragment AND
																						LEFT.ruleNum = RIGHT.ruleNum,
																						GROUP,			
																								xdenorm_w_rec_ids(LEFT, ROWS(RIGHT)));		
																								
			// All Contributors is the sum of all recs found for all the contributionTypes.													
			ds_all_contributors_w_rec_ids := JOIN(ds_velocity_cands_temp, ds_buckets_out,
																					LEFT.acctno = RIGHT.acctno AND
																					LEFT.fragment = RIGHT.fragment AND
																					LEFT.ruleNum = RIGHT.ruleNum,
																					TRANSFORM(FraudShared_Services.Layouts.layout_buckets, 
																							SELF.contributionType := ''; //we'll assign this later.  																																		
																							SELF := LEFT,
																							SELF := RIGHT));
													
			ds_all_contributors_w_rec_ids_norm_ddp := DEDUP(SORT(ds_all_contributors_w_rec_ids, acctno, fragment, 
																													 ruleNum, record_id), 
																										acctno, fragment, ruleNum, record_id);

			// Roll All Contributor records back up.
			ds_all_contributors_temp := PROJECT(ds_buckets_out, 
																			TRANSFORM(FraudShared_Services.Layouts.layout_buckets_found,
																					SELF.contributionType := 'All Contributors',
																					SELF := LEFT, 
																					SELF := []));
			
			// Attach the record_id of all all the payload records that contributed to the count		
			ds_all_contributors_denorm := DENORMALIZE(ds_all_contributors_temp, ds_all_contributors_w_rec_ids_norm_ddp,
																				LEFT.acctno = RIGHT.acctno AND
																				LEFT.fragment = RIGHT.fragment AND
																				LEFT.ruleNum = RIGHT.ruleNum,
																				GROUP,
																						xdenorm_w_rec_ids(LEFT, ROWS(RIGHT)));

			ds_all_contributors_w_rec_ids2 := JOIN(ds_all_contributors_denorm, ds_rulestype,
																			LEFT.fragment = RIGHT.fragment AND
																			LEFT.contributionType = RIGHT.contributionType AND
																			LEFT.rulenum = RIGHT.rulenum,
																					TRANSFORM(FraudShared_Services.Layouts.layout_buckets_found,
																							SELF := RIGHT, 
																							SELF := LEFT));

			ds_velocity_w_rec_ids := MAP(allContrib => ds_all_contributors_w_rec_ids2,
																	 useContributionType => ds_contrib_w_rec_ids,
																	 ds_no_contrib_w_rec_ids);
			
			ds_velocity_w_rec_ids2 := PROJECT(ds_velocity_w_rec_ids,
																		TRANSFORM(FraudShared_Services.Layouts.layout_buckets_found, 
																				SELF := LEFT));		
																			
			RETURN ds_velocity_w_rec_ids2;
			
		ENDMACRO;
		//////////////////////////////////////////////////////////////////////////////////////
		
		//==============================================================================
		//Create contibution type buckets
		//==============================================================================

		ds_buckets := get_buckets(ds_rulestype, TRUE, FALSE);	

		//==============================================================================
		//Create Transaction type buckets
		//==============================================================================
		
		ds_transBuckets := get_buckets(ds_rulestrans, FALSE, FALSE);

		//==============================================================================
		//Create All Contributors buckets
		//==============================================================================																					
		ds_buckets_allContrib := get_buckets(ds_rulestype, TRUE, TRUE);							
															
		ds_recs_all := ds_buckets + ds_transBuckets + ds_buckets_allContrib;	
		
		//only those records that exceed max velocity
		ds_velocity_recs := ds_recs_all(foundCnt >= maxCnt);
		
		ds_velocity_recs_found := PROJECT(ds_recs_all, 
																	TRANSFORM(FraudShared_Services.Layouts.layout_buckets_found,
																			SELF := LEFT,
																			self := []));
		RETURN ds_velocity_recs_found;
		
	END;
	
	EXPORT getFragmentMatchTypes(DATASET(FraudShared_Services.Layouts.BatchIn_rec) ds_batch_in,
															 DATASET(FraudShared_Services.Layouts.Raw_payload_rec) ds_payload,
															 FraudGovPlatform_Services.IParam.BatchParams batch_params) := FUNCTION
	
			rec_velocity_matches :=  RECORD
				BatchShare.Layouts.ShareAcct;
				UNSIGNED8 record_id;
				STRING date;
				DATASET({STRING fragmentType}) fragment_matches;
				DATASET({STRING contributionType}) contributionType_matches;
			END;

			layout_velocity_in_temp := RECORD
				BatchShare.Layouts.ShareAcct;
				UNSIGNED8 record_id;
				STRING fragment;
				STRING date;
				DATASET({STRING contributionType}) contributionType_matches;
			END;
			
			rec_velocity_matches xform_velocity_matches(FraudShared_Services.Layouts.BatchIn_rec l, 
																								  FraudShared_Services.Layouts.Raw_Payload_rec r) := TRANSFORM
					
			SELF.acctno := l.acctno;
			SELF.date := r.event_date;
			SELF.record_id := r.record_id;
					
			person :=  IF(l.did <> 0 AND 
										l.did = r.did, 
										DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.PERSON_FRAGMENT}], 
												{STRING fragmentType}));
												
			name :=  IF(l.name_last <> '' AND 
									l.name_first <> '' AND
									stringlib.StringToUpperCase(l.name_first) = stringlib.StringToUpperCase(r.cleaned_name.fname) AND
									stringlib.StringToUpperCase(l.name_last) = stringlib.StringToUpperCase(r.cleaned_name.lname), 
									DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.NAME_FRAGMENT}], 
											{STRING fragmentType}));
												
			ssn :=  IF(l.ssn <> '' AND 
								 l.ssn = r.ssn, 
								 DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.SSN_FRAGMENT}], 
										{STRING fragmentType}));
					 
			physicalAddress :=  IF(l.prim_range = r.clean_address.prim_range AND
															stringlib.StringToUpperCase(l.prim_name) = r.clean_address.prim_name AND
															l.sec_range = r.clean_address.sec_range AND
															l.unit_desig = r.clean_address.unit_desig AND
															((stringlib.StringToUpperCase(l.p_city_name) = r.clean_address.p_city_name AND 
															stringlib.StringToUpperCase(l.st) = r.clean_address.st ) OR
															l.z5 = r.clean_address.zip), 
															DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.PHYSICAL_ADDRESS_FRAGMENT}], 
																	{STRING fragmentType}));
															
			mailing_address_1 := IF(l.mailing_addr <> '', TRIM(stringlib.StringToUpperCase(l.mailing_addr)), l.mailing_prim_range + ' ' + 
															TRIM(stringlib.StringToUpperCase(l.mailing_predir)) + ' ' + 
															TRIM(stringlib.StringToUpperCase(l.mailing_prim_name)) + 
															' ' + TRIM(stringlib.StringToUpperCase(l.mailing_addr_suffix)) + ' ' + 
															TRIM(stringlib.StringToUpperCase(l.mailing_postdir)));
			
			mailing_address_2 := TRIM(stringlib.StringToUpperCase(l.mailing_unit_desig)) + ' ' + l.mailing_sec_range;
			
			mailingAddress :=  IF(mailing_address_1 = r.additional_address.street_1 AND
														mailing_address_2 = r.additional_address.street_2 OR 
														((stringlib.StringToUpperCase(l.mailing_p_city_name) = r.additional_address.city AND 
														stringlib.StringToUpperCase(l.mailing_st) = r.additional_address.state ) OR
														l.mailing_z5 = r.additional_address.zip), 
														DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.MAILING_ADDRESS_FRAGMENT}], 
																{STRING fragmentType}));			
															 
			IPAddress :=  IF(l.ip_address <> '' AND 
											 l.ip_address = r.IP_Address, 
											 DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.IP_ADDRESS_FRAGMENT}], 
													{STRING fragmentType}));
													
			phone :=  IF(l.phoneno <> '' AND 
									 ((l.phoneno = r.clean_phones.phone_number) OR 
										(l.phoneno = r.clean_phones.cell_phone)), 
										DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.PHONE_FRAGMENT}], 
												{STRING fragmentType}));
						
			deviceID :=  IF(l.device_id <> '' AND 
											l.device_id = r.device_id, 
											DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.DEVICE_ID_FRAGMENT}], 
													{STRING fragmentType}));
										
			driversLicenseNumber :=  IF(l.dl_number <> '' AND 
																	l.dl_state <> '' AND
																	l.dl_state = r.drivers_license_state AND
																	l.dl_number  = r.drivers_license, 
																	DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.DRIVERS_LICENSE_NUMBER_FRAGMENT}], 
																			{STRING fragmentType}));

			bankAccountNumber := IF(l.bank_account_number <> '' AND
															l.bank_routing_number <> '' AND
															l.bank_routing_number = r.bank_routing_number_1 AND
															l.bank_account_number = r.bank_account_number_1,
															DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.BANK_ACCOUNT_NUMBER_FRAGMENT}], 
																	{STRING fragmentType}));
																																	
			geolocation :=  IF(l.geo_lat <> '' AND l.geo_long <> '' AND 
												 l.geo_lat = r.clean_address.geo_lat AND 
												 l.geo_long = r.clean_address.geo_long, 
												 DATASET([{FraudGovPlatform_Services.Constants.Fragment_Types.GEOLOCATION_FRAGMENT}], 
														{STRING fragmentType}));
									
			customer := IF(batch_params.GlobalCompanyId = r.classification_permissible_use_access.gc_id, 
											DATASET([{'Customer'}], {STRING contributionType}));
			
			customerProgram := IF(batch_params.IndustryType = r.classification_permissible_use_access.ind_type,
													DATASET([{'Customer Program'}], {STRING contributionType}));
			
			customerAgency := DATASET([], {STRING contributionType});
			
			SELF.fragment_matches := person + name + ssn + physicalAddress + mailingAddress + IPAddress + 
															 phone + deviceID + driversLicenseNumber + bankAccountNumber + geolocation;
											 
			SELF.contributionType_matches := customer + customerProgram + customerAgency;
														
			SELF := [];
		END;

		// this set of recs has to be generated based on rows each customer has access to and match in some way with 
		// their request criteria.
		ds_velocity_matches := JOIN(ds_batch_in, ds_payload,
																LEFT.acctno = RIGHT.acctno,
																		xform_velocity_matches(LEFT, RIGHT));

		layout_velocity_in_temp xnorm_fragment(rec_velocity_matches l, {STRING fragmentType} r) := TRANSFORM
			SELF.acctno := l.acctno;
			SELF.fragment :=  r.fragmentType;
			SELF.date := l.date;
			SELF.contributionType_matches := l.contributionType_matches;
			SELF.record_id := l.record_id;
			SELF :=  l;
			SELF := [];
		END;

		fragment_recs_norm := NORMALIZE(ds_velocity_matches, LEFT.fragment_matches, xnorm_fragment(LEFT,  RIGHT));

		FraudShared_Services.layouts.layout_velocity_in xnorm_contributionType(layout_velocity_in_temp l, 
																															      {STRING contributionType} r) := TRANSFORM
			SELF.acctno := l.acctno;
			SELF.fragment :=  l.fragment;
			SELF.date := (INTEGER)l.date;
			SELF.contributionType := r.contributionType;
			SELF :=  l;
			SELF := [];
		END;

		contributionType_recs_norm := NORMALIZE(fragment_recs_norm, 
																			LEFT.contributionType_matches, 
																					xnorm_contributionType(LEFT,  RIGHT));
		RETURN contributionType_recs_norm;
		
	END;
	
	EXPORT AddPayload(DATASET(FraudShared_Services.Layouts.layout_scored_buckets) ds_velocity_recs,
										DATASET(FraudShared_Services.Layouts.Raw_payload_rec) ds_payload) := FUNCTION
																
		rec_w_record_ids := RECORD
			FraudShared_Services.Layouts.layout_scored_buckets - [ds_record_ids];
			UNSIGNED8 record_id;
		END;
		
		rec_w_record_ids xnorm_rec_id(ds_velocity_recs l, {unsigned8 record_id} r) := TRANSFORM
			SELF := r;
			SELF := l;
		END;
	
		ds_velocity_recs_norm := NORMALIZE(ds_velocity_recs, 		
															LEFT.ds_record_ids,
																	xnorm_rec_id(LEFT, RIGHT));

		rec_w_payload := RECORD
			ds_velocity_recs_norm;
			FraudShared.Layouts_Key.Main;
		END;
		
		ds_velocity_recs_norm_w_payload := JOIN(ds_velocity_recs_norm, ds_payload,
																						LEFT.acctno = RIGHT.acctno AND
																						LEFT.record_id = RIGHT.record_id,
																									TRANSFORM(rec_w_payload,
																											SELF.acctno := LEFT.acctno;
																											SELF := RIGHT,
																											SELF := LEFT));
															
		rec_w_payload2 := RECORD
			rec_w_payload;
			DATASET(FraudShared.Layouts_Key.Main) ds_payload;
		END;
		
		ds_rec_velocity_recs_denorm_w_payload_temp := PROJECT(ds_velocity_recs_norm_w_payload, 
																											TRANSFORM(rec_w_payload2,
																													SELF := LEFT,
																													SELF := []));
										
		rec_w_payload2 xform_roll(rec_w_payload2 l, DATASET(rec_w_payload2) allRows) := TRANSFORM
				SELF.acctno := l.acctno;
				SELF.ds_payload := PROJECT(allRows, TRANSFORM(FraudShared.Layouts_Key.Main, SELF := LEFT));
				SELF := l;
		END;
		
		ds_rec_velocity_recs_denorm_w_payload_temp_grp := GROUP(SORT(ds_rec_velocity_recs_denorm_w_payload_temp, acctno, 
																																fragment, contributionType, ruleNum), 
																													acctno, fragment, contributionType, ruleNum);
		
		ds_velocity_recs_denorm_w_payload:= ROLLUP(ds_rec_velocity_recs_denorm_w_payload_temp_grp,
																						GROUP,
																								xform_roll(LEFT, ROWS(LEFT)));
		RETURN ds_velocity_recs_denorm_w_payload;
														
	END;
		
END;