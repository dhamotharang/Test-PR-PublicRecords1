import risk_indicators, ut, mdr, aml;


EXPORT AMLAttributesMaster(Risk_Indicators.Layout_BocaShell_Neutral AMLin)

 := MODULE

isPrescreen := False;
shared	capZero := '0';
shared	cap150 := '150';
shared	cap255 := '255';
shared	cap960 := '960';
shared	cap9999 := '9999';
shared	capMax := '9999999999';
	
shared 	ageDate := (unsigned4)Risk_Indicators.iid_constants.myGetDate(AMLin.historydate); 						
shared unsigned3 fixYYYY00( unsigned YYYYMM ) := if( YYYYMM > 0 and YYYYMM % 100 = 0, YYYYMM + 1, YYYYMM );
shared	sysdate := if(AMLin.historydate <> 999999, (integer)((string)AMLin.historydate[1..6]), (integer)(ut.GetDate[1..6]));
shared	subjectFirstSeen := fixYYYY00(ut.Min2(AMLin.ssn_verification.header_first_seen, AMLin.ssn_verification.credit_first_seen));
shared	noSSNinput     := not AMLin.input_validation.ssn;
shared	checkBoolean(boolean x) := if(x, '1', '0');

shared	capS(string input, string lowerBound, string upperBound) := trim(IF((unsigned)input < (unsigned)upperBound, 
										IF((UNSIGNED)input < (UNSIGNED)lowerBound, lowerBound, input), 
										upperBound));	// get smaller number and make sure the lower bounds is not exceeded
export boolean noAddrinput    := not AMLin.input_validation.Address;
export string1 SubjectOnFile := if(AMLin.did > 0 , '1', '0');	
export	string3	AddrChangeCount60 	:= capS((string)AMLin.other_address_info.addrs_last_5years, capZero, cap255);
shared	statusAddr1 := map(AMLin.address_verification.input_address_information.applicant_owned AND 
														~AMLin.address_verification.input_address_information.applicant_sold  => 'O',// owned
										 ~AMLin.address_verification.input_address_information.occupant_owned and
														AMLin.iid.dwelltype not in ['','S'] => 'R',// rent,
										 'U');// unknown
shared	statusAddr2 := map(AMLin.address_verification.address_history_1.applicant_owned AND 
														~AMLin.address_verification.address_history_1.applicant_sold  => 'O',// owned
										 ~AMLin.address_verification.address_history_1.occupant_owned and 
														AMLin.address_verification.addr_type2 not in ['','S'] => 'R',// rent,
										 'U');// unknown;
shared	statusAddr3 := map(AMLin.address_verification.address_history_2.applicant_owned AND 
														~AMLin.address_verification.address_history_2.applicant_sold  => 'O',// owned
										 ~AMLin.address_verification.address_history_2.occupant_owned and 
														AMLin.address_verification.addr_type3 not in ['','S'] => 'R',// rent,
										 'U');// unknown;										 
shared eviction_count := AMLin.bjl.eviction_recent_unreleased_count + AMLin.bjl.eviction_historical_unreleased_count +
																	AMLin.bjl.eviction_recent_released_count + AMLin.bjl.eviction_historical_released_count;										 
export	string3	EvictionCount	:= capS((string)eviction_count, capZero, cap255);										 
export	string2	InputAddrHighRisk	:= if(noAddrInput, '-1', checkBoolean(AMLin.iid.hriskaddrflag = '4'));	
export	string2	InputAddrDelivery	:= map(AMLin.advo_input_addr.address_vacancy_indicator='Y' => '4',  // vacant address
								AMLin.advo_input_addr.seasonal_delivery_indicator='Y' and AMLin.advo_input_addr.residential_or_business_ind in ['A','C'] => '3',  // seasonal residential
								AMLin.advo_input_addr.seasonal_delivery_indicator='E' => '2',  // educational institution
								AMLin.advo_input_addr.throw_back_indicator='Y' => '1',  // mail is sent to PO box instead of the home address
								'-1');
