EXPORT MacAddressSelectionEngine := macro 

/* Take the first ADLBest and Best Address row */
				BestRow := dsBestE((string)seq = l.acctno)[1];
				BestAddressRow := dsBestAddress(acctno = l.acctno)[1];
/* attribute to check if empty ADL Best's address*/
				IsBestAddressBlank := BestAddressRow.prim_name = ''  OR 
															 ((BestAddressRow.p_city_name = '' OR BestAddressRow.st = '') AND (BestAddressRow.z5 = '' ));
												 
/* attribute to check  if empty Best Address*/																 
			  IsBestBlank	:= BestRow.c_best_prim_name = ''  OR 
												 ((BestRow.c_best_p_city_name = '' OR BestRow.c_best_st = '') AND (BestRow.c_best_z5 = '' ));
												 
/* attributes to check 	for equality between ADL Best Address, Best Address and Input address. Disregard unit_desig :bug 190955 */
				IsBestEqualsInput :=  BestRow.c_best_prim_range = l.prim_range and
															BestRow.c_best_predir = l.predir and
															BestRow.c_best_prim_name = l.prim_name and
															BestRow.c_best_addr_suffix = l.addr_suffix and
															BestRow.c_best_postdir = l.postdir and
															BestRow.c_best_sec_range = l.sec_range and
															BestRow.c_best_p_city_name = l.p_city_name and
															BestRow.c_best_st = l.st and
															BestRow.c_best_z5 = l.z5;
																			
				IsBestAddressEqualsInput :=   
															BestAddressRow.prim_range = l.prim_range and
															BestAddressRow.predir = l.predir and
															BestAddressRow.prim_name = l.prim_name and
															BestAddressRow.suffix = l.addr_suffix and
															BestAddressRow.postdir = l.postdir and
															BestAddressRow.sec_range = l.sec_range and
															BestAddressRow.p_city_name = l.p_city_name and
															BestAddressRow.st = l.st and
															BestAddressRow.z5 = l.z5;
															
				IsBestEqualsBestAddress := 		
															BestRow.c_best_prim_range = BestAddressRow.prim_range and
															BestRow.c_best_predir = BestAddressRow.predir and
															BestRow.c_best_prim_name = BestAddressRow.prim_name and
															BestRow.c_best_addr_suffix = BestAddressRow.suffix and
															BestRow.c_best_postdir = BestAddressRow.postdir and
															BestRow.c_best_sec_range = BestAddressRow.sec_range and
															BestRow.c_best_p_city_name = BestAddressRow.p_city_name and
															BestRow.c_best_st = BestAddressRow.st and
															BestRow.c_best_z5 = BestAddressRow.z5;									
					
					
/* Find the rule it falls into based on the above attributes	*/
					RuleNumber :=  MemberPoint.findRule(IsBestAddressBlank,IsBestBlank,IsBestEqualsInput,IsBestAddressEqualsInput,IsBestEqualsBestAddress);
/* Find the confidence for ADL Bests's address */
					BestConfidence := MemberPoint.findBestConfidence(BestRow,l);
/* Find the confidence for Best Address */
					BestAddressConfidence := MemberPoint.findBestAddressConfidence(BestAddressRow ,l);

/*  Determine if the 2 confidence values are good enough */					
					IsBestConfidenceGood := map (
																		BParams.AddressConfidenceThreshold = 'L' and BestConfidence in ['L','M','H'] => true,
																		BParams.AddressConfidenceThreshold = 'M' and BestConfidence in ['M','H'] => true,
																		BParams.AddressConfidenceThreshold = 'H' and BestConfidence ='H' => true,
																		false);
																		
					IsBestAddressConfidenceGood :=  map (
																		BParams.AddressConfidenceThreshold = 'L' and BestAddressConfidence in ['L','M','H'] => true,
																		BParams.AddressConfidenceThreshold = 'M' and BestAddressConfidence in ['M','H'] => true,
																		BParams.AddressConfidenceThreshold = 'H' and BestAddressConfidence ='H' => true,
																		false);
																		
/* Calculate what goes into the output Address and NewAddress  */
	FillAddressWithPre1 :=  
		map (
			RuleNumber in [2,3,4,6,10]  => MemberPoint.Constants.FillWith.ADL_BEST,
			RuleNumber in [7,8]  => MemberPoint.Constants.FillWith.BEST_ADDRESS,
			RuleNumber in [1,5]  => MemberPoint.Constants.FillWith.BEST_ADDRESS,
			MemberPoint.Constants.FillWith.BLANK);

		FillNewAddressWithPre1 := 
		if( 
			RuleNumber in [2,10] , 
			MemberPoint.Constants.FillWith.BEST_ADDRESS,
			MemberPoint.Constants.FillWith.BLANK
			);
/* Blank based on confidence */
		FillAddressWithPre := 
		map ( 
				(FillAddressWithPre1 = MemberPoint.Constants.FillWith.ADL_BEST) and IsBestConfidenceGood 
																											=> MemberPoint.Constants.FillWith.ADL_BEST, 
				(FillAddressWithPre1 = MemberPoint.Constants.FillWith.BEST_ADDRESS) and IsBestAddressConfidenceGood 
																											=> MemberPoint.Constants.FillWith.BEST_ADDRESS,
																												 MemberPoint.Constants.FillWith.BLANK);

		FillNewAddressWithPre := 
		if(FillNewAddressWithPre1 = MemberPoint.Constants.FillWith.BEST_ADDRESS and 
				IsBestAddressConfidenceGood,
				MemberPoint.Constants.FillWith.BEST_ADDRESS,
				MemberPoint.Constants.FillWith.BLANK);
			
/* Now shift NewAddress to Address if Address is empty */
					isNeedToShift 			:= FillAddressWithPre = MemberPoint.Constants.FillWith.BLANK;
					FillAddressWith 		:= if(isNeedToShift,FillNewAddressWithPre,FillAddressWithPre);
					FillNewAddressWith 	:= if(isNeedToShift,MemberPoint.Constants.FillWith.BLANK,FillNewAddressWithPre);
									
/* Compute actual outputs before filling */
					ADLBestAdd1 := Address.Addr1FromComponents(	BestRow.c_best_prim_range,  BestRow.c_best_predir,  BestRow.c_best_prim_name,
																											BestRow.c_best_addr_suffix,  BestRow.c_best_postdir,  BestRow.c_best_unit_desig,  
																											BestRow.c_best_sec_range
																										) ;
													
					BestAddressAdd1 := Address.Addr1FromComponents(	BestAddressRow.prim_range,  BestAddressRow.predir,  
																													BestAddressRow.prim_name, BestAddressRow.suffix,  
																													BestAddressRow.postdir,  BestAddressRow.unit_desig,  
																													BestAddressRow.sec_range 
																												) ;
					ADLBest_address_match_codes := 	map(BestRow.verify_best_address = 100 =>'C',
																							BestRow.verify_best_address between 1 and 99 =>'U',
																							BestRow.verify_best_address = 255 =>'U',
																							'X');
					BestAddress_address_match_codes := map(
																									Not IsBestAddressBlank and IsBestAddressEqualsInput => 'C',
																									Not IsBestAddressBlank and Not IsBestAddressEqualsInput => 'U',
																									'X'
																								);


endmacro;