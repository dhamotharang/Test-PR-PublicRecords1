// Code originally created by Sandy Butler.
// READ ME NOW! READ ME NOW! READ ME NOW!
// All attributes that have the word RESTRICTED contain data for MN from OKC.  This data CANNOT be
//   part of the normal DL base and key files.  It will go through the normal DL process, but be
//   pulled out before the data becomes part of the base file.  Only if you have the LEGAL right to
//   access and use this data, should you even think about using the code or data.  When in doubt,
//   ask someone.
// READ ME NOW! READ ME NOW! READ ME NOW!

import lib_stringlib, ut;

// A table that associates Minnesota's DL conviction descriptions with their conviction codes
export fn_MN_RESTRICTED_ConvCodes_Table(string conviction_description) := function
	 
	 //Remove all special characters and spaces to eliminate issues where special characters and/or inserted spaces
	 //are causing differences in the conviction description.
	 convdesc 		:= lib_stringlib.stringlib.stringfilter(ut.CleanSpacesAndUpper(conviction_description),'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789');
	 
	 conv_code		:=map(convdesc='ALLOWFAILINDUTIESOFDRIVERATACCIDENT'							=>'AC0',
											convdesc='FAILTOGIVEREQUIREDINFORMATIONATACCIDENT'					=>'AC1',
											convdesc='FAILTOLEAVEINFORMATIONATACCIDENTSCENE'						=>'AC2',
											convdesc='FAILTOREPORTACCIDENT'															=>'AC3',
											convdesc='GIVEFALSEINFORMATIONONACCIDENTREPORT'							=>'AC4',
											convdesc='FAILTOGIVEINSURANCEINFORMATIONAFTERACCI'					=>'AC5',	//to handle truncation issue
											convdesc='FAILTOGIVEINSURANCEINFORMATIONAFTERACCIDENT'			=>'AC5',
											convdesc='ALLOWUSEDLMNIDCARDATTEMPTPURCHASALCOHOL'					=>'AL0',
											convdesc='USEDLMNIDCARDATTEMPTTOPURCHASEALCOH'							=>'AL1',	//to handle truncation issue
											convdesc='USEDLMNIDCARDATTEMPTTOPURCHASEALCOHOL'						=>'AL1',
											convdesc='ALLOWILLEGALORIMPROPERBACKING'										=>'BA0',
											convdesc='ILLEGALORIMPROPERBACKING'													=>'BA1',
											convdesc='BODILYHARMCVOALCOHOL'															=>'CB1',
											convdesc='BODILYHARMCVODRUGSHAZARDOUSSUBSTANCES'						=>'CB2',
											convdesc='BODILYHARMCVO'																		=>'CB3',
											convdesc='ALLOWCHANGEOFCOURSEVIOLATION'											=>'CC0',
											convdesc='ILLEGALCHANGEOFCOURSE'														=>'CC1',
											convdesc='ILLEGALORIMPROPERTURN'														=>'CC2',
											convdesc='ILLEGALORIMPROPERUTURN'														=>'CC3',
											convdesc='IMPROPERLANECHANGE'																=>'CC4',
											convdesc='FAILTOSIGNAL'																			=>'CC5',
											convdesc='IMPROPERSIGNAL'																		=>'CC6',
											convdesc='FATALCVOALCOHOL'																	=>'CF1',
											convdesc='FATALCVODRUGSHAZARDOUSSUBSTANCES'									=>'CF2',
											convdesc='FATALCVO'																					=>'CF3',
											convdesc='GREATBODILYHARMCVOALCOHOL'												=>'CG1',
											convdesc='GREATBODILYHARMCVODRUGSHAZARDOUSSUBSTANCES'				=>'CG2',
											convdesc='GREATBODILYHARMCVO'																=>'CG3',
											convdesc='ALLOWCRIMINALNEGLIGENCE'													=>'CN0',
											convdesc='CRIMINALNEGLIGENCE'																=>'CN1',
											convdesc='CRIMINALVEHICULAROPERATIONFATAL'									=>'CN2',
											convdesc='CRIMINALVEHICULAROPERATIONGREATBODILYHARM'				=>'CN3',
											convdesc='CRIMVEHOPERATIONSUBSTANTIALBODILYHARM'						=>'CN4',
											convdesc='CRIMINALVEHICULAROPERATIONBODILYHARM'							=>'CN5',
											convdesc='CRIMVEHOPERATIONINJURYTOUNBORNCHILD'							=>'CN6',
											convdesc='CHILDRESTRAINTVIOLATION'													=>'CR1',
											convdesc='SUBSTANTIALBODILYHARMCVOALCOHOL'									=>'CS1',
											convdesc='SUBSTANTIALBODILYHARMCVODRUGSHAZARDOUSSUB'				=>'CS2',
											convdesc='SUBSTANTIALBODILYHARMCVO'													=>'CS3',
											convdesc='CRIMINALVEHICULAROPERATIONFATAL'									=>'CV2',
											convdesc='CRIMINALVEHICULAROPERATIONGREATBODILYH'						=>'CV3',	//to handle truncation issue
											convdesc='CRIMINALVEHICULAROPERATIONGREATBODILYHARM'				=>'CV3',
											convdesc='CRIMVEHOPERATIONSUBSTANTIALBODILYHARM'						=>'CV4',
											convdesc='CRIMINALVEHICULAROPERATIONBODILYHARM'							=>'CV5',
											convdesc='CRIMVEHOPERATIONINJURYTOUNBORNCHILD'							=>'CV6',
											convdesc='ALLOWDRIVINGAFTERWITHDRAWAL'											=>'DA0',
											convdesc='DRIVINGAFTERWITHDRAWAL'														=>'DA1',
											convdesc='VIOLATIONOFLIMITEDLICENSE'												=>'DA2',
											convdesc='POSSESSIONORDISPLAYOFWITHDRAWNDLMNID'							=>'DA3',	//to handle truncation issue                 
											convdesc='POSSESSIONORDISPLAYOFWITHDRAWNDLMNIDC'						=>'DA3',	//to handle truncation issue										
											convdesc='POSSESSIONORDISPLAYOFWITHDRAWNDLMNIDCARD'					=>'DA3',
											convdesc='FAILTOSURRENDERWITHDRAWNDLMNIDCARD'								=>'DA4',
											convdesc='DRIVINGAFTERINIMICALCANCELLATION'									=>'DA5',
											convdesc='DRIVINGAFTERINIMICALCANCELLATIONNOACTION'					=>'DA5',	//to handle old value 											
											convdesc='DRIVINGAFTERCANCPETTYMSD'													=>'DA6',	//to handle old value ??
											convdesc='DRIVINGAFTERWITHDRAWALPETTY'											=>'DA6',
											convdesc='PETTYMSDDRIVINGAFTERWITHDRAWL'										=>'DA6',	//to handle old value                           
											convdesc='PETTYMSDDRIVINGAFTERWITHDRAWL02'									=>'DA6',	//to handle old value  											
											convdesc='DRIVINGATERWITHDRAWALNOACTION'										=>'DA7',	//to handle old value
											convdesc='DRIVINGAFTERWITHDRAWLNOACTION'										=>'DA7',	//to handle old value                           
											convdesc='DRIVINGAFTERWITHDRAWNNOACTION'										=>'DA7',	//to handle old value           
											convdesc='DRIVINGAFTERWITHDRAWLNOACTION'										=>'DA7',	//to handle old value                             	
											convdesc='DRIVINGAFTERWITDHRAWALNOACTION'										=>'DA7',	//to handle old value                                     
											convdesc='DRIVINGAFTERWITHDRAWALNOACITON'										=>'DA7',	//to handle old value              
											convdesc='DRIVINGAFTERWITHDRAWLNNOACTION'										=>'DA7',	//to handle old value                                     
											convdesc='DRIVINGAFTERWITHDRAWALNOACTIONPETTY'							=>'DA7',	//to handle old value                               
											convdesc='DRIVINGAFTERWITHDRAWALPETTYNOACTION'							=>'DA7',	//to handle old value            																		
											convdesc='DRIVINGAFTERWTIHDRAWLNOACTION'										=>'DA7',	//to handle old value 
											convdesc='DRIVINGAFTERWTIHDRAWALNOACTION'										=>'DA7',	//to handle old value           
											convdesc='DRIVINGAFTERWTITHDRAWALNOACTION'									=>'DA7',	//to handle old value           
											convdesc='DRIVINGAFTERWITHDRAWALNOACTION'										=>'DA7',
											convdesc='DUIPLED20ORMORE'																	=>'DH1',
											convdesc='DUI20ORMORE'																			=>'DH2',
											convdesc='DUIRAILROADCROSSING'															=>'DH3',
											convdesc='DUIRAILROADCROSSING20ORMORE'											=>'DH4',
											convdesc='DUIRAILROADCROSSINGOFFROADRECVEHICLE'							=>'DH5',
											convdesc='DUIRAILROADCROSSING20ORMORERECVEHICLE'						=>'DH6',
											convdesc='ALLOWDUIALCOHOLORCNTRLSUB'												=>'DI0',
											convdesc='DRIVINGWHILEUNDERINFLUENCEPLED'										=>'DI1',
											convdesc='DRIVINGWHILEUNDERTHEINFLUENCE'										=>'DI2',
											convdesc='AGGDRIVINGWHILEUNDERINFLUENCEPLED'								=>'DI3',
											convdesc='AGGRAVATEDDRIVINGWHILEUNDERINFLUENCE'							=>'DI4',
											convdesc='DRIVEWHILEUNDRINFLUENCOFCONT'											=>'DI5',	//to handle truncation issue
											convdesc='DRIVEWHILEUNDRINFLUENCOFCONTSUBSTANCE'						=>'DI5',	//to handle truncation issue
											convdesc='DRIVEWHILEUNDRINFLUENCOFCONTSUBSTANCEPLED'				=>'DI5',
											convdesc='DRIVEWHILEUNDRTHEINFLUENCOFCONTSUBSTA'						=>'DI6',	//to handle truncation issue											
											convdesc='DRIVEWHILEUNDRTHEINFLUENCOFCONTSUBSTANCE'					=>'DI6',
											convdesc='AGGDRIVEUNDERINFLUENCEOFCONTSUBSTANCEPLED'				=>'DI7',
											convdesc='AGGDRIVEUNDERINFLUENCEOFCONTSUBSTANCE'						=>'DI7',	//to handle truncation issue
											convdesc='AGGRAVATEDDRIVEUNDRINFLUENCOFCONTSUBSTANCE'				=>'DI8',
											convdesc='ALCOHOLRELATEDDRIVING04ORMORECONVICTIO'						=>'DI9',	//to handle truncation issue
											convdesc='ALCOHOLRELATEDDRIVING04ORMORECONVICTION'					=>'DI9',																
											convdesc='DRIVINGWHILEUNDERTHEINFLUENCEIC1'									=>'DJ0',
											convdesc='DRIVINGWHILEUNDERTHEINFLUENCEIC3'									=>'DJ1',
											convdesc='DRIVINGWHILEUNDERTHEINFLUENCEIC6'									=>'DJ2',
											convdesc='AGGDRIVINGWHILEUNDERINFLUENCEIC3'									=>'DJ3',
											convdesc='AGGDRIVINGWHILEUNDERINFLUENCEIC6'									=>'DJ4',
											convdesc='AGGDRIVINGWHILEUNDERINFLUENCEIC1'									=>'DJ5',
											convdesc='DRIVINGUNDERINFLUENCEOFCONTSUBSTANCEIC1'					=>'DJ6',
											convdesc='DRIVINGUNDERINFLUENCEOFCONTSUBSTANCEICD'					=>'DJ7',
											convdesc='AGGDRIVINGUNDERINFLUENCECONTSUBSTANCEIC1'					=>'DJ8',
											convdesc='AGGDRIVINGUNDERINFLUENCECONTSUBSTANCEIC3'					=>'DJ9',
											convdesc='DUI20ORMOREIC9'																		=>'DK1',
											convdesc='DUI16ORMORE'																			=>'DK2',
											convdesc='DUI16ORMOREINOFFROADVEHICLE'											=>'DK3',
											convdesc='DUIRAILROADCROSSING16ORMORE'											=>'DK4',
											convdesc='DUIRAILROADCROSSING16ORMOREOFFROADVEH'						=>'DK5',
											convdesc='ALLOWEXPIREDIMPROPERORNODRIVLICPOSSESSION'				=>'DL0',
											convdesc='NODRIVERLICENSEINPOSSESSION'											=>'DL1',
											convdesc='NODRIVERSLICENSEINPOSSESSIONPETTY'								=>'DL1',	//to handle old value											
											convdesc='VIOLATEINSTRUCTIONPERMIT'													=>'DL2',	//to handle old value ??
											convdesc='EXPIREDDRIVERLICENSEORINSTRUCTIONPERMIT'					=>'DL2',
											convdesc='INVALIDDRIVERLICENSE'															=>'DL3',
											convdesc='IMPROPERADDRESSONDRIVERLICENSE'										=>'DL4',
											convdesc='FAILTODISPLAYDRIVERLICENSE'												=>'DL5',
											convdesc='TEXTINGWHILEOPERATINGAMOTORVEHICLE'								=>'DL6',
											convdesc='USINGAHANDHELDPHONEWHILEDRIVING'									=>'DL7',
											convdesc='DUICHILDENDANGERMENT'															=>'ED1',
											convdesc='DUICHILDENDANGERMENT20ORMORE'											=>'ED2',
											convdesc='DUICHILDENDANGERMENTOFFROADRECVEHICLE'						=>'ED3',
											convdesc='DUICHILDENDANGERMENT20ORMORERECVEHICL'						=>'ED4',	//to handle truncation issue
											convdesc='DUICHILDENDANGERMENT20ORMORERECVEHICLE'						=>'ED4',
											convdesc='SCHOOLBUSHEADSTARTDRIVERNOTADROP'									=>'ED5',
											convdesc='DUICHILDENDANGERMENT16ORMORE'											=>'ED6',
											convdesc='DUICHILDENDANGERMENT16ORMORERECVEHICLE'						=>'ED7',
											convdesc='ALLOWEQUIPMENTVIOLATION'													=>'EQ0',
											convdesc='EQUIPMENTVIOLATION'																=>'EQ1',
											convdesc='MOTORCYCLEEQUIPMENTVIOLATION'											=>'EQ2',
											convdesc='LITTERING'																				=>'EQ3',
											convdesc='ALLOWFAILTOAPPEAR'																=>'FA0',
											convdesc='FAILTOAPPEARORPAYFINE'														=>'FA1',
											convdesc='ALLOWUSEMOTORVEHICLEINCOMMISSIONOFAFELONY'				=>'FE0',
											convdesc='USEOFMOTORVEHICLEINCOMMISSIONOFA'									=>'FE1',	//to handle truncation issue
											convdesc='USEOFMOTORVEHICLEINCOMMISSIONOFAFELON'						=>'FE1',	//to handle truncation issue
											convdesc='USEOFMOTORVEHICLEINCOMMISSIONOFAFELONY'						=>'FE1',
											convdesc='SALEMANUFACTUREDISTRIBUTIONORPOSSOFDR'						=>'FE2',	//to handle truncation issue
											convdesc='SALEMANUFACTUREDISTRIBUTIONORPOSSOFDRUGS'					=>'FE2',
											convdesc='SOLDPOSSESSEDCONTROLLEDSUBSTANCE'									=>'FE3',
											convdesc='ALLOWILLEGALORIMPROPERFOLLOW'											=>'FO0',
											convdesc='FOLLOWTOOCLOSE'																		=>'FO1',
											convdesc='FOLLOWEMERGENCYVEHICLE'														=>'FO2',
											convdesc='ALLOWFLEEFROMPEACEOFFICER'												=>'FP0',
											convdesc='FLEEPEACEOFFICER'																	=>'FP1',
											convdesc='FLEEPEACEOFFICERFATAL'														=>'FP2',
											convdesc='FLEEPEACEOFFICERGREATBODILYHARM'									=>'FP3',
											convdesc='FLEEPEACEOFFICERSUBSTANTIALBODILYHARM'						=>'FP4',
											convdesc='ALLOWHEADLIGHTVIOLATION'													=>'HL0',
											convdesc='FAILTODIMHEADLIGHTS'															=>'HL1',
											convdesc='DRIVEWITHOUTHEADLIGHTS'														=>'HL2',
											convdesc='DRIVEMOTORCYCLEWITHOUTHEADLIGHT'									=>'HL3',
											convdesc='ALLOWLEAVESCENEOFACCIDENT'												=>'HR0',
											convdesc='LEAVESCENEOFACCIDENTFATAL'												=>'HR1',
											convdesc='LEAVESCNEACCPERSINJPETTYMISD'											=>'HR2',	//to handle old value
											convdesc='LEAVESCENEOFACCIDENTPERSONALINJURY'								=>'HR2',							
											convdesc='LEAVESCENEOFACCIDENTPETTYMISDEAMONOR'							=>'HR3', 	//to handle old value                                                  
											convdesc='LEAVESCENEPETTYMSD'																=>'HR3', 	//to handle old value                                      
											convdesc='LEAVESCENEPDPETTYMISD'														=>'HR3',	//to handle old value
											convdesc='LEAVESCENEACCNOPERSINJURYPETTYMSD'								=>'HR3',	//to handle old value
											convdesc='LEAVESCENEOFACCIDENTPETTYMISDEAMONOR'							=>'HR3',	//to handle old value                   
											convdesc='LEAVESCENEOFACCIDENTNOPERSONALINJURY'							=>'HR3',
											convdesc='IMPLIEDCONSENTTESTDRUGS'													=>'ICD',
											convdesc='IMPLIEDCONSENTTESTDRUGSOFFROADRECVEH'							=>'ICE',
											convdesc='IMPLIEDCONSENTTESTREFUSALCONVICTION'							=>'ICR',
											convdesc='IMPLIEDCONSENTREFUSAL'														=>'IC1',
											convdesc='IMPLIEDCONSENTTEST16ORMORE'												=>'IC2',
											convdesc='IMPLIEDCONSENTTEST'																=>'IC3',
											convdesc='IMPLIEDCONSENTTEST'																=>'IC4',
											convdesc='IMPLIEDCONSENTREFUSAL'														=>'IC6',
											convdesc='IMPLIEDCONSENTREFUSAL'														=>'IC7',
											convdesc='IMPLIEDCONSENTTEST04ORMORE'												=>'IC8',
											convdesc='IMPLIEDCONSENTTEST20ORMORE'												=>'IC9',
											convdesc='ALLOWLANEUSAGEVIOLATION'													=>'IL0',
											convdesc='ILLEGALORIMPROPERUSEOFLANE'												=>'IL1',
											convdesc='OVERCENTERLINE'																		=>'IL2',
											convdesc='WRONGWAY'																					=>'IL3',
											convdesc='MOTORCYCLELANEVIOLATION'													=>'IL4',
											convdesc='DRIVINGONSHOULDER'																=>'IL5',
											convdesc='ALLOWINTERFERENCEWITHCONTROLVISIONORHEARING'			=>'IN0',
											convdesc='CROWDEDDRIVERSEAT'																=>'IN1',
											convdesc='DRIVEWITHEQUIPMNTINTERFERINGVISIONOR'							=>'IN2',	//to handle truncation issue
											convdesc='DRIVEWITHEQUIPMNTINTERFERINGVISIONORHEA'					=>'IN2',	//to handle truncation issue			
											convdesc='DRIVEWITHEQUIPMNTINTERFERINGVISIONORHEARING'			=>'IN2',
											convdesc='VISIONOBSTRUCTED'																	=>'IN3',
											convdesc='TOOMANYPASSENGERSONMOTORCYCLE'										=>'IN4',
											convdesc='PASSENGERONMOPED'																	=>'IN5',
											convdesc='INATTENTIVEDRIVING'																=>'IN6',
											convdesc='INATTENTIVEDRIVINGPETTY'													=>'IN6',	//to handle old value
											convdesc='ALLOWILLEGALOPERATION'														=>'IO0',
											convdesc='ILLEGALOPERATION'																	=>'IO1',
											convdesc='IGNITIONINTERLOCKVIOLPROVIDENONEQUIPMV'						=>'IV1',
											convdesc='IGNITIONINTERLOCKVIOLTAMPBYPASS'									=>'IV2',	//to handle truncation issue                         
											convdesc='IGNITIONINTERLOCKVIOLTAMPBYPASSCIRCUMVEN'					=>'IV2',	//to handle truncation issue											
											convdesc='IGNITIONINTERLOCKVIOLTAMPBYPASSCIRCUMVENT'				=>'IV2',
											convdesc='UNDER21DRINKINGANDDRIVING'												=>'JA1',
											convdesc='UNDERAGEDRINKDRIVEPETTYMSD'												=>'JA1',	//to handle old value
											convdesc='ALLOWJUVENILEUSEDLMNIDCARDPURCTOBACCO'						=>'JV0',
											convdesc='JUVENILEUSEDLMNIDCARDATTEMPTPURCHALCOHOL'					=>'JV1',
											convdesc='JUVENILEUSEDLMNIDCARDPURCTOBACCO'									=>'JV2',
											convdesc='ALLOWNODRIVERLICENSECLASSORENDORS'								=>'LC0',	//to handle truncation issue
											convdesc='ALLOWNODRIVERLICENSECLASSORENDORSVIOLA'						=>'LC0',	//to handle truncation issue
											convdesc='ALLOWNODRIVERLICENSECLASSORENDORSVIOLATION'				=>'LC0',
											convdesc='NOMOTORCYCLEENDORSEMENT'													=>'LC1',
											convdesc='NOSCHOOLBUSENDORSEMENT'														=>'LC2',
											convdesc='NOMOPEDPERMIT'																		=>'LC3',
											convdesc='INSTRUCTIONPERMITPROVISIONALLICENSE'							=>'LC4',	//to handle truncation issue                      
											convdesc='INSTRUCTIONPERMITPROVISIONALLICENSEVIOLAT'				=>'LC4',	//to handle truncation issue											
											convdesc='INSTRUCTIONPERMITPROVISIONALLICENSEVIOLATION'			=>'LC4',
											convdesc='MOTORCYCLEINSTRUCTIONPERMITVIOLATION'							=>'LC5',
											convdesc='EXPIREDMOTORCYCLEINSTRUCTIONPERMIT'								=>'LC6',
											convdesc='WRONGCLASSLICENSE'																=>'LC7',
											convdesc='NODRIVERLICENSE'																	=>'LC8',
											convdesc='NOMNDLPETTY'																			=>'LC9',	//to handle old value
											convdesc='NOMNDLPETTYMSD'																		=>'LC9',	//to handle old value                                          
											convdesc='NOMINNESOTADLPETTY'																=>'LC9',	//to handle old value                                       
											convdesc='NOMINNESOTADRIVERSLICENSEPETTY'										=>'LC9',	//to handle old value
											convdesc='NOMINNESOTADRIVERLICENSE'													=>'LC9',	
											convdesc='MEDICALCERTADMINACTION'														=>'MC1',
											convdesc='MEDICALCERTCONV'																	=>'MC2',
											convdesc='USEDLINATTEMPTTOPURCHASEALCOHOL'									=>'MI1',
											convdesc='ALLOWILLEGALUSEOFDRIVERLICENSEMNIDCAR'						=>'MR0',	//to handle truncation issue
											convdesc='ALLOWILLEGALUSEOFDRIVERLICENSEMNIDCARD'						=>'MR0',
											convdesc='P0SSESSORDISPLAYFICTITIOUSALTERED'								=>'MR1',	//to handle truncation issue                       
											convdesc='P0SSESSORDISPLAYFICTITIOUSALTEREDDLIPO'						=>'MR1',	//to handle truncation issue											
											convdesc='P0SSESSORDISPLAYFICTITIOUSALTEREDDLIPORID'				=>'MR1',
											convdesc='DEFACEDORMUTILATEDDLIPORID'												=>'MR2',
											convdesc='USEFICTICIOUSNAMETOPOLICEAPPLICATION'							=>'MR3',
											convdesc='MAKEFRAUDULENTDRIVERLICENSE'											=>'MR4',
											convdesc='USEORDISPLAYANOTHERSDRIVERLICENSEMNID'						=>'MR5',	//to handle truncation issue
											convdesc='USEORDISPLAYANOTHERSDRIVERLICENSEMNIDCARD'				=>'MR5',
											convdesc='POSSESSANOTHERSDRIVERLICENSEMNIDCARD'							=>'MR6',
											convdesc='ALLOWANOTHERTOUSEDRIVERLICENSEMNIDCAR'						=>'MR7',	//to handle truncation issue
											convdesc='ALLOWANOTHERTOUSEDRIVERLICENSEMNIDCARD'						=>'MR7',		
											convdesc='GIVEFALSEINFORMATIONTOPOLICEOFFICER'							=>'MR8',
											convdesc='TAKEANYPARTOFDRIVERLICENSEEXAMFORANOTHER'					=>'MR9',
											convdesc='USEOFFRAUDFORISSUANCEOFACDLORCLPLICENSE'					=>'MS0',	
											convdesc='ALLOWNOFAULT'																			=>'NF0',
											convdesc='NOFAULT'																					=>'NF1',
											convdesc='NOPROOFOFINSURANCE'																=>'NF2',
											convdesc='NOPROOFOFINSURANCEREPORT'													=>'NF3',
											convdesc='NOPROOFOFINSURANCECONVICTION'											=>'NF4',
											convdesc='NOINSURANCECONVICTION'														=>'NF6',
											convdesc='NOPROOFREPORTPOLICEISSUE'													=>'NF7',
											convdesc='NOPROOFOFINSURANCECOURTADMIN'											=>'NF8',
											convdesc='FAILTOPROVIDEINSURANCEINFOCONVICTION'							=>'NF9',
											convdesc='ALLOWOPENBOTTLE'																	=>'OB0',
											convdesc='ALLOWOPENBOTTLEPETTY'															=>'OB0',	//to handle old value
											convdesc='OPENBOTTLE'																				=>'OB1',
											convdesc='OPENBOTTLEPETTY'																	=>'OB1',	//to handle old value
											convdesc='OPENBOTTLEPETTYMISD'															=>'OB1',	//to handle old value
											convdesc='ALLOWPASSINGVIOLATION'														=>'PA0',
											convdesc='ILLEGALORIMPROPERPASSING'													=>'PA1',
											convdesc='FAILTOALLOWPASSING'																=>'PA2',
											convdesc='PASSONSHOULDER'																		=>'PA3',
											convdesc='ALLOWFAILTOOBEYPEACEOFFICER'											=>'PO0',
											convdesc='FAILTOOBEYPEACEOFFICER'														=>'PO1',                        
											convdesc='FAILURETOOBEYPOLICEOFFICERPETTY'									=>'PO1',	//to handle old value
											convdesc='PERJURYFALSEAFFIDAVIT'														=>'PR1',
											convdesc='ALLOWCARELESSORRECKLESSDRIVING'										=>'RK0',
											convdesc='PETTYCARELESS'																		=>'RK1',	//to handle old value
											convdesc='CARELESSPETTY'																		=>'RK1',	//to handle old value											
											convdesc='CARELESSDRIVING'																	=>'RK1',
											convdesc='CARLESSPETTYMISD'																	=>'RK1',	//to handle old value											
											convdesc='NEGLIGENTDRIVING'																	=>'RK1',	//to handle old value											
											convdesc='CARELESSDRVPETTYMSD'															=>'RK1',	//to handle old value                                      
											convdesc='CARLESSDRVGPETYMISD'															=>'RK1',	//to handle old value                                      
											convdesc='CARELESSDRIVINGPETTY'															=>'RK1',	//to handle old value
											convdesc='CARELESSDRVGPETTYMSD'															=>'RK1',	//to handle old value                                     
											convdesc='CARLESSDRVGPETTYMISD'															=>'RK1',	//to handle old value                                     
											convdesc='CARELESSDRIVIINGPETTY'														=>'RK1',	//to handle old value
											convdesc='CARLESSDRIVINGPETTYMSD'														=>'RK1',	//to handle old value
											convdesc='CARELESSDRIVINGPETTYMSD'													=>'RK1',	//to handle old value
											convdesc='CARELESSDRIVINGPETTYMISD'													=>'RK1',	//to handle old value
											convdesc='CARELESSDRIVINGAMENDEDFROMDWI'										=>'RK1',	//to handle old value
											convdesc='CARELESSDRIVINGPETTYMISDEMEANOR'									=>'RK1',	//to handle old value
											convdesc='RECKLESSDRVGPETTY'																=>'RK2',	//to handle old value
											convdesc='RECKLESSPETTYMUISD'																=>'RK2',	//to handle old value											
											convdesc='RECKLESSDRIVINGPETTY'															=>'RK2',	//to handle old value
											convdesc='RECKLESSDRIVINGPETTY'															=>'RK2',	//to handle old value
											convdesc='RECKLESSDRVGPETTYMISD'														=>'RK2',	//to handle old value
											convdesc='RECKLESSDRIVINGPETTYMSD'													=>'RK2',	//to handle old value
											convdesc='RECKLESSDRIVINGPETTYMISD'													=>'RK2',	//to handle old value
											convdesc='RECKLESSDRIVINGPETTYMSDPERCT'											=>'RK2',	//to handle old value
											convdesc='RECKLESSDRIVING'																	=>'RK2',
											convdesc='CARELESSDRIVINGAMENDEDFROMDWI'										=>'RK3',
											convdesc='RAILROADINGVIOLFAILTOSLOWDOWN'										=>'RR0',
											convdesc='RAILROADINGVIOLFAILTOSTOPB4REACHINGTR'						=>'RR1',	//to handle truncation issue
											convdesc='RAILROADINGVIOLFAILTOSTOPB4REACHINGTRACKS'				=>'RR1',
											convdesc='RAILROADINGVIOLFAILTOSTOPASREQUIRED'							=>'RR2',
											convdesc='RAILROADINGVIOLSTOPONTRACKS'											=>'RR3',
											convdesc='RAILROADINGVIOLINSUFFUNDERCARRIAGECLEARANCE'			=>'RR4',
											convdesc='ALLOWRESTRICTIONVIOLATION'												=>'RV0',
											convdesc='RESTRICTIONVIOLATION'															=>'RV1',
											convdesc='RESTRICTIONVIOLALCOHOLORDRUG'											=>'RV2',
											convdesc='IGNITIONINTERLOCKVIOLMVNODEVICE'									=>'RV3',
											convdesc='ALLOWRIGHTOFWAYVIOLATION'													=>'RW0',
											convdesc='FAILTOYIELDTOMOTORVEHICLE'												=>'RW1',
											convdesc='FAILTOYIELDPETTYMISDEMEANOR'											=>'RW1',	//to handle old value
											convdesc='FAILTOYIELDTOPEDESTRIAN'													=>'RW2',
											convdesc='FAILTOSTOPATSIDEWALKORLEAVINGALLEY'								=>'RW3',
											convdesc='FAILTOSTOPATPEDESTRIANCROSSWALK'									=>'RW4',
											convdesc='FAILTOSTOPATSCHOOLCROSSINGORPATROL'								=>'RW5',	
											convdesc='ALLOWFAILTOSTOPFORSCHOOLBUS'											=>'SB0',
											convdesc='FAILTOSTOPFORSCHOOLBUS'														=>'SB1',
											convdesc='FAILTOSTOPFORSCHOOLBUSGROSS'											=>'SB2',	//to handle truncation issue 
											convdesc='FAILTOSTOPFORSCHOOLBUSGROSSMISDEMEAN'							=>'SB2',	//to handle truncation issue
											convdesc='FAILTOSTOPFORSCHOOLBUSGROSSMISDEMEANOR'						=>'SB2',
											convdesc='SCHOOLBUSDRIVERVIOLATION'													=>'SB3',
											convdesc='FAILTOSTOPFORSCHOOLBUSPETTY'											=>'SB4',
											convdesc='ALLOWFAILTOOBEYTRAFFICCONTROLDEVICES'							=>'SC0',
											convdesc='FAILTOOBEYSIGN'																		=>'SC1',
											convdesc='FAILTOOBEYSEMAPHORE'															=>'SC2',
											convdesc='FAILTOSTOPATRAILROADCROSSING'											=>'SC3',
											convdesc='VIOLATIONOFCONTROLLEDACCESS'											=>'SC4',
											convdesc='HOVLANEINFRACTION'																=>'SC5',
											convdesc='DRIVINGINPROHIBITEDAREA'													=>'SC6',
											convdesc='CROSSINGMEDIANORCENTERLANE'												=>'SC7',
											convdesc='RAILROADGRADECROSSINGVIOLATION'										=>'SC8',
											convdesc='ALLOWSPEEDORFAILTOEXERCISEDUECARE'								=>'SP0',
											convdesc='SPEED'																						=>'SP1',
											convdesc='SPEEDPETTY'																				=>'SP1',	//to handle old value
											convdesc='MINIMUMSPEED'																			=>'SP2',
											convdesc='EXHIBITIONDRIVING'																=>'SP3',
											convdesc='ERRATICDRIVING'																		=>'SP4',
											convdesc='UNREASONABLEACCELERATION'													=>'SP5',
											convdesc='FAILTOEXERCISEDUECAREORCONTROL'										=>'SP6',
											convdesc='SERIOUSSPEED'																			=>'SP7',
											convdesc='RACING'																						=>'SP8',
											convdesc='SPEEDOVER100MPH'																	=>'SP9',
											convdesc='ALLOWUNSAFESTART'																	=>'ST0',
											convdesc='UNSAFESTART'																			=>'ST1',
											convdesc='THEFTOFGAS'																				=>'TG1',
											convdesc='ALLOWTRAFFICHAZARD'																=>'TH0',
											convdesc='TRAFFICHAZARD'																		=>'TH1',
											convdesc='STOPONHIGHWAYORFREEWAY'														=>'TH2',
											convdesc='OPENDOORINTOTRAFFIC'															=>'TH3',
											convdesc='ILLEGALPARKING'																		=>'TH4',
											convdesc='IMPEDETRAFFIC'																		=>'TH5',
											convdesc='UNCODEDPETTYMISDEMEANORMOVINGVIOLATION'						=>'UC1',
											convdesc='UNCODEDMISDEMEANORMOVINGVIOLATION'								=>'UC2',
											convdesc='UNCODEDNOTCOUNTEDTOWARDANYDEPARTMENTAC'						=>'UC3',	//to handle truncation issue
											convdesc='UNCODEDNOTCOUNTEDTOWARDANYDEPARTMENTACTION'				=>'UC3',
											convdesc='UNCODEDREVIEWBYDEVREQUIRED'												=>'UC4',
											convdesc='VIOLATIONOFOUTOFSERVICEORDER'											=>'VO1',
											convdesc='ALLOWTHEFTOFMOTORVEHICLE'													=>'WP0',
											convdesc='THEFTOFMOTORVEHICLE'															=>'WP1',
											convdesc='THEFTOFAMOTORVEHCILEPETTY'												=>'WP1',	//to handle old value
											convdesc='THEFTTAKEDRIVEMVNOOWNERCONSENTGROSSMI'						=>'WP1',	//to handle old value
											convdesc='THEFTTAKEDRIVEMVNOOWNERCONSENTGROSSMISDEM'				=>'WP1',	//to handle old value
											convdesc='USEMOTORVEHICLETOPATRONIZEPROSTITUTION'						=>'XY1',
											convdesc='ICTESTREFUSALINOFFROADRECVEHICLE'									=>'XY2',
											convdesc='DUIINOFFROADRECREATIONALVEHICLE'									=>'XY3',
											convdesc='DUI20ORMOREINOFFROADRECVEHICLE'										=>'XY4',
											convdesc='ICTESTREFUSALCONVICTIONOFFROADVEH'								=>'XY5',
											convdesc='ICTESTINOFFROADRECREATIONALVEHICLE'								=>'XY6',
											convdesc='ICTEST20ORMOREINOFFROADVEHICLE'										=>'XY7',
											convdesc='ICTEST16ORMOREINOFFROADVEHICLE'										=>'XY8',
											convdesc='DUICONTSUBSTANCEINOFFROADVEHICLE'									=>'XY9',
											'');

	return_conv_code := ut.CleanSpacesAndUpper(conv_code);
	
	return return_conv_code;
end;