export	string10	EstimatedAnnualIncome	:= capS((string)AMLin.estimated_income, capZero, capMax) ;
shared  Age_Oldest_Record := capS((string)round((ut.DaysApart((string)subjectFirstSeen, (string)sysdate)) / 30), capZero, cap960);
export	string3	AgeOldestRecord	:= if(subjectFirstSeen=0, '-1', Age_Oldest_Record );	
shared	IAdateFirstSeen := fixYYYY00(AMLin.address_verification.input_address_information.date_first_seen);
shared	AH1dateFirstSeen := fixYYYY00(AMLin.address_verification.address_history_1.date_first_seen);
shared	AH2dateFirstSeen := fixYYYY00(AMLin.address_verification.address_history_2.date_first_seen);
shared	CAaddrChooser := map(AMLin.address_verification.input_address_information.isbestmatch => 1, // input is current
											 AMLin.address_verification.address_history_1.isbestmatch => 2, // hist 1 is current
											 AMLin.address_verification.address_history_2.isbestmatch => 3, // hist 2 is current
											 4);	// don't know what the current address is	

shared	CADateFirstReported := map(CAaddrChooser=1 => IAdateFirstSeen,
														 CAaddrChooser=2 =>	AH1dateFirstSeen,
														 CAaddrChooser=3 => AH2dateFirstSeen,
														 0);	
														 
export	string2	StatusMostRecent 	:= map(CAaddrChooser=1 => statusAddr1,
																	CAaddrChooser=2 => statusAddr2,
																	CAaddrChooser=3 => statusAddr3,
																	'-1');
																	
export	string2	CurrAddrCorrectional	:= map(noAddrInput => '-1',
																CAaddrChooser=1 => checkboolean(AMLin.iid.hriskaddrflag='4' AND AMLin.iid.hrisksic = '2225'),
																CAaddrChooser=2 => checkboolean(AMLin.other_address_info.hist1_isprison),
																CAaddrChooser=3 => checkboolean(AMLin.other_address_info.hist2_isprison),
																'-1');
shared felony_count := AMLin.bjl.felony_count;
export	string3	FelonyCount	:= capS((string)felony_count, capZero, cap255);

export	string3	LienCount	:= capS((string)(AMLin.bjl.liens_historical_unreleased_count + AMLin.bjl.liens_recent_unreleased_count +
														 AMLin.bjl.liens_historical_released_count + AMLin.bjl.liens_recent_released_count), capZero, cap255);
														 
export	string1	PropertyOwner	:= checkboolean(AMLin.address_verification.owned.property_total>0);
export	string1	VoterRegistrationRecord	:= checkboolean(StringLib.StringFind(AMLin.header_summary.ver_sources,mdr.sourcetools.src_Voters_v2, 1) > 0);

export	string2	SSNNonUS	:= map(noSSNInput => '-1', 
																AMLin.iid.non_us_ssn => '1',
																'0');

export	string2	SSNProblems	:= map(noSSNInput 								=> '-1',  // not input
							  AMLin.iid.decsflag='1' 		=> '5',   // deceased SSN
								AMLin.iid.socsdobflag='1'	=> '4',  	// issued prior to DOB
								Risk_Indicators.rcSet.isCodeIS(AMLin.shell_input.ssn, AMLin.iid.socsvalflag, AMLin.iid.socllowissue, AMLin.iid.socsRCISflag)  => '3',  	// verified and valid, but was invalid prior to June 25th (reason code IS flag)
								not AMLin.SSN_Verification.Validation.valid => '2',  // invalid ssn
								Risk_Indicators.rcSet.isCodeRS(AMLin.shell_input.ssn, AMLin.iid.socsvalflag, AMLin.iid.socllowissue, AMLin.iid.socsRCISflag)	=> '1', // randomized ssn (RS)
								'0');  // valid

shared 	under21 := AMLin.inferred_age < 21 OR (ut.GetAgeI_asOf(AMLin.reported_dob, (unsigned)ageDate)) < 21;	
export	string3	BestReportedAge(boolean isPrescreen)	:= if(AMLin.reported_dob=0 OR (isPrescreen AND under21), '-1', 
																															capS((string)ut.GetAgeI_asOf(AMLin.reported_dob, ageDate), capZero, cap150) );

export	string1	WatercraftOwner	:= checkboolean(AMLin.watercraft.watercraft_count>0);

export	string1	AircraftOwner	:= checkboolean(AMLin.aircraft.aircraft_count>0)	;

