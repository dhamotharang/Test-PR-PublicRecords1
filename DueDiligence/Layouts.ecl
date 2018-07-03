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
		STRING2 PerLegalStateCriminal;
		STRING10 PerLegalStateCriminal_Flag;
    STRING2 PerLegalFedCriminal;
		STRING10 PerLegalFedCriminal_Flag;
		STRING2 PerLegalCivil;
		STRING10 PerLegalCivil_Flag;
		STRING2 PerLegalTraffInfr;
		STRING10 PerLegalTraffInfr_Flag;
		STRING2 PerLegalTypes;
		STRING10 PerLegalTypes_Flag;
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
		STRING2 BusLegalStateCriminal;
		STRING10 BusLegalStateCriminal_Flag;
    STRING2 BusLegalFedCriminal;
    STRING10 BusLegalFedCriminal_Flag;
		STRING2 BusLegalCivil;
		STRING10 BusLegalCivil_Flag;
		STRING2 BusLegalTraffInfr;
		STRING10 BusLegalTraffInfr_Flag;
		STRING2 BusLegalTypes;
		STRING10 BusLegalTypes_Flag;
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
    BOOLEAN   useLexIDAsOverride;
		
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
    BOOLEAN lexIDVerified;
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


 //---                                                                          ---
 //--- This is all of the criminal data we have for each DID and each offense   ---
 //--- So there are multiple rows for each DID.                                 ---
 //--- data collected came from key-offenders, key-offenses, offenders-risk-key ---
 //--- and key-punishments                                                      ---
 //---                                                                          ---
	EXPORT CriminalOffenseLayout_by_DIDOffense  := RECORD
		unsigned4	seq := 0;
		UNSIGNED6 DID;
		string60 	offender_key;      // offenders key
		unsigned4 historydate; 
		UNSIGNED4 DateToUse; 
		UNSIGNED3 NumOfDaysAgo;  
    
    //case details
    string35 	caseNum;                     // Key_Offenders_Risk.case_num
    string50  courtType;                   // Key_Offenders.datasource
    string3   num_of_counts;               // Key_Offenses.num_of_counts
    string75  charge;                      // Key_Offenders_Risk.offense.court_off_desc_1
    string40  courtDispDesc1;              // Key_Offenders_Risk.offense.court_disp_desc_1
		string40  courtDispDesc2;              // Key_Offenders_Risk.offense.court_disp_desc_2
    
    //offense details
    STRING35  caseType;                    // Key_Offenders.case_type_desc
    STRING35  arrestLevel;                 // Key_Court_Offenses.arr_off_lev_mapped 
    string1   untouchedOffenseScore;
    string1   offenseScore;                // values are 'U' or null = UNKOWN, 'M'= Misdemeanor, 'F'= Felony, 'T' = TRAFFIC, 'I'=Infraction.
    string5   courtOffenseLevel;           // values are documented in a spreadsheet. 
    
    //offense locations
    STRING25  offenseState;                // Key_Offenders_Risk.orig_state
    STRING30  offenseCounty;               // Key_Offenders_Risk.county_of_origin
    STRING    courtCounty;                 // Key_Offenses.court_county
    STRING50  offenseCity;                 // Key_Offenses.offenseTown
    STRING    agency;                      // Key_Court_Offenses.le_agency_desc
           
    //offense dates
    string8   offenseDate;                 // Key_Offenders_Risk.offense.off_date
		string8   arrestDate;                  // Key_Offenders_Risk.offense.arr_date
    string8   courtDispDate;               // Key_Offenders_Risk.offense.court_disp_date
    string8   sentenceDate;                // Key_Offenders_Risk.offense.sent_date
		string8   appealDate;                  // Key_Offenders_Risk.offense.appeal_date
    STRING8   incarcerationDate;
    STRING8   incarcerationReleaseDate;
    
    //additional offense details
    /*  To determine whether any of these 3 conditions were EVER TRUE - follow the code in getIndCriminal */
		string1   Ever_incarc_offenders;       // pulled from key_ offenders
		string1   Ever_incarc_offenses;        // pulled from key_ offenses
		string1   Ever_incarc_punishments;     // pulled from key_ punishment
    /*  To determine whether any of these 3 condition are CURRENTLY TRUE - Use logic similar to the VOO function */
		string1   Curr_incarc_offenders;        // Key_Offenses.curr_incar_flag
		string1   Curr_incarc_offenses;         // Key_Offenses.stc_desc_2
		string1   Curr_incarc_punishments;      // Key_Punishment.latest_adm_dt
    STRING1   currentProbation;             // Key_Offenders.curr_prob_flag
    STRING    probationSentence;            // Key_Court_Offenses.sent_probation
    
    //offender description/info
    string30  race;                        // Key_Offenders_Risk.race_desc
    string1   sex;                         // Key_Offenders_Risk.sex
    string50  hairColor;                   // Key_Offenders_Risk.hair_color_desc
    string15  eyeColor;                    // Key_Offenders_Risk.eye_color_desc
    string3   height;                      // Key_Offenders_Risk.height
    string3   weight;                      // Key_Offenders_Risk.weight
    string2   citizenship;                 // Key_Offenders_Risk.citizenship
    
    //other details
    UNSIGNED4 legalEventTypeCode;       // Code/Weight from RegularExpressions
    STRING1   stateFederalData;            //Constant of S = State  or F = Federal
    string8   earliestOffenseDate;         // in order to calculate how old this date is I need to send we clean it before using it.
		string8   untouchedearliestOffenseDate;  // if we need to show this in the report it should be the uncleaned date.
    string20  courtStatute;                // Key_Offenders_Risk.offense.court_statute
		string70  courtStatuteDesc;            // Key_Offenders_Risk.offense.court_statute_desc
    
    string1 	curr_parole_flag;            // pulled from the offenders key
    string1 	curr_parole_punishments;     // pulled from the key_ punishment
    
		
    


  
		string1   convictionFlag; 
		string1   trafficFlag;
		string1   criminalOffenderLevel;       // values are 4 = NON-TRAFFIC/CONVICTED, 3 = NON-TRAFFIC/NOT-CONVICTED, 2 = TRAFFIC/CONVICTED, 1 = TRAFFIC/NOT-CONVICTED
		
		string20  caseTypeDesc;                // ***???

		string30  stc_desc_2;                  // offenses key  --- pulled but not used, except for verification
		string35  court_off_lev_mapped;        // Court_Offenses key
    
    //temp
    // string8   caseDate;
    // string8   vendorUploadedDate;
	 
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
    //Non Convicted traffic and infractions ever
    UNSIGNED2   NonConvictedTraffic1T_Ever;
    UNSIGNED2   NonConvictedInfraction1I_Ever;    
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
	
	
  
  EXPORT BusinessLegalSummary := RECORD 
    UNSIGNED3   BusFelonyConviction_4F;
    UNSIGNED3   BusFelonyNonConviction_3F;
    UNSIGNED3   BusMisdemeanorConviction_4M;
    UNSIGNED3   BusMisdemeanorNonConviction_3M;
    UNSIGNED3   BusUnknownConviction_4U;
    UNSIGNED3   BusUnknownNonConviction_3U;
    UNSIGNED3   BusTrafficConviction_2T;
    UNSIGNED3   BusTrafficNonConviction_1T; 
    UNSIGNED3   BusInfractionConviction_2I;
    UNSIGNED3   BusInfractionNonConviction_1I;
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
    BusinessLegalSummary;
    DATASET(LayoutAgent) namesAssocWithFein {MAXCOUNT(DueDiligence.Constants.MAX_ASSOCIATED_FEIN_NAMES)};
    DATASET(DD_CompanyNames) companyDBA {MAXCOUNT(DueDiligence.Constants.MAX_DBA_NAMES)};
    STRING parentCompanyName;
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
	
	
	EXPORT RelatedParty := RECORD
		SlimIndividual;
		STRING2 usResidencyScore;
		STRING10 usResidencyFlags;
		STRING2 legalEventTypeScore;
		STRING10 legalEventTypeFlags;
    STRING2 trafficInfractionScore;
    STRING10 trafficInfractionFlags;
    STRING2 stateCriminalLegalEventsScore;
    STRING10 stateCriminalLegalEventsFlags;
    STRING2 civilLegalEventsScore;
    STRING10 civilLegalEventsFlags;
    DerogatoryEvents;                           //***these are rolled upto the DID 
		UNSIGNED3 numOfPositions;
		DATASET(Positions) positions; //{MAXCOUNT(DueDiligence.Constants.MAX_POSITIONS)};
		UNSIGNED3 numOfLicenses;
		DATASET(Licenses) licenses; //{MAXCOUNT(DueDiligence.Constants.MAX_LICENSES)};
		DATASET(CriminalOffenseLayout_by_DIDOffense) partyOffenses;    //***these are listed at the offense level for each DID
	END;

	
	EXPORT Indv_Internal := Record
		UNSIGNED4	 seq := 0;
		UNSIGNED4	 historyDate;													//If all 9s will be todays date, otherwise cleaned input date (actual date value)
		UNSIGNED4		historyDateRaw;										//cleaned date used to calc history date
		BOOLEAN 			inputAddressProvided;
		BOOLEAN				fullInputAddressProvided;
    Indv_Input indvRawInput;
		Indv_Input	indvCleanInput;
    GeographicRiskLayout; 
		UNSIGNED6		inquiredDID;
		RelatedParty 		individual;																								//populated in DueDiligence.getIndDID, DueDiligence.getIndBestData
		UNSIGNED4 	numberOfSpouses;																							
		DATASET(SlimIndividual) spouses;																												//populated in DueDiligence.getIndRelatives
		DATASET(SlimIndividual) parents {MAXCOUNT(DueDiligence.Constants.MAX_PARENTS)}; 			//populated in DueDiligence.getIndRelatives
		STRING2				indvType;                         					    //II = Inquired Individual, IS = Inquired Individual Spouse,  IP = Inquired Individual Parent, 
		
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
		DATASET(RelatedParty) execs {MAXCOUNT(DueDiligence.Constants.MAX_EXECS)};												//populated in DueDiligence.getBusExec
    
    DueDiligence.LayoutsAttributes.BusinessAttributeValues;         //used in calc'ing attribute values in getBusKRI

		// unsigned2 	CountOwnProp;                                       //populated in DueDiligence.getBusProperty - 
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