IMPORT iesp, SALT28;

EXPORT Layouts := MODULE

  EXPORT LinkIDs := RECORD
		SALT28.UIDType	LinkID := 0;
		INTEGER2				Weight := 0;                    // Specificity attached to this match
		UNSIGNED2				Score := 0;                     // Chances of being correct as a percentage
		UNSIGNED4				LinkCount := 0;                 // Number of times that particular LinkID is returned from the BIP Append Process
	END;
	
	EXPORT DD_CompanyNames := RECORD
		STRING120 Name := '';
		UNSIGNED4	LinkCount := 0;                       // Number of times that particular Name is returned from the BIP Append Process
	END;
	
/* Output of DueDiligence.getBusBIPId */  
	EXPORT LinkID_Results := RECORD
		UNSIGNED6 Seq       := 0;
		BOOLEAN BIPIDSourceInput;                       // Indicates if the BIP IDs were returned from the append process or input
		LinkIDs PowID;
		LinkIDs ProxID;
		LinkIDs SeleID;
		LinkIDs OrgID;
		LinkIDs UltID;
	END;
  
  EXPORT AddressSlimDetail := RECORD
    STRING10 prim_range;
		STRING2  predir;
		STRING28 prim_name;
		STRING4  addr_suffix;
		STRING2  postdir;
		STRING10 unit_desig;
		STRING8  sec_range;
		STRING25 city;
		STRING2  state;
		STRING5  zip5;
		STRING4  zip4;
    STRING3  county;                               //Due Diligence is capturing the last 3 digits of the full 5 digit FIPS code. It uses the 3 digit code to access the Census Keys and the will build the 5 digit FIPS to determine HIFCA and HIDTA  
    STRING7  geo_blk;
  END;

	EXPORT Address := RECORD
		STRING   streetAddress1;
		STRING   streetAddress2;
		AddressSlimDetail;
		STRING4  cart;	
		STRING1  cr_sort_sz;
		STRING4  lot;	
		STRING1  lot_order;
		STRING2  dbpc; 	
		STRING1  chk_digit; 
		STRING2  rec_type;
		STRING10 geo_lat;
		STRING11 geo_long;
		STRING4  msa; 
		STRING1  geo_match;
		STRING4  err_stat;	
		UNSIGNED4 dateLastSeen;
	END;

	EXPORT Name := RECORD
		STRING120 fullName;
		STRING20 firstName;
		STRING20 middleName;
		STRING20 lastName;
		STRING5 suffix;	
	END;
  
  EXPORT Shared_Input := RECORD
    STRING lexID;
		STRING30 accountNumber;
    Address address;
    STRING phone;
    UNSIGNED6 inputSeq;
  END;

	EXPORT Busn_Input := RECORD
		LinkID_Results BIP_IDs;
		Shared_Input;
		STRING companyName;
		STRING altCompanyName;
		STRING fein;
	END;

	EXPORT Indv_Input := RECORD
		Shared_Input;
		STRING3 nameInputOrder;
		Name name;		
		STRING ssn;
		STRING8 dob;
	END;


	EXPORT Input := RECORD
		BOOLEAN validRequest;
		STRING errorMessage;
		BOOLEAN addressProvided;
		BOOLEAN fullAddressProvided;
		UNSIGNED4 seq;
		UNSIGNED4 historyDateYYYYMMDD;
		STRING10 requestedVersion;
		Busn_Input business;
		Indv_Input individual;
	END;

	EXPORT CleanedData := RECORD
		Input inputEcho;
		Input cleanedInput;
	END;

  //ALSO USED BY BATCH - changing name will impact batch
	EXPORT PerAttributes := RECORD
		STRING15 PerLexID;
		STRING2 PerAssetOwnProperty;
		STRING10 PerAssetOwnProperty_Flag;
		STRING2 PerAssetOwnAircraft;
		STRING10 PerAssetOwnAircraft_Flag;
		STRING2 PerAssetOwnWatercraft;
		STRING10 PerAssetOwnWatercraft_Flag;
		STRING2 PerAssetOwnVehicle;
		STRING10 PerAssetOwnVehicle_Flag;
    STRING2 PerAccessToFundsIncome;
		STRING10 PerAccessToFundsIncome_Flag;
		STRING2 PerAccessToFundsProperty;
		STRING10 PerAccessToFundsProperty_Flag;		
		STRING2 PerGeographic;
		STRING10 PerGeographic_Flag;
		STRING2 PerMobility;
		STRING10 PerMobility_Flag;
		STRING2 PerStateLegalEvent;
		STRING10 PerStateLegalEvent_Flag;
    STRING2 PerFederalLegalEvent;
		STRING10 PerFederalLegalEvent_Flag;
		STRING2 PerCivilLegalEvent;
		STRING10 PerCivilLegalEvent_Flag;
		STRING2 PerOffenseType;
		STRING10 PerOffenseType_Flag;
		STRING2 PerAgeRange;
		STRING10 PerAgeRange_Flag;
		STRING2 PerIdentityRisk;
		STRING10 PerIdentityRisk_Flag;
		STRING2 PerUSResidency;
		STRING10 PerUSResidency_Flag;
		STRING2 PerMatchLevel;
		STRING10 PerMatchLevel_Flag;
		STRING2 PerAssociates;
		STRING10 PerAssociates_Flag;
		STRING2 PerProfLicense;
		STRING10 PerProfLicense_Flag;
	END;

  //ALSO USED BY BATCH - changing name will impact batch
	EXPORT BusAttributes := RECORD
		STRING15 BusLexID;
		STRING2 BusAssetOwnProperty;
		STRING10 BusAssetOwnProperty_Flag;
		STRING2 BusAssetOwnAircraft;
		STRING10 BusAssetOwnAircraft_Flag;
		STRING2 BusAssetOwnWatercraft;
		STRING10 BusAssetOwnWatercraft_Flag;
		STRING2 BusAssetOwnVehicle;
		STRING10 BusAssetOwnVehicle_Flag;
		STRING2 BusAccessToFundsProperty;
		STRING10 BusAccessToFundsProperty_Flag;
		STRING2 BusGeographic;
		STRING10 BusGeographic_Flag;
		STRING2 BusValidity;
		STRING10 BusValidity_Flag;
		STRING2 BusStability;
		STRING10 BusStability_Flag;
		STRING2 BusIndustry;
		STRING10 BusIndustry_Flag;
		STRING2 BusStructureType;
		STRING10 BusStructureType_Flag;
		STRING2 BusSOSAgeRange;
		STRING10 BusSOSAgeRange_Flag;
		STRING2 BusPublicRecordAgeRange;
		STRING10 BusPublicRecordAgeRange_Flag;
		STRING2 BusShellShelf;
		STRING10 BusShellShelf_Flag;
		STRING2 BusMatchLevel;
		STRING10 BusMatchLevel_Flag;
		STRING2 BusStateLegalEvent;
		STRING10 BusStateLegalEvent_Flag;
    STRING2 BusFederalLegalEvent;
    STRING10 BusFederalLegalEvent_Flag;
		STRING2 BusCivilLegalEvent;
		STRING10 BusCivilLegalEvent_Flag;
		STRING2 BusOffenseType;
		STRING10 BusOffenseType_Flag;
		STRING2 BusBEOProfLicense;
		STRING10 BusBEOProfLicense_Flag;
		STRING2 BusBEOUSResidency;
		STRING10 BusBEOUSResidency_Flag;
	END;

	EXPORT BatchInLayout  := RECORD
		UNSIGNED4 seq;
		STRING30  acctNo;
		STRING15  custType;
		STRING15 	lexID;
		STRING120 companyName;
		STRING120 altCompanyName;
		STRING11  taxID;
		STRING3		nameInputOrder;	// sequence of name (FML = First/Middle/Last, LFM = Last/First/Middle) if not specified, uses default name parser
		STRING120 fullName;
		STRING20 	firstName;
		STRING20 	middleName;
		STRING20 	lastName;
		STRING5 	suffix;
		STRING9   ssn;
		STRING8   dob;
		
		STRING120   streetAddress1;
		STRING120   streetAddress2;
		STRING10 		prim_range;
		STRING2  		predir;
		STRING28 		prim_name;
		STRING4  		addr_suffix;
		STRING2  		postdir;
		STRING10 		unit_desig;
		STRING8  		sec_range;
		STRING25 		city;
		STRING2  		state;
		STRING5  		zip5;
		STRING4  		zip4;

		STRING10  phone;
		UNSIGNED4	HistoryDateYYYYMMDD;
	END;