// AML Attributes

																				
export string2 IndCitizenshipIndex := Map(
																					SubjectOnFile = '0'																																												=> '-1',
																					(integer)SSNNonUS = 1 and  VoterRegistrationRecord <> '1'  																								=> '9',
																					(integer)AgeOldestRecord between 0 and 35  	and  VoterRegistrationRecord <> '1'														=> '8',
																					(integer)AgeOldestRecord between 36 and 59 	and  VoterRegistrationRecord <> '1'			 											=> '7',
																				  (integer)AgeOldestRecord between 60 and 120  and  VoterRegistrationRecord <> '1'													=> '6',

																					((unsigned)BestReportedAge(false) <= 25 	and  VoterRegistrationRecord <> '1'	 and	 
																					AMLin.AMLParentPubRec10yrs = 1 )  or 
																					((integer)AgeOldestRecord >= 120 and  VoterRegistrationRecord <> '1')                 										=> '5',	
																																									
																					(AMLin.AMLParentIsVoter = 1 or (integer)AMLin.AMLParentNonUsSSN = 0)  and VoterRegistrationRecord <> '1' 	=> '4',
																					(integer)SSNProblems = 0 and  PropertyOwner <> '1' and VoterRegistrationRecord <> '1'											=> '3',	
																					(integer)SSNProblems = 0 and  PropertyOwner = '1' and VoterRegistrationRecord <> '1'											=> '2',
																					VoterRegistrationRecord ='1' 																																							=> '1',
																					'0');
																					
shared AMLeasoncodeIS_value := if(Risk_Indicators.rcSet.isCodeIS(AMLin.AMLSSN, AMLin.AMLsocsvalflag, AMLin.AMLSocllowissue, AMLin.AMLSocsRCISflag), 2, 0);																	
shared string3	AMLAgeOldestRecord	:= if(AMLin.amlfirstseendt='0', '-1', capS((string)round((ut.DaysApart((string)AMLin.amlfirstseendt, (string)sysdate)) / 30), capZero, cap960));
	
export string2 RelIndCitizenshipIndex := Map(AMLin.did = 0 																																							=> '-1',
																						Risk_Indicators.rcSet.isCode85(AMLin.AMLSSN, AMLin.AMLSocllowissue) and AMLin.AMLRelatIsVoter = 0 																								=> '9',

																					 (integer)AMLAgeOldestRecord between 0 and 35 and AMLin.AMLRelatIsVoter = 0										=> '8',
																					 (integer)AMLAgeOldestRecord between 36 and 59  and AMLin.AMLRelatIsVoter	= 0									=> '7',
																				   (integer)AMLAgeOldestRecord between 60 and 119 and AMLin.AMLRelatIsVoter = 0									=> '6',
																					 ( round((ut.DaysApart((string)AMLin.amlfirstseendt, (string)sysdate)) / 30) >= 120 
																						and AMLin.AMLRelatIsVoter = 0) or
																						(AMLin.AMLAge <= 25 and AMLin.AMLRelatIsVoter = 0 and AMLin.AMLRelatParentPubRec10yrs = 1)  => '5', 
								  													'0');
																						
																						
export string2 IndMobilityIndex := Map(	SubjectOnFile = '0' => '-1',
																				(unsigned)AddrChangeCount60 >= 5 and  trim(StatusMostRecent) <> 'O'																						=> '9',
																				(unsigned)AddrChangeCount60 = 4  and  trim(StatusMostRecent) <> 'O'																						=> '8',
																				(unsigned)AddrChangeCount60 = 3  and  trim(StatusMostRecent) <> 'O'																						=> '7',
																				round((ut.DaysApart((string)IAdateFirstSeen, (string)sysdate)) / 30) >= 12 and   
																				AMLin.AMLLengthPrevAddr >=  Risk_indicators.iid_constants.tenyears
																				and ~AMLin.AMLOwnPrevAddr                                               																			=> '6',
																				~StatusMostRecent='O' 																																												=> '5',	
                                        (unsigned)AddrChangeCount60 = 3	and		trim(StatusMostRecent) = 'O'   										 											=> '4',
																				round((ut.DaysApart((string)CADateFirstReported, (string)sysdate)) / 30) >= 36 
																										and trim(StatusMostRecent) = 'O' 																																	=> '3',
																				round((ut.DaysApart((string)CADateFirstReported, (string)sysdate)) / 30) >= 12 and 
																				AMLin.AMLLengthPrevAddr >=  Risk_indicators.iid_constants.tenyears  and AMLin.AMLOwnPrevAddr                  => '2',
																				round((ut.DaysApart((string)CADateFirstReported, (string)sysdate)) / 30) >= 120 
																									and trim(StatusMostRecent) = 'O' 																																		=> '1',
																				'0');  
																				
