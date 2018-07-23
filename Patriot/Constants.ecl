EXPORT	Constants	:=
MODULE

	export	boolean	BUILD_BID_KEYS	:=	true;

  export	real	DEF_THRESHOLD			:=	0.84;
  export	real	DEF_THRESHOLD_V4	:=	0.85;
  export	real	MAX_THRESHOLD			:=	1.00;
  export	real	MIN_THRESHOLD			:=	0.70;
	
	EXPORT STRING LIMIT_ERROR_MESSAGE := 'Search is too broad. Too many results.';
	
	export	string	wlALL		:=	'ALL';  		// FROM PRODUCT MANAGEMENT "ALL WILL MEAN ALL AVAILABLE LISTS"
	export	string	wlALLV4		:=	'ALLV4';  		// Includes ALL Plus Additional V4 Lists"
	//export	string	wlADD		:=	'ADD';  	// Additional list from above,without ofac
	//export	string	wlALLP	:=	'ALLP';  	// include all of the lists below

	export	string	wlADFA	:=	'ADFA';	 	//AUSTRALIA DEPT OF FOREIGN AFFAIRS AND TRADE
	export	string	wlBES		:=	'BES';	 	//BANK OF ENGLAND CONSOLIDATED LIST
	export	string	wlBIS 	:=	'BIS';	 	//BUREAU OF INDUSTRY AND SECURITY
	export	string	wlCFTC	:=	'CFTC';	 	//COMMODITY FUTURES TRADING COMMISSION SANCTIONS
	export	string	wlDTC		:=	'DTC';	 	//DTC DEBARRED PARTIES
	export	string	wlEPLS	:=	'EPLS';	 	//EPLS
	export	string	wlEUDT	:=	'EUDT';	 	//EU CONSOLIDATED LIST
	export	string	wlFAR		:=	'FAR';	 	//FOREIGN AGENTS REGISTRATIONS
	export	string	wlFATF	:=	'FATF';	 	//FATF Financial Action Task Force
	export	string	wlFAJC	:=	'FAJC';	 	//FATF Deficient Jurisdictions
	export	string	wlFBI		:=	'FBI';	 	//FBI: MOST WANTED  + SEEKING INFORMATION + HIJACK SUSPECTS
	export	string	wlFBIH	:=	'FBIH';	 	//FBI HIJACK SUSPECTS 
	export	string	wlFBIW	:=	'FBIW';	 	//FBI MOST WANTED
	export	string	wlFBIT	:=	'FBIT';	 	//FBI MOST WANTED TERRORISTS 
	export	string	wlFBIS	:=	'FBIS';	 	//FBI SEEKING INFORMATION 
	export	string	wlFBIM	:=	'FBIM';	 	//FBI TOP TEN MOST WANTED	
	export	string	wlFCEN	:=	'FCEN';	 	//FINANCIAL CRIMES ENFORCEMENT NETOWRK SPECIAL ALERT LIST
	export	string	wlHKMA	:=	'HKMA';	 	//HONG KONG MONETARY AUTHORITY
	export	string	wlHLDP	:=	'HLDP';	 	//HUD LDP
	export	string	wlHMTB	:=	'HMTB';	 	//HM TREASURY INVESTMENT BAN LIST
	export	string	wlHMTS	:=	'HMTS';	 	//HM TREASURY SANCTIONS
	export	string	wlIMW		:=	'IMW';	 	//INTERPOL MOST WANTED
	export	string	wlIFUF	:=	'IFUF';	 	//IRELAND FINANCIAL REGULATOR UNAUTHORIZED FIRMS
	export	string	wlJFSA	:=	'JFSA';	 	//JAPAN FSA
	export	string	wlJMOF	:=	'JMOF';	 	//JAPAN MOF SANCTIONS
	export	string	wlJWMD	:=	'JWMD';	 	//JAPAN METI-WMD PROLIFERATORS
	export	string	wlMASI	:=	'MASI';	 	//MONETARY AUTHORITY OF SINGAPORE
	export	string	wlNPRS	:=	'NPRS';	 	//NONPROLIFERATION SANCTIONS
	export	string	wlOCC		:=	'OCC';	 	//UNAUTHORIZED BANKS
	export	string	wlOFAC	:=	'OFAC';	 	//OFFICE OF FOREIGN ASSET CONTROL: SDN + PLC + SANCTIONS
	export	string	wlOFAE	:=	'OFAE';	 	//OFFICE OF FOREIGN ASSET CONTROL: SDN + PLC
	export	string	wlOFFC	:=	'OFFC';	 	//OFFSHORE FINANCIAL CENTERS
	export	string	wlOIGE	:=	'OIGE';	 	//OIG EXCLUSIONS
	export	string	wlOSC		:=	'OSC';	 	//OFFICE OF FOREIGN ASSET CONTROL: SANCTIONS
	export	string	wlOSFI	:=	'OSFI';	 	//OSFI CONSOLIDATED LIST + OSFI COUNTRY
	export	string	wlOSFIL	:=	'OSFIL';	//OSFI CONSOLIDATED LIST 
	export	string	wlOSFIC	:=	'OSFIC';	//OSFI COUNTRY
	export	string	wlPBC		:=	'PBC';		//PEOPLES BANK OF CHINA (PBC)
	export	string	wlPEP		:=	'PEP';	 	//CHIEFS OF STATE AND FOREIGN CABINET MEMBERS
	export	string	wlPMLC	:=	'PMLC';	 	//PRIMARY MONEY LAUNDERING CONCERN
	export	string	wlPMLJ	:=	'PMLJ';	 	//PRIMARY MONEY LAUNDERING CONCERN - JURISDICTIONS
	export	string	wlRBAU	:=	'RBAU';	 	//RESERVE BANK OF AUSTRALIA
	export	string	wlRMSB	:=	'RMSB';	 	//REGISTERED MONEY SERVICES BUSINESSES
	export	string	wlSDT 	:=	'SDT';	 	//TERRORIST EXCLUSION LIST
	export	string	wlUKFSA	:=	'UKFSA';	//UK FSA
	export	string	wlUNNT	:=	'UNNT';	 	//UN CONSOLIDATED LIST
	export	string	wlWBIF 	:=	'WBIF';		//WORLD BANK INELIGIBLE FIRMS

	// set of all the lists available from Bridger
	export	ALL_WATCHLISTS_SET	:=	[	wlADFA,	wlBES,	wlBIS,	wlCFTC,	wlDTC,	wlEPLS,	wlEUDT,	wlFAR,	wlFATF,	wlFBIH,	wlFBIW,	wlFBIT,
																		wlFBIS,	wlFBIM,	wlHKMA,	wlHLDP,	wlHMTB,	wlHMTS,	wlIFUF,	wlIMW,	wlJFSA,	wlJMOF,	wlJWMD,	wlMASI,	
																		wlNPRS,	wlOCC,	wlOFAC,	wlOFAE,	wlOFFC,	wlOIGE,	wlOSC,	wlOSFIL,wlOSFIC,wlPBC,	wlPEP,	wlPMLC,	
																		wlPMLJ,	wlRBAU,	wlRMSB,	wlSDT,	wlUKFSA,wlUNNT,	wlWBIF
																	];	//wlFCEN - This list not available in new bridger data

END;