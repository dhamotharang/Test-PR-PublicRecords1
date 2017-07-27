export	Velocity_Constants	:=
module

	// DID record limit
	export	DID_RECORD_LIMIT	:=	1000;
	
	// Sample(Fake DID's)
	export	set of unsigned6	FAKE_DIDS	:=	[999999001001,999999001012];
	
	// Gateway constants
	export	string	ServiceURL							:=	'http://gatewayprodesp.sc.seisint.com:7726/WsDbHandler';
	export	string	AlertIDServiceName			:=	'AccurintSpSearchAlertIdSProc';
	export	string	VelocityIDServiceName		:=	'AccurintSpSearchIdentityVelocityIdSProc';
	
	// Max count for records
	export	integer	MAX_COUNT_RECORDS				:=	1000;
	
	// Descriptions for time frames
	export	DS_TIME_FRAME	:=	dataset(	[	{1,'LAST 24 HOURS'},
																				{7,'LAST 7 DAYS'},
																				{30,'LAST 30 DAYS'},
																				{90,'LAST 90 DAYS'},
																				{365,'LAST 12 MONTHS'},
																				{0,'ALL TIME PERIODS'}
																			],
																			{unsigned	Days,string	Desc}
																		);
	
	// Set which includes industry values that need to be filtered
	export	set	of	string	VERTICAL_FILTER	:=	[	'BACKGROUND SCREENING',
																								'DIRECT MARKETING',
																								'GOVERNMENT',
																								'GOVERNMENT & ACADEMIC',
																								'GOVERNMENT HEALTHCARE',
																								'HEALTHCARE',
																								'HEALTHCARE INITIATIVE',
																								'INSURANCE',
																								'INTERNAL',
																								'INTERNATIONAL VERTICAL',
																								'LEGAL',
																								'LNSSI',
																								'USLM',
                                                // New FIDO verticals
                                                'ECLA INTERNATIONAL', // Old INTERNATIONAL VERTICAL
                                                'PAYER', // Old HEALTHCARE INITIATIVE
                                                'PROVIDER', // Old HEALTHCARE INITIATIVE
                                                'LIFE SCIENCES', // Old HEALTHCARE INITIATIVE
                                                'PHARMACY', // Old HEALTHCARE INITIATIVE
                                                'HEALTHCARE - GOVERNMENT', // Old GOVERNMENT HEALTHCARE
                                                'GOVERNMENT CORE', // Old GOVERNMENT
                                                'INSURANCE EXCHANGE',
                                                'AUTO UNDERWRITING',
                                                'AUTO CLAIMS SUMMARY',
                                                'AUTO MARKETING',
                                                'LIFE INSURANCE',
                                                'INSURANCE OTHER',
                                                'INSURANCE UNASSIGNED',
                                                'INSURANCE INTERNATIONAL',
																								'COMMERCIAL',
																							  'COPLOGIC SOLUTIONS',
																							  'DATA/BULK OKC',
																							  'DISCONTINUEDOPS',
																							  'GOVERNMENT CORE FED',
																							  'GOVERNMENT CORE SL',
																							  'HEALTHCARE - COMMERCIAL',
																							  'HEALTHCARE-GOV FED',
																							  'HEALTHCARE-GOV SL',
																							  'HOME OWNERS',
																							  'INSURANCE INTERNATIONAL',
																							  'INSURANCE OTHER',
																							  'INSURANCE UNASSIGNED',
																							  'INTERNAL',
																							  'LIFE INSURANCE',
																							  'PENDING ASSIGNMENT',
																							  'PI/BACKGROUND',
																							  'SIGNATURE INFO SERVICES',
																							  'VITALCHEK'
																							];
	
	// Set that includes vertical values that need to be filtered
	export	set	of	string	INDUSTRY_FILTER	:=	[	'GOVERNMENT',
																								'HEALTHCARE',
																								'INSURANCE',
																								'INTERNAL',
																								'TEST ACCOUNT'
																							];
	
	// Verticals for all the industries
	export	Vertical	:=
	module
		export	Auto						 :=	'AUTO';
		export	Collections			 :=	'COLLECTIONS';
		export	Core						 :=	'CORE';
		export	Emblem					 :=	'EMBLEM';
		export	Emerging				 :=	'EMERGING';		
		export  Receivable  		 := 'RECEIVABLES MANAGEMENT';
		export	Financial		     :=	'FINANCIAL SERVICES'; 
		export  CorpCore         := 'CORPORATE MARKETS - CORE';		
		export  CorpEnterprise   := 'CORPORATE MARKETS - ENTERPRISE';
		export  Abc              := 'ABC';
		export  Aml              := 'AML';
		export  Gaming           := 'GAMING';
		export  Brm              := 'BRM';
		export  OtherBrm 				 := 'OTHER - BRM';
		export  AutoFinance 		 := 'AUTO FINANCE';
		export  ConsumerCredit 	 := 'CONSUMER CREDIT';
		export  Fraud 					 := 'FRAUD';
		export  OtherFraud 			 := 'OTHER - FRAUD';
		export  CorpMkts  			 := 'CORP MKTS LEGACY';
		export  FsLegacy 			   := 'FS LEGACY';
		export  Infrastructure	 := 'INFASTRUCTURE';
		export  OnePC 					 := '1PC';
		export  ThreePC 				 := '3PC';
		export  Communication    := 'COMMUNICATIONS/MOBILE/MEDIA';
		export  D2c              := 'D2C';
		export  Digital          := 'DIGITAL ECONOMY';
		export  RealEstate       := 'REAL ESTATE';
		export  Cdm              := 'CDM';
		export  Notassigned      := 'NOT ASSIGNED';
	end;

	// Industry categories and values
	export	Industry	:=
	module
		// Industry categories
		export	AltFinancialServices	:=	'ALTERNATIVE FINANCIAL SERVICES';
		export	Auto									:=	'AUTO';
		export	Banking								:=	'BANKING';
		export	Communications				:=	'COMMUNICATIONS';
		export	Credit								:=	'CREDIT';
		export	DirectToConsumer			:=	'DIRECT TO CONSUMER';
		export	Finance								:=	'FINANCE';
		export	Kba										:=	'KBA';
		export	MoneyServiceBusiness	:=	'MONEY SERVICE BUSINESS';
		export	Other									:=	'OTHER CATEGORY';
		export	Retail								:=	'RETAIL';
		export	SkipLocate						:=	'SKIP LOCATE';
		export	Utility								:=	'UTILITIES';
		
		// Industry values
		export	BankingVals						:=	[	'BANKING',
																				'CREDIT UNION',
																				'FINANCIAL SERVICES',
																				'MORTGAGE',
																				'DDA',
																				'CARDS',
																				'CARDS - SUBPRIME',
																				'COMMERCIAL LENDING',
																				'FINANCE COMPANY',
																				'FS SERVICES PROVIDER',
																				'INVESTMENTS/SECURITIES',
																				'MORTGAGE/REAL ESTATE'
																			];
		
		
		export	AltFinServicesVals		:=	[	'PAYDAY',
																				'PAY DAY'
																			];
		
		export	MoneyServiceBusVals		:=	[	'MSB',
																				'PREPAID CARDS'
																			];
		
		export	SkipLocateVals				:=	[	'COLLECTIONS',
																				'COLLECTION LAW FIRM',
																				'FIRST PARTY',
																				'THIRD PARTY'
																			];
	
	
		export	UtilitiesVals					:=	[	'CABLE/SATELLITE/INTERNET',
																				'COMMUNICATIONS',
																				'UTILITIES'
																			];
	end;	//End industry module
	
	// Different product categories and values
	export	Product	:=
	module
		// Product categories
		export	IdVerificationFraudPrevention	:=	'IDENTITY VERIFICATION AND FRAUD PREVENTION';
		export	Other													:=	'OTHER PRODUCTS';
		
		// Product values
		export	IDVFPFunctionVals							:=	[	'BUS INSTANT ID & FRAUDDEFENDER',
																								'BUS INSTANT ID FRAUDDEFENDER',
																								'BUSINESS INSTANT ID',
																								'FLEXID',
																								'FLEXID WITH VERIFICATION SUMMARY FLAGS',
																								'FRAUDPOINT',
																								'FRAUDPOINTÂ®',
																								'IDENTIFIER2 SEARCH',
																								'IDENTITY FRAUD REPORT',
																								'INSTANT ID',
																								'INSTANT ID & FRAUD DEFENDER SEARCH',
																								'INSTANT ID BUSINESS VERIF',
																								'INSTANT ID FRAUD DEFENDER SEARCH',
																								'INSTANT ID INTERNATIONAL',
																								'INSTANT ID MODEL SEARCH',
																								'INSTANT IDÂ® BUSINESS VERIF',
																								'INSTANT IDÂ® BV + FRAUDDEFENDER',
																								'INSTANT IDÂ® BV FRAUDDEFENDER',
																								'INSTANT IDÂ® CONSUMER VERIF',
																								'INSTANT IDÂ® CONSUMER VERIF W FRAUDPOINT',
																								'INSTANT IDÂ® CONSUMER VERIF W/ FRAUDPOINT',
																								'INSTANT IDR CONSUMER VERIF',
																								'INTERNATIONAL INSTANT ID - PASSPORT VALIDATION',
																								'RISK_INDICATORS.INSTANTID_BATCH',
																								'RISKINDICATORS.INSTANTIDBATCH',
																								'RISKWISE AUTOINDEX (VS/SS) (PW50)',
																								'RISKWISE BUSINESS INSTANT ID (PB01)',
																								'RISKWISE BUSINESS INSTANT ID (VS) (BNK4)',
																								'RISKWISE CONSUMER INSTANT ID W/ FRAUD DEFENDER (PW',
																								'RISKWISE CONSUMER INSTANT ID W/ OFAC (NP21)',
																								'RISKWISE CONSUMER INSTANT ID W/O OFAC (NP22)',
																								'RISKWISE CONSUMER INSTANT ID W/OFAC (ISO-CC) (NP82',
																								'RISKWISE CUSTOM FRAUD/ID ADVISOR+ RC (HRG 1-4 EX39',
																								'RISKWISE CUSTOM FRAUDADVISOR (SCORE ONLY EX40)',
																								'RISKWISE CUSTOM FRAUDPOINT/INSTANT ID (ALLV)',
																								'RISKWISE CUSTOM INSTANT ID (IDP1)',
																								'RISKWISE CUSTOM INSTANT ID W/ FRAUDDEFENDER & RC (',
																								'RISKWISE CUSTOM SCORE (WFS2)',
																								'RISKWISE CUSTOM SCORE (WFS3)',
																								'RISKWISE CUSTOM SCORE (WFS4)',
																								'RISKWISE CUSTOM SCORE W/ OFAC (EX94)',
																								'RISKWISE FRAUD & ID ADVISOR (SCORE ONLY EX12)',
																								'RISKWISE FRAUD & ID ADVISOR+ (HRG 1 EX06)',
																								'RISKWISE FRAUD & ID ADVISOR+ (HRG 1-2 EX07)',
																								'RISKWISE FRAUD & ID ADVISOR+ (HRG 1-3 EX08)',
																								'RISKWISE FRAUD & ID ADVISOR+ (HRG 1-4 EX09)',
																								'RISKWISE FRAUD & ID ADVISOR+ (HRG 1-5 EX10)',
																								'RISKWISE FRAUDADVISOR (EX01)',
																								'RISKWISE FRAUDADVISOR (NO SSN EX11)',
																								'RISKWISE FRAUDADVISOR/BUSINESS ADVISOR (EX24)',
																								'RISKWISE FRAUDDEFENDER (PW03)',
																								'RISKWISE FRAUDPOINT PREMIUM INSTANT ID L2 (VS/SS)',
																								'RISKWISE FRAUDPOINT PREMIUM INSTANT ID W/ FORMER (',
																								'RISKWISE ID ADVISOR (RC ONLY EX04)',
																								'RISKWISE ID ADVISOR W/ DATA (EX02)',
																								'RISKWISE ID ADVISOR+ (RC ONLY EX05)',
																								'RISKWISE ID ADVISOR+ W/ DATA (EX03)',
																								'RISKWISE INSTANT ID (CUSTOM NP31)',
																								'RISKWISE INSTANT ID (DL01)',
																								'RISKWISE INSTANT ID (NPT1)',
																								'RISKWISE INSTANT ID W/ LN OFAC (NP90)',
																								'RISKWISE INSTANT ID W/ LN OFAC (NP91)',
																								'RISKWISE INSTANT ID W/ LN OFAC (NP92)',
																								'RISKWISE INSTANT ID W/ OFAC (NP80)',
																								'RISKWISE INSTANT ID W/ OFAC (NP81)',
																								'RISKWISE NEXGEN FRAUD & ID ADVISOR+ (HRG1-3 2X08)',
																								'RISKWISE NEXGEN FRAUD & ID ADVISOR+ (HRG1-5 2X10)',
																								'RISKWISE NEXGEN FRAUDADVISOR (2X01)',
																								'RISKWISE PREMIUM INSTANT ID (PI07)',
																								'RISKWISE PREMIUM INSTANT ID LEVEL 2 (PI02)',
																								'RISKWISE PREMIUM INSTANT ID VERIFICATION SERVICES',
																								'RISKWISE PREMIUM INSTANT ID/FRAUDPOINT (PI09)',
																								'RISKWISE THINDEX (VS/SS) (SD01)',
																								'RISKWISE THINDEX BLUE (VS/SS) (NEW PW01)'
																							];
	end;	//End product module
	
	export	FUNCTIONS_TO_INCLUDE						:=	[	'NATIONAL COMPREHENSIVE REPORT + ASSOCIATES',
																								'PERSON INVESTIGATION',
																								'PATRIOT ACT SEARCH',
																								'NATIONAL COMPREHENSIVE REPORT',
																								'FACES OF THE NATION',
																								'VOTER REGISTRATION SEARCH',
																								'BATCHSERVICES.PROPERTYBATCHSERVICE',
																								'BATCHSERVICES.ACCURINTPROPERTYBATCHSERVICE',
																								'SUMMARY REPORT',
																								'ASSET REPORT',
																								'WE ALSO FOUND REPORT',
																								'NEXT STEPS - NEIGHBORS SEARCH',
																								'DEED SEARCH',
																								'NEXT STEPS - ASSOCIATES SEARCH',
																								'INSTANT ID & FRAUD DEFENDER SEARCH',
																								'DRIVERS LICENSE SEARCH',
																								'ADVANCED PERSON SEARCH',
																								'EAUTHENTICATE TRANSACTION',
																								'ADL INFO SEARCH',
																								'HISTORICAL DL SEARCH',
																								'DIDVILLE.RANBESTINFOBATCHSERVICE',
																								'ADL COMPREHENSIVE SEARCH',
																								'LOCATOR REPORT',
																								'RELATIVE REPORT',
																								'NEXT STEPS - RELATIVES/NEIGHBORS/ASSOCIATES SEARCH',
																								'FLAT RATE COMPREHENSIVE REPORT',
																								'PHONES PLUS SEARCH',
																								'NEXT STEPS - RELATIVES SEARCH',
																								'DIRECTORY ASSISTANCE SEARCH',
																								'TOTAL PROPERTY SEARCH',
																								'FINDER REPORT',
																								'INSTANT ID',
																								'ADDRBEST.BESTADDRESSBATCHSERVICE',
																								'ADVANCED PERSON SEARCH (ROLLUP)',
																								'CUSTOM COMPREHENSIVE REPORT',
																								'PERSON SEARCH'
																							];

end;