export string2 RelIndMobilityIndex := Map(AMLin.did = 0 => '-1',	
																				(unsigned)AMLin.AMLAddrsLast5years >= 5 and ~AMLin.AMLOwnCurrentAddr																=> '9',
																				(unsigned)AMLin.AMLAddrsLast5years = 4   and ~AMLin.AMLOwnCurrentAddr																=> '8',
																				(unsigned)AMLin.AMLAddrsLast5years = 3 and ~AMLin.AMLOwnCurrentAddr  																=> '7',
																				AMLin.AMLLastMoveOvrYr and AMLin.AMLLengthPrevAddr >=  Risk_indicators.iid_constants.tenyears
																												 and ~AMLin.AMLOwnPrevAddr																													=> '6',	
																				~AMLin.AMLOwnCurrentAddr 																																						=> '5',	
																				'0');
																				
shared unsigned NumNonFelonyCrimes := AMLin.bjl.criminal_count - (unsigned)FelonyCount;

shared unsigned LienEvictionRecentCountAML := AMLin.bjl.liens_unreleased_count12
																			        + AMLin.bjl.liens_released_count12
																			        + AMLin.bjl.eviction_count12; 
																							
shared unsigned LienEvictionOver12CountAML := ((unsigned)LienCount + AMLin.bjl.eviction_count) - LienEvictionRecentCountAML;

export string2 IndLegalEventsIndex := Map(SubjectOnFile = '0' 																																												=> '-1',
																					CurrAddrCorrectional = '1' or AMLin.AMLPossIncarceration = '1' 																							=> '9',
																					AMLin.AMLMajEvent12 > 0 																																										=> '8',
																					AMLin.AMLMajEvent5 > 0 																																											=> '7',
																					AMLin.AMLMajEvent5plus > 0 																																									=> '6',
																					felony_count = 0 and (NumNonFelonyCrimes + (unsigned)LienEvictionRecentCountAML) >= 3  											=> '5',	
																					felony_count = 0 and (NumNonFelonyCrimes + (unsigned)LienCount + (unsigned)EvictionCount) >= 10  					  => '4',	
																					felony_count = 0 and (NumNonFelonyCrimes + (unsigned)LienCount + (unsigned)EvictionCount) between 4 and 9  	=> '3',	
																					felony_count = 0 and (NumNonFelonyCrimes + (unsigned)LienCount + (unsigned)EvictionCount) between 1 and 3  	=> '2',	
																					((unsigned)FelonyCount +(unsigned)NumNonFelonyCrimes+(unsigned)LienCount+(unsigned)EvictionCount)=0  				=> '1',
																					'0');
																					

export string2 RelIndLegalEventsIndex := Map(AMLin.did = 0 => '-1',
																					AMLin.AMLisIncarcerated   or AMLin.AMLPossIncarceration = '1' 																							=> '9',
																					AMLin.AMLMajEvent12 > 0 																																										=> '8',
																					AMLin.AMLMajEvent5 > 0 																																											=> '7',
																					AMLin.AMLMajEvent5plus > 0 																																									=> '6',
																					AMLin.AMLFelonyCount = 0 and (NumNonFelonyCrimes + (unsigned)LienEvictionRecentCountAML) >= 3  							=> '5',	
																						'0');																						 

export string2 IndAccesstoFundsIndex := Map(SubjectOnFile = '0' => '-1',
																						(unsigned)EstimatedAnnualIncome > 250999 and  AMLin.AMLOfficerPosition between 1 and 3  											=> '9',
																						(unsigned)EstimatedAnnualIncome > 250000  																																=> '8',
																						(unsigned)EstimatedAnnualIncome between 200000 and 249999 and AMLin.AMLOfficerPosition between 1 and 3  	=> '7',
																						(unsigned)EstimatedAnnualIncome between 200000 and 249999   																							=> '6',
																						(unsigned)EstimatedAnnualIncome between 150000 and 199999 and AMLin.AMLOfficerPosition between 1 and 3  																																=> '5',		
																						(unsigned)EstimatedAnnualIncome between 150000 and 199999 																								=> '4',
																						(unsigned)EstimatedAnnualIncome between 100000 and 149999 																								=> '3',
																						(unsigned)EstimatedAnnualIncome between 50000 and 99999 																									=> '2',
																						(unsigned)EstimatedAnnualIncome < 50000 and (unsigned)EstimatedAnnualIncome > 0																																	=> '1',
																						'0');



													
