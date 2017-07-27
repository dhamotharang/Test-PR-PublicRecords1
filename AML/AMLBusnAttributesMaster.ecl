import risk_indicators, ut, mdr, easi, riskwise, aml;

EXPORT AMLBusnAttributesMaster(Layouts.AMLBusnAssocLayout AMLin)   := MODULE

shared	checkBoolean(boolean x) := if(x, '1', '0');
export  string1 SubjectOnFile := if(AMLin.bdid > 0, '1', '0');
shared	sysdate := if(AMLin.historydate <> 999999, (integer)((string)AMLin.historydate[1..6]), (integer)(ut.GetDate[1..6]));	

isPrescreen := False;

FIPSCode := ut.st2FipsCode(StringLib.StringToUpperCase(AMLin.st)) + AMLin.county; 

export string2 BusnGeoIndex := Map(	SubjectOnFile = '0' => '-1',
																		 (FIPSCode in AML.AMLConstants.setHIFCA or FIPSCode in AML.AMLConstants.setHIDTA) and 
																		(unsigned)AMLin.EasiTotCrime>=140 and	StringLib.StringToUpperCase(AMLin.st) in AML.AMLConstants.setBorderStates 		=> '9',																																					
																		(unsigned)AMLin.EasiTotCrime>=140 and StringLib.StringToUpperCase(AMLin.st) in AML.AMLConstants.setBorderStates 	  => '8', 
																		(unsigned)AMLin.EasiTotCrime>=140 and (FIPSCode in AML.AMLConstants.setHIFCA or
																		FIPSCode in AML.AMLConstants.setHIDTA)																																							=> '7', 												
																		AMLin.HRBusPct																																																			=> '6',
																		 AMLin.AddressVacancyInd = 'Y' 		or trim(AMLin.hriskaddrflag) = '4'	 																	                    => '5',
																		(	FIPSCode in AML.AMLConstants.setHIFCA or	FIPSCode in AML.AMLConstants.setHIDTA)  																=> '4',
																		 (unsigned)AMLin.EasiTotCrime>=140 																																									=> '3',	

																		(unsigned)AMLin.EasiTotCrime between 60 and 139 																																		=> '2',	
																		(unsigned)AMLin.EasiTotCrime between 1 and 59 																																			=> '1',	
																			'0');


export string2 BusnValidityIndex := Map(	SubjectOnFile = '0' 																																														=> '-1',
																					AMLin.ShellShelfBusn 																																														=> '9', 
																					AMLin.AddressVacancyInd = 'Y'  																																									=> '8',
																					round((ut.DaysApart((string)AMLin.BusnHdrDtLastSeen, (string)sysdate)) / 30) >= 60 															=> '7',
																					AMLin.srcCount = 1 and round((ut.DaysApart((string)AMLin.BusnHdrDtFirstSeen, (string)sysdate)) / 30)  <= 12 
																					and AMLin.CorpStatus <> 'A' 																																										=> '6',
																					AMLin.srcCount = 1 and round((ut.DaysApart((string)AMLin.BusnHdrDtFirstSeen, (string)sysdate)) / 30) >= 60 			
																					and AMLin.CorpStatus <> 'A'  																																										=> '5',
																					AMLin.srcCount > 1 and  AMLin.CorpStatus <> 'A' and 
																							round((ut.DaysApart((string)AMLin.BusnHdrDtFirstSeen, (string)sysdate)) / 30) <= 60													=> '4',
																					AMLin.srcCount > 1 and round((ut.DaysApart((string)AMLin.BusnHdrDtFirstSeen, (string)sysdate)) / 30) >= 60 
																					and  AMLin.CorpStatus <> 'A'  																																									=> '3',
																					AMLin.IndSSNMatch 									  																																					=> '2',
																					AMLin.CorpStatus = 'A' 																																													=> '1',
																					'0');



