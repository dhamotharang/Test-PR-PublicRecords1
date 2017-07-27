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
		UNSIGNED4 seq;
		UNSIGNED4 historyDateYYYYMMDD;
		Busn_Input business;
		Indv_Input individual;
	END;
	
	EXPORT RequestValidation := RECORD
		BOOLEAN validRequest;
		STRING errorMessage;
		Input;
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
		STRING11 BusAssetOwnVehicle_Flags       := 'XXXXXXXXXXX';
		
		STRING2  BusAccessToFundsProperty;
		STRING11 BusAccessToFundsProperty_Flags := 'XXXXXXXXXXX';
		
		STRING2  BusGeographicRisk;
		STRING11 BusGeographicRisk_Flags        := 'XXXXXXXXXXX';
		
		STRING2  BusValidityRisk;
		STRING11 BusValidityRisk_Flags          := '';	
		
		STRING2  BusStabilityRisk;
		STRING11 BusStabilityRisk_Flags        := 'XXXXXXXXXXX';	
		
		STRING2  BusIndustryRisk;
		STRING11 BusIndustryRisk_Flags         := 'XXXXXXXXXXX';
		
		STRING2  BusStructureType;
		STRING11 BusStructureType_Flags        := 'XXXXXXXXXXX';
		
		STRING2  BusSOSAgeRange;
		STRING11 BusSOSAgeRange_Flags          := ' ';
		
		STRING2  BusPublicRecordAgeRange;
		STRING11 BusPublicRecordAgeRange_Flags := '';
		
		STRING30 BusShellShelfRisk;
		STRING11 BusShellShelfRisk_Flags       := 'XXXXXXXXXXX';
		
		STRING2  BusMatchLevel;
		STRING11 BusMatchLevel_Flags           := 'XXXXXXXXXXX';
		
		STRING2  BusLegalEvents;
		STRING11 BusLegalEvents_Flags          := 'XXXXXXXXXXX';
		
		STRING2  BusLegalEventsFelonyType;
		STRING11 BusLegalEventsFelonyType_Flags := 'XXXXXXXXXXX';
		
		STRING4  BusHighRiskNewsProfiles;
		STRING12 BusHighRiskNewsProfiles_Flags := 'XXXXXXXXXXXX';
		
		STRING2  BusLinkedBusRisk; 
		STRING11 BusLinkedBusRisk_Flags        := 'XXXXXXXXXXX';
		
		STRING2  BusExecOfficersRisk;
		STRING11 BusExecOfficersRisk_Flags     := 'XXXXXXXXXXX';
		
		STRING2  BusExecOfficersResidencyRisk;
		STRING11 BusExecOfficersResidencyRisk_Flags := 'XXXXXXXXXXX';
	END;


	EXPORT AssocIndexLayout  := RECORD
		unsigned4 seq;
		unsigned6 did;
		unsigned6 CLAMdid;
		boolean isrelat;
		unsigned3 RelIndCitizenshipIndex5Count  := 0;
		unsigned3 RelIndCitizenshipIndex6Count  := 0;
		unsigned3 RelIndCitizenshipIndex7Count  := 0;
		unsigned3 RelIndCitizenshipIndex8Count  := 0;
		unsigned3 RelIndCitizenshipIndex9Count  := 0;
		unsigned3 RelIndMobilityIndex5Count  := 0;
		unsigned3 RelIndMobilityIndex6Count  := 0;
		unsigned3 RelIndMobilityIndex7Count  := 0;
		unsigned3 RelIndMobilityIndex8Count  := 0;
		unsigned3 RelIndMobilityIndex9Count  := 0;
		unsigned3 RelIndLegalEventsIndex5Count  := 0;
		unsigned3 RelIndLegalEventsIndex6Count  := 0;
		unsigned3 RelIndLegalEventsIndex7Count  := 0;
		unsigned3 RelIndLegalEventsIndex8Count  := 0;
		unsigned3 RelIndLegalEventsIndex9Count  := 0;
		unsigned3 RelIndAccesstoFundsIndex5Count  := 0;
		unsigned3 RelIndAccesstoFundsIndex6Count  := 0;
		unsigned3 RelIndAccesstoFundsIndex7Count  := 0;
		unsigned3 RelIndAccesstoFundsIndex8Count  := 0;
		unsigned3 RelIndAccesstoFundsIndex9Count  := 0;
		unsigned3 RelIndBusAssocIndex5Count  := 0;
		unsigned3 RelIndBusAssocIndex6Count  := 0;
		unsigned3 RelIndBusAssocIndex7Count  := 0;
		unsigned3 RelIndBusAssocIndex8Count  := 0;
		unsigned3 RelIndBusAssocIndex9Count  := 0;
		unsigned3 RelIndHighValAssetsIndex5Count  := 0;
		unsigned3 RelIndHighValAssetsIndex6Count  := 0;
		unsigned3 RelIndHighValAssetsIndex7Count  := 0;
		unsigned3 RelIndHighValAssetsIndex8Count  := 0;
		unsigned3 RelIndHighValAssetsIndex9Count  := 0;
		unsigned3 RelIndGeogIndex5Count  := 0;
		unsigned3 RelIndGeogIndex6Count  := 0;
		unsigned3 RelIndGeogIndex7Count  := 0;
		unsigned3 RelIndGeogIndex8Count  := 0;
		unsigned3 RelIndGeogIndex9Count  := 0;
		unsigned3 RelIndAssocIndex  := 0;
		unsigned3 RelIndAgeIndex5Count  := 0;
		unsigned3 RelIndAgeIndex6Count  := 0;
		unsigned3 RelIndAgeIndex7Count  := 0;
		unsigned3 RelIndAgeIndex8Count  := 0;
		unsigned3 RelIndAgeIndex9Count  := 0;
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
		unsigned2   Watercraftlength;                       //populated in DueDiligence.getBusWatercraft 
		/* BusAssetOwnAircraft */
		unsigned2 	AircraftCount;                          //populated in DueDiligence.getBusAircraft 
		/* BusSOSAgeRange      */  
		unsigned4   SOSIncorporationDate;										//populated in DueDiligence.getBusSOSDetail
		/* BusPublicRecordAgeRange */ 	
		unsigned4 	BusnHdrDtFirstSeen;											//populated in DueDiligence.getBusHeader
		
		
		string2   	LastCorpStatus;													//populated in DueDiligence.getBusSOSDetail
		boolean   	NoSOSFilingEver;												//populated in DueDiligence.getBusSOSDetail
		unsigned4   SOSLastReported;												//populated in DueDiligence.getBusSOSDetail
		unsigned4   lastReinstatDate;												//populated in DueDiligence.getBusSOSDetail
		unsigned4   lastDissolvedDate;											//populated in DueDiligence.getBusSOSDetail
		boolean   	BusnNameChangeSOS;											//populated in DueDiligence.getBusSOSDetail
		boolean   	contactChangeSOS;												//populated in DueDiligence.getBusSOSDetail  -- Need to do yet
		boolean   	addressChangeSOS;												//populated in DueDiligence.getBusSOSDetail  -- Need to do yet
		unsigned2 	SOSAddrLocationCount;										//populated in DueDiligence.getBusSOSDetail
		unsigned2 	CorpStateCount;													//populated in DueDiligence.getBusSOSDetail
		
		unsigned3 	srcCount := 0;													//populated in DueDiligence.getBusHeader
		unsigned2 	CreditSrcCnt := 0;											//populated in DueDiligence.getBusHeader
		unsigned2 	ShellHdrSrcCnt := 0;										//populated in DueDiligence.getBusHeader
		unsigned4 	BusnHdrDtFirstNonCredit;								//populated in DueDiligence.getBusHeader  -- Need to do yet
		unsigned4	  BusnHdrDtLastSeen;											//populated in DueDiligence.getBusHeader
		integer8 	  FirstSeenInputAddr;											//populated in DueDiligence.getBusHeader  -- Need to do yet
		unsigned2 	HDAddrCount;														//populated in DueDiligence.getBusHeader  
		unsigned2 	HDStateCount;														//populated in DueDiligence.getBusHeader  
		
		STRING1     dwelltype := '';
		STRING1     hriskaddrflag := '';
		string5     FIPsCode;
		string9   	fein := '';
		string10  	phone10 := '';
		string2	    src := '';
		

		
		string4   	HRBusnSIC;
		string4   	HRBusnYPNAICS;
		string5     IndustryNAICS;
		string4   	BusnRisklevel;
		STRING60    busnType;
		boolean     NoFein;
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
		boolean     BusRegHit := false;
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
		string120		bestCompanyName	         := '';
		UNSIGNED1 	bestCompanyNamescore     := 0;
		string50		bestAddr			           := '';
		string25		bestCity			           := '';
		string2			bestState			           := '';
		string5			bestZip			             := '';
		string4			bestZip4			           := '';
		unsigned1		bestAddrScore		         := 0;
		string9			bestFEIN			           := '';
		unsigned1		bestFEINScore		         := 0;
		string10		bestPhone			           := '';
		unsigned1		bestPhoneScore		       := 0;
		BusAttributes_KRI;
	END;

	EXPORT BatchInLayout  := RECORD
		unsigned4 seq;
		string30  acctNo;
		string15  custType;
		STRING15 lexID;
		string120 companyName;
		string120 altCompanyName;
		string11  taxID;
		STRING20 firstName;
		STRING20 middleName;
		STRING20 lastName;
		STRING5 suffix;
		STRING9   ssn;
		STRING8   dob;

		STRING120 streetAddress1;
		STRING120 streetAddress2;
		STRING25  city;
		STRING2   state;
		STRING5   zip5;
		STRING10  phone;
		unsigned4	HistoryDateYYYYMMDD;
	END;

	EXPORT BatchOut := RECORD
		STRING30 AcctNo;
		STRING15 IndLexID;
		STRING25 IndAssetOwnProperty;
		STRING35 IndAssetOwnProperty_Flags;
		STRING25 IndAssetOwnAircraft;
		STRING35 IndAssetOwnAircraft_Flags;
		STRING30 IndAssetOwnWatercraft;
		STRING35 IndAssetOwnWatercraft_Flags;
		STRING25 IndAssetOwnVehicle;
		STRING35 IndAssetOwnVehicle_Flags;
		STRING30 IndAccessToFundsIncome;
		STRING35 IndAccessToFundsIncome_Flags;
		STRING30 IndAccessToFundsProperty;
		STRING40 IndAccessToFundsProperty_Flags;
		STRING25 IndGeographicRisk;
		STRING30 IndGeographicRisk_Flags;
		STRING20 IndMobility;
		STRING25 IndMobility_Flags;
		STRING20 IndLegalEvents;
		STRING30 IndLegalEvents_Flags;
		STRING30 IndLegalEventsFelonyType;
		STRING40 IndLegalEventsFelonyType_Flags;
		STRING30 IndHighRiskNewsProfiles;
		STRING40 IndHighRiskNewsProfiles_Flags;
		STRING20 IndAgeRange;
		STRING25 IndAgeRange_Flags;
		STRING20 IndIdentityRisk;
		STRING30 IndIdentityRisk_Flags;
		STRING25 IndResidencyRisk;
		STRING30 IndResidencyRisk_Flags;
		STRING20 IndMatchLevel;
		STRING30 IndMatchLevel_Flags;
		STRING25 IndAssociatesRisk;
		STRING30 IndAssociatesRisk_Flags;
		STRING25 IndProfessionalRisk;
		STRING35 IndProfessionalRisk_Flags;
		 
		STRING15 BusLexID;
		STRING25 BusAssetOwnProperty;
		STRING35 BusAssetOwnProperty_Flags;
		STRING25 BusAssetOwnAircraft;
		STRING35 BusAssetOwnAircraft_Flags;
		STRING30 BusAssetOwnWatercraft;
		STRING35 BusAssetOwnWatercraft_Flags;
		STRING25 BusAssetOwnVehicle;
		STRING35 BusAssetOwnVehicle_Flags;
		STRING30 BusAccessToFundsProperty;
		STRING40 BusAccessToFundsProperty_Flags;
		STRING25 BusGeographicRisk;
		STRING30 BusGeographicRisk_Flags;
		STRING20 BusValidityRisk;
		STRING30 BusValidityRisk_Flags;
		STRING25 BusStabilityRisk;
		STRING30 BusStabilityRisk_Flags;
		STRING20 BusIndustryRisk;
		STRING30 BusIndustryRisk_Flags;
		STRING25 BusStructureType;
		STRING20 BusStructureType_Flags;
		STRING20 BusSOSAgeRange;
		STRING30 BusSOSAgeRange_Flags;
		STRING30 BusPublicRecordAgeRange;
		STRING40 BusPublicRecordAgeRange_Flags;
		STRING25 BusShellShelfRisk;
		STRING30 BusShellShelfRisk_Flags;
		STRING20 BusMatchLevel;
		STRING30 BusMatchLevel_Flags;
		STRING20 BusLegalEvents;
		STRING30 BusLegalEvents_Flags;
		STRING30 BusLegalEventsFelonyType;
		STRING40 BusLegalEventsFelonyType_Flags;
		STRING30 BusHighRiskNewsProfiles;
		STRING40 BusHighRiskNewsProfiles_Flags;
		STRING25 BusLinkedBusRisk;
		STRING30 BusLinkedBusRisk_Flags;
		STRING25 BusExecOfficersRisk;
		STRING35 BusExecOfficersRisk_Flags;
		STRING35 BusExecOfficersResidencyRisk;
		STRING45 BusExecOfficersResidencyRisk_Flags;
	END;
END;