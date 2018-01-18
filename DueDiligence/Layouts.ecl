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
		STRING3  county;                               //Due Diligence is capturing the last 3 digits of the full 5 digit FIPS code. It uses the 3 digit code to access the Census Keys and the will build the 5 digit FIPS to determine HIFCA and HIDTA  
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
		STRING3 nameInputOrder;
		Name name;
		Address address;
		STRING phone;
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
		STRING10  BusAssetOwnProperty_Flags;              				 // 'TFFFFFFFFF'    This is a series of True False flags indicating which portion of the MAP statements were TRUE while setting the index
		
		STRING2   BusAssetOwnAircraft;
		STRING10  BusAssetOwnAircraft_Flags;  
		
		STRING2   BusAssetOwnWatercraft;
		STRING10  BusAssetOwnWatercraft_Flags;               
		
		STRING2  BusAssetOwnVehicle;
		STRING10 BusAssetOwnVehicle_Flags;
		
		STRING2  BusAccessToFundsProperty;
		STRING10 BusAccessToFundsProperty_Flags;
		
		STRING2  BusGeographicRisk;
		STRING10 BusGeographicRisk_Flags;
		
		STRING2  BusValidityRisk;
		STRING10 BusValidityRisk_Flags;	
		
		STRING2  BusStabilityRisk;
		STRING10 BusStabilityRisk_Flags;	
		
		STRING2  BusIndustryRisk;
		STRING10 BusIndustryRisk_Flags;
		
		STRING2  BusStructureType;
		STRING10 BusStructureType_Flags;
		
		STRING2  BusSOSAgeRange;
		STRING10 BusSOSAgeRange_Flags;
		
		STRING2  BusPublicRecordAgeRange;
		STRING10 BusPublicRecordAgeRange_Flags;
		
		STRING2  BusShellShelfRisk;
		STRING10 BusShellShelfRisk_Flags;
		
		STRING2  BusMatchLevel;
		STRING10 BusMatchLevel_Flags;
		
		STRING2  BusLegalCriminal;
		STRING10 BusLegalCriminal_Flags;
		
		STRING2  BusLegalCivil;
		STRING10 BusLegalCivil_Flags;
		
		STRING2  BusLegalTraffInfr;
		STRING10 BusLegalTraffInfr_Flags;
		
		STRING2  BusLegalEventsFelonyType;
		STRING10 BusLegalEventsFelonyType_Flags;
		
		STRING2  BusHighRiskNewsProfiles;
		STRING10 BusHighRiskNewsProfiles_Flags;
		
		STRING2  BusLinkedBusRisk; 
		STRING10 BusLinkedBusRisk_Flags;
		
		STRING2  BusExecOfficersRisk;
		STRING10 BusExecOfficersRisk_Flags;
		
		STRING2  BusExecOfficersResidencyRisk;
		STRING10 BusExecOfficersResidencyRisk_Flags;
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