export string2 RelIndAccesstoFundsIndex := Map(AMLin.did = 0 => '-1',
																						(unsigned)AMLin.AMLIncome > 250000 	and AMLin.AMLOfficerPosition between 1 and 3															=> '9',
																						(unsigned)AMLin.AMLIncome > 250000																			  																		=> '8',
																						(unsigned)AMLin.AMLIncome between 200000 and 249999  and AMLin.AMLOfficerPosition between 1 and 3 						=> '7',	
																						(unsigned)AMLin.AMLIncome between 200000 and 249999 	=> '6',	
																						(unsigned)AMLin.AMLIncome between 150000 and 199999  and AMLin.AMLOfficerPosition between 1 and 3  						=> '5',	
																						'0');

																						

export string2 IndBusAssocIndex := Map(	SubjectOnFile = '0' => '-1',
																				AMLin.AMLOfficePositionsCount > 1 and AMLin.AMLHRBusinessCount > 1 and AMLin.AMLHRProfLicProv 		=> '9', 
																				AMLin.AMLOfficePositionsCount >= 1 and AMLin.AMLHRBusinessCount = 1 and AMLin.AMLHRProfLicProv	  => '8',
																				AMLin.AMLOfficePositionsCount > 1  and AMLin.AMLHRBusinessCount	> 1																=> '7',
																				AMLin.AMLHRProfLicProv 																																						=> '6',
																				AMLin.AMLOfficerPosition between 1 and 3 	and AMLin.AMLHRBusiness																	=> '5',
																				AMLin.AMLHRDegreeField 																																						=> '4', 
																				AMLin.AMLProfLic or AMLin.AMLAttendCollege 																												=> '3',
																				AMLin.AMLOfficerPosition between 1 and 3 																													=> '2',
																				~AMLin.AMLAttendCollege and ~AMLin.AMLProfLic and AMLin.AMLOfficePositionsCount = 0 							=> '1',
																				'0');

export string2 RelIndBusAssocIndex := Map(AMLin.did = 0 => '-1',	
																				AMLin.AMLOfficePositionsCount > 1 and  AMLin.AMLHRProfLicProv
																														and AMLin.AMLHRBusinessCount > 1									=> '9', 
																				AMLin.AMLOfficePositionsCount >= 1 and  AMLin.AMLHRProfLicProv
																														and AMLin.AMLHRBusinessCount = 1									=> '8',
																				AMLin.AMLOfficePositionsCount > 1	and AMLin.AMLHRBusinessCount > 1 		=> '7',
																				AMLin.AMLHRProfLicProv 																								=> '6',
																				AMLin.AMLOfficerPosition between 1 and 3 	and AMLin.AMLHRBusiness		 	=> '5',
																				'0');


export string2 RelIndHighValAssetsIndex := Map(AMLin.did = 0 => '-1',
																						  AMLin.relativeAircraftCount >= 1 and AMLin.relativePropertyCount >= 5  							=> '9',
																						  AMLin.relativeAircraftCount >= 1 or AMLin.relativePropertyCount >= 8  							=> '8',
																							AMLin.relativePropertyCount >= 5  																																						=> '7',
																							AMLin.relativePropertyCount >= 4  																																						=> '6',
																							AMLin.relativePropertyCount >= 3  																																						=> '5',
																							'0');


export string2 IndHighValAssetsIndex := Map(SubjectOnFile = '0' => '-1',	
																						AMLin.Aircraft.aircraft_count >= 1 and  AMLin.Address_Verification.owned.property_total >= 5  							=> '9',
																						AMLin.Aircraft.aircraft_count >= 1 or  AMLin.Address_Verification.owned.property_total >= 8   																												=> '8',
																						AMLin.Address_Verification.owned.property_total >= 5  																																																=> '7',
																						AMLin.Address_Verification.owned.property_total >= 4  																																																=> '6',
																						AMLin.Address_Verification.owned.property_total >= 3  																																																=> '5',
																						AMLin.Address_Verification.owned.property_total >= 2  																																																=> '4',
																						AMLin.Address_Verification.owned.property_total >= 1 and AMLin.Watercraft.watercraft_count >= 1  																											=> '3',
																						AMLin.Address_Verification.owned.property_total >= 1 or AMLin.Watercraft.watercraft_count >= 1  																											=> '2',
																						(AMLin.Address_Verification.owned.property_total + AMLin.Watercraft.watercraft_count +  AMLin.Aircraft.aircraft_count) = 0 														=>  '1',																					
																						'0');
																							

FipsAddrtoUse :=  ut.st2FipsCode(StringLib.StringToUpperCase(AMLin.shell_input.st)) + AMLin.shell_input.county;

