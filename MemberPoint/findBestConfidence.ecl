export string1 findBestConfidence(
																	MemberPoint.Layouts.BestExtended rowBestE, 
																	MemberPoint.Layouts.BatchInter rowBatchInter) := function
																	
		IsAdlBestAddressBlank := rowBestE.best_addr1 = '' and  rowBestE.best_city = '' and 	rowBestE.best_state = '' and 	rowBestE.best_zip = '' ;											
		IsGood255 := rowBestE.verify_best_address  = 255 and not IsAdlBestAddressBlank;
		IsGood0 := rowBestE.verify_best_address  = 0 and not IsAdlBestAddressBlank;
		
		CompositAddressScore := 	map(	
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Adult and rowBestE.verify_best_address not in [0,255] => 
									( rowBestE.verify_best_address +  MemberPoint.Constants.SubjectAdultScore)/2,
							
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Guardian	and rowBestE.verify_best_address not in [0,255] => 
									( rowBestE.verify_best_address +  MemberPoint.Constants.InputGuardianAdultScore)/2,
							
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Derived and rowBestE.verify_best_address not in [0,255] => 
									( rowBestE.verify_best_address + 	MemberPoint.Constants.DerivedGuardianAdultScore)/2,
									
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Adult and IsGood0 => 
									( rowBestE.verify_best_address +  MemberPoint.Constants.SubjectAdultScore)/2,
							
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Guardian	and IsGood0 => 
									( rowBestE.verify_best_address +  MemberPoint.Constants.InputGuardianAdultScore)/2,
							
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Derived and IsGood0 => 
									( rowBestE.verify_best_address + 	MemberPoint.Constants.DerivedGuardianAdultScore)/2,		
							
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Adult and IsGood255 => 
									( MemberPoint.Constants.AdlBestAddressScore.MidAverage + MemberPoint.Constants.SubjectAdultScore)/2,
							
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Guardian and IsGood255 => 
									( MemberPoint.Constants.AdlBestAddressScore.MidAverage + MemberPoint.Constants.InputGuardianAdultScore)/2,
							
							rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Derived and IsGood255 => 
									( MemberPoint.Constants.AdlBestAddressScore.MidAverage + MemberPoint.Constants.DerivedGuardianAdultScore)/2,
															0);
							
										
		CompositAddressConfidence :=  map(
										 CompositAddressScore between  MemberPoint.Constants.AdlBestAddressScore.HighMin and 
																									 MemberPoint.Constants.AdlBestAddressScore.HighMax 		=> 'H',
										 CompositAddressScore between  MemberPoint.Constants.AdlBestAddressScore.MidMin and 
																									 MemberPoint.Constants.AdlBestAddressScore.MidMax 		=> 'M',
										 CompositAddressScore between  MemberPoint.Constants.AdlBestAddressScore.LowMin and 
																									 MemberPoint.Constants.AdlBestAddressScore.LowMax 		=> 'L',
										 '');
										 
		return(CompositAddressConfidence);
end;