//***Coordinate these changes witht the batch team ***//
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
		UNSIGNED4 DateFirstSeen;
		UNSIGNED4 DateLastSeen;
		STRING10 SICCode;
		STRING5 SICIndustry;
		STRING7 SICRiskLevel;
		STRING10 NAICCode;
		STRING5 NAICIndustry;
		STRING7 NAICRiskLevel;
		BOOLEAN IsPrimary;
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


 //---                                                                          ---
 //--- This is all of the criminal data we have for each DID and each offense   ---
 //--- So there are multiple rows for each DID.                                 ---
 //--- data collected came from key-offenders, key-offenses, offenders-risk-key ---
 //--- and key-punishments                                                      ---
 //---                                                                          ---
	EXPORT CriminalOffenseLayout_by_DIDOffense  := RECORD
		unsigned4	seq := 0;
		UNSIGNED6 DID;
		string60 	offender_key;               // offenders key
		unsigned6 origdid;
		unsigned4 historydate;
		unsigned4 ToDaysDate;   
		UNSIGNED4 DateToUse; 
		UNSIGNED3 NumOfDaysAgo;  
		string8 	file_date;
		string8   earliestOffenseDate;         // in order to calculate how old this date is I need to send we clean it before using it.
		string8   untouchedearliestOffenseDate;  // if we need to show this in the report it should be the uncleaned date. 
		/* data from the offender_risk_ key */    // A summary of offenses for this offender_key
		/* data about the offense */ 
		string1   dataType;                    // ***new 2 = Criminal court 
		string1   convictionFlag;              // ***new
		string1   trafficFlag;                 // ***new
		string1   untouchedOffenseScore;
		string1   offenseScore;                // values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
		string1   criminalOffenderLevel;       // values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
		string5   courtOffenseLevel;           // values are documented in a spreadsheet.  
		string20  courtStatute;                // offenders risk key - offense.court_statute
		string70  courtStatuteDesc;            // offenders risk key - offense.court_statute_desc
		string35 	caseNum;                     // offenders risk key
		string20  caseCourt;                   // offenders risk key
		string20  caseTypeDesc;                // ***???
		string20  courtType;                   // offenders risk key - source_file
		string75  charge;                      // offenders risk key - offense.court_off_desc_1
		string40  courtDispDesc1;              // offender_risk_ key
		string40  courtDispDesc2;              // offender_risk_ key
		string8   offenseDate;                 // offender_risk_ key
		string8   arrestDate;                  // offender_risk_ key
		string8   courtDispDate;               // offender_risk_ key
		string8   sentenceDate;                // offender_risk_ key
		string8   appealDate;                  // offender_risk_ key
		string30  countyOfOrigin;              // offender_risk_ key
		string2   origState;                   // offender_risk_ key
		string30  stc_desc_2;                  // offenses key
		string35  arr_off_lev_mapped;          // Court_Offenses key
		string35  court_off_lev_mapped;        // Court_Offenses key
		string1   punishment_type;             // punishment key
		/*  To determine whether any of these 3 condition are CURRENTLY TRUE - Use logic similar to the VOO function */
		string1   Curr_incarc_offenders;        // pulled from key_ offenders
		string1   Curr_incarc_offenses;         // pulled from key_ offenses
		string1   Curr_incarc_punishments;      // pulled from key_ punishment
		/*  To determine whether any of these 3 conditions were EVER TRUE - follow the code in getIndCriminal */
		string1   Ever_incarc_offenders;       // pulled from key_ offenders
		string1   Ever_incarc_offenses;        // pulled from key_ offenses
		string1   Ever_incarc_punishments;     // pulled from key_ punishment
		/*  To determine whether any of these conditions are CURRENTLY TRUE */ 
  string1 	 curr_parole_flag;            // pulled from the offenders key
  string1 	 curr_parole_punishments;     // pulled from the key_ punishment
	 string20  curr_stat_inm;               // pulled from the punishment key
	END;
	
 //---                                                                          ---
 //--- These counts are all of the data we have for each offense but it is      ---
 //--- rolled up to a single DID                                                ---
 //---                                                                          ---
	EXPORT TrafficOffensesCounts := RECORD                            
	 /* CONVICTED TRAFFIC VIOLATIONS */ 
		unsigned2   ConvictedTraffic2T_OVNYR;                           //*** Convicted Traffic Violations over 3 years
		unsigned2   ConvictedTraffic2T_NYR;                             //*** Convicted Traffic Violations in the past 3 years
		unsigned2   ConvictedTraffic2T_Ever;                            //*** Convicted Traffic Violations EVER
	/*  CONVICTED INFRACTIONS VIOLATIONS */    
		unsigned2   ConvictedInfractions2I_OVNYR;                       //*** Convicted Infractions over 3 years
		unsigned2   ConvictedInfractions2I_NYR;                         //*** Convicted Infractions in the past 3 years
		unsigned2   ConvictedInfractions2I_Ever;                        //*** Convicted Infractions EVER
  END;  
	
	EXPORT CivilOffensesCounts := RECORD                               
	/* LIENS and JUDGMENTS and EVICTIONS */  
		unsigned2   liensUnreleasedCntOVNYR;                            //*** liens unreleased over 3 years
		unsigned2   liensUnreleasedCntInThePastNYR;                     //*** liens unreleased in the past 3 years
		unsigned2   liensUnreleasedCnt;                                 //*** liens unreleased EVER
		
		unsigned2   evictionsCntOVNYR;                                  //*** evictions over 3 years ago
		unsigned2   evictionsCntInThePastNYR;                           //*** evcitions in the past 3 years
		unsigned2   evictionsCnt;                                       //*** evictions EVER
	END;  
	
	EXPORT CriminalOffensesCounts := RECORD                            
	/* CONVICTED NON-TRAFFIC VIOLATIONS */  
		unsigned2   ConvictedFelonyCount4F_OVNYR;                          //*** Convicted Felony counts over 3 years ago 
		unsigned2   ConvictedFelonyCount4F_NYR;                          //*** Convicted Felony counts in past 3 years
		unsigned2   ConvictedFelonyCount4F_Ever;                         //*** Convicted Felony counts EVER
		
		unsigned2   ConvictedUnknownCount4U_OVNYR;                         //*** Convicted Unknown counts over 3 years ago
		unsigned2   ConvictedUnknownCount4U_NYR;                         //*** Convicted Unknown counts in past 3 years
		unsigned2   ConvictedUnknownCount4U_Ever;                        //*** Convicted Unknown counts EVER
		
		unsigned2   ConvictedMisdemeanorCount4M_OVNYR;                     //*** Convicted Misdemeanor counts over 3 years ago 
		unsigned2   ConvictedMisdemeanorCount4M_NYR;                     //*** Convicted Misdemeanor counts in past 3 years
		unsigned2   ConvictedMisdemeanorCount4M_Ever;                    //*** Convicted Misdemeanor counts EVER
		
		/* NON-CONVICTED NON-TRAFFIC VIOLATIONS */ 
		unsigned2   NonConvictedFelonyCount3F_OVNYR;                       //*** Non-Convicted Felony counts over 3 years ago
		unsigned2   NonConvictedFelonyCount3F_NYR;                       //*** Non-Convicted Felony counts in past 3 years
		unsigned2   NonConvictedFelonyCount3F_EVER;                        //*** Non-Convicted Felony count EVER
		
		unsigned2   NonConvictedUnknownCount3U_OVNYR;                      //*** Non-Convicted Unknown counts over 3 years ago
		unsigned2   NonConvictedUnknownCount3U_NYR;                      //*** Non-Convicted Unknown counts in past N# of years
		unsigned2   NonConvictedUnknownCount3U_EVER;                     //*** Non-Convicted Unknown counts EVER
		
		unsigned2   NonConvictedMisdemeanorCount3M_OVNYR;                  //*** Non-Convicted Misdemeanor counts over 3 years ago
		unsigned2   NonConvictedMisdemeanorCount3M_NYR;                  //*** Non-Convicted Misdemeanor counts in past N# of years
		unsigned2   NonConvictedMisdemeanorCount3M_EVER;                   //*** Non-Convicted Misdemeanor count EVER
	END;   
	
	EXPORT IncarcaratedParoleFlags := RECORD                           
    /* Incarcarated and Parole Evidence of */    
		BOOLEAN     EverIncarcer;                                       //*** Ever incarcerated
		BOOLEAN     CurrIncarcer;                                       //*** Currently incarcerated  
		BOOLEAN     CurrParole;                                         //*** Currently on Parole	
	END;
  
	
	 EXPORT DerogatoryEvents := RECORD 
	  /* Incarcarated and Parole counts */    
		 IncarcaratedParoleFlags; 
	  CivilOffensesCounts;  
		 CriminalOffensesCounts;
		 TrafficOffensesCounts;  
		/* TOTAL OF ALL OFFENSES  */  
		unsigned2   ALLOffensesForThisDID;                            //*** All Criminal Offenses EVER.
 END;
	
	
	EXPORT Positions := RECORD
		UNSIGNED4 firstSeen;
		UNSIGNED4 lastSeen;
		STRING title;
	END;
	
	EXPORT Licenses := RECORD
		STRING30 licenseNumber;
		UNSIGNED6 dateFirstSeen;
		UNSIGNED6 dateLastSeen;
		UNSIGNED6 issueDate;
		UNSIGNED6 expirationDate;
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
	
	
	EXPORT RelatedParty := RECORD
		UNSIGNED6 did;
		STRING9 ssn;
		Name;
		Address;
		DerogatoryEvents;                           //***these are rolled upto the DID 
		UNSIGNED3 numOfPositions;
		DATASET(Positions) positions; //{MAXCOUNT(DueDiligence.Constants.MAX_POSITIONS)};
		UNSIGNED3 numOfLicenses;
		DATASET(Licenses) licenses; //{MAXCOUNT(DueDiligence.Constants.MAX_LICENSES)};
		DATASET(CriminalOffenseLayout_by_DIDOffense) partyOffenses;    //***these are listed at the offense level for each DID
	END;

	
	EXPORT LayoutAgent := RECORD
		UNSIGNED4 dateFirstSeen;
		UNSIGNED4 dateLastSeen;
		STRING4 source;
		Name;
		Address;
	END;
	
	EXPORT Indv_Internal := Record
		unsigned4	  seq := 0;
		UNSIGNED4	  historydate;
		RelatedParty individual;
		Indv_Input  indv_info;
		STRING2			indv_type;                         //II = Inquired Individual, IS = Inquired Individual Spouse, 
		IndAttributes;
	END;


	EXPORT Busn_Internal := Record
		UNSIGNED4	  seq := 0;
		UNSIGNED4	  historydate;
		BOOLEAN 		inputAddressProvided;
		BOOLEAN			fullInputAddressProvided;
		SET setUniquePowIDs;																        //populated in DueDiligence.getBusHeader 
		Busn_Input	busn_input;							 								      // This is the raw input as is
		Busn_Input  busn_info;          	   								// This all of this information has been cleaned - address is either cleaned or best
		STRING2			relatedDegree;					 								      //IB = Inquired Bus, LB = Linked Bus, RB = Related Bus, IE = Inquired Bus Exec
		UNSIGNED2		linkBusCount;
		DATASET(Busn_Input) linkedBusinesses {MAXCOUNT(DueDiligence.Constants.MAX_LINKED_BUSINESSES)};	//populated in DueDiligence.getBusLinkedBus
		DATASET(RelatedParty) execs {MAXCOUNT(DueDiligence.Constants.MAX_EXECS)};												//populated in DueDiligence.getBusExec
		/* BusAssetOwnProperty */
		unsigned6 	PropTaxValue;                           //populated in DueDiligence.getBusProperty
		unsigned2 	CurrPropOwnedCount;                     //populated in DueDiligence.getBusProperty - do we need this?
		unsigned2 	CountSoldProp;                          //populated in DueDiligence.getBusProperty - do we need this?
		unsigned2 	CountOwnProp;                           //populated in DueDiligence.getBusProperty - 
		/* BusAssetOwnWatercraft */ 
		unsigned2 	WatercraftCount;                        //populated in DueDiligence.getBusWatercraft 
		unsigned2  Watercraftlength;                       //populated in DueDiligence.getBusWatercraft 
		/* BusAssetOwnAircraft */
		unsigned2 	AircraftCount;                          //populated in DueDiligence.getBusAircraft 
		/* BusAssetOwnVehicle */
		unsigned2 	VehicleCount;                           //populated in DueDiligence.getBusVehicle
		unsigned6  VehicleBaseValue;
		/*BusSOSAgeRange*/  
		UNSIGNED4  sosIncorporationDate;										         //populated in DueDiligence.getBusSOSDetail
		BOOLEAN   	noSOSFilingEver;												            //populated in DueDiligence.getBusSOSDetail
		UNSIGNED4		filingDate;	
		/*BusPublicRecordAgeRange*/ 	
		UNSIGNED4 	busnHdrDtFirstSeen;											          //populated in DueDiligence.getBusHeader
		UNSIGNED3 	srcCount;																               //populated in DueDiligence.getBusHeader
		/*BusValidityRisk*/
		UNSIGNED2 	sosAddrLocationCount;										         //populated in DueDiligence.getBusSOSDetail
		UNSIGNED2 	hdAddrCount;														              //populated in DueDiligence.getBusHeader 
		UNSIGNED2 	creditSrcCnt;														             //populated in DueDiligence.getBusHeader
		BOOLEAN     noFein;																	               //populated in DueDiligence.getBusHeader			
		BOOLEAN     busRegHit;															              //populated in DueDiligence.getBusRegistration
		/*BusStabilityRisk*/
		BOOLEAN			sosFilingExists;												             //populated in DueDiligence.getBusSOSDetail
		BOOLEAN			sosAllDissolveInactiveSuspend;					      //populated in DueDiligence.getBusSOSDetail
		BOOLEAN			sosHasAtleastOneDissolvedFiling;				     //populated in DueDiligence.getBusSOSDetail					
		BOOLEAN			sosHasAtleastOneInactiveFiling;					     //populated in DueDiligence.getBusSOSDetail			
		BOOLEAN			sosHasAtleastOneSuspendedFiling;				     //populated in DueDiligence.getBusSOSDetail	
		BOOLEAN			sosHasAtleastOneOtherStatusFiling;			    //populated in DueDiligence.getBusSOSDetail		
		BOOLEAN			sosHasAtleastOneActiveFiling;						      //populated in DueDiligence.getBusSOSDetail
		UNSIGNED4   sosLastReinstateDate;										        //populated in DueDiligence.getBusSOSDetail
		UNSIGNED4   firstReportedAtInputAddress;						     //populated in DueDiligence.getBusSOSDetail
		BOOLEAN   	sosBusNameChange;												           //populated in DueDiligence.getBusSOSDetail																				
		BOOLEAN   	sosBusAddressChange;										          //populated in DueDiligence.getBusSOSDetail
		BOOLEAN   	sosContactNameChange;										         //populated in DueDiligence.getBusSOSDetail			
		BOOLEAN   	sosContactAddressChange;								        //populated in DueDiligence.getBusSOSDetail		
		BOOLEAN			feinIsSSN;															                //populated in DueDiligence.getBusAsInd
		BOOLEAN			busIsSOHO;															                //populated in DueDiligence.getBusAsInd
		STRING2			residentialAddr;												             //populated in DueDiligence.getBusAsInd
		UNSIGNED1		personNameSSN;													             //populated in DueDiligence.getBusAsInd
		UNSIGNED1		personAddrSSN;													             //populated in DueDiligence.getBusAsInd
		BOOLEAN     inputAddressVerified;                		//populated in DueDiligence.getBusHeader
		BOOLEAN			cmra;																		                  //populated in DueDiligence.getBusAddrData
		BOOLEAN			vacant;																	                 //populated in DueDiligence.getBusAddrData
		BOOLEAN			notFoundInHeader;												            //populated in DueDiligence.getBusHeader
		/*BusStructureType*/
		STRING60    hdBusnType;															             //populated in DueDiligence.getBusHeader
		STRING60    adrBusnType;														             //populated in DueDiligence.getBusAddrData
		/*BusIndustryRisk*/
		SicNaicRiskLayout sicNaicRisk;											          //populated in DueDiligence.getBusSicNaic
		UNSIGNED3		numOfSicNaic;
		DATASET(LayoutSICNAIC) sicNaicSources {MAXCOUNT(DueDiligence.Constants.MAX_SIC_NAIC)};		//populated in DueDiligence.getBusSicNaic, DueDiligence.getBusHeader, DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		/*BusShellShelfRisk*/
		UNSIGNED3 	numOfBusFoundAtAddr;										         //populated in DueDiligence.getBusAddrData
		UNSIGNED3		numOfBusIncInStateLooseLaws;						     //populated in DueDiligence.getBusAddrData
		UNSIGNED3		numOfBusNoReportedFein;									       //populated in DueDiligence.getBusAddrData
		UNSIGNED4 	busnHdrDtFirstSeenNonCredit;						     //populated in DueDiligence.getBusHeader
		UNSIGNED2 	shellHdrSrcCnt;													           //populated in DueDiligence.getBusHeader
		BOOLEAN			incorpWithLooseLaws;										          //populated in DueDiligence.getBusHeader, DueDiligence.getBusSOSDetail, DueDiligence.getBusAddrData
		BOOLEAN			privatePostExists;											           //populated in DueDiligence.getBusAddrData
		BOOLEAN			mailDropExists;													            //populated in DueDiligence.getBusAddrData
		BOOLEAN			remailerExists;													            //populated in DueDiligence.getBusAddrData
		BOOLEAN			storageFacilityExists;								         	//populated in DueDiligence.getBusAddrData
		BOOLEAN			undeliverableSecRangeExists;						      //populated in DueDiligence.getBusAddrData
		BOOLEAN			registeredAgentExists;									         //populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		BOOLEAN 		atleastOneAgentSameAddrAsBus;						     //populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		UNSIGNED3		numOfRegAgents;
		DATASET(LayoutAgent) registeredAgents {MAXCOUNT(DueDiligence.Constants.MAX_REGISTERED_AGENTS)};							//populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		BOOLEAN     agentShelfBusn;													         //populated in DueDiligence.getBusAddrData
		BOOLEAN		  agentPotentialNIS;											         //populated in DueDiligence.getBusAddrData
		/*BusExecutiveOfficersRisk*/
		UNSIGNED3		numOfBusExecs;												           	//populated in DueDiligence.getBusExec
		BOOLEAN			atleastOneActiveLawAcctExec;					     	//populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveFinRealEstateExec;		  	//populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveMedicalExec;						     //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveBlastPilotExec;					   //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveLawAcctExec;					    //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveFinRealEstateExec;		 //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveMedicalExec;					    //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveBlastPilotExec;				  //populated in DueDiligence.getBusProfLic
		
		/* BusMatchLevel  */ 
		INTEGER2		weight;                                 //populated in -------------------------- 
		
		unsigned4   SOSLastReported;																								
		unsigned2 	CorpStateCount;													
		unsigned4	  BusnHdrDtLastSeen;										        	//populated in DueDiligence.getBusHeader
		unsigned2 	HDStateCount;														           //populated in DueDiligence.getBusHeader  		
		STRING1     dwelltype := '';
		STRING1     hriskaddrflag := '';
		string5     FIPsCode;
		string2	    src := '';
		
		/*BusGeographicRisk*/
		// for debugging only begin
		STRING12    buildgeolink;
		STRING3	    EasiTotCrime;
		STRING      CityState;
    // for debugging only end 	
		string1   	 AddressVacancyInd;                      //populated in DueDiligence.getBusGeographicRisk
		boolean     CountyHasHighCrimeIndex;                //populated in DueDiligence.getBusGeographicRisk
		boolean     CountyBordersForgeinJur;                //populated in DueDiligence.getBusGeographicRisk
		boolean     CountyBorderOceanForgJur;               //populated in DueDiligence.getBusGeographicRisk
		boolean     CityBorderStation;                      //populated in DueDiligence.getBusGeographicRisk
		boolean     CityFerryCrossing;                      //populated in DueDiligence.getBusGeographicRisk
		boolean     CityRailStation;                        //populated in DueDiligence.getBusGeographicRisk
		boolean     HIDTA;                                  //populated in DueDiligence.getBusGeographicRisk
		boolean     HIFCA;                                  //populated in DueDiligence.getBusGeographicRisk
		boolean     HighFelonNeighborhood;                  //populated in DueDiligence.getBusGeographicRisk
		boolean     HRBusPct;                               //populated in DueDiligence.getBusGeographicRisk
		
		string30  	ShellBusnIndvalues;
		unsigned1   ShellIndCount;
		boolean     ShelfBusn;
		BOOLEAN		  PotentialNIS;
		boolean     ExecSNNMatch;
	  /* Civil Offenses   */   
		CivilOffensesCounts  Business;
		
		/* Criminal Evidence flags  are all for any one of the Business Executives tied to this business*/                                    
		BOOLEAN     BEOevidenceOfCurrentIncarceration;                // Level 9
		BOOLEAN     BEOevidenceOfCurrentParole;                       // Level 9
		BOOLEAN     BEOevidenceOfFelonyConvictionInLastNYR;           // Level 8 - at least one 4F - in last 3 years
		BOOLEAN     BEOevidenceOfFelonyConvictionOlderNYR;            // Level 7 - at least one 4F - older than 3 years
		BOOLEAN     BEOevidenceOfPreviousIncarceration;               // Level 6
		BOOLEAN     BEOevidenceOfUncatagorizedConvictionInLastNYR;    // Level 5 - at least one 4U - in the last 3 years
		BOOLEAN     BEOevidenceOfMisdeameanorConvictionInLastNYR;     // Level 4 - at least one 4M - in the last 3 years
		BOOLEAN     BEOevidenceOfUncatagorizedConvictionOlderNYR;     // Level 3 - at least one 4U - older than 3 years
		BOOLEAN     BEOevidenceOfMisdeameanorConvictionOlderNYR;      // Level 2 - at lease one 4M - older than 3 years
		
		/* Civil Evidence flags  are all for any one of the Business Executives tied to this business - Civil can be any combo of liens, judgments and evictions */                                    
		BOOLEAN     BEOevidenceOf10CivilNYR;                          // Level 9 - 10 or more Civil      in last 3 years
		BOOLEAN     BEOevidenceOf5To9CivilNYR;                        // Level 8 -  5 - 9     Civil      in last 3 years
		BOOLEAN     BEOevidenceOf3To4CivilNYR;                        // Level 7 -  3 - 4     Civil      in last 3 years
		BOOLEAN     BEOevidenceOf1To2CivilNYR;                        // Level 6 -  1 - 2     Civil      in last 3 years
		BOOLEAN     BEOevidenceOf10CivilOlderNYR;                     // Level 5 - 10 or more Civil      older than 3 years
		BOOLEAN     BEOevidenceOf5To9CivilOlderNYR;                   // Level 4 -  5 - 9     Civil      older than 3 years
		BOOLEAN     BEOevidenceOf3To4CivilOlderNYR;                   // Level 3 -  3 - 4     Civil      older than 3 years
		BOOLEAN     BEOevidenceOf1To2CivilOlderNYR;                   // Level 2 -  1 - 2     Civil      older than 3 years
		
		/* Traffic & Infraction Evidence flags  are all for any one of the Business Executives tied to this business*/                                    
		BOOLEAN     BEOevidenceOf3TrafficNYR;                         // Level 9 - 3 or more traffic     in last 3 years
		BOOLEAN     BEOevidenceOf2TrafficNYR;                         // Level 8 - 1 or 2    traffic     in last 3 years
		BOOLEAN     BEOevidenceOf3InfractionsNYR;                     // Level 7 - 3 or more infractions in last 3 years
		BOOLEAN     BEOevidenceOf2InfractionsNYR;                     // Level 6 - 1 or 2    infractions in last 3 years
		BOOLEAN     BEOevidenceOf3TrafficOlderNYR;                    // Level 5 - 3 or more traffic     older than 3 years
		BOOLEAN     BEOevidenceOf2TrafficOlderNYR;                    // Level 4 - 1 or 2    traffic     older than 3 years
		BOOLEAN     BEOevidenceOf3InfractionsOlderNYR;                // Level 3 - 3 or more infractions older than 3 years
		BOOLEAN     BEOevidenceOf2InfractionsOlderNYR;                // Level 2 - 1 or 2    infractions older than 3 years
		
		unsigned2		LinkedBusnValidityCount	 := 0;	
		string120		bestCompanyName	         := '';										//populated in DueDiligence.getBusBestData
		UNSIGNED1 	bestCompanyNamescore     := 0;
		string50		bestAddr			           := '';										//populated in DueDiligence.getBusBestData
		string25		bestCity			           := '';										//populated in DueDiligence.getBusBestData
		string2			bestState			           := '';										//populated in DueDiligence.getBusBestData
		string5			bestZip			             := '';										//populated in DueDiligence.getBusBestData
		string4			bestZip4			           := '';										//populated in DueDiligence.getBusBestData
		unsigned1		bestAddrScore		         := 0;
		string9			bestFEIN			           := '';										//populated in DueDiligence.getBusBestData
		unsigned1		bestFEINScore		         := 0;
		string10		bestPhone			           := '';										//populated in DueDiligence.getBusBestData
		unsigned1		bestPhoneScore		       := 0;
		BusAttributes_KRI;
		iesp.duediligencereport.t_DDRBusinessReport BusinessReport;
	END;

END;