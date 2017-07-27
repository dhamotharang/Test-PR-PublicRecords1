IMPORT UT;

EXPORT GetBusnKRIs(DATASET(Layouts.BusnLayoutV2) BusnBDIDs) := FUNCTION


Layouts.BusnLayoutV2  BusnKRIs(BusnBDIDs le)  := TRANSFORM
  sysdate := if(le.historydate <> 999999, (integer)((string)le.historydate[1..6]), (integer)(ut.GetDate[1..6]));
	self.seq    := le.seq ;
	self.historydate := le.historydate;
	self.origbdid  := le.origbdid;
	self.BusnRelatDegree  := le.BusnRelatDegree;
	self.BusHighValueAssets :=  Map(
																	le.CurrPropOwnedCount >= 5 and le.AirCraftCount > 0 						  	=> '9', 
																	le.CurrPropOwnedCount between 2 and 4 and le.AirCraftCount > 0   	=> '8',
														 			le.AirCraftCount > 0   						   																=> '7',
																	le.CurrPropOwnedCount >= 5 and le.watercraftCount > 	0	 						=> '6',
																	le.CurrPropOwnedCount >= 5																				  => '5',	
																	le.CurrPropOwnedCount between 2 and 4 and le.watercraftCount > 	0	=> '4',	
																	le.CurrPropOwnedCount between 2 and 4															=> '3',	
														      le.CurrPropOwnedCount = 1 or  le.watercraftCount > 0 						  =>  '2',
																	le.CurrPropOwnedCount = 0 and le.watercraftCount = 0 and
																	le.AirCraftCount = 0																								=>  '1',
																	'0');
	self.BusAccessToFunds   := Map(
																	le.PropTaxValue >= 10000000 						  											=> '9', 
																	le.PropTaxValue between 5000000 and 9999999     						  	=> '8',
														 			le.PropTaxValue between 1000000 and 4999999    								=> '7',
																	le.PropTaxValue between 500000 and  999999										  => '6',
																	le.PropTaxValue between 100000 and 499999											=> '5',	
																	le.PropTaxValue between 50000 and   99999											=> '4',	
																	le.PropTaxValue between 1 and 50000														=> '3',	
														      le.CurrPropOwnedCount = 0  and le.CountSoldProp > 0	          =>  '2',
																	le.PropTaxValue =0  and le.CurrPropOwnedCount = 0 						=>  '1',
																	'0');
	self.BusGeographicRisk  := Map(
																	(integer)le.EasiTotCrime >= 140 and le.CountyBordersForgeinJur and
 						  										(le.HIDTA or le.HIFCA)								       										=> '9', 
																	(integer)le.EasiTotCrime >= 140 and (le.CountyBordersForgeinJur or 
																	(le.CountyborderOceanForgJur and ~le.CountyBordersForgeinJur))  => '8',
														 			le.st in AMLConstants.IslandState or le.CityBorderStation or
																	le.CityFerryCrossing  or le.CityRailStation   									=> '7',
																	le.AddressVacancyInd = 'Y' or le.hriskaddrflag = '4'						=> '6',
																	(integer)le.EasiTotCrime >= 140 and (le.HIDTA or le.HIFCA)			=> '5',	
																	(integer)le.EasiTotCrime >= 140																	=> '4',	
																	le.HRBusPct or le.HighFelonNeighborhood		 											=> '3',	
														      le.HIDTA or le.HIFCA         																		=>  '2',
																	(integer)le.EasiTotCrime > 1   																	=>  '1',
																	'0');
	self.BusValidityRisk   := Map(
																	(max(le.SOSAddrLocationCount, le.HDAddrCount) = 1) 
																	and le.NoFein and ~le.BusRegHit and le.CreditSrcCnt = 0 and
																	le.AddressVacancyInd = 'Y'																					  => '9', 
																	
																	(max(le.SOSAddrLocationCount, le.HDAddrCount) = 1) 
																	and ((~le.NoFein and ~le.BusRegHit and le.CreditSrcCnt = 0) 
																	or (le.NoFein and le.BusRegHit and le.CreditSrcCnt = 0) 
																	or (le.NoFein and ~le.BusRegHit and le.CreditSrcCnt > 0))
																	and le.AddressVacancyInd = 'Y'																				=> '8',
  																
																	(max(le.SOSAddrLocationCount, le.HDAddrCount) = 1)  and 
																	((~le.NoFein and le.BusRegHit) or
																		(~le.NoFein	and le.CreditSrcCnt > 0 ) or							
																			(le.BusRegHit	and le.CreditSrcCnt = 0)) 	
																	and le.AddressVacancyInd = 'Y'																				=> '7',
																	
																	(max(le.SOSAddrLocationCount, le.HDAddrCount) = 1)  and 
																		 le.NoFein and ~le.BusRegHit and le.CreditSrcCnt = 0 							=> '6',
																		 
																	(max(le.SOSAddrLocationCount, le.HDAddrCount) = 1) 
																	and ((~le.NoFein and ~le.BusRegHit and le.CreditSrcCnt = 0) 
																	or (le.NoFein and le.BusRegHit and le.CreditSrcCnt = 0)  
																	or (le.NoFein and ~le.BusRegHit and le.CreditSrcCnt > 0))  						=> '5',
																	
																	(max(le.SOSAddrLocationCount,le.HDAddrCount) = 1)  and 
																				((~le.NoFein and le.BusRegHit) or
																				(~le.NoFein	and le.CreditSrcCnt > 0) or							
																				(le.BusRegHit	and le.CreditSrcCnt = 0)) 												=> '4',
																				
																	(max(le.SOSAddrLocationCount,le.HDAddrCount) > 1)  and 
																		 le.NoFein and ~le.BusRegHit and le.CreditSrcCnt = 0								=> '3',
																		 
														      (max(le.SOSAddrLocationCount, le.HDAddrCount) > 1) 
							/*have fein */		and ((~le.NoFein and ~le.BusRegHit and le.CreditSrcCnt = 0) 
							/*have reg */			or (le.NoFein and le.BusRegHit and le.CreditSrcCnt = 0)  
							/*have credit */	or (le.NoFein and ~le.BusRegHit and le.CreditSrcCnt > 0))		         =>  '2',
																	
																	(max(le.SOSAddrLocationCount, le.HDAddrCount) > 1)  and 
																				((~le.NoFein and le.BusRegHit) or
																				(~le.NoFein	and le.CreditSrcCnt > 0 ) or							
																				(le.BusRegHit	and le.CreditSrcCnt > 0)) 		 										=>  '1',
																	'0');
																	
																	
	self.BusStabilityRisk  := Map(
																 le.LastDissolvedDate <> 0 and le.lastReinstatDate = 0 												    => '9', 
																 	round((ut.DaysApart((string)le.lastReinstatDate, ut.GetDate)) / 30) <= 12
																	and le.lastReinstatDate <> 0 																								    => '8',
														 			le.LastCorpStatus = 'I' 																								          => '7',

																	le.addressChangeSOS	or 	le.contactChangeSOS	or le.BusnNameChangeSOS	or
																	(le.FirstSeenInputAddr <> 0 and
																	ut.DaysApart((string)le.FirstSeenInputAddr, ut.GetDate)  <= 90)							    => '6',	
																	le.ExecSNNMatch 			                                                            => '5',
																	(max(le.SOSAddrLocationCount, le.HDAddrCount) between 1 and 3) 
																	 and (max(le.CorpStateCount,le.HDStateCount) = 1 ) 														=> '4',	
 		 														
														     ( max(le.SOSAddrLocationCount,le.HDAddrCount) between 1 and 3) 
																	and (max(le.CorpStateCount,le.HDStateCount) > 1 ) 														=> '3',
																	(max(le.SOSAddrLocationCount,le.HDAddrCount) >= 4) and
																	(max(le.CorpStateCount, le.HDStateCount) = 1)  								 							 	=>  '2',
																	(max(le.SOSAddrLocationCount, le.HDAddrCount) >= 4) and
																	(max(le.CorpStateCount, le.HDStateCount) > 1  )   															=>  '1',
																	'0');
																	
	self.BusIndustryRisk  := Map( 	trim(le.IndustryNAICS) = 'CIB' and  
																		(le.hrbusnypnaics = 'HIGH' or le.BusnRisklevel = 'HIGH')												=> '9', 
																	trim(le.IndustryNAICS) = 'MSB' and  
																		(le.hrbusnypnaics = 'HIGH' or le.BusnRisklevel = 'HIGH')												=> '8',
																	trim(le.IndustryNAICS) = 'NBFI' and  
																		(le.hrbusnypnaics = 'HIGH' or le.BusnRisklevel = 'HIGH')	 											=> '7',
																	trim(le.IndustryNAICS) = 'CAS' and  
																		(le.hrbusnypnaics = 'HIGH' or le.BusnRisklevel = 'HIGH')												=> '6',
																	trim(le.IndustryNAICS) = 'LEG' and  
																		(le.hrbusnypnaics = 'HIGH' or le.BusnRisklevel = 'HIGH')												=> '5',	
																	trim(le.IndustryNAICS) = 'AUTO' and  
																		(le.hrbusnypnaics = 'HIGH' or le.BusnRisklevel = 'HIGH')												=> '4',	
																	le.BusnRisklevel = 'HIGH'  or le.hrbusnypnaics = 'HIGH'
																		OR le.HRBusnSIC	= 'HIGH'	 																											=> '3',	
														      (le.BusnRisklevel = 'MED'  or le.hrbusnypnaics = 'MED')													=> '2',
																	le.BusnRisklevel = 'LOW'  or le.hrbusnypnaics = 'LOW' 
																	or  le.HRBusnSIC	= 'LOW'																													=> '1',
																	'0');
	self.BusShellShelfRisk  := Map(
																	le.ShellIndCount > 0											=> '2:' + trim(le.ShellBusnIndvalues),
														      le.ShellIndCount = 0	          					=>  '1',
																	'0');
  self.BusStructureType  := Map(
																	trim(le.busnType) = 'TRUST'																					=> '9', 
																				
																	trim(le.busnType) = 'LIMITED LIABILITY CORPORATION'									=> '8',
  	
																	trim(le.busnType) = 'FOREIGN LLC'																		=> '7',
																	trim(le.busnType) = 'FOREIGN CORPORATION-NON FOR PROFIT'	or
																		trim(le.busnType) = 'CORPORATION-NON FOR PROFIT'	 									=> '6',
																	trim(le.busnType) = 'CORPORATION-BUSINESS'	OR
																		trim(le.busnType) = 'FOREIGN CORPORATION' 													=> '5',	
																	trim(le.busnType) = 'ASSUMED NAME/DBA'	 or
																		trim(le.busnType) = 'PROPRIETORSHIP'																=> '4',	
																	trim(le.busnType) = 'PROFESSIONAL CORPORATION' or
																		trim(le.busnType) = 'PROFESSIONAL ASSOCIATION'     								=> '3',	
														      trim(le.busnType) = 'LIMITED PARTNERSHIP'	  or 
																		trim(le.busnType) = 'LIMITED LIABILITY PARTNERSHIP'								=>  '2',
																	trim(le.busnType) = ''																								=>  '1',
																	'0');																	
	SOSAge := ut.DaysApart((string)le.SOSFirstReported, ut.GetDate);
	self.BusSOSAgeRange  := Map(
																le.NoSOSFiling									  													=> '9',
																SOSAge < ut.DaysInNYears(1) and ~le.NoSOSFiling   					=> '8',
																~le.NoSOSFiling and SOSAge < ut.DaysInNYears(2)   					=> '7',
																~le.NoSOSFiling and	 SOSAge <  ut.DaysInNYears(3)						=> '6',
																~le.NoSOSFiling and	 SOSAge < ut.DaysInNYears(4)						=> '5',	
																~le.NoSOSFiling and	SOSAge < ut.DaysInNYears(6)							=> '4',	
																~le.NoSOSFiling and	 SOSAge <  ut.DaysInNYears(8)	 					=> '3',	
																~le.NoSOSFiling and	 SOSAge < ut.DaysInNYears(10)  					=>  '2',
																~le.NoSOSFiling and	SOSAge >=  ut.DaysInNYears(10)	 				=>  '1',
																	'0');
	HDRAge := ut.DaysApart((string)le.BusnHdrDtFirstSeen, ut.GetDate);
	self.BusPublicRecordAgeRange  := Map(
																			  le.srcCount = 0 																											=> '9', 
																			 HDRAge < ut.DaysInNYears(1)and le.srcCount > 1		
																			 and le.BusnHdrDtFirstSeen <> 0																				=> '8',
																			 le.BusnHdrDtFirstSeen <> 0  and HDRAge < ut.DaysInNYears(2)						=> '7',
																			 le.BusnHdrDtFirstSeen <> 0  and HDRAge < ut.DaysInNYears(3)						=> '6',
																			 le.BusnHdrDtFirstSeen <> 0  and HDRAge < ut.DaysInNYears(4)						=> '5',
																			 le.BusnHdrDtFirstSeen <> 0  and HDRAge < ut.DaysInNYears(6)						=> '4',	
																			 le.BusnHdrDtFirstSeen <> 0  and HDRAge <  ut.DaysInNYears(8)					=> '3',	
																			 le.BusnHdrDtFirstSeen <> 0  and HDRAge < ut.DaysInNYears(10)       		=>  '2',
																			 le.BusnHdrDtFirstSeen <> 0  and HDRAge > ut.DaysInNYears(10)					=>  '1',
																	'0');
	self.BusMatchLevel  := Map(
																	le.score between 0 and 20 					=> '9', 
																	le.score between 21 and 30					=> '8',
														 			le.score between 31 and 40   			=> '7',
																	le.score between 41 and 50					=> '6',
																	le.score between 51 and 60					=> '5',	
																	le.score between 61 and 70					=> '4',	
																	le.score between 71 and 80 		 		=> '3',	
														      le.score between 81 and 90	        =>  '2',
																	le.score between 91 and 100 				=>  '1',
																	'0');
	self.BusLegalEvents  := Map(
																le.ExecIncarceratedCnt > 0									  																																		=> '9', 
																le.ExecFelony3yr > 0 or  le.ExecParoleCnt > 0																																			=> '8',
														 		le.ExecFelonyCnt3plus > 0	   																																											=> '7',
																le.ExecEverIncarCnt > 0 or le.ExecSOCnt > 0 																																			=> '6',
																le.ExecFelonyCnt = 0 and 
																le.Execnonfelonycount12 + le.ExecLienscount12	+ le.UnreleasedLienCount12 + le.ReleasedLienCount12	>= 3						=> '5',	
																le.ExecFelonyCnt = 0 and 
																le.Execnonfelonycount + le.ExecLienscount	+ le.UnreleasedLienCount + le.ReleasedLienCount	>= 10										=> '4',	
																le.ExecFelonyCnt = 0 and 
																le.Execnonfelonycount + le.ExecLienscount	+ le.UnreleasedLienCount + le.ReleasedLienCount	between 4 and 9		 		 	=> '3',	
														    le.ExecFelonyCnt = 0 and 
																le.Execnonfelonycount + le.ExecLienscount	+ le.UnreleasedLienCount + le.ReleasedLienCount	between 1 and 3  	      =>  '2',
																le.ExecFelonyCnt = 0 and 
																le.Execnonfelonycount + le.ExecLienscount	+ le.UnreleasedLienCount + le.ReleasedLienCount	= 0	 										=>  '1',
																	'0');
																	
	self := le;
END;


KRIndexesBusn := project(sort(BusnBDIDs, seq), BusnKRIs(left));



RETURN KRIndexesBusn;

END;
