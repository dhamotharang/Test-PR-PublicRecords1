// NOTE1: To assist in finding things, this attribute has been re-arranged to put things
// in alphabetic product name order.  However the BR & AR modules refer to other modules,
// so they have to be at the bottom.
//
// Due to multiple different developers style, some attributes are within the general
// "Constants" module and others are within their own product sub-module.
// 
// !!! ------> IF YOU ADD NEW ATTRIBUTES OR MODULES, AS A CURTIOUSY TO OTHERS,
// PLEASE ADD THEM IN THE APPROPRIATE PRODUCT ALPHABETIC ORDER.

// NOTE2: If you add a new module do not make it the same name as any existing 
// iesp.* attribute name.  For some reason doing so causes a syntax error.

// NOTE3: It also seems that adding a attribute name ABC inside MODULE_FOO
// which is the same name as an already existing iesp.ABC MODULE then there is a circular
// reference problem

IMPORT ut;

EXPORT Constants := MODULE
	//ISS Interface constants
	export unsigned2 INS_MAX_ATTRIBUTES := 500;

	export Participant := module
		export UNSIGNED2 MaxVehicles := 10;
		export UNSIGNED2 MaxPolicies := 10;
	end;
	
	//Claims
	export Claims := module
		export UNSIGNED2 MaxClaims := 10;
		export UNSIGNED2 MaxParticipants := 99;
	end;
  // Limits on record numbers for child datasets 

  // Miscellaneous
	export unsigned2 MaxCountMetronetPhones := 50;
	export unsigned2 MaxCountLast3Digits := 10;
  export unsigned2 MaxCountHRI := 10;
	export unsigned2 MaxCountWatchLists := 50;
	export unsigned2 MaxCountASL := 1;
	export unsigned2 MaxCountASLSearch := 1000;
	export unsigned2 MaxPhoneListingTypes := 4; //so far: mobile, business, government, residential
	export unsigned2 MaxCountIncomeRiskHRI := 25; // ~18 from biid + 5 new ones from includes both : 
	                                              // business risk HRI codes and 
	                                              // 5 new ones in income risk
  export unsigned1 MaxResponseExceptions := 20;
	export unsigned2 MaxCountHealthCareConsolidatedSearch := 1000;
  
	export unsigned2 MAX_REPORT_SOURCES := 1;
	export unsigned2 MAX_CONSUMER_STATEMENTS := 100;
  
	// Full File Disclosure
	export unsigned2 MaxConsumerAlerts := 100;
	export unsigned2 MaxConsumerStatementIds := 20 * 5; 
	export unsigned2 MaxConsumerStatements := 200;
	
  // Accidents - Florida and National
	export unsigned2 ACCIDENTS_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
 	export unsigned2 ACCIDENTS_MAX_COUNT_CHARGED_OFFENSES := 8;
 	export unsigned2 ACCIDENTS_MAX_COUNT_FRDL_CHARGES     := 8;
 	export unsigned2 ACCIDENTS_MAX_COUNT_CITATIONS        := 8;
 	export unsigned2 ACCIDENTS_MAX_COUNT_PASSENGERS   := 100;
 	export unsigned2 ACCIDENTS_MAX_COUNT_VEHICLES     := 100;
 	export unsigned2 ACCIDENTS_MAX_COUNT_PROP_DAMAGES := 100;
 	export unsigned2 ACCIDENTS_MAX_COUNT_PEDESTRIANS  := 100;
	export unsigned2 NATIONAL_ACCIDENTS_MAX_COUNT_ACCIDENT := 2000;
	export unsigned2 NATIONAL_ACCIDENTS_MAX_COUNT_VEHICLE := 100;
	export unsigned2 ACCIDENT_STATE_RESTRICTIONS_MAX_RECORDS := 100;
	export unsigned2 ACCIDENT_STATE_RESTRICTIONS_MAX_REQUIRED_ITEMS := 100;
	export unsigned2 ACCIDENT_STATE_RESTRICTIONS_MAX_RESTRICTED_ITEMS := 100;
	
	// used by progressive phone and bps search
	EXPORT SET OF STRING	TNT_CURRENT_SET := ['B', 'V','C']; 
	
	// Address Search
	export Address := MODULE
		export unsigned2 MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
	END;
	
	// Address risk
	export AddrRisk := MODULE
	   export unsigned2 MAX_COUNT_SEARCH_RESPONSE_RECORDS := 500;
	END;
	
	// AddressShell (address attributes ESDL)
	EXPORT AddressShell := MODULE
		EXPORT UNSIGNED2 MaxCountAttributes := 300; 
	END;
	
	// AddressSummary
	export AddressSummaryConstants := MODULE
		export MaxPreviousAddressRecords := 3;
	end;

  //Alcohol, Tobacco & Firearms (ATF) - Firearms and Explosives
 	export unsigned2 ATF_MAX_COUNT_SEARCH_RECORDS := 2000;

  // Alerts
  export unsigned1 MAX_COUNT_ALERT_TOKENS := 1;
  export unsigned1 MAX_COUNT_ALERT_TOKENSETS := 1;

  // AMLR
	export AMLRAttributesConst := MODULE
		export unsigned2 MaxAttributes := 17;
	end;
	
  // Bankruptcy
	export BANKRPT := MODULE  // "bankruptcy" cannot be used
    export unsigned2 MaxCountSearch := 1000;
    export unsigned2 MaxCountReport := 10;
    export unsigned2 MaxPersonNames     := 20;
    export unsigned2 MaxPersonAddresses := 5;
    export unsigned2 MaxPersonPhones    := 5; 
		export unsigned2 MaxPersonEmails		:= 5;
    export unsigned2 MaxStatusHistory := 20;
    export unsigned2 MaxComments      := 20;
    export unsigned2 MaxAttorneys     := 2;
    export unsigned2 MaxDebtors       := 20; //actual number can reach ~400, but this value will cover 99.99%
    export unsigned2 MaxTrustees      := 1;
    export unsigned2 MaxDockets       := 1000; // TODO: actual number can be as high as 40,000.
  end;

	// BestAddressAndPhone Search
	export BAP_MAX_COUNT_SEARCH_ADDRESS_RESPONSE_RECORDS := 2000;
	export BAP_MAX_COUNT_SEARCH_PHONE_RESPONSE_RECORDS := 2000;

  // Better Business Bureau (BBB) Member & Non-Member
	EXPORT BBB := MODULE
		EXPORT UNSIGNED2 MAX_COUNT_MEMBER_REPORT_RECORDS    := 1;
		EXPORT UNSIGNED2 MAX_COUNT_NONMEMBER_REPORT_RECORDS := 1;
	END;

  EXPORT BenefitAssess := MODULE
		EXPORT UNSIGNED2 MAX_COUNT_PROPERTY_RECORDS := 5;
		EXPORT UNSIGNED2 MAX_COUNT_SEARCH_RESPONSE_RECORDS := 10;
		EXPORT UNSIGNED2 MAX_COUNT_MARRIAGEDIVORCE_RECORDS := 3;
    EXPORT UNSIGNED2 MAX_COUNT_PEOPLEATWORK_NAMES   := 5;
    EXPORT UNSIGNED2 MAX_COUNT_PEOPLEATWORK_EMPLOYERS := 5;
    EXPORT UNSIGNED2 MAX_COUNT_PEOPLEATWORK_CONTACTS  := 5;
		EXPORT UNSIGNED2 MAX_COUNT_PHONES_PER_ADDRESS := 5;
    EXPORT UNSIGNED2 MAX_COUNT_EMPLOYER_DATES_SEEN := 5;
    EXPORT UNSIGNED2 MAX_COUNT_EMPLOYER_FEINS := 5;
    EXPORT UNSIGNED2 MAX_COUNT_EMPLOYER_COMPANY_NAMES := 5;
    EXPORT UNSIGNED2 MAX_COUNT_EMPLOYER_ADDRESSES := 5;
    EXPORT UNSIGNED2 MAX_COUNT_EMPLOYER_POSITIONS := 10;
		EXPORT UNSIGNED2 MAX_COUNT_PROFESSIONAL_LICENSES := 3;
	  EXPORT UNSIGNED2 MAX_COUNT_WATERCRAFTS := 3;
		EXPORT UNSIGNED2 MAX_COUNT_AIRCRAFTS := 3;
		EXPORT UNSIGNED2 MAX_COUNT_BANKRUPTCIES := 3;
		EXPORT UNSIGNED2 MAX_COUNT_LIENS_JUDGEMENTS := 3;
	END;
		
	// Business Credit, AKA Experian Business Reports (EBR)
	EXPORT BIZ_CREDIT := MODULE
		EXPORT UNSIGNED2 MAX_BIZCREDITS      := 100;
		EXPORT UNSIGNED2 MAX_HIST_COMPINFO	 := 100;
		EXPORT UNSIGNED2 MAX_EXEC_SUMMARY    := 10;
		EXPORT UNSIGNED2 MAX_TRADE           := 1000;
		EXPORT UNSIGNED2 MAX_TRADE_PAY_TOT   := 1000;
		EXPORT UNSIGNED2 MAX_TRADE_PAY_TREND := 200;
		EXPORT UNSIGNED2 MAX_TRADE_QTR_AVG   := 200;
		EXPORT UNSIGNED2 MAX_PAY_DETAIL      := 1000;
		EXPORT UNSIGNED2 MAX_PUBLIC_RECS     := 100;
		EXPORT UNSIGNED2 MAX_BANKRUPTCIES    := 100;
		EXPORT UNSIGNED2 MAX_TAXLIENS        := 100;
		EXPORT UNSIGNED2 MAX_JUDGMENTS       := 100;
		EXPORT UNSIGNED2 MAX_UCC_FILINGS     := 100;
		EXPORT UNSIGNED2 MAX_COLL_ACC        := 12;
		EXPORT UNSIGNED2 MAX_BANK_DETAIL     := 100;
		EXPORT UNSIGNED2 MAX_DEMO_DATA       := 10;
		EXPORT UNSIGNED2 MAX_SIC             := 10;
		EXPORT UNSIGNED2 MAX_NAIC            := 10;
		EXPORT UNSIGNED2 MAX_INQUIRY         := 100;
		EXPORT UNSIGNED2 MAX_INQUIRY_COUNTS  := 20;
		EXPORT UNSIGNED2 MAX_GOVT_TRADE      := 100;
		EXPORT UNSIGNED2 MAX_GOVT_DEBARRED   := 100;
		EXPORT UNSIGNED2 MAX_SNP             := 100;
		EXPORT UNSIGNED2 MAX_EXECUTIVE			 := 10;
	END;

	//Biz_Header_Update_Service maxcount for the response dataset
	export unsigned2 MaxCountResponseDataset := 1000;

  // Business Instant ID
	EXPORT BIID := MODULE
		EXPORT UNSIGNED2 MAXREPATTRIBUTES := 12;
		EXPORT UNSIGNED2 MAXRISKINDICATORS := 255;
		EXPORT UNSIGNED2 MAXAUTHORIZEDREPS := 5;
		EXPORT UNSIGNED2 MAXWATCHLISTS := 50;
		EXPORT UNSIGNED2 MAXNAMESADDRESSESOFPHONE := 3;
		EXPORT UNSIGNED2 MAXFEINMATCHRESULTS := 3;
		EXPORT UNSIGNED2 MAXRISKINDICATORSSMALL := 10;
		EXPORT UNSIGNED2 MAXRESIDENTIALBUSINESSINDICATORS := 4;
		EXPORT UNSIGNED2 MAXVERIFICATIONSUMMARIES := 5;
		EXPORT UNSIGNED2 MAXBUS2EXECINDEXES := 7;
	END;
	
 // Basic Person Search
	export BPS := MODULE
		// Bps search
		export unsigned2 SEARCH_MAX_COUNT_RESPONSE_RECORDS := 2000;
		// Rollup Bps search
		export unsigned2 ROLLUP_MAX_COUNT_RESPONSE_RECORDS := 2000;
		export unsigned2 ROLLUP_MAX_COUNT_NAMES := 15;
		export unsigned2 ROLLUP_MAX_COUNT_SSNS := 15;
		export unsigned2 ROLLUP_MAX_COUNT_DATES := 15;
		export unsigned2 ROLLUP_MAX_COUNT_PHONES := 15;
		export unsigned2 ROLLUP_MAX_COUNT_SOURCES := 1000;
		export unsigned2 ROLLUP_MAX_COUNT_DLS := 5;
		export unsigned2 ROLLUP_MAX_COUNT_ADDRESSES := 20;
		// embedded Source Doc dataset
		export SOURCE_DOC_MAX_IDS := ut.limits.HEADER_PER_DID;
		// custom dataset 1
		export unsigned2 TRANSACTION_HIST_MAX_COUNT_RECS := 100;
		export unsigned2 MAX_ATM_VISITS := 3;
		export unsigned2 MAX_TRIPLEGS := 3;
	END;

	EXPORT BusinessCredit := MODULE
		export unsigned2 MaxReasons 			:= 200;
		export unsigned2 MaxScores 				:= 50;
		export unsigned2 MaxPaymentHistory:= 10000;
		export unsigned2 MaxSection 			:= 1000;
		export unsigned2 MaxCodes 				:= 100;
		export unsigned2 MaxVariation 		:= 1000;
    export unsigned2 MaxTradelines    := 50;
    
    //  business credit reduces Top Business constants
    export unsigned2 MAX_COUNT_BIZRPT_INCORP_RECORDS      := 100; 
    export unsigned2 MAX_COUNT_BIZRPT_PROPERTY_RECORDS    := 50; 
    export unsigned2 MAX_COUNT_BIZRPT_PROPERTY_TOTAL_RECS := 100;
    export unsigned2 MAX_COUNT_BIZRPT_SRCDOC_RECORDS      := 50; 
	END;
	
	// Business Registration
	export BUSREG := MODULE
		export unsigned2 MAX_OFFICERS := 6;
	END;
	
	// Caltaxpermitholder AKA Calbus 
	export CALTAX := module
		export unsigned2	MAX_COUNT_SEARCH_RECORDS := 1;
  end;

	// Change of Address
	export COA_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;

  // CheckPerson
	export CheckPerson := MODULE
   	export MaxCountResponseRecords := 200;
	END;
	
		// Child Identity Fraud Report
	export ChildIdentityFraud := module
		export MaxPersonRecords := 3;
	end;
  
  //Citizenship
  export Citizenship := MODULE
    export MaxAttributes := 27;
  end;

  // Contact Plus
	export Contact_Plus := module
		export unsigned1 MaxCountNameRecords := 100;
		export unsigned1 MaxCountSSNRecords := 50;
		export unsigned1 MaxCountDobRecords := 50;
		export unsigned1 MaxCountDODRecords := 50;
		export unsigned1 MaxCountAddressRecords := 200;
		export unsigned1 MaxCountSources := 100;
	end;
	
	// Civil Court
  export unsigned2 MAX_COUNT_CIVIL_COURT_SEARCH_RESPONSE_RECORDS := 2000; // need this to be lower since a higher number will
	                                                                        // overflow and cause memory error.
	export unsigned2 MAX_COUNT_CIVIL_COURT_REPORT_RESPONSE_RECORDS := 2000;
	export unsigned2 MAX_COUNT_CIVIL_COURT_ENTITES := 8;
	export unsigned2 MAX_COUNT_CIVIL_COURT_AUTOKEY_LIMIT := 1750;
	
	// Code Lookup
	export unsigned2 MaxCountCodeRecords := 3000;

	// Concealed Carry Weapons (CCW)
	export unsigned2 CCW_MAX_SEARCH_RECORDS := 2000;

	// ConsumerAttributesReport (BocaShell attributes etc...ESDL)
	EXPORT ConsumerAttributesShell := MODULE
		EXPORT UNSIGNED2 MaxCountAttributes := 1040; 
	END;
	
	//ConsumerProfileReport
	export ConsumerProfile := MODULE
		export unsigned2 MAX_COUNT_AKAS := 50;
		export unsigned2 MAX_COUNT_ADDR_HIST := 30;
		export unsigned2 MAX_COUNT_ALERTS := 5;
	END;
	
	// Corporate/Corporations, AKA Incorporations 
	export CORP := module
		export unsigned2	MAX_COUNT_REPORT_RECORDS := 1;
		export unsigned2  MAX_HISTORIES := 300;
		export unsigned2  MAX_CONTACTS := 150; 
		export unsigned2  MAX_EVENTS := 150;
		export unsigned2  MAX_STOCKS := 100;
		export unsigned2  MAX_ANNUAL_RPTS := 100;
		export unsigned2  MAX_TRADEMARKS := 100;
		export unsigned2  MAX_TRADENAMES := 100;
		export unsigned2  MAX_CONTACT_NAMES := 10;
		export unsigned2  MAX_CONTACT_ADDR := 10;
		export unsigned2  MAX_CONTACT_TYPES := 10; 
		export unsigned2  MAX_RAW_ADDR := 10;
  end;

	// Court Search Adviser
	export CtSearchAdviser := MODULE 
		export unsigned2 MaxCounties := 40;
		export unsigned2 MaxStates := 100;
		export unsigned2 MaxDistricts := 40;
		export unsigned2 MaxAddresses:= 100;
		export unsigned2 MaxAKAs:= 200;
	END;

	// Criminal Search & Report
	export CRIM := module
		export unsigned2	MaxRawRecords			:= 2000;
		export unsigned2	MaxSearchRecords	:= 2000;
		export unsigned2	MaxReportRecords	:= 100;
		// max counts per offender_key derived from data as of 10/28/08
		export unsigned2	MaxAKAs						:= 150;		// actual 115
		export unsigned2	MaxOffenses				:= 350;		// actual 329
		export unsigned2	MaxCourtOffenses	:= 1650;	// actual 1600
		export unsigned2	MaxPrisons				:= 50;		// actual 45
		export unsigned2	MaxParoles				:= 50;		// actual 45
		export unsigned2	MaxEvents					:= 4500;	// actual 4105
		export unsigned1	MaxScarsMarksTattoos	:=5;
		export unsigned2	MaxParOffenses				:= 10;		// actual 4
		export unsigned2	MaxImageLength				:= 50000;
		export unsigned2	MaxImageRecords				:= 20;
	end;

  EXPORT DATA_INVESTIGATION := MODULE
    EXPORT UNSIGNED2 BANKRUPTCIES_MAX_JOIN_RECS := 10000;
    EXPORT UNSIGNED2 LIENS_MAX_JOIN_RECS        := 10000;
  END;
  
  // Directory Assistance Wireless
	EXPORT DAW := MODULE
		EXPORT UNSIGNED2 MAX_RECORDS       := 1;
		EXPORT UNSIGNED2 MAX_DESCRIPTIONS  := 3;
		EXPORT UNSIGNED2 MAX_LISTING_TYPES := 3;		
	END;

  // Directory of Corporate Affiliations AKA DCA AKA LNCA
	EXPORT DCA := MODULE
		EXPORT UNSIGNED2 MAX_COUNT_SEARCH_RECORDS := 1;
		EXPORT UNSIGNED2 MAX_SICS                 := 100;
		EXPORT UNSIGNED2 MAX_NAICS								:= 100;
		EXPORT UNSIGNED2 MAX_COMPETITORS          := 10;
		EXPORT UNSIGNED2 MAX_CONTACTS             := 100;
		EXPORT UNSIGNED2 MAX_EXECUTIVES           := 100;
		EXPORT UNSIGNED2 MAX_EXCHANGES            := 19;		
	END;

  // Dead Company (InfoUSA)
	EXPORT DEADCO := MODULE
		EXPORT UNSIGNED2 MAX_COUNT_SEARCH_RECORDS := 1;
		EXPORT UNSIGNED2 MAX_SECONDARY_SICS       := 4;
		EXPORT UNSIGNED2 MAX_FRANCHISES           := 1; //???
	END;
	
  // Deconfliction	
	EXPORT DECONFLICTION := MODULE
		EXPORT UNSIGNED2 MAX_COUNT_RECORDS := 2000;
		EXPORT UNSIGNED2 MAX_COMPANY_IDS := 10;
		EXPORT UNSIGNED2 MAX_EXCL_UIDS := 200;
	END;

	// Diversity Cert 
	EXPORT DIVERSITYCERT := MODULE
		EXPORT UNSIGNED2 MaxDiversityCert := 25;
		EXPORT UNSIGNED2 MaxExports := 2;
	  EXPORT UNSIGNED2 MaxBusinessReferences := 5;
		EXPORT UNSIGNED2 MaxCertifications := 6;
		EXPORT UNSIGNED2 MaxProcurements := 5;
		EXPORT UNSIGNED2 MaxWorkCodes := 8;
		EXPORT UNSIGNED2 MaxCountSuppRiskRecords := 25;
		EXPORT UNSIGNED2 MaxLocations := 5;
		EXPORT UNSIGNED2 MaxClassDesc := 5;
		EXPORT UNSIGNED2 MaxCommodities := 8;
		EXPORT UNSIGNED2 MaxRegions := 5;
		EXPORT UNSIGNED2 MaxProductDesc := 5;
		EXPORT UNSIGNED2 MaxAddresses := 5;
		EXPORT UNSIGNED2 MaxPhones := 5;
		EXPORT UNSIGNED2 MaxEmails := 3;
		EXPORT UNSIGNED2 MaxUrls := 3;
		EXPORT UNSIGNED2 MaxSicCodes := 8;
		EXPORT UNSIGNED2 MaxNaicsCodes := 8;
	END;

  // for Doxie.HeaderFileRollupSearch call from BusinessAuthRepSearch 
  // Counts from: doxie.rollup_limits
  EXPORT DoxieHFRS := MODULE
    EXPORT UNSIGNED1 PHONES       := 10;
    EXPORT UNSIGNED1 PHONE_HRIS   := 10;
    EXPORT UNSIGNED1 ADDRESS_HRIS := 10;
    EXPORT UNSIGNED1 NAMES        := 15;
    EXPORT UNSIGNED1 ADDRESSES    := 15;
    EXPORT UNSIGNED1 SSNS         := 15;
    EXPORT UNSIGNED1 DOBS         := 15;
    EXPORT UNSIGNED1 DODS         := 15;
	  EXPORT UNSIGNED1 MAX_COUNT_SEARCH_RESPONSE_RECORDS := 20000;  // taken from doxie.header_records_byDID return limit
  END;  

  // Driver Licenses (DL)
  export DL := MODULE
    export unsigned1 MaxCountEndorsements := 5;
    export unsigned1 MaxCountRestrictions := 5;
    export unsigned1 MaxCountDL := 20;
  end;
  export unsigned1 MaxCountDL := 10; // when embedded

	// Drug Enforcement Administration (DEA)
  export unsigned2 MAX_COUNT_DEA_REGISTRATION := ut.limits.DEA_MAX; //actual count=16 (reg number= MM0726503: W20081013-145222, prod)
  export unsigned2 MAX_COUNT_DEA_SEARCH := 100;
		
	//Due Diligence
	export DDRAttributesConst := MODULE
		export unsigned2 MaxAttributes      				:= 21;		
    // export unsigned2 MaxMatchSummaries     		 	:= 20;
    // export unsigned2 MaxNewsProfiles       		 	:= 20;
    export unsigned2 MaxProperties         			:= 500;
    export unsigned2 MaxPropertyOwners   				:= 500;
    export unsigned2 MaxAircraft         				:= 500;
    export unsigned2 MaxWatercraft         			:= 500;
    export unsigned2 MaxVehicles         				:= 500;
    export unsigned2 MaxOperatingLocations 			:= 500;   
    export unsigned2 MaxReportingBureaus 				:= 500;
    export unsigned2 MaxReportingSources 				:= 500;
    export unsigned2 MaxSOSFilingStatuses 			:= 500;
    export unsigned2 MaxSICNAICs					 			:= 500;
		export unsigned2 MaxActions         				:= 500;
		export unsigned2 MaxDescriptions    				:= 210;
		export unsigned2 MaxBusinesses      				:= 500;
		export unsigned2 MaxSSNAssociations     		:= 500;
		// export unsigned2 MaxPersonNames      				:= 500;
		// export unsigned2 MaxAgents      						:= 500;
		export unsigned2 MaxCreditors   						:= 500;
		export unsigned2 MaxDebtors   							:= 500;
		export unsigned2 MaxLienJudgementsEvictions	:= 500;
		export unsigned2 MaxLegalEvents   					:= 500;
		export unsigned2 MaxLegalPartyNames					:= 500;
		export unsigned2 MaxLegalSources  					:= 500;
		export unsigned2 MaxTitles   								:= 500;
		export unsigned2 MaxLicenses   							:= 500;
		export unsigned2 MaxBusinessExecs   				:= 500;
		export unsigned2 MaxRegisteredAgents   			:= 500;
		export unsigned2 MaxIndvAssociations   			:= 500;
		export unsigned2 MaxBusAssociations   			:= 500;
	end;

  //Dun and Bradstreet (DNB)
 	export unsigned2 DNB_MAX_COUNT_SEARCH_RECORDS := 500;	

  // Electronic Authorization (eAuth)
  export EAUTHORIZE := MODULE // "eauth" cannot be used
    export unsigned1 MaxQuestions := 23;//eAuth.Constants.QNUM; //number of questions; unique questions only
    export unsigned1 MaxAnswers := 20; // number of multichoices
    // number of invalid suggestions to generate (currently only for city6 question)
    export unsigned1 MaxInvalidAnswers := 20;
    export unsigned1 MaxAddress := 40; // number of person address to use for questions generating
  end;
	
  // eCrash 
  EXPORT eCrashMod := MODULE
	   export unsigned2 MaxRecords := 2000;
	   export unsigned2 Max_Involved_Parties := 50;
		 export unsigned2 MaxAnalyticRecords := 200;
		 export unsigned2 Max_Documents :=200;
	END;
	
	// EC (European Commission) Ruling
	export EC_RULING := MODULE
			export unsigned2 MaxRelatedCase := 100;
			export unsigned2 MaxDecisions := 100;
			export unsigned2 MaxPressRelease := 100;
			export unsigned2 MaxPublicationJournals := 100;
			export unsigned2 MaxSearchRecords := 200;
	end;
	
	// Email
	EXPORT Email := MODULE
		EXPORT UNSIGNED2 MAX_RECS_PER_DID := 100;
    EXPORT UNSIGNED2 MAX_MSGS_PER_DID := 10; 
		EXPORT UNSIGNED2 MAX_NAMES_PER_PERSON := 20;
		EXPORT UNSIGNED2 MAX_ADDRS_PER_PERSON := 20;
		EXPORT UNSIGNED2 MAX_EMAILS_PER_PERSON := 20;
	END;
	
  // Experian Business Reports (EBR)
	EXPORT EBR := MODULE
		EXPORT UNSIGNED2 MAX_COUNT_REPORT_RECORDS  := 1;
		EXPORT UNSIGNED2 MAX_COUNT_SEARCH_RECORDS  := 1; //???
		EXPORT UNSIGNED2 MAX_INQUIRY_HISTORY       := 100; //EBR_Servicesconstants.maxcounts.Inquiry_history value, but may be too big here???
		EXPORT UNSIGNED2 MAX_INQUIRY_COUNTS        := 20;  //EBR_Servicesconstants.maxcounts.Inquiry_counts value, but may be too big here???
		EXPORT UNSIGNED2 MAX_EXECUTIVE_SUMMARIES   := 10;  //EBR_Servicesconstants.maxcounts.Executive_Summary value, but may be too big here???
		EXPORT UNSIGNED2 MAX_TRADE_PAYMENT_DETAILS := 1000; //EBR_Servicesconstants.maxcounts.Trade value, but may be too big here???
		EXPORT UNSIGNED2 MAX_TRADE_PAYMENT_TRENDS  := 200; //EBR_Servicesconstants.maxcounts.Trade_Payment_Totals value, but may be too big here???
		EXPORT UNSIGNED2 MAX_TRADE_QUARTER_AVGS    := 200; //EBR_Servicesconstants.maxcounts.Trade_Quarterly_Averages value, but may be too big here???
		EXPORT UNSIGNED2 MAX_BANKRUPTCIES          := 100; //EBR_Servicesconstants.maxcounts.public_records value, but may be too big here???
		EXPORT UNSIGNED2 MAX_TAXLIENS              := 100; //EBR_Servicesconstants.maxcounts.public_records value, but may be too big here???
		EXPORT UNSIGNED2 MAX_JUDGMENTS             := 100; //EBR_Servicesconstants.maxcounts.public_records value, but may be too big here???
		EXPORT UNSIGNED2 MAX_COLLATERAL_ACCOUNTS   := 100; //EBR_Servicesconstants.maxcounts.Collateral_Accounts value, but may be too big here???; //???
		EXPORT UNSIGNED2 MAX_COLLACCTS_COLLATERALS := 12;
		EXPORT UNSIGNED2 MAX_UCC_FILINGS           := 100; //EBR_Servicesconstants.maxcounts.public_records value, but may be too big here???
		EXPORT UNSIGNED2 MAX_UCC_COLLATERALS       := 6; 
		EXPORT UNSIGNED2 MAX_BANKING_DETAILS       := 100; //EBR_Servicesconstants.maxcounts.Bank_Details value, but may be too big here???
		EXPORT UNSIGNED2 MAX_DEMOGRAPHICS_5600     := 10;  //EBR_Servicesconstants.maxcounts.Demographic_Data value, but may be too big here???
		EXPORT UNSIGNED2 MAX_DEMO5600_SICS         := 4; 
		EXPORT UNSIGNED2 MAX_DEMOGRAPHICS_5610     := 10;  //EBR_Servicesconstants.maxcounts.Demographic_Data value, but may be too big here???
		EXPORT UNSIGNED2 MAX_GOVERNMENT_TRADES     := 100; //EBR_Servicesconstants.maxcounts.Government_Trade value, but may be too big here???
		EXPORT UNSIGNED2 MAX_GOV_DEBARRED_CONTRACTORS := 100; //EBR_Servicesconstants.maxcounts.Government_Debarred_Contractor value, but may be too big here???
	END;

  // Federal Aviation Administration (FAA) - Aircraft Registrations & Pilots
	export MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
	export MAX_COUNT_REPORT_RESPONSE_RECORDS := 2000;
	export MAX_COUNT_PILOT_REPORT_RESPONSE_RECORDS := 2000;
	export MAX_COUNT_PILOT_SEARCH_RESPONSE_RECORDS := 2000;
	export MAX_COUNT_PILOT_CERTIFICATES := 20;
	export MAX_COUNT_PILOT_RECORD_INFO := 20;
	export MAX_COUNT_FAAPILOTS := 20;

	// Fein, AKA DNB (Dun and Bradstreet) Fein 
	export DNBFEIN := module
		export unsigned2 MAX_COUNT_SEARCH_RECORDS := 1;
		export unsigned2 MAX_ADDRESSES            := 5;
		export unsigned2 MAX_COMPANIES            := 10;
		export unsigned2 MAX_CONTACTS            	:= 5;
  end;

	// Fictitious Business Names (FBN)
  export FBN := MODULE 
    export unsigned1 MaxCountOwners := 25;
		export unsigned2 MAX_COUNT_SEARCH_RECORDS := 1;
  end;

	// FCC Licenses
	export FCC := module
		export unsigned2 MAX_COUNT_REPORT_RECORDS := 100; //???
  end;

	// FCRA Inquiry History
	EXPORT FCRAInqHist := MODULE
		EXPORT UNSIGNED2 MAX_LEXIDS := 100;
		EXPORT UNSIGNED2 MAX_RECORDS := 10000;
	END;

  // FlexID
  export FI := MODULE
		export unsigned1 MaxCVIRiskIndicators	:= 75;
  end;
	
  //Foreclosures
	EXPORT unsigned2 MAX_COUNT_Foreclosure_SEARCH := 2000;
	EXPORT unsigned2 MAX_COUNT_Foreclosure_REPORT := 100;
	export unsigned2 MAX_COUNT_PLAINTIFF   := 100;
	export unsigned2 MAX_COUNT_DEFENDANT   := 100;
	
	// Franchise
  export FRANDX := MODULE
		export unsigned1 MAX_EXECUTIVES	:= 25;
  end;
	
  // Fraud Defense Network
	export FDN := MODULE
    // Counts used in the iesp.frauddefensenetwork attribute related to the "Susupicious Activity Report"
		export unsigned2 MAX_COUNT_EXCLUDE_IND_TYPES := 10; //estimated, actual still TBD
		export unsigned2 MAX_COUNT_FILE_TYPES        := 20; //estimated, actual still TBD
  export unsigned2 MAX_COUNT_MATCH_DETAILS     := 50; //estimated, actual still TBD  
  export unsigned2 MAX_COUNT_RESPONSE_RECORDS  := 10; //estimated, actual still TBD
  export unsigned2 ROLLUP_MAX_COUNT_HITS       := 10; //estimated, actual still TBD
  end;
	
	export FraudGov := MODULE
		export unsigned2 MAX_COUNT_SEARCH_RECORDS := 2000;
		export unsigned2 MAX_COUNT_PAYLOAD := 1000;
		export unsigned2 MAX_COUNT_VELOCITY := 1000;
		export unsigned2 MAX_COUNT_KNOWN_RISK := 1000;
		export unsigned2 MAX_COUNT_BUSINESS_LINKIDS := 100;
		export unsigned2 MAX_COUNT_OFFENSES := 6;
		export unsigned2 MAX_COUNT_CRIMINAL_CASES := 6;
		export unsigned2 MAX_COUNT_REMARKS := 30;
		export unsigned2 MAX_COUNT_ADDRESS := 10;
		export unsigned2 MAX_COUNT_CRIMINAL := 1000;
		export unsigned2 MAX_COUNT_GLOBAL_WATCHLIST := 1000;
		export unsigned2 MAX_COUNT_RED_FLAG := 1000;
		export unsigned2 MAX_ALERT := 4;
		export unsigned2 MAX_COUNT_IDENTITY_DETAIL := 1000;
		export unsigned2 MAX_COUNT_ELEMENT_DETAIL := 1000;
		export unsigned2 MAX_COUNT_ASSOCIATED_ADDRESS := 1000;
		export unsigned2 MAX_COUNT_SCORE_BREAKDOWN := 1000;
		export unsigned2 MAX_COUNT_INDICATOR_ATTRIBUTE := 1000;
		export unsigned2 MAX_COUNT_CLUSTER := 1000;
		export unsigned2 MAX_COUNT_ASSOCIATED_IDENTITY := 1000;
		export unsigned2 MAX_COUNT_TIMELINE_DETAILS := 1000;
		export unsigned2 MAX_COUNT_DELTABASE := 1000;
		export unsigned2 MAX_COUNT_NVP := 1000;
		export unsigned2 MAX_TIMELINE_PHONES := 20;
	end;
	
	export Fraud_Point := MODULE
		export unsigned2 MaxAttributes := 256; // update after reviewing attribute return counts.
	end;

	// BridgerXG5 Gateway
	export GWBRIDGER := MODULE
		export unsigned MaxList := 50;
		export unsigned MaxItem := 1024;
	end;
	
	// Government Services Administration (GSA) Verification
	export unsigned  MAX_GSA_VERIFICATION_REQUEST_RECORDS := 25;  //actual averages 5 with at most 19
	export unsigned  MAX_GSA_VERIFICATION_RESPONSE_RECORDS := 50;  //actual 28
	export unsigned  MAX_GSA_VERIFICATION_RESPONSE_ADDRS := 50; 
	export unsigned  MAX_GSA_VERIFICATION_RESPONSE_ACTIONS := 50; 
	export unsigned  MAX_GSA_VERIFICATION_RESPONSE_REFERENCES := 50; 

	// HealthCareAttributes 
	EXPORT HealthCareAttributeConstants := MODULE
		EXPORT UNSIGNED2 MaxCountAttributes := 12; 
	END;
	
 	// NOTE: For Healthcare Provider report
  export HPR := MODULE
		export unsigned2 Max_Small_Cnt						:= 10;
		export unsigned2 Max_Large_Cnt						:= 50;
		export unsigned4 Max_1KCnt_Search					:= 1000;
		export unsigned4 Max_Cnt_Search					  := 2000;
		export unsigned2 MAX_ADDRESSES_PHONES			:= Max_Large_Cnt;
		export unsigned2 MAX_DEAS									:= Max_Small_Cnt;
		export unsigned2 MAX_SSNS	 								:= Max_Small_Cnt;
		export unsigned2 MAX_UNIQUEIDS						:= Max_Small_Cnt;
		export unsigned2 MAX_BDIDS								:= Max_Small_Cnt;
		export unsigned2 MAX_LANGUAGES					  := Max_Small_Cnt;
		export unsigned2 MAX_DOBS 							 	:= Max_Small_Cnt;
		export unsigned2 MAX_TAXIDS  							:= Max_Small_Cnt;
		export unsigned2 MAX_UPINS 							 	:= Max_Small_Cnt;
		export unsigned2 MAX_DEGREES 							:= Max_Small_Cnt;
		export unsigned2 MAX_NPIS									:= Max_Small_Cnt;
		export unsigned2 MAX_TAXONOMIES						:= Max_Small_Cnt;
		export unsigned2 MAX_RESIDENCIES 					:= Max_Small_Cnt;
		export unsigned2 MAX_MEDICALSCHOOLS 			:= Max_Small_Cnt;
		export unsigned2 MAX_SPECIALTIES 					:= Max_Small_Cnt;  //DID=002369276991 has over 60 specialities
		export unsigned2 MAX_SANCTIONIDS  				:= Max_Small_Cnt;
		export unsigned2 MAX_GROUPAFFILIATIONS  	:= Max_Large_Cnt;
		export unsigned2 MAX_HOSPITALAFFILIATIONS	:= Max_Large_Cnt;
		export unsigned2 MAX_SANCTIONS						:= Max_Large_Cnt;
		export unsigned2 MAX_NAMES							 	:= Max_Large_Cnt;
		export unsigned2 MAX_BUSINESSADDRESSES		:= Max_Large_Cnt;
		export unsigned2 MAX_LICENSES  						:= 75;//Increase as per Kathy.
		export unsigned2 MAX_VERIFICATIONS				:= Max_Large_Cnt;
		export unsigned2 MAX_DODS									:= Max_Large_Cnt;
		export unsigned2 MAX_FEINS								:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_Relatives 						:= 6;
		EXPORT UNSIGNED2 MAX_RelativeDepth 				:= 1;
		EXPORT UNSIGNED2 MAX_RelativeAddresses		:= 5;
		EXPORT UNSIGNED2 MAX_NeighborhoodCount		:= 3;
		EXPORT UNSIGNED2 MAX_NeighborCount				:= 3;
		EXPORT UNSIGNED2 MAX_HistoricalNeighborhoodCount := 3;
		EXPORT UNSIGNED2 MAX_HistoricalNeighborCount := 3;
		EXPORT UNSIGNED2 MaxCLIA 									:= Max_Large_Cnt;
		EXPORT UNSIGNED2 Max_CLIA									:= Max_Large_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_ADDRESSES				:= Max_Large_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Contacts				:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_TypeOfPractice	:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Certications   	:= Max_Small_Cnt; //Deprecated, use the constant below for future methods.
		EXPORT UNSIGNED2 Max_ABMS_Certifications	:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Career					:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Education				:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Prof_Assoc      := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Memberships			:= Max_ABMS_Prof_Assoc;
		EXPORT UNSIGNED2 Max_NCPDP_Search					:= Max_Cnt_Search;
		EXPORT UNSIGNED2 Max_NCPDP_Report					:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_NPPES								:= Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_POS									:= Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_MEDICARE							:= Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_MEDICAID							:= Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_AFFILIATIONS					:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_LICENSES_INPUT       := 10;
		EXPORT UNSIGNED2 MAX_DEAS_INPUT           := 2;
		EXPORT UNSIGNED2 MAX_TAXONOMIES_INPUT     := 5;
		EXPORT UNSIGNED2 MAX_MISC									:= Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_AHA									:= Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_STATE_CONTROLLED_SUBSTANCES := Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_OFFICE_ATTRIBUTES		:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_COMMUNITY_RESOURCES	:= Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_CONTACTS							:= Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_SURESCRIPTS          := Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_ABMS                 := Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_SPECIALTIES_INPUT    := Max_Small_Cnt;
		EXPORT UNSIGNED2 MAX_ROSTER               := Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_PROVIDERSEARCH       := Max_1KCnt_Search;
		EXPORT UNSIGNED2 MAX_PROVIDERREPORT       := Max_1KCnt_Search;
		EXPORT UNSIGNED2 MAX_LEGACY_IDS           := 10;
		EXPORT UNSIGNED2 MAX_COPYRIGHTS           := Max_Small_Cnt;
  end;

  export HC_LOOKUPS := MODULE
		export unsigned2 Max_FacilityTypes				:= 15;
		export unsigned2 Max_OrgTypes							:= 75;
		export unsigned2 Max_Taxonomies						:= 1000;
	  export unsigned2 Max_MDMSearchFields      := 30;
  end;
	
  export HC_MDM := MODULE
		export unsigned2 MAX_CUSTOM_INPUT					:= 5;
		export unsigned2 MAX_CUSTOM_FIELDS				:= 1000;
		export unsigned2 MAX_Phones								:= 10;
		export unsigned2 MAX_ADDRESS							:= 10;
		export unsigned2 MAX_IDS									:= 10;
		export unsigned2 MAX_CUSTOMER_RECORDS			:= 50;
  end;
	
  export HC_PROVIDERPOINT := MODULE
		export unsigned2 Max_Small_Cnt						:= 10;
		export unsigned2 Max_Large_Cnt						:= 50;
		export unsigned4 Max_Cnt_Search					  := 2000;
		export unsigned2 MAX_ADDRESSES_PHONES			:= Max_Large_Cnt;
		export unsigned2 MAX_DEAS									:= Max_Small_Cnt;
		export unsigned2 MAX_SSNS	 								:= Max_Small_Cnt;
		export unsigned2 MAX_UNIQUEIDS						:= Max_Small_Cnt;
		export unsigned2 MAX_BDIDS								:= Max_Small_Cnt;
		export unsigned2 MAX_LANGUAGES					  := Max_Small_Cnt;
		export unsigned2 MAX_DOBS 							 	:= Max_Small_Cnt;
		export unsigned2 MAX_TAXIDS  							:= Max_Small_Cnt;
		export unsigned2 MAX_UPINS 							 	:= Max_Small_Cnt;
		export unsigned2 MAX_DEGREES 							:= Max_Small_Cnt;
		export unsigned2 MAX_NPIS									:= Max_Small_Cnt;
		export unsigned2 MAX_RESIDENCIES 					:= Max_Small_Cnt;
		export unsigned2 MAX_MEDICALSCHOOLS 			:= Max_Small_Cnt;
		export unsigned2 MAX_SPECIALTIES 					:= Max_Small_Cnt;  //DID=002369276991 has over 60 specialities
		export unsigned2 MAX_SANCTIONIDS  				:= Max_Small_Cnt;
		export unsigned2 MAX_GROUPAFFILIATIONS  	:= Max_Large_Cnt;
		export unsigned2 MAX_HOSPITALAFFILIATIONS	:= Max_Large_Cnt;
		export unsigned2 MAX_SANCTIONS						:= Max_Large_Cnt;
		export unsigned2 MAX_NAMES							 	:= Max_Large_Cnt;
		export unsigned2 MAX_BUSINESSADDRESSES		:= Max_Small_Cnt;
		export unsigned2 MAX_LICENSES  						:= 75;//Increase as per Kathy.
		export unsigned2 MAX_VERIFICATIONS				:= Max_Large_Cnt;
		export unsigned2 MAX_DODS									:= Max_Large_Cnt;
		export unsigned2 MAX_FEINS								:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_Relatives 						:= 6;
		EXPORT UNSIGNED2 MAX_RelativeDepth 				:= 1;
		EXPORT UNSIGNED2 MAX_RelativeAddresses		:= 5;
		EXPORT UNSIGNED2 MAX_NeighborhoodCount		:= 3;
		EXPORT UNSIGNED2 MAX_NeighborCount				:= 3;
		EXPORT UNSIGNED2 MAX_HistoricalNeighborhoodCount := 3;
		EXPORT UNSIGNED2 MAX_HistoricalNeighborCount := 3;
		EXPORT UNSIGNED2 MaxCLIA 									:= Max_Large_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_ADDRESSES				:= Max_Large_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Contacts				:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_TypeOfPractice	:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Certications		:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Career					:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Education				:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Prof_Assoc			:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_NCPDP_Search					:= Max_Cnt_Search;
		EXPORT UNSIGNED2 Max_NCPDP_Report					:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_NPPES								:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_OFFICEATTRIBUTES			:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_Gateways							:= Max_Small_Cnt;
  end;
  
  export HC_ClaimsCleanse := MODULE
		export unsigned2 Max_Small_Cnt						:= 10;
		export unsigned2 Max_Large_Cnt						:= 50;
		export unsigned4 Max_Cnt_Search					  := 2000;
		export unsigned2 MAX_ADDRESSES_PHONES			:= Max_Large_Cnt;
		export unsigned2 MAX_DEAS									:= Max_Small_Cnt;
		export unsigned2 MAX_SSNS	 								:= Max_Small_Cnt;
		export unsigned2 MAX_UNIQUEIDS						:= Max_Small_Cnt;
		export unsigned2 MAX_BDIDS								:= Max_Small_Cnt;
		export unsigned2 MAX_LANGUAGES					  := Max_Small_Cnt;
		export unsigned2 MAX_DOBS 							 	:= Max_Small_Cnt;
		export unsigned2 MAX_TAXIDS  							:= Max_Small_Cnt;
		export unsigned2 MAX_UPINS 							 	:= Max_Small_Cnt;
		export unsigned2 MAX_DEGREES 							:= Max_Small_Cnt;
		export unsigned2 MAX_NPIS									:= Max_Small_Cnt;
		export unsigned2 MAX_RESIDENCIES 					:= Max_Small_Cnt;
		export unsigned2 MAX_MEDICALSCHOOLS 			:= Max_Small_Cnt;
		export unsigned2 MAX_SPECIALTIES 					:= Max_Small_Cnt;  //DID=002369276991 has over 60 specialities
		export unsigned2 MAX_SANCTIONIDS  				:= Max_Small_Cnt;
		export unsigned2 MAX_GROUPAFFILIATIONS  	:= Max_Large_Cnt;
		export unsigned2 MAX_HOSPITALAFFILIATIONS	:= Max_Large_Cnt;
		export unsigned2 MAX_SANCTIONS						:= Max_Large_Cnt;
		export unsigned2 MAX_NAMES							 	:= Max_Large_Cnt;
		export unsigned2 MAX_BUSINESSADDRESSES		:= Max_Small_Cnt;
		export unsigned2 MAX_LICENSES  						:= 75;//Increase as per Kathy.
		export unsigned2 MAX_VERIFICATIONS				:= Max_Large_Cnt;
		export unsigned2 MAX_DODS									:= Max_Large_Cnt;
		export unsigned2 MAX_FEINS								:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_Relatives 						:= 6;
		EXPORT UNSIGNED2 MAX_RelativeDepth 				:= 1;
		EXPORT UNSIGNED2 MAX_RelativeAddresses		:= 5;
		EXPORT UNSIGNED2 MAX_NeighborhoodCount		:= 3;
		EXPORT UNSIGNED2 MAX_NeighborCount				:= 3;
		EXPORT UNSIGNED2 MAX_HistoricalNeighborhoodCount := 3;
		EXPORT UNSIGNED2 MAX_HistoricalNeighborCount := 3;
		EXPORT UNSIGNED2 MaxCLIA 									:= Max_Large_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_ADDRESSES				:= Max_Large_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Contacts				:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_TypeOfPractice	:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Certications		:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Career					:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Education				:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ABMS_Prof_Assoc			:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_NCPDP_Search					:= Max_Cnt_Search;
		EXPORT UNSIGNED2 Max_NCPDP_Report					:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_NPPES								:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_OFFICEATTRIBUTES			:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_Gateways             := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_RefID_Cnt            := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_Modifiers_Cnt        := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_Diagnosis_Cnt        := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_Amount_Cnt           := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_Adjustment_Cnt       := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_Date_Cnt            	:= Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_ClmDiagnosis_Cnt     := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_VisitReason_Cnt      := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_TreatmentCode_Cnt    := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_Service_Cnt          := Max_Small_Cnt;
		EXPORT UNSIGNED2 Max_OtherPayer_Cnt       := Max_Small_Cnt;
  end;
  
 	// NOTE: For Healthcare Facility report
  export HC_FACILITY_REPORT := MODULE
		export unsigned2 Max_Small_Cnt						:= 10;
		export unsigned2 Max_Medium_Cnt						:= 50;
		export unsigned2 Max_Large_Cnt						:= 100;
		export unsigned2 MAX_BDIDS								:= Max_Medium_Cnt;
		export unsigned2 MAX_BUSINESSADDRESSES		:= Max_Medium_Cnt;
		export unsigned2 MAX_FACILITYINFO					:= Max_Medium_Cnt;
		export unsigned2 MAX_INDUSTRYCODES				:= Max_Small_Cnt;
		export unsigned2 MAX_URLS									:= Max_Medium_Cnt;
		export unsigned2 MAX_PARENT_RECORDS				:= Max_Small_Cnt;
		export unsigned2 MAX_CORPHIST_RECORDS			:= Max_Medium_Cnt;
		export unsigned2 MAX_CORPFILINGS					:= Max_Medium_Cnt;
		export unsigned2 MAX_CORPAFFILIATIONS			:= Max_Medium_Cnt;
		export unsigned2 MAX_REGISTEREDAGENTS			:= Max_Medium_Cnt;
		export unsigned2 MAX_BUSREGISTRATIONS			:= Max_Medium_Cnt;
		export unsigned2 MAX_IRS5500							:= Max_Medium_Cnt;
		export unsigned2 MAX_PROPERTY_RECORDS			:= Max_Large_Cnt;
		export unsigned2 MAX_PROPERTY_PARTY_RECORDS:= Max_Medium_Cnt;
		export unsigned2 MAX_FORECLOSURE_NODS			:= Max_Medium_Cnt;
		export unsigned2 MAX_AIRCRAFT_PARTY_RECORDS:= Max_Small_Cnt;
		export unsigned2 MAX_AIRCRAFT_RECORDS			:= Max_Medium_Cnt;
		export unsigned2 MAX_WATERCRAFT_PARTY_RECORDS:= Max_Small_Cnt;
		export unsigned2 MAX_WATERCRAFT_RECORDS		:= Max_Medium_Cnt;
		export unsigned2 MAX_MVR_PARTY_RECORDS		:= Max_Small_Cnt;
		export unsigned2 MAX_MVR_RECORDS					:= Max_Medium_Cnt;
		export unsigned2 MAX_LICENSES  						:= Max_Medium_Cnt;
		export unsigned2 MAX_DEAS									:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_NPPES								:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_CLIA 								:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_NCPDP								:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_UCC_DEBTORS					:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_UCC_SECUREDS					:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_UCC_ASSIGNEES				:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_UCC_COLLATERALS			:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_UCC_FILINGS					:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_ACTIVE_UCCS					:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_TERMINATED_UCCS			:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_SANCTIONS						:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_BANKRUPTCIES					:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_LIENSJUDGMENTS				:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_POSITION_RECORDS			:= Max_Medium_Cnt;
		EXPORT UNSIGNED2 MAX_GROUPAFFILIATIONS  	:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_HOSPITALAFFILIATIONS	:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_CONNECTED_BUSINESSES	:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_CONTACT_RECORDS			:= Max_Large_Cnt;
		EXPORT UNSIGNED2 MAX_DNBSIC_RECORDS				:= Max_Medium_Cnt;
	END;
	
	export HCAffiliationSearch := MODULE
		export unsigned2 MaxResults := 2000;
		export unsigned2 MaxSpecialties := 2;
	end;

	export HCOrganizationSearch := MODULE
		export unsigned2 MaxResults := 200;
	end;

	export HCOrganizationReport := MODULE
		export unsigned2 MaxResults := 200;
	end;
	
	export HCProviderSearch := MODULE
		export unsigned2 MaxResults := 200;
	end;
	
	export HCProviderReport := MODULE
		export unsigned2 MaxResults := 200;
	end;
	
	export HC_Subrogation := MODULE
		export unsigned2 MaxRecords := 100;
		export unsigned2 MaxPassengers := 20;
		export unsigned2 MaxOtherParties := 20;
	end;
	
  // Hunting & Fishing Licenses
	export unsigned2 HF_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;

	// Identity Management system (IDM); FKA BLS 
	export IDM := MODULE
		export unsigned1 MaxAddress := 20;
    export unsigned1 MaxHistoricalPhones := 10; //old phones (for a given person)
		export unsigned1 MaxRNA := 40; //includes associates and relatives
		export unsigned1 MaxRNA_Address := 10;
		export unsigned1 MaxRelatives := 20; 
		export unsigned1 MaxAssociates := 20; 
    export unsigned1 MaxProperties := 10;
		export unsigned1 MaxPropertyParties := 20;
		export unsigned1 MaxPropertyEntities := 25; //to match iesp.Constants.Prop.MaxEntities
		export unsigned1 MaxPropertyRecords := 20; //max number of records for a property
    export unsigned1 MaxVehicles := 10;
    export unsigned1 MaxVehicleDetails := 10; //max number of different records per vehicles -> max number of different registration addresses
    export unsigned1 MaxStudentColleges := 10; 
    export unsigned1 MaxWatercrafts := 10;
		export unsigned1 MaxAircrafts := 10;
		export unsigned1 MaxAircraftRegistrations := 40; // max number of registrations per aircraft
		export unsigned1 MaxEmails := 20;
		export unsigned1 MaxPeopleAtWork	:= 20;
		export unsigned1 MaxNeighbors	:= 20;
		export unsigned1 MaxTransactions	:= 20;
    export unsigned1 MaxProfLicenses := 10;
    export unsigned1 MaxDriverLicenses := 10;
		export unsigned1 MaxAkas := 10;
	end;
	
	// Identity Fraud Network Constants
	export IDFraudNetwork := module
		export MaxRiskIndicators := 1000;
		export MaxUSPISHotList := 100;
	end;

  // Identity Fraud Report
  EXPORT IFR := MODULE
    // number of most important indicators to be shown at the report summary
    export unsigned1 MaxSummaryIndicators := 100;
    // indicators per each data (address, phone, etc.)
    export unsigned1 MaxIndicators := 10;
    // source groups, like Assets, Bureau, Deaths, Utility, Other Public Records, etc.
    export unsigned1 MaxSourcetypes := 16;
    export unsigned1 MaxBestPhones := 10;
		export unsigned1 MaxIndices := 3;
    // subject's data variations to return in "AssociatedData" section
    export unsigned1 MaxNames     := 20;
    export unsigned1 MaxSSNs      := 10;
    export unsigned1 MaxDOBs      := 10;
    export unsigned1 MaxAddresses := 30;
		export unsigned1 MaxEmails    := 2;
    export unsigned1 MaxAssociatedIdentities := 20;
  END;

	// InstantID
	export unsigned2 MaxCountVerificationResults := 35;
	export unsigned2 MaxCountDataSourceResults := 35;
	export unsigned2 MaxCountCountrySettings := 200;
	
	// InstantID/Identifier2 (IID)
  export Identifier2c := MODULE
	  export MaxRiskIndicators := 50;
		export MaxRiskIndicators_ICIID := 25;
		export MaxStatusIndicators := 6;
		export MaxOther := 12; // There are up to 12 red flags categories... need to up this number!
		export maxImposter := 1;
		export maxProfLic := 1;
		export maxPropDeed := 1;
		export maxPropTax := 1;
		export maxDea := 1;
		export maxDL := 1;
		export maxOccupant := 1;
		export yearOnly := 9999;
		export yearMonthOnly := 999999;
		export MaxWatchlists := MaxCountWatchLists;
	END;

	// IdentityContactResolution (ICR) - As used by govt_collection_services
  export IdentityContactResolution := MODULE
	  export MaxDebtorPhones := 3;
		export MaxReportAKAs := 3;
		export MaxReportPhones := 3;
		export MaxReportDebtors := 3;
		export MaxReports := 10;
	END;
  
  //InstantId Reporting and Archiving
	EXPORT IIDReporting := MODULE	
		//Search
		export unsigned2 MaxSearchRecords := 100;
		//Report
		export unsigned3 MaxReportLength := 100000;
		export unsigned2 MaxVerifiedElements := 100;
		export unsigned2 MaxCVIElements:= 1000;
		//FraudPoint
		export unsigned2 MaxFraudPointWarnings := 425;
		export unsigned2 MaxRiskIndexScore := 100;
		export unsigned2 MaxFraudRiskIndex := 425;
		export unsigned2 MaxFraudPointSummary := 100;
		//RedFlags	
		export unsigned2 MaxRedFlags := 500;
		export unsigned2 MaxRiskIndicators := 700;
		export unsigned2 MaxRedFlagsSummary := 1000;
	  //iidi	
		export unsigned2 MaxMatchingSources := 100;
		export unsigned2 MaxIVIRiskIndicators := 500;
		export unsigned2 MaxFieldVerification := 100;
		//iid
		export unsigned2 MaxNAP := 100;
		export unsigned2 MaxNAS := 100;
		//shared
		export unsigned2 MaxDOBVerified := 30;
		export unsigned2 MaxNASNAP := 200;
	END;

	// Insurance Certification
	EXPORT InsuranceCert := MODULE
		export unsigned2 MaxNAICCodes := 10;
		export unsigned2 MaxAddresses := 10;
		export unsigned2 MaxContacts := 15;
		export unsigned2 MaxMCOs := 10;
		export unsigned2 MaxSubsidiaries := 25;
		export unsigned2 MaxPolicies := 25;
		export unsigned2 MaxPhones := 10;
	END;
	
	// Insurance
	EXPORT Insurance := MODULE
		export MaxRiskIndicators := 4;
		export MaxScores := 3;
		export MaxScoreOptions := 3;
	END;
	
	// International (Mexican) dockets
	export unsigned2 INTERNATIONALDOCKET_MAX_COUNT_STATECODES	:= 35;
	export unsigned2 INTERNATIONALDOCKET_MAX_COUNT_AKAS := 50;
	export unsigned2 INTERNATIONALDOCKET_MAX_COUNT_DOCKETS := 50;
	export unsigned2 INTERNATIONALDOCKET_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
	
	// International (Mexican) Professional Licenses/Certifications
	export unsigned2 INTERNATIONALPROFLICENSE_MAX_COUNT_AKAS := 50;
	export unsigned2 INTERNATIONALPROFLICENSE_MAX_COUNT_LICENSES := 50;
	export unsigned2 INTERNATIONALPROFLICENSE_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;	
	export unsigned2 INTERNATIONALPROFCERT_MAX_COUNT_AKAS := 50;
	export unsigned2 INTERNATIONALPROFCERT_MAX_COUNT_CERTIFICATIONS := 50;
	export unsigned2 INTERNATIONALPROFCERT_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
		
	// Internet domain search
	export unsigned2 INTERNETDOMAIN_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
	export unsigned2 INTERNETDOMAIN_MAX_COUNT_ADDRESSES := 8;
  
	// inview report (gateway)
  EXPORT INVIEW_EQUIFAX := MODULE
		export unsigned2 INV_INTERNET_TRAITS_MAX_COUNT := 10;
	  export unsigned2 INV_EFX_AVGDBTS_MAX_COUNT := 10;
		export unsigned2 INV_EFX_INDUSTRY_DBT_MAX_COUNT := 10;
		export unsigned2 INV_REASONCODES_MAX_COUNT := 10;
		export unsigned2 INV_TELEPHONE_TRAITS_MAX_COUNT := 10;
		export unsigned2 INV_TRADELINKS_MAX_COUNT := 10;
		export unsigned2 INV_SICCODES_MAX_COUNT := 10;
		export unsigned2 INV_NAISCCODES_MAX_COUNT := 10;
		export unsigned2 INV_ADDRESS_TRAITS_MAX_COUNT := 10;
		export unsigned2 INV_IDNUMBER_TRAITS_MAX_COUNT := 10;
		export unsigned2 INV_COMPANYNAME_TRAITS_MAX_COUNT := 10;
		export unsigned2 INV_PERSONNAME_TRAITS_MAX_COUNT := 10;
		export unsigned2 INV_PRINCIPALID_TRAITS_MAX_COUNT := 10;
		export unsigned2 INV_PRINCIPALINFOSOURCE_MAX_COUNT := 10;
		export unsigned2 INV_INQUIRIES_MAX_COUNT := 10;
		export unsigned2 INV_ALERTS_MAX_COUNT := 10;
		export unsigned2 INV_DECISIONTOOLS_MAX_COUNT := 10;
		export unsigned2 INV_FIRMOGRAPHICSTRAITS_MAX_COUNT := 10;
		export unsigned2 INV_APPLICATIONERRORS_MAX_COUNT := 10;
		export unsigned2 INV_PRODUCTCODES_MAX_COUNT := 10;
		export unsigned2 INV_CUSTOMERSECURITYINFO_MAX_COUNT := 10;
		export unsigned2 INV_SITES_MAX_COUNT := 10;
		export unsigned2 INV_PRINCIPALTRAITS_MAX_COUNT := 10;
		export unsigned2 INV_FLAGS_MAX_COUNT := 10;
		export unsigned2 INV_IDTRAITS_MAX_COUNT := 10;
		export unsigned2 INV_EFX_DATAPOINTS_MAX_COUNT := 10;
	END;
	
	// Jail Booking
	EXPORT JB := MODULE
		EXPORT UNSIGNED2 MAX_SEARCH_RECORDS := 2000;
		EXPORT UNSIGNED2 MAX_COMP_REPORT_RECORDS := 100;
		EXPORT UNSIGNED2 MAX_REPORT_RECORDS := 2000;
		EXPORT UNSIGNED2 MAX_CHARGES_RECORDS := 100;
	END;
	
	// Labor Action EBSA (Employee Benefit Security Admin)
	EXPORT LABOR_ACTION_EBSA := MODULE
			EXPORT UNSIGNED2 MaxSearchRecords := 200;
	END;
	
	// Labor Action MSHA (Mine Safety and Health Admin)
	EXPORT LABOR_ACTION_MSHA := MODULE
			EXPORT UNSIGNED2 MaxAccidents := 100;
			EXPORT UNSIGNED2 MaxViolations := 100;
			EXPORT UNSIGNED2 MaxOperators := 100;
			EXPORT UNSIGNED2 MaxControllers := 100;
			EXPORT UNSIGNED2 MaxContractors := 100;
			EXPORT UNSIGNED2 MaxSearchRecords := 200;
	END;
	
	// Labor Action WHD
	EXPORT LABORACTIONWHD := MODULE
			EXPORT UNSIGNED2 MaxCaseIDs := 50;
			EXPORT UNSIGNED2 MaxLaborActionWHDRecords := 10;
			EXPORT UNSIGNED2 MaxCountSuppRiskRecords := 25;
	END;
	
	// Lead Integrity (ITA Attributes via ESDL)
	EXPORT LI := MODULE
		EXPORT UNSIGNED2 MaxAttributes := 400; // This will need to be changed in the future if we return more than 400 ITA attributes
		EXPORT UNSIGNED1 maxModels := 1;
		EXPORT UNSIGNED1 maxModelScores := 1;
		EXPORT UNSIGNED1 maxWarningCodeIndicators := 6;
	END;

	// Liens & Judgements
	EXPORT Liens := MODULE
    EXPORT UNSIGNED2 MAX_LIENS_JUDGEMENTS := 50; 
		EXPORT UNSIGNED2 MAX_PARTIES := 25;
		EXPORT UNSIGNED2 MAX_ADDRESSES := 10;
		EXPORT UNSIGNED2 MAX_DEBTORS := 25;
		EXPORT UNSIGNED2 MAX_CREDITORS := 25;
		EXPORT UNSIGNED2 MAX_ATTORNEYS := 25;
		EXPORT UNSIGNED2 MAX_THIRD_PARTIES := 1;
		EXPORT UNSIGNED2 MAX_FILINGS := 15;
		EXPORT UNSIGNED2 MAX_PHONES := 50;
	END;
	
	//LNCA (aka DCA) Firmographics
	EXPORT LNCA := MODULE
    EXPORT UNSIGNED2 MaxSICCodes := 100; 
		EXPORT UNSIGNED2 MaxExecutives := 100;
		EXPORT UNSIGNED2 MaxExchanges := 20;
		EXPORT UNSIGNED2 MaxNAICSCodes := 100;
		EXPORT UNSIGNED2 MaxLNCA := 1;
		EXPORT UNSIGNED3 MaxLNCARecLen := 250000;
		EXPORT UNSIGNED2 MaxCountSuppRiskRecords := 25;
	END;
	
	//lookups
	export lookups := MODULE
		EXPORT UNSIGNED2 SEARCH_MAX_ZIPCODE_RESPONSE_RECORDS := 2000;
		EXPORT UNSIGNED2 SEARCH_MAX_AREACODE_RESPONSE_RECORDS := 2000;
		EXPORT UNSIGNED2 SEARCH_MAX_CITYSEARCH_RESPONSE_RECORDS := 2000;
		EXPORT UNSIGNED2 SEARCH_MAX_COMPANYSEARCH_RESPONSE_RECORDS := 2000;
	end;

	export MemberPoint := MODULE
		export unsigned2 MAX_PHONES := 3;
		export unsigned2 MAX_EMAILS := 5;
	end;

	// Mortgage Industry Data Exchange(MIDEX) from Mortgage Asset Research Institute(MARI)
	export MIDEX := MODULE
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_RECORDS    := 100;  // ??
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_PHONES     := 10;   // Final# TBD???	
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_EMAILS     := 10;   // Final# TBD???	
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_NAMEVARS   := 20;   // Final# TBD???	
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_SSNS       := 10;   // Final# TBD???
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_NPRECS     := 50;   // Final# TBD???	
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_PUBRECS    := 50;   // Final# TBD???	
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_LICENSES   := 100;   // Final# TBD???	
    export unsigned2 MAX_COUNT_REPORT_RESPONSE_FMRECS     := 50;
		export unsigned2 MAX_COUNT_REPORT_LICENSES					  := 200;  
		export unsigned2 MAX_COUNT_REPORT_NMLS					      := 3;  
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_OTHERLICS  := 10;   // Final# TBD???	
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_NUMREPORTS := 50;
    export unsigned2 MAX_COUNT_REPORT_REBUTTALS           := 50;
	  export unsigned2 MAX_COUNT_REPORT_REPORTBY            := 250;
		export unsigned2 MAX_COUNT_REPORT_EMAILS              := 50;
		export unsigned2 MAX_COUNT_REPORT_INCIDENT_INFO       := 500;
    export unsigned2 MAX_COUNT_REPORT_ACTIONS_COUNT       := 20;
    export unsigned2 MAX_COUNT_REPORT_PARTY_INFO          := 20;
    export unsigned2 MAX_COUNT_REPORT_OTHER_IDEN_REF      := 20;
    export unsigned2 MAX_COUNT_REPORT_PARTY_COUNT         := 25;
	  export unsigned2 MAX_COUNT_REPORT_INCIDENTS           := 50;
		export unsigned2 MAX_COUNT_REPORT_PROFESSIONS         := 25;
    export unsigned2 MAX_COUNT_REPORT_ACTIONS             := 15;
    export unsigned2 MAX_COUNT_REPORT_PARTY               := 50;
    export unsigned2 MAX_COUNT_REPORT_TEXT                := 500;
    export unsigned2 MAX_COUNT_REPORT_PUBLICACTION        := 50;
    export unsigned2 MAX_COUNT_REPORT_AKA_DBA             := 100;  // Bug: 161341 (CR16) -- Per Rodney, since the AKAs/DBAs are no longer a string500 field we should increase the max to 20
                                                                  // because he is limiting the data to have no more than 20 AKA + DBA. 
                                                                  // JIRA: 10581 - there are 59 DBAs, increasing limit to 100
    export unsigned2 MAX_COUNT_SEARCH_RESPONSE_REPORTNUMBERS := 250;
		export unsigned2 MAX_COUNT_SEARCH_RESPONSE_RECORDS    := 2000; // Final# TBD???
		export unsigned2 MAX_COUNT_SEARCH_RESPONSE_ADDRESSES  := 20;   // Final# TBD???
		export unsigned2 MAX_COUNT_SEARCH_RESPONSE_NAMES      := 20;   // Final# TBD???		
		export unsigned2 MAX_COUNT_SEARCH_RESPONSE_AKAS       := 5;
		export unsigned2 MAX_COUNT_SEARCH_LICENSES					  := 200;  
		export unsigned2 MAX_COUNT_REGISTRATIONS       				:= 250;
		export unsigned2 MAX_COUNT_OFFICE_LOCATIONS       		:= 100;
		export unsigned2 MAX_COUNT_REPRESENT       						:= 150;
		export unsigned2 MAX_COUNT_REGULATORS       					:= 100;
		export unsigned2 MAX_COUNT_DISC_ACTIONS       				:= 150;
		export unsigned2 MAX_COUNT_REG_ACTIONS       					:= 150;
    export unsigned2 MAX_COUNT_SEARCH_NMLS                := 20;
    
    // Smartlinx Business 
		export unsigned2 MAX_COUNT_SMARTLINX_BIZ_PROPERTIES          := 150;
		export unsigned2 MAX_COUNT_SMARTLINX_BIZ_LIENS_JUDGMENTS     := 10;
		export unsigned2 MAX_COUNT_SMARTLINX_BIZ_BUSINESS_ASSOCIATES := 150;
		export unsigned2 MAX_COUNT_SMARTLINX_BIZ_BANKRUPTCIES        := 50;
		export unsigned2 MAX_COUNT_SMARTLINX_BIZ_NAME_VARIATIONS     := 100;
		export unsigned2 MAX_COUNT_SMARTLINX_BIZ_PHONE_VARIATIONS    := 100;
		export unsigned2 MAX_COUNT_SMARTLINX_BIZ_ADDRESS_VARIATIONS  := 100;
		export unsigned2 MAX_COUNT_SMARTLINX_BIZ_ASSOCIATED_PEOPLE   := 500;
	end;
	
	// Motor Vehicle Registrations (MVR)
  export MV := MODULE 
    // ideally, those should refer to VehicleV2_Services.Constant values...
    export unsigned1 MaxCountGateways := 2;
    export unsigned1 MaxCountOwners := 10;
    export unsigned1 MaxCountRegistrants := 10;
    export unsigned1 MaxCountLienHolders := 10;
    export unsigned1 MaxCountLessees := 10;
    export unsigned1 MaxCountLessors := 10;
		export unsigned1 MaxCountBrands := 5;
		export UNSIGNED1 MaxCountMakes := 4;
		export UNSIGNED1 MaxCountModels := 4;
		export UNSIGNED1 MaxCountMajorColors := 4;
		export UNSIGNED1 MaxCountMinorColors := 4;
		export MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
		export MAX_COUNT_REPORT_RESPONSE_RECORDS := 2000;
  end;
	
	// Natural Disaster Readiness
	export NATURAL_DISASTER := MODULE
		export unsigned2 MaxISOCommittees	:= 50;
		export unsigned2 MaxNaturalDisaster := 50;
		EXPORT UNSIGNED2 MaxCountSuppRiskRecords := 25;
	END;
	
	// Neighborhood Safety Report
  export NeighborSafety := MODULE 
    export unsigned1 MaxSexOffender := 10;
    export unsigned1 MaxPublicSafety := 4;
    export unsigned1 MaxCorrecFacility := 3;
		export unsigned1 MaxAddressRisk := 30;
    export unsigned1 MaxSchools := 4;
    export unsigned1 MaxColleges := 4;
		export MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
		export MAX_COUNT_REPORT_RESPONSE_RECORDS := 2000;
  end;

  // Official Records - from certain counties
	export unsigned2 OFFRECS_MAX_COUNT_REPORT_RESPONSE_RECORDS := 2;
	export unsigned2 OFFRECS_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
 	export unsigned2 OFFRECS_MAX_COUNT_PARTIES := 500;

	EXPORT Order__Score := MODULE
	  EXPORT UNSIGNED2 MaxAttributeVersionCount := 3;
		EXPORT UNSIGNED2 MaxAttributes := 131;
    EXPORT UNSIGNED2 MaxModelOptionsCount :=2;
	END;

   // Oregon Workers Compensation (ORWORK)
	EXPORT ORWORK := MODULE
		EXPORT UNSIGNED2 MAX_NAMES := 5;
	END;
	 
	// Occupational Safety & Health Administration
	EXPORT OSHAIR := MODULE
		EXPORT UNSIGNED2 MaxCountSuppRiskRecords := 25;
		EXPORT UNSIGNED2 MaxCountViolationRecords := 75;
		EXPORT UNSIGNED2 MaxClassifications := 20;
		EXPORT UNSIGNED2 MaxHoursInspection := 10;
		EXPORT UNSIGNED2 MaxViolations := 1000;
		EXPORT UNSIGNED2 MaxHazardSubstances := 200;
		EXPORT UNSIGNED2 MaxHazardCodes := 5;
		EXPORT UNSIGNED2 MaxAccidents := 200;
		EXPORT UNSIGNED2 MaxNaics := 200;
	END;

  // Patriot Act
	export	Patriot := MODULE
		export unsigned1 MaxAkas := 10;
		export unsigned1 MaxRemarks := 30;
		export unsigned1 MaxAddresses := 10;
		export unsigned1 MaxAddressLines := 10;
	end;

  	// PersonContext
	EXPORT PersonContext := MODULE
	   export unsigned2 CD_CONTENT_MAX_SIZE := 3000;
	   export unsigned2 MAX_RECORDS := 10000;
		 export unsigned2 MAX_KEYS := 300;
	END;

  // phones feedback (PHONESFEEDBACK name can't be used)
  export PHFEEDBACK := MODULE
    export unsigned2 MaxAdditionalPhones := 10;  
    export unsigned2 MaxOtherInfo        := 10;
    export unsigned2 MaxFeedbacks        := 10;
  end;

  // Address Feedback
	export ADDRFEEDBACK := MODULE
    export unsigned2 MaxOtherInfo        := 10;
    export unsigned2 MaxFeedbacks        := 10;
  end;

	// phone finder report
	export Phone_Finder := MODULE;
		export unsigned1 MaxPhoneHistory := 5;
		export unsigned1 MaxIdentities   := 10;
		export unsigned1 MaxOtherPhones  := 35;
		export unsigned1 MaxPhoneFinderRecords := 1;
		export unsigned1 MaxPorts := 100;
		export unsigned1 MaxSpoofs := 100;
		export unsigned1 MaxOTPs := 100;
		export unsigned1 MaxInquiries := 100;
		export unsigned1 MaxPRIRules := 20;
		export unsigned1 MaxAlerts := 20;
		export unsigned1 MaxAlertMessages := 20;
	end;
  // Phone History Report
	export unsigned2 PhoneHistoryMaxRecords :=500;
  export unsigned2 PhoneInfoMessages := 1;
	
	// phone picklist
	export Phone_PickList := MODULE
		export MaxRecords := 100;
	END;
	
	// Premise Association
	export PAR := MODULE
		export unsigned2 MaxAttributes := 24;
		export unsigned2 MaxSummaryHRI := 50;
		export unsigned2 MaxSummaryPhones := 10;
		export unsigned2 MaxSummaryEmails := 50;
		export unsigned2 MaxSupport := 50;
	END;

  // Professional Licenses (PL)
	EXPORT PROFLIC := MODULE
		EXPORT UNSIGNED2 UNKNOWN := 10; // DEFAULT
		EXPORT UNSIGNED2 LARGE := 50; // DEFAULT
		EXPORT UNSIGNED2 XLARGE := 100; // DEFAULT
		EXPORT UNSIGNED2 MAX_RECORDS := UNKNOWN;
		EXPORT UNSIGNED2 MAX_PHONESINFO  := UNKNOWN;
		EXPORT UNSIGNED2 MAX_SANCTIONIDS := UNKNOWN;
		EXPORT UNSIGNED2 MAX_PROVIDERS := UNKNOWN;
		EXPORT UNSIGNED2 MAX_NAMES := UNKNOWN;
		EXPORT UNSIGNED2 MAX_TAXIDS := UNKNOWN;
		EXPORT UNSIGNED2 MAX_DOBS := UNKNOWN;
		EXPORT UNSIGNED2 MAX_UPINS := UNKNOWN;
		EXPORT UNSIGNED2 MAX_LANGUAGES := UNKNOWN;
		EXPORT UNSIGNED2 MAX_TAXONOMY := UNKNOWN;
		EXPORT UNSIGNED2 MAX_LICENSEINFOS := LARGE;
		EXPORT UNSIGNED2 MAX_DEGREES := UNKNOWN;
		EXPORT UNSIGNED2 MAX_SPECIALTIES := XLARGE;  
		EXPORT UNSIGNED2 MAX_BUSADDRANDPHONES := LARGE;
		EXPORT UNSIGNED2 MAX_GROUPAFFILIATIONS := LARGE;
		EXPORT UNSIGNED2 MAX_HOSPITALAFFILIATIONS := LARGE;
		EXPORT UNSIGNED2 MAX_RESIDENCIES := LARGE;
		EXPORT UNSIGNED2 MAX_MEDICALSCHOOLINFOS := LARGE;
		EXPORT UNSIGNED2 MAX_PROFESSIONALLICENSERECORDS := UNKNOWN;
		EXPORT UNSIGNED2 MAX_PROVIDERRECORDS := UNKNOWN;
		EXPORT UNSIGNED2 MAX_SANCTIONRECORDS := UNKNOWN;
	END;

	// Profile Booster
	export ProfileBooster := MODULE
		export unsigned2 MaxAttributes := 200;
		export unsigned2 MaxSummaryHRI := 50;
		export unsigned2 MaxHRICount := 6;
		export unsigned2 MaxModelScoreCount := 1;
		export unsigned2 MaxModelCount := 1;
	END;

  // Progressive phones
	export ProgPhones := Module
		export unsigned2 MaxDedupePhones := 150;
		export unsigned2 MaxCountPhoneRecords := 150;
	end;	

  // Property Records - Assessments, Deeds, Mortgages
  export PROP := MODULE // "property" cannot be used
    export unsigned1 MaxCountSearchDeeds := 100;
    export unsigned1 MaxCountSearchAssessments := 100;
    export unsigned1 MaxCountReportDeeds := 50;
    export unsigned1 MaxCountReportAssessments := 50;
    export unsigned1 MaxSellers := 3;
    export unsigned1 MaxBuyers  := 3;
    export unsigned1 MaxOwners  := 3;
		export unsigned1 MaxSchoolTaxDistrict := 3;
		export unsigned1 MaxBuildingAreas := 8;
		export unsigned1 MaxTaxExemptions := 4;
		export unsigned1 MaxAmenities := 5;
		export unsigned1 MAxOtherBuildings := 5;
		export unsigned1 MaxSiteInfluences := 5;
		export unsigned1 MaxNames := 15; //Guess - will do research for exact number.
		export unsigned1 MaxOriginalNames := 15;//Guess - will do research for exact number.
		export unsigned1 MaxOriginalNames2 := 15;//Guess - will do research for exact number.
		export unsigned1 MAxEntities := 25;//Guess - will do research for exact number.
    export unsigned1 MaxCountReport2Records := 1;
  end;

	// Property history plus report (Property history with mortgage risk indicators)
	EXPORT PropertyHistoryPlusReport := MODULE
		EXPORT UNSIGNED1 MaxCountHRI              := 20;
		EXPORT UNSIGNED1 MaxCountTransactions     := 100;
		EXPORT UNSIGNED1 MaxCountIndividual       := 2;
		EXPORT UNSIGNED1 MaxCountRelationships    := 2;
		EXPORT UNSIGNED1 MaxCountResidents        := 20;
		EXPORT UNSIGNED1 MaxCountHistoricalValues := 250;
	END;
	
	// Public Profile
	EXPORT PublicProfile := MODULE
		EXPORT UNSIGNED2 MAX_SSN_RECORDS := 15;
		EXPORT UNSIGNED2 MAX_DOB_RECORDS := 15;
		EXPORT UNSIGNED2 MAX_DOD_RECORDS := 15;
		EXPORT UNSIGNED2 MAX_NAME_RECORDS := 15;
		EXPORT UNSIGNED2 MAX_ADDRESS_RECORDS := 15;
		EXPORT UNSIGNED2 MAX_SOURCE_RECORDS := ut.limits.header_per_did;
		EXPORT UNSIGNED2 MAX_SUBJECT_RECORDS := 10;
		EXPORT UNSIGNED2 MAX_FORECLOSURES := 10; 
		EXPORT UNSIGNED2 MAX_NOTICE_OF_DEFAULTS := 50;
		EXPORT UNSIGNED2 MAX_CRIMINAL_RECORDS := 50; 
		EXPORT UNSIGNED2 MAX_AIRCRAFTS := 50; 
	END;

	//Qsent gateway
	export unsigned MAX_EXCLUDED_PHONES := 15;
	export unsigned REALTIME_PHONE_LIMIT := 10;
	
  // Rate Evasion for Insurance
	export unsigned2 RATEEVA_MAX_COUNT_ADDL_DRIVERS := 10;
	export unsigned2 RATEEVA_MAX_COUNT_ADDR_DOC_SRCES := 10;
	export unsigned2 RATEEVA_MAX_COUNT_BRANDED_DISP_LINES := 10;
	export unsigned2 RATEEVA_MAX_COUNT_BRANDED_TITLE_RECS := 10;
	export unsigned2 RATEEVA_MAX_COUNT_DL_RESTRICTIONS := 10;
	export unsigned2 RATEEVA_MAX_COUNT_INPUT_VINS := 8;
	export unsigned2 RATEEVA_MAX_COUNT_OTHER_SSNS := 10;
	export unsigned2 RATEEVA_MAX_COUNT_PADDL_DRIVERS := 10;
	export unsigned2 RATEEVA_MAX_COUNT_PREV_ADDRS := 20;
	export unsigned2 RATEEVA_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 1;
	export unsigned2 RATEEVA_MAX_COUNT_SSNS := 10;
	export unsigned2 RATEEVA_MAX_COUNT_VEHICLES := 10;
	export unsigned2 RATEEVA_MAX_COUNT_WARNINGS := 10;
	export unsigned2 RATEEVA_MAX_COUNT_COMBI_ELEMENTS  := 10;
	export unsigned2 RATEEVA_MAX_COUNT_RISK_INDICATORS := 60;

  // Right Address
  // UPS search limits (UPSsearch is a ChoicePoint Autonomy migration)
	// NOTE that this module is called "RA" rather than RightAddress (as a sane
	// person might expect) since there appears to be some sort of conflict
	// with either the rightaddress module in the main repository or (perhaps
	// more likely) the iesp.rightaddress module.
	export RA := MODULE
		// max number of records returned by an individual or business search,
		// prior to any dedupes, rollups, or elimination due to score.
		export unsigned2 MAX_SEARCH_RECORDS := 10000;
		// max number of responses returned by UPS_Services.RightAddressService.
		// Each record in the response may contain up to MAX_CHILD_RECORDS names
		// and MAX_CHILD_RECORDS addresses (which may, in turn, contain up to 
		// MAX_CHILD_RECORDS phone listings).
		export unsigned2 MAX_RESPONSE_RECORDS := 100;
		// max number of rolled up names/addresses/phones included in a response.
		export unsigned2 MAX_CHILD_RECORDS := 25;				
	end;
	
	// Relationship Identifier
	
	EXPORT RelationshipIdentifier := MODULE
		EXPORT  UNSIGNED2 MAX_COUNT_SEARCH_MATCH_RECORDS := 8;
		EXPORT  UNSIGNED2 MAX_COUNT_MATCH_RECORDS := 5;
		EXPORT  UNSIGNED2 MAX_COUNT_ALL_MATCH_RECORDS := 40;		
		EXPORT  UNSIGNED2 MAX_COUNT_RELATIONSHIP_TYPES := 25;
		EXPORT  UNSIGNED2 MAX_COUNT_RELATIONSHIP_MIDEX_LICENSES := 10;
	END;
	
	// RetrieveImage
	export Retrieve_Image := module
		export MaxImageSize := 100000000;
	end;
	
		// RetrieveImage
	export Retrieve_Document := module
		export MaxDocumentSize := 100000000;
	end;
	
  // RiskView
	export RiskView_Report := MODULE
			export MaxRecords := 512;
			export MaxModels := 3;
	end;
	
	export RiskView_2 := MODULE
			export MaxHRICount := 12;
			export MaxModelCount := 9;
			export MaxModelOptionCount := 100;
			export MaxAttributes := 1000;
			export MaxAlertCount := 12;
			export MaxPublicReportCount := 99;
	end;
		
  // Risk Metrics
	export RISK_METRIC := MODULE
			export unsigned2 MaxSubsidiaries := 100;
			export unsigned2 MaxRiskMetrics := 100;
			export unsigned2 MaxWorkersComp := 100;
			export unsigned2 MaxSelfInsurance := 100;
			export unsigned2 MaxCountSuppRiskRecords := 25;
	end;
	
  // SearchPoint 
	export unsigned2 SP_MAX_COUNT_RESPONSE_RECORDS := 3000;
  
  // Sex Offender
	// For AKAs, the actual dedup max count=71 (sspk=C2MO2069522; W20090218-091022 & W20090218-100428 on dev)
	export unsigned2 SEXOFF_MAX_COUNT_AKAS := 75;
	// For alternate addresses, the actual deduped max count=1169 (sspk=C2TX1867828; W20090416-135902 & W20090416-155016 on dev)
	// However any value over 4?? (exact number would take a long time to determine) causes a 
	// "System error 1451: Memory pool exhausted" runtime error.
	// Therefore a max count of 400 was picked which will work for all but 3 offenders 
	// that have more than 400 alternate addresses.
	export unsigned2 SEXOFF_MAX_COUNT_ALT_ADDRESSES := 400; 
  // For convictions, the actual max count=5 (sspk=CC2CA2004119 et al; W20090225-144435 on dev)
  export unsigned2 SEXOFF_MAX_COUNT_CONVICTIONS := 10;
	export unsigned2 SEXOFF_MAX_COUNT_INPUT_HASHVALS := 3000;
	export unsigned2 SEXOFF_MAX_COUNT_REPORT_RESPONSE_RECORDS := 20; // actual based on did it is 11
	export unsigned2 SEXOFF_MAX_COUNT_SEARCH_RESPONSE_RECORDS := 2000;
	export unsigned2 SEXOFF_MAX_COUNT_ADDRESSES := 3;
	export unsigned2 SEXOFF_MAX_COUNT_REGISTRATION_DATES := 3;

	EXPORT SBAnalytics := MODULE
		EXPORT UNSIGNED1 MaxModelCount := 10;
		EXPORT UNSIGNED1 MaxModelOptionCount := 10;
		EXPORT UNSIGNED1 MaxHRICount := 6;
		EXPORT UNSIGNED2 MaxAttributes := 2000;
		EXPORT UNSIGNED2 MaxAttributeVersionCount := 10;
	END;
	// Safety Certifications and Site Security
	export SITE_SECURITY := MODULE
			export unsigned2 MaxSearchRecords := 200;
	end;
	
  // Skip Trace (The only Clarity gateway product we are using as of 10/11/2010.)
	// The Skiptrace module name was choosen by the ESP group when they created the 
	// iesp.gateway_skiptrace attribute.
	// NOTE: the Clarity skiptrace gateway is used by WorkPlace_Services Search & 
	// Report Services and constants related to those are found below under WP_MAX_*.
	export Skiptrace := MODULE 
		export unsigned2 MaxAddresses   := 3;
	  export unsigned2 MaxBanks       := 3;
	  export unsigned2 MaxEmployments := 3;
	  export unsigned2 MaxEmails      := 3;
	  export unsigned2 MaxPhones      := 3;
	END;

	// Smartlinx Search Core Constants
	export SLR := module
		export MaxList		:= 10;
		export MaxItem 		:= 1024;
	end;
	
  // Small Business 
	export INTEGER1 MaxCountSmallBusinessHRI    := 4;
	export INTEGER1 MaxCountSmallBusinessModels := 2;
	
	//Smartlinx report
	export SMART := MODULE
	  export unsigned2 MaxUnRolledRecords    := 1000;//all sections should use this as a limit on records prior to rollup logic
		export unsigned1 MaxAka	 		      := 50;  //unlimited
		export unsigned1 MaxImposters     := 50;  //unlimited other using same SSN
		export unsigned1 MaxAddress       := 50;
		export unsigned1 MaxEmails        := 50;
		export unsigned1 MaxPhonesHist    := 10; //old phones (for a given person)
		export unsigned1 MaxVoter					:= 50;
		export unsigned1 MaxProfLic      	:= 50;
		export unsigned2 MaxDLs 			  	:= 50;
		export unsigned1 MaxDEA           := 50;
		export unsigned2 MaxHuntFish			:= 50;
		export unsigned2 MaxWeapons 			:= 50;
		export unsigned1 MaxFirearms      := 50;
		export unsigned1 MaxFaaCert      := 50;
		export unsigned2 MaxProperties 		:= 50;
		export unsigned2 MaxDeeds     		:= 50;
		export unsigned1 MaxForeclosures  := 50;
		export unsigned1 MaxNOD           := 50;
		export unsigned2 MaxVehicles 			:= 25;
		export unsigned1 MaxWatercrafts 	:= 25;
		export unsigned1 MaxAircrafts   	:= 25; 
		export unsigned2 MaxBankruptcies	:= 100;
		export unsigned2 MaxLiens 		    := 100;
		export unsigned1 MaxUCCs      	  := 100;
		export unsigned2 MaxBusiness 		  := 100;
		export unsigned2 MaxEmployer 		  := 50;
		export unsigned2 MaxFBN        	  := 50;
		export unsigned2 MaxOtherBusi 	  := 50;
		export unsigned1 MaxPeopleAtWork  := 50;
		export unsigned1 MaxRoles         := 50;
		export unsigned1 MaxNeighbors 	  := 100; //current address only 20 addrs 2 humans per addr
		export unsigned1 MaxNeighborhood 	:= 1;
		export unsigned1 MaxRelatives     := 100;
		export unsigned1 MaxAssociates    := 100;
		export unsigned1 MaxSexualOffenses := 50;
		export unsigned1 MaxCrimRecords   := 100;
		export unsigned1 MaxSources       := 100; //unlimited
		
		export string1 CURRENT      := 'C';
    export string1 PRIOR        := 'P';
	  export string1 ACTIVE       := 'A';
		export string1 INACTIVE     := 'I';
		export string1 CLOSED       := 'C';
	  export string1 TERMINATED   := 'T';
		export string1 DEBTOR       := 'D';
		export string1 SECURER      := 'S';
		export string1 UNKNOWN      := 'U';
		//criminal record types
		export string25 DOC         := 'DEPARTMENT OF CORRECTIONS';
    export string25 ARRESTLOG      := 'ARREST LOG';
    export string25 CRIMINALCOURT    := 'CRIMINAL COURT'; 
	end;

	// SNA Constants
	export SNA := module
		export MaxBusinessReturn		:= 8000;
		export MaxSIC_CODES := 12;
	end;

	//Socio Constants
	export Socio := module
		export Max_Scores := 10;
		export Max_Invalids := 10;
	end;
	
	// Taxpayer info, AKA Txbus?
	export TAXPAYER := module
		export unsigned2	MAX_COUNT_SEARCH_RECORDS := 1;
		export unsigned2	MAX_COUNT_OUTLET_RECORDS := 1;
  end;

	// Taxpro
	export TAXPRO := module
		export unsigned2	MAX_COUNT_SEARCH_RECORDS := 1;
  end;

	// Text Power Search
	EXPORT PowerSrch := MODULE
		EXPORT UNSIGNED2 SEARCH_MAX_COUNT_RESPONSE_RECORDS := 2000;
	END;

	// Thin RollupPersonSearch
	EXPORT ThinRps := MODULE
	  EXPORT UNSIGNED2 MaxCountNames := 100;
		EXPORT UNSIGNED2 MaxCountAddresses := 100;
		EXPORT UNSIGNED2 MaxCountDOBs := 100;
		EXPORT UNSIGNED2 MaxCountDODs := 100;
		EXPORT UNSIGNED2 MaxCountRelatives := 5;
		EXPORT UNSIGNED2 MaxCountResponseRecords := 100;		
	END;
	
	// Thin RollupPersonSearch Extended
	EXPORT ThinRpsExt := MODULE
		EXPORT UNSIGNED2 MaxNames := ThinRps.MaxCountNames;
		EXPORT UNSIGNED2 MaxAddresses := ThinRps.MaxCountAddresses;
		EXPORT UNSIGNED2 MaxDOBs := ThinRps.MaxCountDOBs;
		EXPORT UNSIGNED2 MaxDODs := ThinRps.MaxCountDODs;
		EXPORT UNSIGNED2 MaxRelatives := ThinRps.MaxCountRelatives;
		EXPORT UNSIGNED2 MaxPhones := 1;
		EXPORT UNSIGNED2 MaxRespRecords := ThinRps.MaxCountResponseRecords;				
		EXPORT UNSIGNED2 MaxEmailAddresses := 5;		
		EXPORT UNSIGNED2 MaxCountCollegeAddresses := 5;
		EXPORT UNSIGNED2 MaxCountPersonCounts := 25;
	END;
	EXPORT ThinReverseAddress := MODULE
		EXPORT UNSIGNED2 MaxAddresses := 5;
		EXPORT UNSIGNED2 MaxCurrentResidents := 1;
		EXPORT UNSIGNED2 MaxPreviousResidents := 5;
		EXPORT UNSIGNED2 MaxRespRecords := 5; 
		EXPORT UNSIGNED2 MaxRelatives := 10;
	END;
	
	EXPORT TISTA := MODULE
		export unsigned2 MAX_WARNINGS := 20;
		export unsigned2 MAX_ADDRESSES := 5;
		export unsigned2	MAX_NAMEVALUES := 10;
	end;

	// TopBusiness, AKA BIP/Business Integration Project 
	EXPORT TOPBUSINESS := module

    // Report, Search & Source Services limits:
		export unsigned2 MAX_COUNT_REPORT_RESPONSE_RECORDS   := 100;
		export unsigned2 MAX_COUNT_SEARCH_RESPONSE_RECORDS   := 2000;
		export unsigned2 MAX_COUNT_SOURCE_RESPONSE_RECORDS   := 1;
		export unsigned2 MAX_COUNT_SOURCE_SEARCHBY_RECORDS   := 50;
		export unsigned2 MAX_COUNT_SEARCH_MATCH_PRE_ROLLUP_RECORDS := 50;
		export unsigned2 MAX_COUNT_SEARCH_MATCH_ROLLUP_RECORDS := 5;
		
		// associate/relationship/relative limits:
		export unsigned2 MAX_COUNT_BIZRPT_RELATIONSHIP_RECORDS := 20;
		export unsigned2 MAX_COUNT_BIZRPT_ASSOCIATE_RECORDS    := 100; //req BIZ2.0-1280 & 1410
    export unsigned2 MAX_COUNT_BIZRPT_PARENT_RECORDS       := 5;
		
		// best section 		
		export unsigned	 MAX_COUNT_BIZRPT_OTHER_COMPANIES := 100;
		export unsigned	 MAX_COUNT_BIZRPT_FEINS           := 100;
		
		// Profile section limits		
		export unsigned2 MAX_COUNT_BIZRPT_FINANCE_RECORDS     :=  1;  //req BIZ2.0-0430
		export unsigned2 MAX_COUNT_BIZRPT_PARCOMP_RECORDS     :=  5;  //req BIZ2.0-0440
		export unsigned2 MAX_COUNT_BIZRPT_INDUSTRY_RECORDS    := 50;  //req BIZ2.0-0450???
		export unsigned2 MAX_COUNT_BIZRPT_SIC_RECORDS         := 50;  //req BIZ2.0-0450???
		export unsigned2 MAX_COUNT_BIZRPT_NAICS_RECORDS       := 50;  //req BIZ2.0-0450???
		export unsigned2 MAX_COUNT_BIZRPT_INCORP_RECORDS      := 500; //req BIZ2.0-0510 implied???
		export unsigned2 MAX_COUNT_BIZRPT_CFILINGS_PER_STATE  := 10;  //req BIZ2.0-0510
		export unsigned2 MAX_COUNT_BIZRPT_CFILINGS_PER_STATE_BLANK := 30;
		export unsigned2 MAX_COUNT_BIZRPT_CORPHIST_RECORDS    := 25;  //req BIZ2.0-0500???
		export unsigned2 MAX_COUNT_BIZRPT_OPSITE_RECORDS      := 50;  //req BIZ2.0-0460???
		export unsigned2 MAX_COUNT_BIZRPT_PHONES_PER_ADDRESS  :=  5;  //req BIZ2.0-0460???
		export unsigned2 MAX_COUNT_BIZRPT_ADDRESSES_PER_STATE := 50;  //req BIZ2.0-0470
		export unsigned2 MAX_COUNT_BIZRPT_CONTACT_RECORDS     := 100; //req BIZ2.0-0600 & 1260?
		export unsigned2 MAX_COUNT_BIZRPT_REGISTEREDAGENT_RECORDS := 50;
		export unsigned2 MAX_COUNT_BIZRPT_POSITION_RECORDS    := 50;  //req BIZ2.0-0???
		export unsigned2 MAX_COUNT_BIZRPT_LICENSE_RECORDS     := 50;  //req BIZ2.0-0620
		export unsigned2 MAX_COUNT_BIZRPT_URL_RECORDS         := 50;  //req BIZ2.0-0610

		// Bankruptcy section limits
		export unsigned2 MAX_COUNT_BIZRPT_BANKRUPTCY_DEBTORS   := 20;
		export unsigned2 MAX_COUNT_BIZRPT_BANKRUPTCY_ATTORNEYS := 20;
		export unsigned2 MAX_COUNT_BIZRPT_BANKRUPTCY_TRUSTEES  := 20;
		export unsigned2 MAX_COUNT_BIZRPT_BANKRUPTCIES         := 100; //or 100? req BIZ2.0-0670
    
		// ConnectedBusinesses section limits
    export unsigned2 MAX_COUNT_CONNECTED_BUSINESSES        := 100;

    // Judgments&Liens section limits
		export unsigned2 MAX_COUNT_BIZRPT_LIENS_RECORDS := 100; //req BIZ2.0-0710
		export unsigned2 MAX_COUNT_BIZRPT_LIENS_PARTYS  := 20;  //req BIZ2.0-07??
		export unsigned2 MAX_COUNT_BIZRPT_LIENS_FILINGS := 20;  //req BIZ2.0-07??

		// UCC section limits
		// The first 7 are just arbitrary values, no BIZ2.0 report requirement addresses these.
		// As of 02/20/13, may need to discuss with Tim Bernhard?
		export unsigned2 MAX_COUNT_BIZRPT_UCC_DEBTORS     := 20;
		export unsigned2 MAX_COUNT_BIZRPT_UCC_SECUREDS    := 20;
		export unsigned2 MAX_COUNT_BIZRPT_UCC_ASSIGNEES   := 20;
		export unsigned2 MAX_COUNT_BIZRPT_UCC_FILINGS     := 20;
		export unsigned2 MAX_COUNT_BIZRPT_UCC_COLLATERALS := 20;
		export unsigned2 MAX_COUNT_BIZRPT_ACTIVE_UCCS     := 100; //req BIZ2.0-0770
		export unsigned2 MAX_COUNT_BIZRPT_TERMINATED_UCCS := 100; //req BIZ2.0-0770
		export unsigned2 MAX_COUNT_BIZRPT_UCC_ASDEBTORS   := 100; //req BIZ2.0-0770
		export unsigned2 MAX_COUNT_BIZRPT_UCC_ASSECUREDS  := 100; //req BIZ2.0-0770
		
		// tradelines section
		export unsigned  MAX_COUNT_BIZRPT_TRADELINES := 50;
		export unsigned  MAX_COUNT_BIZRPT_TRADELINE_SUMMARIES  := 50;

		// Real Property section limits	
		// ensure that this is 1/2 of MAX_COUNT_BIZRPT_PROPERTY_TOTAL_RECS 
		export unsigned2 MAX_COUNT_BIZRPT_PROPERTY_RECORDS        := 100; 
		export unsigned2 MAX_COUNT_BIZRPT_PROPERTY_PARTY_RECORDS  := 50; 
		export unsigned2 MAX_COUNT_BIZRPT_PROPERTY_DEED_RECORDS   := 10; 
		export unsigned2 MAX_COUNT_BIZRPT_PROPERTY_TOTAL_RECS     := 200;

		// foreclosure NOD section limits
		export unsigned2 MAX_COUNT_BIZRPT_FORECLOSURE_NODS       := 50;
		export unsigned2 MAX_COUNT_BIZRPT_FORECLOSURE_NODS_NAMES := 2;

		// Personal Property sections limits
		export unsigned2 MAX_COUNT_BIZRPT_AIRCRAFT_RECORDS         := 50;  //req BIZ2.0-1090
		export unsigned2 MAX_COUNT_BIZRPT_AIRCRAFT_PARTY_RECORDS   := 50;
		export unsigned2 MAX_COUNT_BIZRPT_MVR_MAIN_RECORDS         := 50;  //req BIZ2.0-1090
		export unsigned2 MAX_COUNT_BIZRPT_MVR_PARTY_RECORDS        := 50;  //req BIZ2.0-????
		export unsigned2 MAX_COUNT_BIZRPT_MVR_TITLE_RECORDS        := 100; //req BIZ2.0-????
		export unsigned2 MAX_COUNT_BIZRPT_MVR_REGISTRATION_RECORDS := 100; //req BIZ2.0-????
		export unsigned2 MAX_COUNT_BIZRPT_WATERCRAFT_MAIN_RECORDS  := 50;  //req BIZ2.0-1090
		export unsigned2 MAX_COUNT_BIZRPT_WATERCRAFT_PARTY_RECORDS := 50;  //req BIZ2.0-????

		// Source section/SourceDocs limits
		export unsigned2 MAX_COUNT_BIZRPT_ALLSRCDOC_RECORDS := 150; //actual value=??? Revised for bug 151725 to output "All" source codes onto multiple/separate recs
		export unsigned2 MAX_COUNT_BIZRPT_SOURCE_RECORDS    := 15; // req BIZ2.0-1430, 11+4 categories total
		export unsigned2 MAX_COUNT_BIZRPT_SRCDOC_RECORDS    := 150; // ???

    // "Accurint only" BUSREG, DNB, EBR & IRS5500 sections limits
		export unsigned2 MAX_COUNT_BIZRPT_BUSREG_RECORDS    := 50;
		export unsigned2 MAX_COUNT_BIZRPT_DNBSIC_RECORDS    := 30; // for all SIC code fields in DNB.Layout_DNB_Base
		export unsigned2 MAX_COUNT_BIZRPT_EBR_RECORDS       := 10; // May need adjusted? Not really sure how many EBR file_numbers could be associated with a seleid
		// NOTE: The BIP2 "Accurint only" EBR section will use the iesp.bizcredit layouts 
		// which use max count values from this attribute named BIZ_CREDIT.MAX_* above.
		export unsigned2 MAX_COUNT_BIZRPT_IRS5500_RECORDS   := 50;
	  export unsigned2 MAX_COUNT_BIZRPT_SANCTION_RECORDS   := 50;
		// SourceService limits
		export unsigned2 MAX_COUNT_SOURCE_CONTACT_RECORD := 20;// max may need adjusted???
	  export unsigned2 MAX_COUNT_ACF_RECORD       := 100; // max may need adjusted???
		export unsigned2 MAX_COUNT_AMSLIC_RECORD    := 100; 
    export unsigned2 MAX_COUNT_BBB_RECORD       := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_BK_RECORD        := 100; // max may need adjusted???
		export unsigned2 MAX_COUNT_BUSREG_RECORD    := 100;
		export unsigned2 MAX_COUNT_CATAX_RECORD    	:= 100; 
    export unsigned2 MAX_COUNT_CALBUS_RECORD    := 100; // max may need adjusted??? 
		export unsigned2 MAX_COUNT_CNLD_RECORD    	:= 100;  
    export unsigned2 MAX_COUNT_CORP_RECORD      := 100; // max may need adjusted???
		export unsigned2 MAX_COUNT_CORTERA_RECORD   := 100;
		export unsigned2 MAX_COUNT_CRASH_RECORD			:= 100;
    export unsigned2 MAX_COUNT_CU_RECORD        := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_DCA_RECORD       := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_DEA_RECORD       := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_DEAD_RECORD      := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_DEADCO_RECORD    := 100;
	  export unsigned2 MAX_COUNT_DIRECTORY_RECORD := 100; // MAY NOT BE NEEDED ???
		export unsigned2 MAX_COUNT_DIVCERT_RECORD   := 100;
    export unsigned2 MAX_COUNT_DNB_RECORD       := 100; 
    export unsigned2 MAX_COUNT_EBR_RECORD       := 100; 
    export unsigned2 MAX_COUNT_EDA_RECORD       := 100; 
	  export unsigned2 MAX_COUNT_FAA_RECORD       := 100; 
    export unsigned2 MAX_COUNT_FBN_RECORD       := 100; 
	  export unsigned2 MAX_COUNT_FCC_RECORD       := 100; 
    export unsigned2 MAX_COUNT_FDIC_RECORD      := 100; 
    export unsigned2 MAX_COUNT_FDICSOD_RECORD   := 100; 
    export unsigned2 MAX_COUNT_FEIN_RECORD      := 100; 
		export unsigned2 MAX_COUNT_EXPFEIN_RECORD   := 100; 
		export unsigned2 MAX_COUNT_EXPCRDB_RECORD		:= 100;
    export unsigned2 MAX_COUNT_FIREARM_RECORD   := 100; 
    export unsigned2 MAX_COUNT_FOREC_RECORD     := 100; 
		export unsigned2 MAX_COUNT_FRANDX_RECORD    := 100; 
    export unsigned2 MAX_COUNT_GAMING_RECORD    := 100; 
		export unsigned2 MAX_COUNT_GONG_RECORD    	:= 100; 
		export unsigned2 MAX_COUNT_GSA_RECORD    		:= 100; 
		export unsigned2 MAX_COUNT_IATAX_RECORD    	:= 100; 
    export unsigned2 MAX_COUNT_IDEXEC_RECORD    := 100; 
		export unsigned2 MAX_COUNT_INSCERT_RECORD 	:= 100; 
    export unsigned2 MAX_COUNT_IRS5500_RECORD   := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_IRS990_RECORD    := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_JS_RECORD        := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_LIQLIC_RECORD    := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_LNJ_RECORD       := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_MSWORK_RECORD    := 100; // max may need adjusted???
	  export unsigned2 MAX_COUNT_MVR_RECORD       := 100; // max may need adjusted???
		export unsigned2 MAX_COUNT_NCPDP_RECORD     := 100;
		export unsigned2 MAX_COUNT_NDR_RECORD     	:= 100;
		export unsigned2 MAX_COUNT_NOD_RECORD       := 100; // max may need adjusted???
		export unsigned2 MAX_COUNT_OIG_RECORD				:= 100;
    export unsigned2 MAX_COUNT_ORWORK_RECORD    := 100; // max may need adjusted???
		export unsigned2 MAX_COUNT_OTHER_RECORD    	:= 750; // max may need adjusted???
		export unsigned2 MAX_COUNT_OTHER_GROUP    	:= 250; // max may need adjusted???
		export unsigned2 MAX_COUNT_OSHAIR_RECORD   	:= 100; 
    export unsigned2 MAX_COUNT_PROFLIC_RECORD   := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_PROP_RECORD      := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_SDA_RECORD       := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_SEC_RECORD       := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_SHEILA_RECORD    := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_SKA_RECORD       := 100; // max may need adjusted???
		export unsigned2 MAX_COUNT_SOURCE_SOURCES 	:= 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_SOURCE_CATEGORIES := 10; // max may need adjusted???
		export unsigned2 MAX_COUNT_SPOKE_RECORD     := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_TAXPRO_RECORD    := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_TXBUS_RECORD     := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_UCC_RECORD       := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_USABIZ_RECORD    := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_UTILITY_RECORD   := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_VICKERS_RECORD   := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_WC_RECORD        := 100; // max may need adjusted???
		export unsigned2 MAX_COUNT_WORKERSCOMP_RECORD := 100; // max may need adjusted???					
    export unsigned2 MAX_COUNT_YP_RECORD        := 100; // max may need adjusted???
    export unsigned2 MAX_COUNT_ZOOM_RECORD      := 100; // max may need adjusted???
		
		// Default or Other source doc defaults
		export unsigned2 OTHER_MAX_SICCODES					:= 75;
		export unsigned2 OTHER_MAX_NAICSCODES				:= 75;
		export unsigned2 OTHER_MAX_CONTACTS					:= 50;
		export unsigned2 OTHER_MAX_PHONES						:= 50;
	END; // of TopBusiness module

  // UCC Filings (cannot use same name: "F" -- for "filing")
  // TODO: following constants must be redefined appropriately, they're hardcoded in 
  // uccv2_services.layout_ucc_rollup
  export UCCF := MODULE
    export unsigned2 MaxCountSearch := 1000;
    export unsigned2 MaxCountReport := 10;
    export unsigned2 MaxPersonParsedParties := 15; // within a Person structure
    export unsigned2 MaxPersonAddresses := 15; // within a Person structure
    export unsigned2 MaxCollaterals := 15;  //? Todd: 230	// no kidding - counted in W20070523-073530
    export unsigned2 MaxDebtors := 15;
    export unsigned2 MaxCreditors := 15;
    export unsigned2 MaxSecureds := 15;
    export unsigned2 MaxAssignees := 15;
    export unsigned2 MaxSigners := 15;
    export unsigned2 MaxFilings := 15;
    export unsigned2 MaxFilingOffices := 15;
    export unsigned2 MaxEvents := 15;
  end;

  // USABIZ (InfoUSA-ABIUS)
	EXPORT USABIZ := MODULE
		EXPORT UNSIGNED2 MAX_COUNT_SEARCH_RECORDS := 1;
		EXPORT UNSIGNED2 MAX_CONTACTS             := 10; //Arbitrary, actual value may need increased?
		EXPORT UNSIGNED2 MAX_FRANCHISES           := 1; //???
		EXPORT UNSIGNED2 MAX_SECONDARY_SICS       := 4;
		EXPORT UNSIGNED2 MAX_SICS									:= 5;
	END;
	
	//Velocity Check - Search Alert
	export VC := MODULE
		 export unsigned2 MAX_SRCHDATE_RECS := 100;
		 export unsigned2 MAX_SEARCH_ALERT_RECS := 36;
		 export unsigned2 SEARCH_ALERT_ID_MAX_DATASETS := 1;
		 export unsigned2 SEARCH_ALERT_ID_MAX_RECORDS := 100;
	END;

	// Verification of Occupancy
	export VOO := MODULE
		export unsigned2 MaxAttributes := 24;
		export unsigned2 MaxSummaryHRI := 50;
		export unsigned2 MaxSummaryPhones := 10;
		export unsigned2 MaxSummaryEmails := 50;
		export unsigned2 MaxSupport := 50;
	END;

  // Watercrafts
  export WATERCRAFTS := MODULE
    export unsigned2 MaxCountSearch := 100;
    export unsigned2 MaxCountReport := 10;
    export unsigned1 MaxOwners := 3;
    export unsigned1 MaxLienholders := 3; //or Moxie_watercraft2_1_search_server.layouts.max_liens
    export unsigned1 MaxEngines := 3; //or Moxie_watercraft2_1_search_server.layouts.max_engines
  END;

  // Work Place Locator (Formerally Known As: Place of Employment/POE)
	export unsigned2 WP_MAX_COUNT_REPORT_RESPONSE_RECORDS        := 1;
	export unsigned2 WP_MAX_COUNT_SEARCH_RESPONSE_RECORDS        := 100;
	export unsigned2 WP_PLUS_MAX_COUNT_SEARCH_RESPONSE_RECORDS   := 2000;
	export unsigned2 WP_MAX_COUNT_SEARCH_RESPONSE_SINGLE_RECORD  := 1;
	export unsigned2 WP_MAX_COUNT_ADDL_COMP  := 4;
	export unsigned2 WP_MAX_COUNT_EMAIL_ADDR := 3;


  // *** Modules that refer to other modules above.
 	// NOTE: Various Max* attributes in the BR module refer to other modules (i.e. BANKRPT,
	// Crim, etc.), so this BR module must be after all of the modules it refers to.
	// 
  // Bps (Business/Person) Report and all other compound reports
  export BR := MODULE
    export unsigned1 UNKNOWN := 10; // default

    export unsigned1 MaxSources := 100;
    // "personal" info
    export unsigned1 MaxAKA := 20; // maximum possible; must be larger than any of MaxRelatives_AKA, MaxAddress_Residents
    export unsigned1 MaxImposters := 20;
    export unsigned1 MaxImposters_AKA := 50; // AKA within <Imposters>
    export unsigned1 MaxRelatives := 20;
    export unsigned1 MaxRelatives_AKA := 15; // AKA within Relatives
    export unsigned1 MaxRelatives_Address := 10; // addresses per relative OR associates
    export unsigned1 MaxAddress := 20;
    export unsigned1 MaxAddress_Residents := 10; // residents per each addresses
    export unsigned1 MaxAddress_Phones := 5; // phones per each addresses
    export unsigned1 MaxAddress_Property := UNKNOWN; // 
    export unsigned1 MaxAssociates := 25; // Associates per each addresses
    export unsigned1 MaxNeighborhood := 5; // number neighborhoods to return
    export unsigned1 MaxHistoricalNeighborhood := 5;
		export unsigned1 NeigborsInNeighborhood := 20; // Changed the no. from 10 to 20 to match with BPS report.
    export unsigned1 Neigbors_Phones := 4;
    export unsigned1 Neigbors_Residents := 10;
    export unsigned1 RNANbrProximityRadius := 20;
		export unsigned1 MaxPhones := 100;
    export unsigned1 MaxPhonesPlus := 10;
    export unsigned1 MaxPhonesHistorical := 10; //old phones (for a given person)

    // single sources
    export unsigned1 MaxAccidents := UNKNOWN; //no limit defined for datatype
    export unsigned1 MaxAircrafts := 10; 
    export unsigned1 MaxAssessments := PROP.MaxCountReportAssessments;
    export unsigned1 MaxBankruptcies := BANKRPT.MaxCountReport;
    export unsigned1 MaxCivilCourtRecords := UNKNOWN;
    export unsigned1 MaxCorpAffiliations := 10;
    export unsigned1 MaxCrimRecords := Crim.MaxReportRecords;
    export unsigned1 MaxCrimHistoryRecords := UNKNOWN; //?
    export unsigned1 CorpAffiliation_Phones := 10; // phones per affiliation
    export unsigned1 MaxDEASubstances := MAX_COUNT_DEA_REGISTRATION;
    export unsigned1 MaxDeeds := PROP.MaxCountReportDeeds;
    export unsigned1 MaxDLs := 10;
    export unsigned2 MaxEmails := UNKNOWN;
    export unsigned1 MaxFaaCertificates := MAX_COUNT_PILOT_CERTIFICATES;
    export unsigned1 MaxFictitiousBusinesses := UNKNOWN;
    export unsigned1 MaxFirearmsExplosives := ATF_MAX_COUNT_SEARCH_RECORDS;
    export unsigned1 MaxForeclosures := MAX_COUNT_Foreclosure_REPORT;
    export unsigned1 MaxHFLicenses := UNKNOWN; //no limit defined for datatype
    export unsigned2 MaxInternetDomains := UNKNOWN; //1000;
		export unsigned2 MaxJailBooking := 50;
    export unsigned1 MaxLiensJudgments := 10;
    export unsigned1 MaxMerchantVessels := UNKNOWN;
    export unsigned1 MaxNoticeOfDefaults := UNKNOWN;
    export unsigned1 MaxPeopleAtWork := 30;
    export unsigned1 MaxProfLicenses := 10;
    export unsigned1 MaxProperties := 10;
    export unsigned2 MaxProviders := UNKNOWN;
    export unsigned1 MaxRTVehicles := UNKNOWN;
    export unsigned2 MaxSanctions := UNKNOWN;
    export unsigned1 MaxSexualOffenses := 50;
    export unsigned1 MaxStudentColleges := 10; 
    export unsigned1 MaxSuperiorLiens := UNKNOWN; //TODO: what is that? should it rather be "LiensSUperior"
    export unsigned1 MaxUCCFilings := UCCF.MaxCountReport;
    export unsigned1 MaxVehicles := 10;
    export unsigned1 MaxVoterRegistrations := ut.Limits.VOTERS_PER_DID;
    export unsigned1 MaxVoterHistory := ut.Limits.VOTERS_HISTORY_MAX;
    export unsigned1 MaxWatercrafts := 10;
    export unsigned1 MaxWeaponPermits := UNKNOWN;
    export unsigned1 MaxMarriageDiv := 10;
    export unsigned1 MaxIndividualInput := 5;
    export unsigned1 MaxCompanyInput := 5;
    export unsigned1 MaxCompanyResult := 5;
    export unsigned1 MaxDBAandOfficersResult := 10;
    export unsigned1 MaxUtilAddresses := 2;
  end;

 	// NOTE: Various Max*** attributes in the AR module refer to the BR & DL modules, 
	// so this AR module must be after the BR & DL modules.
  // Address report
  export AR := MODULE
		export unsigned2 MaxProperties 	:= 500;//BR.MaxProperties;
		export unsigned2 MaxDLs 			:= 500;
		export unsigned2 MaxVehicles 		:= 500;
		export unsigned2 MaxBusiness 		:= 500;
		export unsigned1 MaxNeighbors 	:= BR.NeigborsInNeighborhood;//BR.NeigborsInNeighborhood;
		export unsigned2 MaxBankruptcies 	:= 500;
		export unsigned2 MaxPhonesRes 	:= 250;
		export unsigned2 MaxPhonesBus 	:= 250;
		export unsigned2 MaxResidents 	:= 500;
		export unsigned1 MaxAkas	 		:= BR.MaxAKA;
		export unsigned2 MaxLiens 		:= 500;
		export unsigned2 MaxRestrictions 	:= DL.MaxCountRestrictions;
		export unsigned2 MaxEndorsements 	:= DL.MaxCountEndorsements;
		export unsigned2 MaxPhones	 	:= 500;
		export unsigned2 MaxCriminals := 50;
		export unsigned2 MaxSexOffenders := 50;
		export unsigned2 MaxJailBooking := 50;
		export unsigned2 MaxHuntingandFishing := 50;
		export unsigned2 MaxConcealedWeapons := 50;
		export unsigned1 MaxNeighborhood 	:= 1;
		export unsigned1 MaxRelatives := 50;		
		export unsigned1 MaxAssociates := 50;		
		export unsigned1 MaxOwners := 5;
		export unsigned1 MaxPossibleOccupants := 4;
  end;

	// Consumer Disclosure Data Service -  ConsumerDisclosure/Constants/Limits
	export DataService := module
		export unsigned2 MaxDefault         := 100;
		export unsigned2 MaxAircrafts       := 1000;
		export unsigned2 MaxATF             := 200;
		export unsigned2 MaxAVM             := 1000;
		export unsigned2 MaxBankruptcies    := 1000;  
		export unsigned2 MaxCrimOffenders		:= 2000;  
		export unsigned2 MaxCrimOffenses		:= 750;
		export unsigned2 MaxCrimCourtOffenses	:= 900;
		export unsigned2 MaxCrimPunishment	:= 150;
		export unsigned2 MaxDeathDid        := 100;
		export unsigned2 MaxEmail           := 1000;
		export unsigned2 MaxGong            := 1000;
		export unsigned2 MaxHeader          := 1000;
		export unsigned2 MaxHunters         := 700;
		export unsigned2 MaxInfutor         := 1000;
		export unsigned2 MaxInquiries       := 1000;
		export unsigned2 MaxLiens           := 1000;
		export unsigned2 MaxMarriageDiv     := 150;
		export unsigned2 MaxOptOut          := 100;
		export unsigned2 MaxPAW             := 1000;
		export unsigned2 MaxPersonContext   := PersonContext.MAX_RECORDS;
		export unsigned2 MaxPilots          := 200;
		export unsigned2 MaxProfLicense     := 1000;
		export unsigned2 MaxProperties      := 1000;
		export unsigned2 MaxStudent         := 100;
		export unsigned2 MaxSSN             := 100;
		export unsigned2 MaxSOffenders      := 200;
		export unsigned2 MaxUCCFilings      := 1000;
		export unsigned2 MaxThrive          := 250;
		export unsigned2 MaxWatercrafts     := 1000;
	end;

  // Google Pony express
  export MailMatch := MODULE
    export unsigned2 MaxResults := 1000;
    export unsigned2 MaxCountSearch := 1000;
  END;
	
	// PRCT/Demo Search Tool
  export DEMO_SEARCH_TOOL := MODULE
    export unsigned2 MAX_COUNT_SEARCH_RESPONSE_RECORDS := 100;
  end;
	
END;