//***Coordinate these changes witht the batch team ***//
	EXPORT BatchOut := RECORD
		UNSIGNED4 seq;
    STRING30 acctNo;
    BOOLEAN lexIDChanged;
		PerAttributes;
		BusAttributes;
	END;
	
	EXPORT LayoutSICNAIC := RECORD
		UNSIGNED4 DateFirstSeen;
		UNSIGNED4 DateLastSeen;
		STRING10 SICCode;
		STRING5 SICIndustry;
		STRING7 SICRiskLevel;
		STRING10 NAICCode;
		STRING5 NAICIndustry;
		STRING7 NAICRiskLevel;
		BOOLEAN IsPrimary;
		STRING3 source;
	END;
	
	EXPORT SicNaicRiskLayout := RECORD
		BOOLEAN cibRetailExists;
		BOOLEAN cibNonRetailExists;
		BOOLEAN msbExists;
		BOOLEAN nbfiExists;
		BOOLEAN cagExists;
		BOOLEAN legAcctTeleFlightTravExists;
		BOOLEAN autoExists;
		BOOLEAN otherHighRiskIndustExists;
		BOOLEAN moderateRiskIndustExists;
		BOOLEAN lowRiskIndustExists;
		STRING sicCodes;
		STRING naicCodes;
	END;

  
	
	EXPORT CivilOffensesCounts := RECORD                               
	/* LIENS and JUDGMENTS and EVICTIONS */  
		unsigned2   liensUnreleasedCntOVNYR;                            //*** liens unreleased over 3 years
		unsigned2   liensUnreleasedCntInThePastNYR;                     //*** liens unreleased in the past 3 years
		unsigned2   liensUnreleasedCnt;                                 //*** liens unreleased EVER
    
    unsigned2   liensReleasedCnt;                                   //*** liens released EVER
		
		unsigned2   evictionsCntOVNYR;                                  //*** evictions over 3 years ago
		unsigned2   evictionsCntInThePastNYR;                           //*** evcitions in the past 3 years
		unsigned2   evictionsCnt;                                       //*** evictions EVER
	END;  
		
	
	EXPORT GeographicRiskLayout := RECORD 
		STRING12    buildgeolink;
		STRING3	    EasiTotCrime;
		STRING      CityState;
    STRING5     FipsCode;  
    STRING50    CountyName;                             //populated in DueDiligence.Common.getGeographicRisk 
		boolean     CountyHasHighCrimeIndex;                //populated in DueDiligence.Common.getGeographicRisk
		boolean     CountyBordersForgeinJur;                //populated in DueDiligence.Common.getGeographicRisk
		boolean     CountyBorderOceanForgJur;               //populated in DueDiligence.Common.getGeographicRisk
		boolean     CityBorderStation;                      //populated in DueDiligence.Common.getGeographicRisk
		boolean     CityFerryCrossing;                      //populated in DueDiligence.Common.getGeographicRisk
		boolean     CityRailStation;                        //populated in DueDiligence.Common.getGeographicRisk
		boolean     HIDTA;                                  //populated in DueDiligence.Common.getGeographicRisk
		boolean     HIFCA;                                  //populated in DueDiligence.Common.getGeographicRisk
	END;  	
	
 
	
	
	EXPORT BusSourceLayout := RECORD
		STRING source;
    STRING sourceName;
		STRING sourceType;
		UNSIGNED4 firstReported;
		UNSIGNED4 lastReported;
	END;
  
  EXPORT CommonGeographicLayout := RECORD
	 Address;
	 GeographicRiskLayout;  
	 BOOLEAN cmra;
	 BOOLEAN vacant;
   STRING1 addressType;
	END;	
	
	
	EXPORT LayoutAgent := RECORD
		UNSIGNED4 dateFirstSeen;
		UNSIGNED4 dateLastSeen;
		STRING4 source;
		Name;
		Address;
    BOOLEAN addressMatchesInquiredBusiness;
    UNSIGNED4 numberOfBusinessesAtAddress;
    UNSIGNED4 numberOfBusinessesWithNoFein;
    UNSIGNED4 numberOfBusinssesIncWithLooseIncLaws;
	END;
  
  EXPORT FEINLayoutSources := RECORD
		STRING2 source;  
		INTEGER  source_record_id;
    STRING  vl_id;     
	END;
  
  EXPORT DIDAndName := RECORD
    UNSIGNED6 did;
    Name;
  END;
  
  EXPORT PropertyDataLayout := RECORD
    Address;
    STRING50 addressType;
    STRING8   purchaseDate; 
    INTEGER8  purchasePrice;
    INTEGER2  lengthOfOwnership;
    STRING4 assessedYear;
    INTEGER8 assessedValue;
  END;
  
  EXPORT BusPropertyDataLayout := RECORD
    PropertyDataLayout;
    STRING120 ownerName;
  END;
  
  EXPORT IndPropertyDataLayout := RECORD
    PropertyDataLayout;
    BOOLEAN inquiredOwned;
    BOOLEAN spouseOwned;
    STRING1 ownerOccupied;
    DATASET(DIDAndName) propertyOwners;
  END;
	
	
  
  EXPORT IndReportDetails := RECORD
    STRING9 bestSSN;
    STRING10 bestPhone;
    UNSIGNED4 bestDOB;
    Name bestName;
		Address bestAddress;
    DATASET(IndPropertyDataLayout) properties {MAXCOUNT(DueDiligence.Constants.MAX_PROPERTIES)};
  END;
	
	EXPORT Positions := RECORD
		UNSIGNED4 firstSeen;
		UNSIGNED4 lastSeen;
		STRING title;
	END;
	
	EXPORT Licenses := RECORD
		STRING30 licenseNumber;
		UNSIGNED4 dateFirstSeen;
		UNSIGNED4 dateLastSeen;
		UNSIGNED4 issueDate;
		UNSIGNED4 expirationDate;
		BOOLEAN isActive;
		STRING90 status; 
		STRING80 licenseType;
		STRING80 licenseCategory;
		BOOLEAN lawAcct;
		BOOLEAN realEstate;
		BOOLEAN medical;
		BOOLEAN blastPilot;
		BOOLEAN other;
	END;
	
	EXPORT SlimIndividual := RECORD
		DIDAndName;
		UNSIGNED2 score;		//did score
		STRING9 ssn;
		UNSIGNED4 dob;
		STRING phone;
		Address;
	END;
  
  EXPORT CriminalSources := RECORD
    STRING offenseCharge;
    STRING1 offenseConviction;
    STRING1 offenseChargeLevelCalculated;
    STRING35 offenseChargeLevelReported;
    STRING25 source;
    STRING50 courtDisposition1;
    STRING50 courtDisposition2;
    UNSIGNED4 offenseReportedDate;
    UNSIGNED4 offenseArrestDate;
    UNSIGNED4 offenseCourtDispDate;
    UNSIGNED4 offenseAppealDate;
    UNSIGNED4 offenseSentenceDate;
    UNSIGNED4 offenseSentenceStartDate;
    UNSIGNED4 DOCConvictionOverrideDate;
    UNSIGNED4 DOCScheduledReleaseDate;
    UNSIGNED4 DOCActualReleaseDate;
    STRING50 DOCInmateStatus;
    STRING50 DOCParoleStatus;
    STRING30 offenseMaxTerm;
    DATASET({STRING120 name}) partyNames;
    
    //used for file validation
    STRING1 validate_trafficRelated;
    UNSIGNED8 validate_category;
    STRING validate_eventType;
  END;
  
  EXPORT CriminalOffenses := RECORD
    //fields used for attribute calculation - calc based on roll of sources
    BOOLEAN attr_currentlyIncarceratedOrParoled;
    BOOLEAN attr_felonyPast3Yrs;
    BOOLEAN attr_felonyOver3Yrs;
    BOOLEAN attr_previouslyIncarcerated;
    BOOLEAN attr_uncategorizedConvictionPast3Yrs;
    BOOLEAN attr_uncategorizedConvictionOver3Yrs;
    BOOLEAN attr_misdemeanorConvictionPast3Yrs;
    BOOLEAN attr_misdemeanorConvictionOver3Yrs;
    
    BOOLEAN attr_legalEventCat9;
    BOOLEAN attr_legalEventCat8;
    BOOLEAN attr_legalEventCat7;
    BOOLEAN attr_legalEventCat6;
    BOOLEAN attr_legalEventCat5;
    BOOLEAN attr_legalEventCat4;
    BOOLEAN attr_legalEventCat3;
    BOOLEAN attr_legalEventCat2;
    
    //Top Level Data
    STRING2 state;
    STRING25 source;
    STRING35 caseNumber;
    STRING35 offenseStatute;
    STRING8 offenseDDFirstReportedActivity;
    UNSIGNED4 offenseDDLastReportedActivity;
    UNSIGNED4 offenseDDLastCourtDispDate;
    UNSIGNED offenseDDLegalEventTypeCode;
    STRING offenseCharge;
    STRING1 offenseDDChargeLevelCalculated;
    STRING35 offenseChargeLevelReported; 
    STRING1 offenseConviction;
    STRING13 offenseIncarcerationProbationParole;
    STRING1 offenseTrafficRelated;
    
    //Additional details
    STRING county;
    STRING countyCourt;
    STRING city;
    STRING agency;
    STRING race;
    STRING1 sex;
    STRING hairColor;
    STRING eyeColor;
    STRING3 height;
    STRING3 weight;
    
    //Source info
    DATASET(CriminalSources) sources;
  END;
	
	
	EXPORT RelatedParty := RECORD
		SlimIndividual;
		STRING2 usResidencyScore;
		STRING10 usResidencyFlags;
		STRING2 legalEventTypeScore;
		STRING10 legalEventTypeFlags;
    STRING2 stateCriminalLegalEventsScore;
    STRING10 stateCriminalLegalEventsFlags;
    STRING2 civilLegalEventsScore;
    STRING10 civilLegalEventsFlags;
		UNSIGNED3 numOfPositions;
		DATASET(Positions) positions; //{MAXCOUNT(DueDiligence.Constants.MAX_POSITIONS)};
		UNSIGNED3 numOfLicenses;
		DATASET(Licenses) licenses; //{MAXCOUNT(DueDiligence.Constants.MAX_LICENSES)};
    DATASET(CriminalOffenses) indOffenses;
	END;

  EXPORT BusReportDetails := RECORD
    DATASET(BusPropertyDataLayout) properties {MAXCOUNT(DueDiligence.Constants.MAX_PROPERTIES)};
    DATASET(CommonGeographicLayout) operatingLocations {MAXCOUNT(DueDiligence.Constants.MAX_OPERATING_LOCATIONS)};
    BOOLEAN FEINSourceContainsE5;
    STRING  FEIN_Masked_For_Report;
    UNSIGNED3 FEINSourcesCnt;   
    DATASET(FEINLayoutSources) FEINSources;
    UNSIGNED3 YellowPageCnt;          //***among all of the Shell Shelf Sources - Yellow pages is 1 of them
    UNSIGNED3 BetterBusCnt;           //***among all of the Shell Shelf Sources - Better Business Bureau is 1 of them
    UNSIGNED3 UtilityCnt;             //***among all of the Shell Shelf Sources - Utilities is 1 of them
    UNSIGNED3 GongGovernmentCnt;      //***among all of the Shell Shelf Sources - Gong Government is 1 of them
    UNSIGNED3 GongBusinessCnt;        //***among all of the Shell Shelf Sources - Gong Business is 1 of them  
    STRING2 CompanyIncorpState;
    DATASET(BusSourceLayout) sourcesReporting {MAXCOUNT(DueDiligence.Constants.MAX_BUREAUS)};
    DATASET(BusSourceLayout) bureauReporting {MAXCOUNT(DueDiligence.Constants.MAX_BUREAUS)};
    UNSIGNED4 dateVendorFirstReported;
    DATASET(LayoutAgent) namesAssocWithFein {MAXCOUNT(DueDiligence.Constants.MAX_ASSOCIATED_FEIN_NAMES)};
    DATASET(DD_CompanyNames) companyDBA {MAXCOUNT(DueDiligence.Constants.MAX_DBA_NAMES)};
    STRING parentCompanyName;
    UNSIGNED2   DIDlessBEOCount; 
    DATASET(RelatedParty) DIDlessExecs {MAXCOUNT(DueDiligence.Constants.MAX_EXECS)};												//populated in DueDiligence.getBusExecWithNoDID
	END;


	
	EXPORT Indv_Internal := Record
		UNSIGNED4 seq := 0;
		UNSIGNED4 historyDate;													//If all 9s will be todays date, otherwise cleaned input date (actual date value)
		UNSIGNED4 historyDateRaw;										    //cleaned date used to calc history date
		BOOLEAN inputAddressProvided;
		BOOLEAN fullInputAddressProvided;
    Indv_Input indvRawInput;
		Indv_Input indvCleanInput;
    GeographicRiskLayout; 
		UNSIGNED6 inquiredDID;
		RelatedParty individual;											  //populated in DueDiligence.getIndDID, DueDiligence.getIndBestData
		UNSIGNED4 numberOfSpouses;																							
		DATASET(SlimIndividual) spouses;																												//populated in DueDiligence.getIndRelatives
		DATASET(SlimIndividual) parents {MAXCOUNT(DueDiligence.Constants.MAX_PARENTS)}; 			  //populated in DueDiligence.getIndRelatives
		STRING2 indvType;                         		  //II = Inquired Individual, IS = Inquired Individual Spouse,  IP = Inquired Individual Parent, 
		
    DueDiligence.LayoutsAttributes.PersonAttributeValues;         //used in calc'ing attribute values in getIndKRI

    IndReportDetails;                               //Used to hold report data when we have access instead of multiple key calls
		PerAttributes;
    iesp.duediligencepersonreport.t_DDRPersonReport personReport;
	END;


	EXPORT Busn_Internal := Record
		UNSIGNED4	  seq := 0;
		UNSIGNED4	  historydate;
		BOOLEAN 		inputAddressProvided;
		BOOLEAN			fullInputAddressProvided;
		SET setUniquePowIDs;																            //populated in DueDiligence.getBusHeader 
		Busn_Input	busn_input;							 								            // This is the raw input as is
		Busn_Input  busn_info;          	   								            // This all of this information has been cleaned - address is either cleaned or best
		STRING2			relatedDegree;					 								            //IB = Inquired Bus, LB = Linked Bus, RB = Related Bus, IE = Inquired Bus Exec
		UNSIGNED2		linkBusCount;
		DATASET(Busn_Input) linkedBusinesses {MAXCOUNT(DueDiligence.Constants.MAX_LINKED_BUSINESSES)};	//populated in DueDiligence.getBusLinkedBus
		UNSIGNED2		execCount;                           
		DATASET(RelatedParty) execs        {MAXCOUNT(DueDiligence.Constants.MAX_EXECS)};												//populated in DueDiligence.getBusExec
    
    DueDiligence.LayoutsAttributes.BusinessAttributeValues;         //used in calc'ing attribute values in getBusKRI

		UNSIGNED4		filingDate;	
		BOOLEAN			sosFilingExists;												            //populated in DueDiligence.getBusSOSDetail
		STRING2			residentialAddr;												            //populated in DueDiligence.getBusAsInd
		UNSIGNED1		personNameSSN;													            //populated in DueDiligence.getBusAsInd
		UNSIGNED1		personAddrSSN;													            //populated in DueDiligence.getBusAsInd
		/*BusIndustryRisk*/
		SicNaicRiskLayout sicNaicRisk;											            //populated in DueDiligence.getBusSicNaic -- ATTRIBUTE AND OTHER LAYOUTS??
		UNSIGNED3		numOfSicNaic;
		DATASET(LayoutSICNAIC) sicNaicSources {MAXCOUNT(DueDiligence.Constants.MAX_SIC_NAIC)};		//populated in DueDiligence.getBusSicNaic, DueDiligence.getBusHeader, DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		UNSIGNED3		numOfRegAgents;
		DATASET(LayoutAgent) registeredAgents {MAXCOUNT(DueDiligence.Constants.MAX_REGISTERED_AGENTS)};		//populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		
		/* BusMatchLevel  */ 
		INTEGER2		weight;                                             //populated in -------------------------- 
		
		unsigned4   SOSLastReported;																								
		unsigned2 	CorpStateCount;													
		unsigned4	  BusnHdrDtLastSeen;										        	    //populated in DueDiligence.getBusHeader		
		STRING1     dwelltype := '';
		STRING1     hriskaddrflag := '';
		string5     FIPsCode;
		string2	    src := '';
		
		/*BusGeographicRisk*/
		GeographicRiskLayout;   
		
		string30  	ShellBusnIndvalues;
		unsigned1   ShellIndCount;
		boolean     ShelfBusn;
		BOOLEAN		  PotentialNIS;
		boolean     ExecSNNMatch;
	  /* Civil Offenses   */   
		CivilOffensesCounts  Business;

		BusAttributes;
		BusReportDetails;
    iesp.duediligencebusinessreport.t_DDRBusinessReport BusinessReport;
	END;

END;