export string2 IndGeogIndex := Map(	SubjectOnFile = '0' => '-1',
																		
																		(FipsAddrtoUse in AML.AMLConstants.setHIFCA  or 	FipsAddrtoUse in AML.AMLConstants.setHIDTA) and 
																		(unsigned)AMLin.AMLEasiTotCrime >= 140 and 
																		StringLib.StringToUpperCase(AMLin.shell_input.st) in AML.AMLConstants.setBorderStates                											       => '9',	

																		(unsigned)AMLin.AMLEasiTotCrime >= 140 and StringLib.StringToUpperCase(AMLin.shell_input.st) in AML.AMLConstants.setBorderStates   => '8', 
																		(unsigned)AMLin.AMLEasiTotCrime >= 140 and 
																							(FipsAddrtoUse in AML.AMLConstants.setHIFCA or	FipsAddrtoUse in AML.AMLConstants.setHIDTA) 																	=> '7',
																		AMLin.HRBusPct or 		AMLin.HighFelonNeighborhood																																								=> '6',
																		Trim(InputAddrDelivery) = '4'		or Trim(InputAddrHighRisk) = '1' 																																			=> '5',
																		FipsAddrtoUse in AML.AMLConstants.setHIFCA or	FipsAddrtoUse in AML.AMLConstants.setHIDTA 																				=> '4',
																		(unsigned)AMLin.AMLEasiTotCrime >= 140 																																													=> '3',
																		(unsigned)AMLin.AMLEasiTotCrime between 60 and 139 																																							=> '2',	
																		(unsigned)AMLin.AMLEasiTotCrime between 1 and 59 																																								=> '1',	
																		'0');
																		
shared 	string1 RelAddrHighRisk := if(noAddrInput, '0', AMLin.AMLhriskaddrflag );	

																													
export string2 RelIndGeogIndex := Map(AMLin.did = 0 => '-1',	
																			(AMLin.AMLst+AMLin.AMLcounty in AML.AMLConstants.setHIFCA or  AMLin.AMLst+AMLin.AMLcounty in AML.AMLConstants.setHIDTA) 
																			and AMLin.AMLst in AML.AMLConstants.setBorderStates and (unsigned)AMLin.AMLEasiTotCrime >= 140  										=> '9',	
																			(unsigned)AMLin.AMLEasiTotCrime >= 140 and AMLin.AMLst in AML.AMLConstants.setBorderStates                          => '8', 
																			(unsigned)AMLin.AMLEasiTotCrime >= 140 and (	AMLin.AMLst+AMLin.AMLcounty in AML.AMLConstants.setHIFCA or			
																																				AMLin.AMLst+AMLin.AMLcounty in AML.AMLConstants.setHIDTA) 												=> '7',
																			AMLin.HRBusPct or 		AMLin.HighFelonNeighborhood	 																																	=> '6',
																			AMLin.AMLAddressVacancyInd = '1' or RelAddrHighRisk = '1' 																													=> '5',	
																		  '0');

export string IndPublicityCount90 := (STRING)AMLin.IndPubCount90;
export string IndPublicityCount24 := (STRING)AMLin.IndPubCount24;


export string2 IndAgeIndex := Map(SubjectOnFile = '0' => '-1',
																	(INTEGER)BestReportedAge(false) between 1 and 18 => '9',
																	(INTEGER)BestReportedAge(false) between 19 and 21 => '8',
																	(INTEGER)BestReportedAge(false) between 22 and 25 => '7',
																	(INTEGER)BestReportedAge(false) between 26 and 35 => '6',
																	(INTEGER)BestReportedAge(false) between 36 and 50 => '5',
																	(INTEGER)BestReportedAge(false) between 51 and 63 => '4',
																	(INTEGER)BestReportedAge(false) between 64 and 75 => '3',
																	(INTEGER)BestReportedAge(false) between 76 and 85 => '2',
																	(INTEGER)BestReportedAge(false) > 85 => '1',
																		'0');



export string2 RelIndAgeIndex := Map(AMLin.did = 0 => '-1',
																			AMLin.AMLAge between 1 and 18 => '9',
																			AMLin.AMLAge between 19 and 21 => '8',
																			AMLin.AMLAge between 22 and 25 => '7',
																			AMLin.AMLAge between 26 and 35 => '6',
																			AMLin.AMLAge between 36 and 50 => '5',
																			'0');
																			
																			
END;