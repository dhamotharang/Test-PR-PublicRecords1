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
		UNSIGNED4 dateLastSeen;
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

	EXPORT PerAttributes := RECORD
		UNSIGNED6 PerLexID;
		STRING2 PerAssetOwnProperty;
		STRING10 PerAssetOwnProperty_Flag;
		STRING2 PerAssetOwnAircraft;
		STRING10 PerAssetOwnAircraft_Flag;
		STRING2 PerAssetOwnWatercraft;
		STRING10 PerAssetOwnWatercraft_Flag;
		STRING2 PerAssetOwnVehicle;
		STRING10 PerAssetOwnVehicle_Flag;
		STRING2 PerAccessToFundsProperty;
		STRING10 PerAccessToFundsProperty_Flag;
		STRING2 PerAccessToFundsIncome;
		STRING10 PerAccessToFundsIncome_Flag;
		STRING2 PerGeographic;
		STRING10 PerGeographic_Flag;
		STRING2 PerMobility;
		STRING10 PerMobility_Flag;
		STRING2 PerLegalCriminal;
		STRING10 PerLegalCriminal_Flag;
		STRING2 PerLegalCivil;
		STRING10 PerLegalCivil_Flag;
		STRING2 PerLegalTraffInfr;
		STRING10 PerLegalTraffInfr_Flag;
		STRING2 PerLegalTypes;
		STRING10 PerLegalTypes_Flag;
		STRING4 PerHighRiskNewsProfiles;
		STRING10 PerHighRiskNewsProfiles_Flag;
		STRING2 PerAgeRange;
		STRING10 PerAgeRange_Flag;
		STRING2 PerIdentityRisk;
		STRING10 PerIdentityRisk_Flag;
		STRING2 PerUSResidency;
		STRING10 PerUSResidency_Flag;
		STRING2 PerMatchLevel;
		STRING10 PerMatchLevel_Flag;
		STRING2 PerAssociatesIndex;
		STRING10 PerAssociatesIndex_Flag;
		STRING2 PerProfLicense;
		STRING10 PerProfLicense_Flag;
	END;

	//------These are the customer facing attributes for this product ------
	EXPORT BusAttributes := RECORD
		UNSIGNED6 BusLexID;
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
		STRING2 BusLegalStateCriminal;
		STRING10 BusLegalStateCriminal_Flag;
    STRING2 BusLegalFederalCriminal;
    STRING10 BusLegalFederalCriminal_Flag;
		STRING2 BusLegalCivil;
		STRING10 BusLegalCivil_Flag;
		STRING2 BusLegalTraffInfr;
		STRING10 BusLegalTraffInfr_Flag;
		STRING2 BusLegalTypes;
		STRING10 BusLegalTypes_Flag;
		STRING2 BusLinkedBusFootprint;
		STRING10 BusLinkedBusFootprint_Flag;
		STRING2 BusLinkedBusIndex;
		STRING10 BusLinkedBusIndex_Flag;
		STRING2 BusBEOProfLicense;
		STRING10 BusBEOProfLicense_Flag;
		STRING2 BusBEOUSResidency;
		STRING10 BusBEOUSResidency_Flag;
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
		STRING2 BusHighRiskNewsProfiles;  //TO BE REMOVED WITH BATCH CHANGES
		STRING10 BusHighRiskNewsProfiles_Flags;  //TO BE REMOVED WITH BATCH CHANGES
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
		//unsigned6 origdid;
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
		string50  origState;                   // offender_risk_ key
		string30  stc_desc_2;                  // offenses key
		string35  arr_off_lev_mapped;          // Court_Offenses key
		string35  court_off_lev_mapped;        // Court_Offenses key
		string3   num_of_counts;                // Court_offenses key
		string1   punishment_type;             // punishment key
    STRING    sent_probation;
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
    /* data about the agency and offense */ 
    string50  le_agency_desc;              // pulled from the Key_ Court_Offenses
    string20  source_file;                 // pulled from the Key_ Offenders
    string40  OffenseTown;                 // pulled from ???
    string40  CourtCounty;                 // pulled from ???
    /* data about the offender */
    string2   citizenship;                 // pulled from Key_ Offenders
    string30  race_desc;                   // pulled from Key_ Offenders
    string7   sex;                         // pulled from Key_ Offenders
    string15  hair_color_desc;             // pulled from Key_ Offenders
    string15  eye_color_desc;              // pulled from Key_ Offenders
    string3   height;                      // pulled from Key_ Offenders
    string3   weight;                      // pulled from Key_ Offenders
	 
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
		 CriminalOffensesCounts;
		 TrafficOffensesCounts;  
     BOOLEAN noEvidenceOfConvictedStateCrim;
     BOOLEAN noEvidenceOfTrafficOrInfraction;
		/* TOTAL OF ALL OFFENSES  */  
		unsigned2   ALLOffensesForThisDID;                            //*** All Criminal Offenses EVER.
	END;
	
	EXPORT GeographicRiskLayout := RECORD 
		STRING12    buildgeolink;
		STRING3	    EasiTotCrime;
		STRING      CityState;
    STRING5     FipsCode;  
    STRING50    CountyName;                             //populated in DueDiligence.Common.getGeographicRisk       
		string1   	AddressVacancyInd;                      //is not being populated?????
		boolean     CountyHasHighCrimeIndex;                //populated in DueDiligence.Common.getGeographicRisk
		boolean     CountyBordersForgeinJur;                //populated in DueDiligence.Common.getGeographicRisk
		boolean     CountyBorderOceanForgJur;               //populated in DueDiligence.Common.getGeographicRisk
		boolean     CityBorderStation;                      //populated in DueDiligence.Common.getGeographicRisk
		boolean     CityFerryCrossing;                      //populated in DueDiligence.Common.getGeographicRisk
		boolean     CityRailStation;                        //populated in DueDiligence.Common.getGeographicRisk
		boolean     HIDTA;                                  //populated in DueDiligence.Common.getGeographicRisk
		boolean     HIFCA;                                  //populated in DueDiligence.Common.getGeographicRisk
		boolean     HighFelonNeighborhood;                  //populated in ???
		boolean     HRBusPct;                               //populated in ???
	END;  	
	
 
	
	
	EXPORT BusSourceLayout := RECORD
		STRING sourceName;
		STRING source;
		STRING sourceType;
		UNSIGNED4 firstReported;
		UNSIGNED4 lastReported;
	END;
	
	EXPORT BusOperLocationLayout := RECORD
	 Address;
	 GeographicRiskLayout;  
	 BOOLEAN cmra;
	 BOOLEAN vacant;
	END;	
	
	
	EXPORT BusReportDetails        := RECORD
    DATASET(BusOperLocationLayout) operatingLocations {MAXCOUNT(DueDiligence.Constants.MAX_OPERATING_LOCATIONS)};
    DATASET(BusSourceLayout)       sourcesReporting {MAXCOUNT(DueDiligence.Constants.MAX_SOURCES)};
    DATASET(BusSourceLayout)       bureauReporting {MAXCOUNT(DueDiligence.Constants.MAX_BUREAUS)};
    UNSIGNED4 dateVendorFirstReported;
    //***add additional datasets as needed here ****
    //STRING BusinessReportName;
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

	
	EXPORT SlimIndividual := RECORD
		UNSIGNED6 did;
		UNSIGNED2 score;		//did score
		STRING9 ssn;
		UNSIGNED4 dob;
		STRING phone;
		Name;
		Address;
	END;
	
	
	EXPORT RelatedParty := RECORD
		SlimIndividual;
		STRING2 usResidencyScore;
		STRING10 usResidencyFlags;
		STRING2 legalEventTypeScore;
		STRING10 legalEventTypeFlags;
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
		UNSIGNED4	 seq := 0;
		UNSIGNED4	 historyDate;													//If all 9s will be todays date, otherwise cleaned input date (actual date value)
		UNSIGNED4		historyDateRaw;										//cleaned date used to calc history date
		BOOLEAN 			inputAddressProvided;
		BOOLEAN				fullInputAddressProvided;
		UNSIGNED6		inquiredDID;
		RelatedParty 		individual;																								//populated in DueDiligence.getIndDID, DueDiligence.getIndBestData
		UNSIGNED4 	numberOfSpouses;																							
		SlimIndividual spouse;																												//populated in DueDiligence.getIndRelatives
		DATASET(SlimIndividual) parents {MAXCOUNT(DueDiligence.Constants.MAX_PARENTS)}; 			//populated in DueDiligence.getIndRelatives
		Indv_Input indvRawInput;
		Indv_Input	indvCleanInput;
		STRING2				indvType;                         					      //II = Inquired Individual, IS = Inquired Individual Spouse,  IP = Inquired Individual Parent, 
		/*PerUSResidency*/
		UNSIGNED4 	firstReportedDate;															    //populated in DueDiligence.getIndHeader
		BOOLEAN		  registeredVoter;															    //populated in DueDiligence.getIndHeader
		BOOLEAN			stateVotingSourceAvailable;										    //populated in DueDiligence.getIndHeader
		BOOLEAN			hasSSN;																				    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			hasITIN;																			    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			hasImmigrantSSN;															    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			validSSN;																			    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			hasParent;																		    //populated in DueDiligence.getIndRelatives
		BOOLEAN			atleastOneParentHasSSN;												    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			atleastOneParentHasITIN;											    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			atleastOneParentHasImmigrantSSN;							    //populated in DueDiligecne.getIndSSNData
		BOOLEAN			atleastOneParentIsRegisteredVoter;					      //populated in DueDiligence.getIndHeader
		UNSIGNED4		mostRecentParentSSNIssuanceDate;							      //populated in DueDiligecne.getIndSSNData
		/*PerLegalEventType*/
		BOOLEAN			atleastOneCategory9;
		BOOLEAN			atleastOneCategory8;
		BOOLEAN			atleastOneCategory7;
		BOOLEAN			atleastOneCategory6;
		BOOLEAN			atleastOneCategory5;
		BOOLEAN			atleastOneCategory4;
		BOOLEAN			atleastOneCategory3;
		BOOLEAN			atleastOneCategory2;
		BOOLEAN			noConvictionsOrCategoryHit;
		
		PerAttributes;
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
		DATASET(RelatedParty) execs {MAXCOUNT(DueDiligence.Constants.MAX_EXECS)};												//populated in DueDiligence.getBusExec
		/* BusAssetOwnProperty */
		unsigned6 	PropTaxValue;                                       //populated in DueDiligence.getBusProperty
		unsigned2 	CurrPropOwnedCount;                                 //populated in DueDiligence.getBusProperty - do we need this?
		unsigned2 	CountSoldProp;                                      //populated in DueDiligence.getBusProperty - do we need this?
		unsigned2 	CountOwnProp;                                       //populated in DueDiligence.getBusProperty - 
		/* BusAssetOwnWatercraft */ 
		unsigned2 	WatercraftCount;                                    //populated in DueDiligence.getBusWatercraft 
		unsigned2  	Watercraftlength;                                   //populated in DueDiligence.getBusWatercraft 
		/* BusAssetOwnAircraft */
		unsigned2 	AircraftCount;                                      //populated in DueDiligence.getBusAircraft 
		/* BusAssetOwnVehicle */
		unsigned2 	VehicleCount;                                       //populated in DueDiligence.getBusVehicle
		unsigned6  	VehicleBaseValue;
		/*BusSOSAgeRange*/  
		UNSIGNED4  	sosIncorporationDate;										            //populated in DueDiligence.getBusSOSDetail
		BOOLEAN   	noSOSFilingEver;												            //populated in DueDiligence.getBusSOSDetail
		UNSIGNED4		filingDate;	
		/*BusPublicRecordAgeRange*/ 	
		UNSIGNED4 	busnHdrDtFirstSeen;											            //populated in DueDiligence.getBusHeader
		UNSIGNED3 	srcCount;																            //populated in DueDiligence.getBusHeader  This is a count of ALL Sources
		UNSIGNED3   nonCreditSrcCnt;                                    //populated in DueDiligence.getBusHeader  This is a count of ALL Sources minus the Credit Bureaus
		/*BusValidityRisk*/
		UNSIGNED2 	sosAddrLocationCount;										            //populated in DueDiligence.getBusSOSDetail
		UNSIGNED2 	hdAddrCount;														            //populated in DueDiligence.getBusHeader 
		UNSIGNED2 	creditSrcCnt;														            //populated in DueDiligence.getBusHeader  This is a count of Credit Bureaus
		BOOLEAN     noFein;																	            //populated in DueDiligence.getBusHeader			
		BOOLEAN     busRegHit;															            //populated in DueDiligence.getBusRegistration
		/*BusStabilityRisk*/
		BOOLEAN			sosFilingExists;												            //populated in DueDiligence.getBusSOSDetail
		BOOLEAN			sosAllDissolveInactiveSuspend;					            //populated in DueDiligence.getBusSOSDetail
		BOOLEAN			sosHasAtleastOneDissolvedFiling;				            //populated in DueDiligence.getBusSOSDetail					
		BOOLEAN			sosHasAtleastOneInactiveFiling;					            //populated in DueDiligence.getBusSOSDetail			
		BOOLEAN			sosHasAtleastOneSuspendedFiling;				            //populated in DueDiligence.getBusSOSDetail	
		BOOLEAN			sosHasAtleastOneOtherStatusFiling;			            //populated in DueDiligence.getBusSOSDetail		
		BOOLEAN			sosHasAtleastOneActiveFiling;						            //populated in DueDiligence.getBusSOSDetail
		UNSIGNED4   sosLastReinstateDate;										            //populated in DueDiligence.getBusSOSDetail
		UNSIGNED4   firstReportedAtInputAddress;						            //populated in DueDiligence.getBusSOSDetail
		BOOLEAN   	sosBusNameChange;												            //populated in DueDiligence.getBusSOSDetail																				
		BOOLEAN   	sosBusAddressChange;										            //populated in DueDiligence.getBusSOSDetail
		BOOLEAN   	sosContactNameChange;										            //populated in DueDiligence.getBusSOSDetail			
		BOOLEAN   	sosContactAddressChange;								            //populated in DueDiligence.getBusSOSDetail		
		BOOLEAN			feinIsSSN;															            //populated in DueDiligence.getBusAsInd
		BOOLEAN			busIsSOHO;															            //populated in DueDiligence.getBusAsInd
		STRING2			residentialAddr;												            //populated in DueDiligence.getBusAsInd
		UNSIGNED1		personNameSSN;													            //populated in DueDiligence.getBusAsInd
		UNSIGNED1		personAddrSSN;													            //populated in DueDiligence.getBusAsInd
		BOOLEAN     inputAddressVerified;                		            //populated in DueDiligence.getBusHeader
		BOOLEAN			cmra;																		            //populated in DueDiligence.getBusAddrData
		BOOLEAN			vacant;																	            //populated in DueDiligence.getBusAddrData
		BOOLEAN			notFoundInHeader;												            //populated in DueDiligence.getBusHeader
		/*BusStructureType*/
		STRING60    hdBusnType;															            //populated in DueDiligence.getBusHeader
		STRING60    adrBusnType;														            //populated in DueDiligence.getBusAddrData
		/*BusIndustryRisk*/
		SicNaicRiskLayout sicNaicRisk;											            //populated in DueDiligence.getBusSicNaic
		UNSIGNED3		numOfSicNaic;
		DATASET(LayoutSICNAIC) sicNaicSources {MAXCOUNT(DueDiligence.Constants.MAX_SIC_NAIC)};		//populated in DueDiligence.getBusSicNaic, DueDiligence.getBusHeader, DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		/*BusShellShelfRisk*/
		UNSIGNED3 	numOfBusFoundAtAddr;										            //populated in DueDiligence.getBusAddrData
		UNSIGNED3		numOfBusIncInStateLooseLaws;						            //populated in DueDiligence.getBusAddrData
		UNSIGNED3		numOfBusNoReportedFein;									            //populated in DueDiligence.getBusAddrData
		UNSIGNED4 	busnHdrDtFirstSeenNonCredit;						            //populated in DueDiligence.getBusHeader
		UNSIGNED2 	shellHdrSrcCnt;													            //populated in DueDiligence.getBusHeader
		BOOLEAN			incorpWithLooseLaws;										            //populated in DueDiligence.getBusHeader, DueDiligence.getBusSOSDetail, DueDiligence.getBusAddrData
		BOOLEAN			privatePostExists;											            //populated in DueDiligence.getBusAddrData
		BOOLEAN			mailDropExists;													            //populated in DueDiligence.getBusAddrData
		BOOLEAN			remailerExists;													            //populated in DueDiligence.getBusAddrData
		BOOLEAN			storageFacilityExists;								            	//populated in DueDiligence.getBusAddrData
		BOOLEAN			undeliverableSecRangeExists;						            //populated in DueDiligence.getBusAddrData
		BOOLEAN			registeredAgentExists;									            //populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		BOOLEAN 		atleastOneAgentSameAddrAsBus;						            //populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		UNSIGNED3		numOfRegAgents;
		DATASET(LayoutAgent) registeredAgents {MAXCOUNT(DueDiligence.Constants.MAX_REGISTERED_AGENTS)};		//populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
		BOOLEAN     agentShelfBusn;													            //populated in DueDiligence.getBusAddrData
		BOOLEAN		  agentPotentialNIS;											            //populated in DueDiligence.getBusAddrData
		/*BusExecutiveOfficersRisk*/
		UNSIGNED3		numOfBusExecs;												            	//populated in DueDiligence.getBusExec
		BOOLEAN			atleastOneActiveLawAcctExec;					            	//populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveFinRealEstateExec;		            	//populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveMedicalExec;						            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneActiveBlastPilotExec;					            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveLawAcctExec;					            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveFinRealEstateExec;		            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveMedicalExec;					            //populated in DueDiligence.getBusProfLic
		BOOLEAN			atleastOneInactiveBlastPilotExec;				            //populated in DueDiligence.getBusProfLic
		/*BusLegalEventType*/
		BOOLEAN			atleastOneBEOInCategory9;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory8;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory7;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory6;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory5;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory4;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory3;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			atleastOneBEOInCategory2;                           //populated in DueDiligence.getBusLegalEvents
		BOOLEAN			BEOsHaveNoConvictionsOrCategoryHits;                //populated in DueDiligence.getBusLegalEvents
		/*BusUSResidency*/
		BOOLEAN		atleastOneBEOInvalidSSN;
		BOOLEAN		atleastOneBEOAssocITINOrImmigrantSSN;
		BOOLEAN		atleastOneBEODOBPriorToParentSSN;
		BOOLEAN   atleastOneBEOParentWithITINOrImmigrantSSN;
		BOOLEAN		atleastOneBEONoParentsOrNeitherHaveSSNITIN;
		BOOLEAN		atleastOneBEOPublicRecordsLess3YrsWithNoVote;
		BOOLEAN		atleastOneBEOPublicRecordsBetween3And10YrsWithNoVote;
		BOOLEAN		atleastOneBEOPublicRecordsMoreThan10YrsWithNoVote;
		BOOLEAN		atleastOneBEOOrParentRegisteredVoter;
		
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
    BOOLEAN     BEONoEvidenceOfStateCriminal;
		
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
    BOOLEAN     BEONoEvidenceOfTrafficOrInfraction;

		BusAttributes;
		BusReportDetails;
    iesp.duediligencebusinessreport.t_DDRBusinessReport BusinessReport;
	END;

END;