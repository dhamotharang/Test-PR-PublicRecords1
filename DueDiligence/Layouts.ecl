﻿IMPORT iesp, SALT28;

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
		UNSIGNED4 Seq       := 0;
		BOOLEAN BIPIDSourceInput;                       // Indicates if the BIP IDs were returned from the append process or input
		LinkIDs PowID;
		LinkIDs ProxID;
		LinkIDs SeleID;
		LinkIDs OrgID;
		LinkIDs UltID;
	END;

	EXPORT Address := RECORD
		STRING   streetAddress1;
		STRING   streetAddress2;
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
		STRING4  cart;	
		STRING1  cr_sort_sz;
		STRING4  lot;	
		STRING1  lot_order;
		STRING2  dbpc; 	
		STRING1  chk_digit; 
		STRING2  rec_type;
		STRING5  county;
		STRING10 geo_lat;
		STRING11 geo_long;
		STRING4  msa; 	
		string7  geo_blk;
		STRING1  geo_match;
		STRING4  err_stat;	
	END;

	EXPORT Name := RECORD
		STRING120 fullName;
		STRING20 firstName;
		STRING20 middleName;
		STRING20 lastName;
		STRING5 suffix;	
	END;

	EXPORT Busn_Input := RECORD
		LinkID_Results BIP_IDs;
		STRING lexID;
		STRING30 accountNumber;
		STRING companyName;
		STRING altCompanyName;
		Address address;
		STRING phone;
		STRING fein;
	END;

	EXPORT Indv_Input := RECORD
		STRING lexID;
		STRING30 accountNumber;
		Name name;
		Address address;
		STRING phone;
		STRING ssn;
	END;


	EXPORT Input := RECORD
		BOOLEAN validRequest;
		STRING errorMessage;
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

	EXPORT IndAttributes := RECORD
		UNSIGNED6 IndLexID;
		
		STRING2 IndAssetOwnProperty;
		STRING10 IndAssetOwnProperty_Flags;
		
		STRING2 IndAssetOwnAircraft;
		STRING10 IndAssetOwnAircraft_Flags;
		
		STRING2 IndAssetOwnWatercraft;
		STRING10 IndAssetOwnWatercraft_Flags;
		
		STRING2 IndAssetOwnVehicle;
		STRING10 IndAssetOwnVehicle_Flags;
		
		STRING2 IndAccessToFundsIncome;
		STRING10 IndAccessToFundsIncome_Flags;
		
		STRING2 IndAccessToFundsProperty;
		STRING10 IndAccessToFundsProperty_Flags;
		
		STRING2 IndGeographicRisk;
		STRING10 IndGeographicRisk_Flags;
		
		STRING2 IndMobility;
		STRING10 IndMobility_Flags;
		
		STRING2 IndLegalEvents;
		STRING10 IndLegalEvents_Flags;
		
		STRING2 IndLegalEventsFelonyType;
		STRING10 IndLegalEventsFelonyType_Flags;
		
		STRING4 IndHighRiskNewsProfiles;
		STRING10 IndHighRiskNewsProfiles_Flags;
		
		STRING2 IndAgeRange;
		STRING10 IndAgeRange_Flags;
		
		STRING2 IndIdentityRisk;
		STRING10 IndIdentityRisk_Flags;
		
		STRING2 IndResidencyRisk;
		STRING10 IndResidencyRisk_Flags;
		
		STRING2 IndMatchLevel;
		STRING10 IndMatchLevel_Flags;
		
		STRING2 IndAssociatesRisk;
		STRING10 IndAssociatesRisk_Flags;
		
		STRING2 IndProfessionalRisk;
		STRING10 IndProfessionalRisk_Flags;
	END;

	//------These are the customer facing attributes for this product ------
	EXPORT BusAttributes_KRI := RECORD
		UNSIGNED6 BusLexID;
		
		STRING2   BusAssetOwnProperty;                             // This is an index of -1 through 9 based on the information obtained for the attribute
		STRING10  BusAssetOwnProperty_Flags     := ' ';              // 'TFFFFFFFFF'    This is a series of True False flags indicating which portion of the MAP statements were TRUE while setting the index
		
		STRING2   BusAssetOwnAircraft;
		STRING10  BusAssetOwnAircraft_Flags     := ' ';  
		
		STRING2   BusAssetOwnWatercraft;
		STRING10  BusAssetOwnWatercraft_Flags   := ' ';               
		
		STRING2  BusAssetOwnVehicle;
		STRING10 BusAssetOwnVehicle_Flags       := ' ';
		
		STRING2  BusAccessToFundsProperty;
		STRING10 BusAccessToFundsProperty_Flags := 'XXXXXXXXXXX';
		
		STRING2  BusGeographicRisk;
		STRING10 BusGeographicRisk_Flags        := 'XXXXXXXXXXX';
		
		STRING2  BusValidityRisk;
		STRING10 BusValidityRisk_Flags;	
		
		STRING2  BusStabilityRisk;
		STRING10 BusStabilityRisk_Flags        := 'XXXXXXXXXXX';	
		
		STRING2  BusIndustryRisk;
		STRING10 BusIndustryRisk_Flags         := 'XXXXXXXXXXX';
		
		STRING2  BusStructureType;
		STRING10 BusStructureType_Flags;
		
		STRING2  BusSOSAgeRange;
		STRING10 BusSOSAgeRange_Flags;
		
		STRING2  BusPublicRecordAgeRange;
		STRING10 BusPublicRecordAgeRange_Flags;
		
		STRING30 BusShellShelfRisk;
		STRING10 BusShellShelfRisk_Flags       := 'XXXXXXXXXXX';
		
		STRING2  BusMatchLevel;
		STRING10 BusMatchLevel_Flags           := 'XXXXXXXXXXX';
		
		STRING2  BusLegalEvents;
		STRING10 BusLegalEvents_Flags          := 'XXXXXXXXXXX';
		
		STRING2  BusLegalEventsFelonyType;
		STRING10 BusLegalEventsFelonyType_Flags := 'XXXXXXXXXXX';
		
		STRING4  BusHighRiskNewsProfiles;
		STRING10 BusHighRiskNewsProfiles_Flags := 'XXXXXXXXXXXX';
		
		STRING2  BusLinkedBusRisk; 
		STRING10 BusLinkedBusRisk_Flags        := 'XXXXXXXXXXX';
		
		STRING2  BusExecOfficersRisk;
		STRING10 BusExecOfficersRisk_Flags     := 'XXXXXXXXXXX';
		
		STRING2  BusExecOfficersResidencyRisk;
		STRING10 BusExecOfficersResidencyRisk_Flags := 'XXXXXXXXXXX';
	END;


	
	EXPORT Indv_Internal := Record
		unsigned4	  seq := 0;
		UNSIGNED4	  historydate;
		Indv_Input  indv_info; 
		IndAttributes;
	END;

	EXPORT BatchInLayout  := RECORD
		unsigned4 seq;
		string30  acctNo;
		string15  custType;
		STRING15 	lexID;
		string120 companyName;
		string120 altCompanyName;
		string11  taxID;
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
		unsigned4	HistoryDateYYYYMMDD;
	END;

	EXPORT BatchOut := RECORD
		STRING30 AcctNo;
		STRING15 IndLexID;
		STRING2 IndAssetOwnProperty;
		STRING10 IndAssetOwnProperty_Flags;
		STRING2 IndAssetOwnAircraft;
		STRING10 IndAssetOwnAircraft_Flags;
		STRING2 IndAssetOwnWatercraft;
		STRING10 IndAssetOwnWatercraft_Flags;
		STRING2 IndAssetOwnVehicle;
		STRING10 IndAssetOwnVehicle_Flags;
		STRING2 IndAccessToFundsIncome;
		STRING10 IndAccessToFundsIncome_Flags;
		STRING2 IndAccessToFundsProperty;
		STRING10 IndAccessToFundsProperty_Flags;
		STRING2 IndGeographicRisk;
		STRING10 IndGeographicRisk_Flags;
		STRING2 IndMobility;
		STRING10 IndMobility_Flags;
		STRING2 IndLegalEvents;
		STRING10 IndLegalEvents_Flags;
		STRING2 IndLegalEventsFelonyType;
		STRING10 IndLegalEventsFelonyType_Flags;
		STRING2 IndHighRiskNewsProfiles;
		STRING10 IndHighRiskNewsProfiles_Flags;
		STRING2 IndAgeRange;
		STRING10 IndAgeRange_Flags;
		STRING2 IndIdentityRisk;
		STRING10 IndIdentityRisk_Flags;
		STRING2 IndResidencyRisk;
		STRING10 IndResidencyRisk_Flags;
		STRING2 IndMatchLevel;
		STRING10 IndMatchLevel_Flags;
		STRING2 IndAssociatesRisk;
		STRING10 IndAssociatesRisk_Flags;
		STRING2 IndProfessionalRisk;
		STRING10 IndProfessionalRisk_Flags;
		 
		STRING15 BusLexID;
		STRING2 BusAssetOwnProperty;
		STRING10 BusAssetOwnProperty_Flags;
		STRING2 BusAssetOwnAircraft;
		STRING10 BusAssetOwnAircraft_Flags;
		STRING2 BusAssetOwnWatercraft;
		STRING10 BusAssetOwnWatercraft_Flags;
		STRING2 BusAssetOwnVehicle;
		STRING10 BusAssetOwnVehicle_Flags;
		STRING2 BusAccessToFundsProperty;
		STRING10 BusAccessToFundsProperty_Flags;
		STRING2 BusGeographicRisk;
		STRING10 BusGeographicRisk_Flags;
		STRING2 BusValidityRisk;
		STRING10 BusValidityRisk_Flags;
		STRING2 BusStabilityRisk;
		STRING10 BusStabilityRisk_Flags;
		STRING2 BusIndustryRisk;
		STRING10 BusIndustryRisk_Flags;
		STRING2 BusStructureType;
		STRING10 BusStructureType_Flags;
		STRING2 BusSOSAgeRange;
		STRING10 BusSOSAgeRange_Flags;
		STRING2 BusPublicRecordAgeRange;
		STRING10 BusPublicRecordAgeRange_Flags;
		STRING2 BusShellShelfRisk;
		STRING10 BusShellShelfRisk_Flags;
		STRING2 BusMatchLevel;
		STRING10 BusMatchLevel_Flags;
		STRING2 BusLegalEvents;
		STRING10 BusLegalEvents_Flags;
		STRING2 BusLegalEventsFelonyType;
		STRING10 BusLegalEventsFelonyType_Flags;
		STRING2 BusHighRiskNewsProfiles;
		STRING10 BusHighRiskNewsProfiles_Flags;
		STRING2 BusLinkedBusRisk;
		STRING10 BusLinkedBusRisk_Flags;
		STRING2 BusExecOfficersRisk;
		STRING10 BusExecOfficersRisk_Flags;
		STRING2 BusExecOfficersResidencyRisk;
		STRING10 BusExecOfficersResidencyRisk_Flags;
	END;
	
	EXPORT LayoutSICNAIC := RECORD
		STRING2 Source;
		UNSIGNED4 DateFirstSeen;
		UNSIGNED4 DateLastSeen;
		UNSIGNED4 RecordCount;
		STRING10 SICCode;
		STRING5 SICIndustry;
		STRING7 SICRiskLevel;
		STRING10 NAICCode;
		STRING5 NAICIndustry;
		STRING7 NAICRiskLevel;
		BOOLEAN IsPrimary;
	END;
	
	EXPORT SicNaicRiskLayout := RECORD
		BOOLEAN cibExists;
		BOOLEAN msbExists;
		BOOLEAN nbfiExists;
		BOOLEAN cagExists;
		BOOLEAN legAcctTeleFlightTravExists;
		BOOLEAN autoExists;
		BOOLEAN otherHighRiskIndustExists;
		BOOLEAN moderateRiskIndustExists;
		BOOLEAN lowRiskIndustExists;
	END;

	
	EXPORT Busn_Internal := Record
		unsigned4	  seq := 0;
		UNSIGNED4	  historydate;
		Busn_Input  Busn_info;             // This all of this information has been cleaned.
		STRING2			relatedDegree;					 //IB = Inquired Bus, LB = Linked Bus, RB = Related Bus, IE = Inquired Bus Exec, 
		unsigned3 	LinkedBusncount := 0;
		unsigned3 	BusnRelatDegree := 0;  
		unsigned2 	score := 0;
		/* BusAssetOwnProperty */
		unsigned6 	PropTaxValue;                           //populated in DueDiligence.getBusProperty
		unsigned2 	CurrPropOwnedCount;                     //populated in DueDiligence.getBusProperty - do we need this?
		unsigned2 	CountSoldProp;                          //populated in DueDiligence.getBusProperty - do we need this?
		unsigned2 	CountOwnProp;                           //populated in DueDiligence.getBusProperty - 
		/* BusAssetOwnWatercraft */ 
		unsigned2 	WatercraftCount;                        //populated in DueDiligence.getBusWatercraft 
		unsigned2   Watercraftlength;                       //populated in DueDiligence.getBusWatercraft - this is the longest length boat found 
		/* BusAssetOwnAircraft */
		unsigned2 	AircraftCount;                          //populated in DueDiligence.getBusAircraft 
		/* BusAssetOwnVehicle */
		unsigned2 	VehicleCount;                           //populated in DueDiligence.getBusVehicle
		unsigned6   VehicleBaseValue;
		/*BusSOSAgeRange*/  
		unsigned4   SOSIncorporationDate;										//populated in DueDiligence.getBusSOSDetail
		/*BusPublicRecordAgeRange*/ 	
		unsigned4 	BusnHdrDtFirstSeen;											//populated in DueDiligence.getBusHeader
		
		
		string2   	LastCorpStatus;													
		/*BusSOSAgeRange*/
		boolean   	NoSOSFilingEver;												//populated in DueDiligence.getBusSOSDetail
		unsigned4		filingDate;
		unsigned4   SOSLastReported;												
		unsigned4   lastReinstatDate;												
		unsigned4   lastDissolvedDate;											
		boolean   	BusnNameChangeSOS;											
		boolean   	contactChangeSOS;												
		boolean   	addressChangeSOS;												
		/*BusValidityRisk*/
		unsigned2 	SOSAddrLocationCount;										//populated in DueDiligence.getBusSOSDetail
		unsigned2 	CorpStateCount;													
		/*BusPublicRecordAgeRange*/ 	
		unsigned3 	srcCount := 0;													//populated in DueDiligence.getBusHeader
		/*BusValidityRisk*/
		unsigned2 	CreditSrcCnt := 0;											//populated in DueDiligence.getBusHeader
		unsigned2 	ShellHdrSrcCnt := 0;										//populated in DueDiligence.getBusHeader
		unsigned4 	BusnHdrDtFirstNonCredit;								//populated in DueDiligence.getBusHeader
		unsigned4	  BusnHdrDtLastSeen;											//populated in DueDiligence.getBusHeader
		integer8 	  FirstSeenInputAddr;											//populated in DueDiligence.getBusHeader
		/*BusValidityRisk*/
		unsigned2 	HDAddrCount;														//populated in DueDiligence.getBusHeader  
		unsigned2 	HDStateCount;														//populated in DueDiligence.getBusHeader  
		
		STRING1     dwelltype := '';
		STRING1     hriskaddrflag := '';
		string5     FIPsCode;
		string9   	fein := '';
		string10  	phone10 := '';
		string2	    src := '';
		
		/*BusIndustryRisk*/
		SicNaicRiskLayout sicNaicRisk;											//populated in DueDiligence.getBusSicNaic
		DATASET(LayoutSICNAIC) SicNaicSources;							//populated in DueDiligence.getBusSicNaic, DueDiligence.getBusHeader, DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		
		/*BusStructureType*/
		STRING60    busnType;																//populated in DueDiligence.getBusHeader
		/*BusValidityRisk*/
		boolean     NoFein;																	//populated in DueDiligence.getBusAddrData
		string1   	AddressVacancyInd;
		string3	    EasiTotCrime;
		boolean     CountyBordersForgeinJur;
		boolean     CountyborderOceanForgJur;
		boolean     CityBorderStation;
		boolean     CityFerryCrossing;
		boolean     CityRailStation;
		boolean     HIDTA;
		boolean     HIFCA;
		boolean     HighFelonNeighborhood;
		boolean     HRBusPct;
		string30  	ShellBusnIndvalues;
		unsigned1   ShellIndCount;
		boolean     ShelfBusn;
		BOOLEAN		  PotentialNIS;
		boolean     RAShelfBusn;
		/*BusValidityRisk*/
		boolean     BusRegHit := false;										//populated in DueDiligence.getBusRegistration
		BOOLEAN		  RAPotentialNIS;
		boolean     HasCurrRA;
		boolean		  inc_st_loose;
		boolean		  storage;
		boolean		  priv_post;
		boolean		  undel_sec;
		boolean		  drop;
		boolean		  busAddrCntLooseIncorp;
		boolean		  BusAddrCntnoFein;
		BOOLEAN	    potential_remail;
		boolean     ExecSNNMatch;
		unsigned2		ExecLienscount	         := 0;
		unsigned2		ExecLienscount12	       := 0;
		unsigned2 	ExecFelonyCnt            := 0;
		unsigned2 	ExecFelony3yr            := 0;
		unsigned2 	ExecFelonyCnt3plus       := 0;
		unsigned2   ExecIncarceratedCnt      := 0;	
		unsigned2   ExecParoleCnt            := 0;	
		unsigned2   ExecEverIncarCnt         := 0;	
		unsigned2   ExecSOCnt                := 0;
		unsigned2   ExecnonfelonyCount;
		unsigned2   Execnonfelonycount12;
		unsigned2		UnreleasedLienCount      := 0;
		unsigned2		ReleasedLienCount	       := 0;
		unsigned2		UnreleasedLienCount12    := 0;
		unsigned2		ReleasedLienCount12	     := 0;
		unsigned2		LinkedBusnValidityCount	 := 0;	
		string120		bestCompanyName	         := '';										//populated in DueDiligence.getBusBIPId
		UNSIGNED1 	bestCompanyNamescore     := 0;
		string50		bestAddr			           := '';										//populated in DueDiligence.getBusBIPId
		string25		bestCity			           := '';										//populated in DueDiligence.getBusBIPId
		string2			bestState			           := '';										//populated in DueDiligence.getBusBIPId
		string5			bestZip			             := '';										//populated in DueDiligence.getBusBIPId
		string4			bestZip4			           := '';										//populated in DueDiligence.getBusBIPId
		unsigned1		bestAddrScore		         := 0;
		string9			bestFEIN			           := '';										//populated in DueDiligence.getBusBIPId
		unsigned1		bestFEINScore		         := 0;
		string10		bestPhone			           := '';										//populated in DueDiligence.getBusBIPId
		unsigned1		bestPhoneScore		       := 0;
		BusAttributes_KRI;
		iesp.duediligencereport.t_DDRBusinessReport BusinessReport;
	END;

END;