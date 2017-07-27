import AddrBest,STD;
EXPORT 	string1 findBestAddressConfidence(
																					AddrBest.Layout_BestAddr.batch_out_final rowBestAddress,
																					MemberPoint.Layouts.BatchInter rowBatchInter
																					) := function
					
					isBlankSource := rowBestAddress.srcs = '';
					/* Num of sources = count of commas in the srcs field + 1 */
					countOfSource  := (STD.Str.FindCount(rowBestAddress.srcs, ',') +1); 
					/* Give 10 points to each src if not blank  */
					SourceScorePre := if(isBlankSource, 0 , countOfSource * 10 );  
					/* We make it out of 100  */
					SourceScore		 := if(SourceScorePre > 100 ,100, SourceScorePre); 
					
					CompositAddressScore := 	map(	
															SourceScore <> 0 and rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Adult	=> ( SourceScore + 
																																			 MemberPoint.Constants.SubjectAdultScore)/2,
															
															SourceScore <> 0 and rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Guardian	=> ( SourceScore + 
																																			 MemberPoint.Constants.InputGuardianAdultScore)/2,
															
															SourceScore <> 0 and rowBatchInter.LN_search_name_type = MemberPoint.Constants.LNSearchNameType.Derived	 => ( SourceScore + 
																																				MemberPoint.Constants.DerivedGuardianAdultScore)/2,
															0);
															
				 CompositAddressConfidence :=  map( CompositAddressScore between  MemberPoint.Constants.BestAddressScore.HighMin	 
																																			 and MemberPoint.Constants.BestAddressScore.HighMax => 'H',
																						 CompositAddressScore between  MemberPoint.Constants.BestAddressScore.MidMin	 
																																			 and MemberPoint.Constants.BestAddressScore.MidMax => 'M',
																						 CompositAddressScore between  MemberPoint.Constants.BestAddressScore.LowMin	 
																																			 and MemberPoint.Constants.BestAddressScore.LowMax	 => 'L',
																						 ' '); 
		 return(CompositAddressConfidence);
		end;