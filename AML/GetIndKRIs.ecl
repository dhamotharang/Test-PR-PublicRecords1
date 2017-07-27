IMPORT UT;

EXPORT GetIndKRIs (  DATASET(Layouts.LayoutAMLShellV2) Indivs
													 ) := FUNCTION;

//version 2   - 
sysdate := if(Indivs[1].historydate <> 999999, (integer)((string)Indivs[1].historydate[1..6]), (integer)(ut.GetDate[1..6]));

Layouts.LayoutAMLShellV2  IndivKRIs(Indivs le)  := TRANSFORM
  
	self.seq    := le.seq ;
	self.historydate := le.historydate;
	self.did  := le.did;
	self.relatdegree  := le.relatdegree;
	self.isexec  := le.isexec;
	self.IndHighValueAssets := Map(
																	le.propertyCount >= 5 and le.AirCraftCount > 0 						  		=> '9', 
																	le.propertyCount between 2 and 4 and 	le.AirCraftCount > 0   		=> '8',
														 			le.AirCraftCount > 0   																						=> '7',
																	le.propertyCount >= 5 and   le.watercraftCount > 0								=> '6',
																	le.propertyCount >= 5																							=> '5',	
																	le.propertyCount between 2 and 4 and 	le.watercraftCount > 0		=> '4',	
																	le.propertyCount between 2 and 4					 												=> '3',	
														      le.propertyCount = 1 	or le.watercraftCount > 0										=>  '2',
																	le.propertyCount = 0 and le.watercraftCount = 0 and
																	le.AirCraftCount = 0																							=>  '1',
																	'0');
														 
  self.IndAccesstoFunds  := Map(  // todo don't use between  go to >=
																	le.estimated_income > 250000 and le.isexec                    	=>  '9',
																	le.estimated_income > 250000 	and ~le.isexec						        =>  '8',
																	le.estimated_income >= 150000 and le.isexec                    =>  '7',
																	le.estimated_income >= 150000 and ~le.isexec                   =>  '6',
																	le.estimated_income >= 100000 and  le.isexec                   =>  '5',
																	le.estimated_income >= 100000 and ~le.isexec                 	=>  '4',
																	le.estimated_income >=50000 and  le.isexec                     =>  '3',
																	le.estimated_income >=50000 and ~le.isexec                 		=>  '2',
																	le.estimated_income >= 1         																=>  '1',
																	'0');
	
	self.IndGeographicRisk  := Map(
																	(integer)le.EasiTotCrime  >= 140 and le.CountyBordersForgeinJur 
																	and (le.HIFCA or le.HIDTA)																		=> '9',
																	(integer)le.EasiTotCrime  >= 140 and 
																	(le.CountyBordersForgeinJur or (le.CountyborderOceanForgJur and 
																	le.st not in AMLConstants.StateBorderDiffCountry))						=>  '8',
																	 
																	le.st in AMLConstants.IslandState  or
																	(le.CityBorderStation or le.CityFerryCrossing or
																	le.CityRailStation)       																		=>  '7',
																	le.AddressVacancyInd = 'Y' or	le.HRTransientCommericalAddr or
																	le.IsPrison   																								=>  '6',
																	(integer)le.EasiTotCrime  >= 140 and (le.HIFCA or le.HIDTA ) =>  '5',
																	(integer)le.EasiTotCrime  >= 140     													=>  '4',
																	le.HRBusPctNeighborhood or le.HighFelonNeighborhood 					=>  '3',
																	le.HIDTA or le.HIFCA																					=>  '2',
																	(integer)le.EasiTotCrime  > 1  																=>  '1',
																	'0');
	
	mnthsfirstHdr := round((ut.DaysApart((string)le.EarliestAddrFirstSeenDt, (string)sysdate)) / 30);
	mnthsHist1Addr := round((ut.DaysApart((string)le.AddrHist1_dt_first_seen, (string)sysdate)) / 30);  //hist 1 is curr addr
	// mnthsHist2Addr := round((ut.DaysApart((string)le.AddrHist2_dt_first_seen, (string)sysdate)) / 30);  //hist 2 is prev addr
	LresHist2Addr := round((ut.DaysApart((string)le.AddrHist1_dt_first_seen, (string)le.AddrHist2_dt_first_seen)) / 30);  //hist 2 is prev addr
	self.IndMobility  := Map(															
															~le.AddrHistory																																							=> '9',
															// le.UnqAddrCnt = 0																																					=> '9',
															le.EarliestAddrFirstSeenDt <> 0 and 		mnthsfirstHdr < 12 															=>  '8',

															mnthsfirstHdr >= 12 	and ~le.PrevAddrHistory and 
															le.AddrHistory 	and le.EarliestAddrFirstSeenDt <> 0																			=>  '7',
															
															mnthsHist1Addr < 12 and le.currAddrFirstSeenDt <> 0
															and ((le.addrs_last36 = 3 and le.Move1_dist <= 50 and le.Move2_dist <= 50) or
															(le.addrs_last36 > 3 and le.Move1_dist <= 50 and le.Move2_dist	<= 50 and le.Move3_dist  <= 50))		=>  '6',
															
															mnthsHist1Addr < 12  and le.AddrHist1_dt_first_seen <> 0 and 
															le.AddrHist2_dt_first_seen <> 0 and LresHist2Addr < 36																		=>  '5',
															
															mnthsHist1Addr < 12 	and le.AddrHist1_dt_first_seen <> 0 and 	
															le.AddrHist2_dt_first_seen <> 0 and LresHist2Addr >= 36																	=>  '4',
															
															le.AddrHist1_dt_first_seen <> 0 and mnthsHist1Addr between 12 and 35 										=>  '3',
															le.AddrHist1_dt_first_seen <> 0 and mnthsHist1Addr between 36 and 59											=>  '2',
                              le.AddrHist1_dt_first_seen <> 0 and	mnthsHist1Addr >=  60																=>  '1',
																	'0');
	
	self.IndLegalEvents  := Map(
																le.CurrIncarcer																																										=> '9',
																le.FelonyCount3yr >= 1 or le.CurrParole	  		                    															=>  '8',
																le.FelonyCount  > 0             																																	=>  '7',
																le.EverIncarcer or le.potentialSO																																	=>  '6',
																le.FelonyCount = 0 and 
																(le.nonfelonycriminalcount12 +	le.liensUnreleasedCnt12 + le.liensReleasedCnt12)  >= 3    				=>  '5',
																le.FelonyCount = 0 and 
																(le.nonfelonycriminalCount +	le.liensUnreleasedCnt + le.liensReleasedCnt)  >= 10									=>  '4',
																le.FelonyCount = 0 and 
																(le.nonfelonycriminalCount +	le.liensUnreleasedCnt + le.liensReleasedCnt)  between 4 and 9 			=>  '3',
																le.FelonyCount = 0 and 
																(le.nonfelonycriminalCount +	le.liensUnreleasedCnt + le.liensReleasedCnt)  between 1 and 3 			=>  '2',
																le.FelonyCount = 0 and 
																(le.nonfelonycriminalCount +	le.liensUnreleasedCnt + le.liensReleasedCnt) = 0     								=>  '1',
																	'0');
	
	self.IndAgeRange  := Map(	(integer)le.age = 0		=>	'0',
														
														(integer)le.age  Between 1 and 19				=> '9',
														(integer)le.age  between 20	and 21			=>  '8',
														(integer)le.age  between 22	and 25			=>  '7',
														(integer)le.age  between 26	and 35			=>  '6',
														(integer)le.age  between 36	and 50			=>  '5',
														(integer)le.age  between 51	and 63			=>  '4',
														(integer)le.age  between 64  and 75			=>  '3',
														(integer)le.age  between 76	and 85			=>  '2',
														(integer)le.age  > 85										=>  '1',
														'-1');
	mnthsHdrlastSeen := round((ut.DaysApart((string)le.HdrLastSeenDate, (string)sysdate)) / 30);
	mnthsHdrFirstSeen := round((ut.DaysApart((string)le.HdrFirstSeenDate, (string)sysdate)) / 30);
	self.IndIdentityRisk := Map(  //  variable for first seen /sysdate and use it below   todo
																				le.deceased or ~le.validSSN or 
																				((integer)le.soclhighissue <> 0  and (integer)le.dob	<> 0 and ((integer)le.soclhighissue < (integer)le.dob	)	)	=> '9',
                                        le.HdrFirstSeenDate <> 999999 and																				
																				mnthsHdrFirstSeen < 12   and 	(le.ssns_per_adl > 1 or le.adls_per_ssn > 2	)			                    						=>  '8',
																	       le.HdrFirstSeenDate <> 999999 and mnthsHdrFirstSeen between 12 and 59   and
																				(le.ssns_per_adl > 1 or le.adls_per_ssn > 2	)             																											=>  '7',
																				le.HdrFirstSeenDate <> 999999 and mnthsHdrFirstSeen >= 60 
																				and (le.ssns_per_adl > 1 or le.adls_per_ssn > 2	)   																														=>  '6',
																	      le.HdrFirstSeenDate <> 999999 and mnthsHdrlastSeen >= 24                 																				=>  '5',
																				le.HdrFirstSeenDate <> 999999 and mnthsHdrFirstSeen < 12						 	  																					=>  '4',
																				le.HdrFirstSeenDate <> 999999 and mnthsHdrFirstSeen between 12 and 36 																					=>  '3',
																				le.HdrFirstSeenDate <> 999999 and mnthsHdrFirstSeen between 37 and 96 																					=>  '2',
																	      le.HdrFirstSeenDate <> 999999 and mnthsHdrFirstSeen > 96              																						=>  '1',
																	'0');
	daysDOBHdr1stSeen := ut.DaysApart((string)le.dob, (string)le.HdrFirstSeenDate + '01');
	self.IndResidencyRisk  := Map(
																				((integer)le.dob <> 0 and le.HdrFirstSeenDate <> 999999) and
																				daysDOBHdr1stSeen >= ut.DaysInNYears(24)  
																				and  (~le.validSSN or  (le.NoSSN and ~le.EverITIN ))														=> '9', 
																				((integer)le.dob <> 0 and	le.HdrFirstSeenDate <> 999999)	and											
																				daysDOBHdr1stSeen < ut.DaysInNYears(24) 
																					and  (~le.validSSN  or  (le.NoSSN and ~le.EverITIN))   							  				=> '8',
																				le.EverITIN  or  	le.EverNon_US_SSN																								=> '7',

																					le.assocparentcnt > 0 and (le.ParentHasITIN or 	le.ParentNONUSSSN )						=> '6',
																			 (le.AssocParentCnt > 0 and le.ParentLowIssueDt <> 0 and
																				(integer)le.dob <> 0 and (unsigned4)le.dob < le.ParentLowIssueDt)		  				=> '5',
																			  le.assocparentcnt = 0 or 
																				((le.assocparentcnt > 0 and le.ParentNoSSN	and ~le.ParentHasITIN ) or 
																					le.ParentHasITIN or le.EverITIN )	 and le.validSSN															=> '4',
																				le.validSSN and (~le.isVoter or(~le.VoterSrc and ~le.isVoter))	 								=> '3',
																				
																				(le.isVoter or(~le.ParentVoterSrc and ~le.ParentVoter))												=> '2',
																				le.ParentVoter and le.isVoter	 																										=> '1',
																				'0');
	
	self.IndMatchLevel  := Map(  //  remove between use <= todo
																		le.ADLScore between 0 and 20										  => '9',
																		le.ADLScore between 21 and 30					          =>  '8',
																	 	le.ADLScore between 31 and 40										=>  '7',
																		le.ADLScore between 41 and 50										=>  '6',
																	  le.ADLScore between 51 and 60                    =>  '5',    
																		le.ADLScore between 61 and 70										=>  '4',
																		le.ADLScore between 71 and 80										=>  '3',
																		le.ADLScore between 81 and 90										=>  '2',
																	  le.ADLScore between 91 and 100                 	=>  '1',
																	'0');
		
																																			
	self.IndProfessionalRisk := Map(
																	le.isexec and le.HRBusnCount > 1 and le.HRProfServProv							=> '9',
																	le.isexec and  le.HRProfServProv and
																	le.ShellIndCount > 4											    											=>  '8',
																	le.isexec and  le.ShellIndCount > 4                								=>  '7',
																	le.isexec and le.HRBusnCount >= 1	 and le.HRProfServProv					=>  '6',
																	le.isexec and le.HRProfServProv                                 		=>  '5',
																	le.HRProfServProv																										=>  '4',
																	le.HRDegree																													=>  '3',
																	le.isexec or 	le.profLic 																						=>  '2',
																	~le.isexec and 	~le.profLic and ~le.HRDegree                 			=>  '1',
																	'0');
  
	self := le;
END;

IndivKRIsOut  := project(Indivs, IndivKRIs(left));
// output(Indivs, named('Indivs'));
												 
												 
RETURN 	IndivKRIsOut;												 
END;