export string2 BusnStabilityIndex := Map(	SubjectOnFile = '0' 																																						=> '-1',
																				AMLin.EverDissolution and ~AMLin.EverReinstat 																										=> '9', 
																				AMLin.EverReinstat 																																								=> '8',
																				AMLin.addressChangeSOS or  AMLin.contactChangeSOS 																								=> '7',
																				AMLin.Reported90d  => '6',
																				AMLin.LengthInputAddr < ut.DaysInNYears(2) 																												=> '5',
																				AMLin.LengthInputAddr between ut.DaysInNYears(2) and ut.DaysInNYears(7) 
																						and AMLin.CorpStateCount = 0  																																=> '4',
																				AMLin.LengthInputAddr between ut.DaysInNYears(2) and ut.DaysInNYears(7) 
																						and AMLin.CorpStateCount >= 1  																																=> '3',
																				AMLin.CorpStateCount > 5  or AMLin.AddrCount > 10 or 
																				AMLin.EmpCount > 250 	and AMLin.EverDissolution																										=> '2', 
																				AMLin.LengthInputAddr >= ut.DaysInNYears(7) 																											=> '1',
																				'0');
																				


	unsigned3 BusnMinorEventCnt12 := 		AMLin.BKcount12  + AMLin.UnreleasedLienCount12 + AMLin.ReleasedLienCount12; 
	unsigned3 BusnMinorEventCnt := 		AMLin.BKcount  + AMLin.UnreleasedLienCount + AMLin.ReleasedLienCount; 
	
export string2 BusnLegalEventsIndex := Map(	SubjectOnFile = '0' => '-1',
																						AMLin.RepIncarceratedCnt >= 1 						 											=> '9', 
																				    AMLin.RepFelonyCnt12 >= 1 																			=> '8',
																						 AMLin.RepFelonyCnt2to5yr >=1																		=> '7',
																						AMLin.RepFelonyCnt5plus >=1																			=> '6',
																				    AMLin.RepMinorCnt12  + BusnMinorEventCnt12 >= 3 								=> '5',
																				    AMLin.RepMinorEventCnt  + BusnMinorEventCnt >= 10               => '4', 
																				    BusnMinorEventCnt  +	AMLin.RepMinorEventCnt between 4 and 9 		=> '3',
																				    BusnMinorEventCnt  +	AMLin.RepMinorEventCnt between 1 and 3		=> '2',
																				    AMLin.RepMinorEventCnt  = 0  and  BusnMinorEventCnt = 0  				=> '1',
																						
																						'0');
																						
export string2 BusnIndustryRiskIndex := Map(	SubjectOnFile = '0' => '-1',
																						 AMLin.HRBusiness 																							=> '9', 
																				    ~AMLin.HRBusiness 	 																						=> '1',
																						'0');
																						

export string2 BusnAccessToFundsIndex := Map(SubjectOnFile = '0' => '-1',
																						 AMLin.PropTaxValue >= 10000000              																							=> '9', 
																				     AMLin.PropTaxValue < 10000000 and AMLin.PropTaxValue >= 5000000  												=> '8',
																				     AMLin.PropTaxValue < 5000000 and AMLin.PropTaxValue >= 1000000   												=> '7',
																				     AMLin.PropTaxValue < 1000000 and AMLin.PropTaxValue >= 500000 														=> '6',
																				     AMLin.PropTaxValue < 500000 and AMLin.PropTaxValue >= 100000 		  								     	=> '5',
																				     AMLin.PropTaxValue < 100000  and  AMLin.PropTaxValue >= 50000 														=> '4', 
																				     AMLin.PropTaxValue < 50000   and AMLin.PropTaxValue > 0																	=> '3',
																				     AMLin.CountOwnProp = 0 and AMLin.CountSoldProp >0																	    	=> '2',
																				     AMLin.CountOwnProp = 0 and AMLin.CountSoldProp =0      																	=> '1',
																				     '0');

END;