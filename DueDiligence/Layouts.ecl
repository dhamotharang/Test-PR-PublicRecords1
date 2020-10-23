IMPORT iesp, SALT28;


//NOTE: a good chunk if not all of these record structures will be removed/deleted

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
    STRING120   streetAddress1;
    STRING120   streetAddress2;
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

  SHARED Shared_Input := RECORD
    STRING15 lexID;
    STRING30 accountNumber;
    Address address;
    STRING14 phone;  //to account if input comes in (xxx) xxx-xxxx
    UNSIGNED6 inputSeq;
  END;

  EXPORT Busn_Input := RECORD
    LinkID_Results BIP_IDs;
    Shared_Input;
    STRING120 companyName;
    STRING120 altCompanyName;
    STRING11 fein;
  END;

  EXPORT Indv_Input := RECORD
    Shared_Input;
    STRING3 nameInputOrder;
    Name name;		
    STRING11 ssn; //to account if input comes in xxx-xx-xxxx
    STRING8 dob;
    Address cleanAddress;
  END;

  EXPORT SharedInput := RECORD
    UNSIGNED6 lexID;
    DueDiligence.v3Layouts.Internal.Address address;
    STRING14 phone; 
    STRING11 taxID;
  END;
  
  EXPORT BusInput := RECORD
    STRING120 companyName;
    STRING120 altCompanyName;
    SharedInput;
  END;
  
  EXPORT IndInput := RECORD
    Name name;
    STRING3 nameInputOrder;
    SharedInput;
    STRING8 dob;
  END;


  EXPORT Input := RECORD
    UNSIGNED4 seq;
    UNSIGNED4 inputSeq;
    STRING30 accountNumber;
    BOOLEAN validRequest;
    STRING200 errorMessage;
    STRING25 productRequested; //attributesonly, citizenshiponly, attributesandcitizenship, modules, standard
    STRING10 requestedVersion; //DDAPERV3, DDABUSV3
    DATASET({STRING15 attributeModules}) requestedModules;
    UNSIGNED4 historyDateYYYYMMDD;
    BusInput rawBusiness;
    BusInput cleanedBusiness;
    IndInput rawPerson;
    IndInput cleanedPerson;
    DueDiligence.Citizenship.Layouts.Input;
    
    
    //existing
    BOOLEAN containsCitizenshipReq;
    BOOLEAN containsPersonReq;
    BOOLEAN addressProvided;
    BOOLEAN fullCleanAddressExists;
    BOOLEAN lexIDPopulated;
    BOOLEAN piiPopulated;
    // Busn_Input business;
    // Indv_Input individual;
  END;
  
  EXPORT OldInput := RECORD
    BOOLEAN validRequest;
    STRING200 errorMessage;
    BOOLEAN containsCitizenshipReq;
    BOOLEAN containsPersonReq;
    BOOLEAN addressProvided;
    BOOLEAN fullCleanAddressExists;
    BOOLEAN lexIDPopulated;
    BOOLEAN piiPopulated;
    UNSIGNED4 seq;
    UNSIGNED4 inputSeq;
    UNSIGNED4 historyDateYYYYMMDD;
    STRING10 requestedVersion;
    STRING25 productRequested;
    DueDiligence.Citizenship.Layouts.Input;
    Busn_Input business;
    Indv_Input individual;
  END;

  EXPORT CleanedData := RECORD
    OldInput inputEcho;
    OldInput cleanedInput;
  END;

  //ALSO USED BY BATCH - changing name will impact batch
  EXPORT PerAttributes := RECORD
    STRING15 PerLexID;
    STRING3 PerLexIDMatch;
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
    STRING2 PerFederalLegalMatchLevel;
    STRING10 PerFederalLegalMatchLevel_Flag;
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
    STRING2 PerEmploymentIndustry;
    STRING10 PerEmploymentIndustry_Flag;
    STRING2 PerProfLicense;
    STRING10 PerProfLicense_Flag;
    STRING2 PerBusAssociations;
    STRING10 PerBusAssociations_Flag;
  END;

  //ALSO USED BY BATCH - changing name will impact batch
  EXPORT BusAttributes := RECORD
    STRING15 BusLexID;
    STRING3 BusLexIDMatch;
    STRING2 BusAssetOwnProperty;
    STRING10 BusAssetOwnProperty_Flag;
    STRING2 BusAssetOwnAircraft;
    STRING10 BusAssetOwnAircraft_Flag;
    STRING2 BusAssetOwnWatercraft;
    STRING10 BusAssetOwnWatercraft_Flag;
    STRING2 BusAssetOwnVehicle;
    STRING10 BusAssetOwnVehicle_Flag;
    STRING2 BusAccessToFundSales;
    STRING10 BusAccessToFundsSales_Flag;
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
    STRING2 BusFederalLegalMatchLevel;
    STRING10 BusFederalLegalMatchLevel_Flag;
    STRING2 BusCivilLegalEvent;
    STRING10 BusCivilLegalEvent_Flag;
    STRING2 BusOffenseType;
    STRING10 BusOffenseType_Flag;
    STRING2 BusBEOProfLicense;
    STRING10 BusBEOProfLicense_Flag;
    STRING2 BusBEOUSResidency;
    STRING10 BusBEOUSResidency_Flag;
    STRING2 BusBEOAccessToFundsProperty;
    STRING10 BusBEOAccessToFundsProperty_Flag;
    STRING2 BusLinkedBusinesses;
    STRING10 BusLinkedBusinesses_Flag;
  END;

  SHARED BatchFILayout := RECORD
    STRING8 FIAcctOpenDate;
    STRING100 FICRR;
    STRING100 FIAdditionalCodes1;
    STRING100 FIAdditionalCodes2;
    STRING100 FIAdditionalCodes3;
    STRING100 FIAdditionalCodes4;
    STRING100 FIAdditionalCodes5;
  END;

  EXPORT BatchInLayout  := RECORD
    UNSIGNED4 seq;
    STRING30 acctNo;
    STRING15 custType;
    STRING15 lexID;

    STRING120 companyName;
    STRING120 altCompanyName;
    STRING11 taxID;

    STRING3 nameInputOrder;	// sequence of name (FML = First/Middle/Last, LFM = Last/First/Middle) if not specified, uses default name parser
    Name;
    STRING9 ssn;
    STRING8 dob;

    STRING120 streetAddress1;
    STRING120 streetAddress2;
    STRING10 prim_range;
    STRING2 predir;
    STRING28 prim_name;
    STRING4 addr_suffix;
    STRING2 postdir;
    STRING10 unit_desig;
    STRING8 sec_range;
    STRING25 city;
    STRING2 state;
    STRING5 zip5;
    STRING4 zip4;

    STRING10 phone;
    STRING10 phone2;

    STRING25 dlNumber;
    STRING2 dlState;

    STRING100 emailAddress;
    UNSIGNED4	HistoryDateYYYYMMDD;

    BatchFILayout;
  END;

  //***Coordinate these changes witht the batch team ***//
  EXPORT BatchOut := RECORD
    UNSIGNED4 seq;
    STRING30 acctNo;
    BOOLEAN lexIDChanged;
    BatchFILayout;
    PerAttributes;
    BusAttributes;
    DueDiligence.Citizenship.Layouts.LayoutScoreAndIndicators;
    
    STRING2 PerCivilLegalEventFilingAmt;
    STRING10 PerCivilLegalEventFilingAmt_Flag;
    STRING2 BusCivilLegalEventFilingAmt;
    STRING10 BusCivilLegalEventFilingAmt_Flag;
  END;


  EXPORT LayoutSICNAIC := RECORD
    UNSIGNED4 DateFirstSeen;
    UNSIGNED4 DateLastSeen;
    STRING10 SICCode;
    STRING80 sicDesc;
    STRING5 SICIndustry;
    STRING7 SICRiskLevel;
    STRING10 NAICCode;
    STRING120 naicsDesc;
    STRING5 NAICIndustry;
    STRING7 NAICRiskLevel;
    BOOLEAN IsPrimary;
    STRING3 source;
    UNSIGNED riskiestLevel;
  END;

  EXPORT GeographicRiskLayout := RECORD 
    STRING12    buildgeolink;
    STRING3	    EasiTotCrime;
    STRING28    CityState;
    STRING5     FipsCode; 
    BOOLEAN     validFIPSCode;                          //populated in DueDiligence.CommonAddress.getAddressRisk
    STRING50    CountyName;                             //populated in DueDiligence.CommonAddress.getAddressRisk 
    BOOLEAN     CountyHasHighCrimeIndex;                //populated in DueDiligence.CommonAddress.getAddressRisk
    BOOLEAN     CountyBordersForgeinJur;                //populated in DueDiligence.CommonAddress.getAddressRisk
    BOOLEAN     CountyBorderOceanForgJur;               //populated in DueDiligence.CommonAddress.getAddressRisk
    BOOLEAN     CityBorderStation;                      //populated in DueDiligence.CommonAddress.getAddressRisk
    BOOLEAN     CityFerryCrossing;                      //populated in DueDiligence.CommonAddress.getAddressRisk
    BOOLEAN     CityRailStation;                        //populated in DueDiligence.CommonAddress.getAddressRisk
    BOOLEAN     HIDTA;                                  //populated in DueDiligence.CommonAddress.getAddressRisk
    BOOLEAN     HIFCA;                                  //populated in DueDiligence.CommonAddress.getAddressRisk
    BOOLEAN     censusRecordExists;                     //populated in DueDiligence.CommonAddress.getAddressRisk
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

  EXPORT DIDAndName := RECORD
    UNSIGNED6 did;
    Name;
  END;	
  
  EXPORT DIDNameAddrTaxID := RECORD
    DIDAndName;
    AddressSlimDetail;
    STRING countyName;
    STRING9 taxID;
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
    STRING10 phone;
    Address;
    UNSIGNED1 relationship;
  END;

  EXPORT CriminalTopLevel := RECORD
    //Top Level Data
    STRING2 state;
    STRING25 source;
    STRING35 caseNumber;
    STRING35 offenseStatute;
    UNSIGNED4 offenseDDFirstReportedActivity;
    UNSIGNED4 offenseDDLastReportedActivity;
    UNSIGNED4 offenseDDLastCourtDispDate;
    UNSIGNED2 offenseCategoryID;
    STRING100 offenseCategoryDescription;
    STRING75 offenseCharge;
    STRING1 offenseDDChargeLevelCalculated;
    STRING35 offenseChargeLevelReported; 
    STRING1 offenseConviction;
    STRING25 offenseIncarcerationProbationParole;
    STRING1 offenseTrafficRelated;

    //Additional details
    STRING county;
    STRING50 countyCourt;
    STRING25 city;
    STRING50 agency;
    STRING30 race;
    STRING1 sex;
    STRING15 hairColor;
    STRING5 eyeColor;
    STRING3 height;
    STRING3 weight;
  END;

  EXPORT CriminalSources := RECORD
    STRING75 charge;
    STRING1 conviction;
    STRING1 chargeLevelCalculated;
    STRING35 chargeLevelReported;
    STRING25 source;
    STRING50 courtDisposition1;
    STRING50 courtDisposition2;
    UNSIGNED4 reportedDate;
    UNSIGNED4 arrestDate;
    UNSIGNED4 courtDispDate;
    UNSIGNED4 appealDate;
    UNSIGNED4 sentenceDate;
    UNSIGNED4 sentenceStartDate;
    UNSIGNED4 DOCConvictionOverrideDate;
    UNSIGNED4 DOCScheduledReleaseDate;
    UNSIGNED4 DOCActualReleaseDate;
    STRING50 DOCInmateStatus;
    STRING50 DOCParoleStatus;
    STRING30 maxTerm;
    BOOLEAN currentlyIncarcerated;
    BOOLEAN currentlyParoled;
    BOOLEAN currentlyProbation;
    UNSIGNED4 DOCParoleActualReleaseDate;
    UNSIGNED4 DOCParolePresumptiveReleaseDate;
    UNSIGNED4 DOCParoleScheduledReleaseDate;
    STRING50 DOCParoleCurrentStatus;
    STRING50 DOCCurrentKnownInmateStatus;
    STRING25 DOCCurrentLocationSecurity;
    DATASET({STRING120 name}) partyNames;
  END;
  
  EXPORT LegalAttributes := RECORD
    BOOLEAN attr_stateLegalEvent9;
    BOOLEAN attr_stateLegalEvent8;
    BOOLEAN attr_stateLegalEvent7;
    BOOLEAN attr_stateLegalEvent6;
    BOOLEAN attr_stateLegalEvent5;
    BOOLEAN attr_stateLegalEvent4;
    BOOLEAN attr_stateLegalEvent3;
    BOOLEAN attr_stateLegalEvent2;
    
    BOOLEAN attr_offenseType9;
    BOOLEAN attr_offenseType8;
    BOOLEAN attr_offenseType7;
    BOOLEAN attr_offenseType6;
    BOOLEAN attr_offenseType5;
    BOOLEAN attr_offenseType4;
    BOOLEAN attr_offenseType3;
    BOOLEAN attr_offenseType2;
    BOOLEAN attr_offenseType0;
  END;

  EXPORT CriminalOffenses := RECORD
    //fields used for attribute calculation - calc based on roll of sources
    LegalAttributes;

    //Top Level Data
    CriminalTopLevel;

    //Source info
    DATASET(CriminalSources) sources;
  END;

  EXPORT RelatedParty := RECORD
    SlimIndividual;
    BOOLEAN isOwnershipProng;
    BOOLEAN isControlProng;
    STRING2 busAssociationScore;
    STRING10 busAssociationFlags;
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
    DATASET(CriminalOffenses) indOffenses;   //{MAXCOUNT(DueDiligence.Constants.MAX_OFFENSES)};
  END;

  EXPORT Associates := RECORD
    DIDAndName;
    BOOLEAN isBEO;
    BOOLEAN isOwnershipProng;
    BOOLEAN isControlProng;
    UNSIGNED3 numOfPositions;
    DATASET(Positions) positions;// {MAXCOUNT(DueDiligence.Constants.MAX_POSITIONS)};
  END;

  EXPORT BusAsscoiations := RECORD
    UNSIGNED6 ultID;
    UNSIGNED6 orgID;
    UNSIGNED6 seleID;
    //busines info
    STRING structure;
    DATASET(Associates) beos;
    DATASET(SlimIndividual) registeredAgents;
    DATASET(LayoutSICNAIC) sicNaicSources;
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

  EXPORT WatercraftDataLayout := RECORD
    BOOLEAN inquiredOwned;
    BOOLEAN spouseOwned;
    DATASET(DIDAndName) watercraftOwners;
    UNSIGNED8 purchasePrice;
    STRING4 year;
    STRING30 make;
    STRING30 model;
    STRING vesselType;
    STRING propulsion;
    STRING hullTypeDescription;
    STRING2 titleState;   //TO REMOVE AFTER WEB
    UNSIGNED2 vesselLengthFeet;
    UNSIGNED2 vesselLengthInches;
    UNSIGNED2 vesselTotalLength;	 
    UNSIGNED4 oldestTitleDate;
    UNSIGNED4 newestTitleDate;
    STRING registrationNumber;
    UNSIGNED4 oldestRegistrationDate;
    UNSIGNED4 newestRegistrationDate;
    STRING2 registrationState;
  END;

  EXPORT AircraftDataLayout := RECORD
    BOOLEAN inquiredOwned;
    BOOLEAN spouseOwned;
    DATASET(DIDAndName) aircraftOwners;

    STRING8 tailNumber;
    STRING4 year;
    STRING30 make;
    STRING30 model;
    STRING30 vin;
    STRING8 registrationDate;
    STRING12 manufactureModelCode;		//used to get number of engines
  END;

  EXPORT VehicleDataLayout := RECORD
    BOOLEAN inquiredOwned;
    BOOLEAN spouseOwned;
    DATASET(DIDAndName) vehicleOwners;
      
    STRING30 licensePlateType;
    STRING50 classType;
    STRING4 year;
    STRING36 make;
    STRING30 model;
    UNSIGNED6 basePrice;
    STRING25 vin;

    STRING2 titleState;
    STRING8 titleDate;
    STRING2 registeredState;
    STRING8 registeredDate;
  END;

  EXPORT SlimBusiness := RECORD
    STRING120 companyName;
    Address address;
    STRING14 phone;
    STRING11 fein;
  END;
  
  EXPORT SlimRelation := RECORD
    SlimIndividual;
    STRING2 rawRelationshipType;
    STRING2 relationToInquired;
    BOOLEAN offenseTrafficRelated;
    BOOLEAN otherCriminalOffense;
    BOOLEAN currentlyIncarcerated;    
    BOOLEAN everIncarcerated;
    BOOLEAN potentialSexOffender;
    BOOLEAN currentlyParoleOrProbation;
    BOOLEAN felonyPast3Yrs;
    UNSIGNED4 headerFirstSeenDate;
    BOOLEAN validSSN;
    UNSIGNED4 ssnLowIssueDate;
    UNSIGNED2 ssnMultiIdentities;
    UNSIGNED2 ssnPerADL;
    BOOLEAN hasSSN;
    BOOLEAN ssnRisk;
  END;
  
  EXPORT SourceDetailsLayout := RECORD
    STRING2 source;
    UNSIGNED sourceCount;
    UNSIGNED sourceFirstSeen;
    UNSIGNED sourceLastSeen;
  END;
  
  EXPORT ssnDetails := RECORD
    STRING9 ssn;
    UNSIGNED4 firstSeen;
    UNSIGNED4 lastSeen;
    UNSIGNED4 issuedLowDate;
    UNSIGNED4 issuedHighDate;
    STRING2 issuedState;
    BOOLEAN randomized;
    BOOLEAN enumerationAtEntry;
    BOOLEAN isITIN;
    BOOLEAN invalid;
    BOOLEAN issuedPriorToDOB;
    BOOLEAN randomlyIssuedInvalid;
    BOOLEAN reportedDeceased;
    DATASET(SourceDetailsLayout) sourceInfo;
  END;
  
  EXPORT AddressDetails := RECORD
    UNSIGNED6 seq;
    AddressSlimDetail;
    UNSIGNED4 dateFirstSeen;
    UNSIGNED4 dateLastSeen;
  END;
  
  EXPORT LiensJudgementsEvictionDetails := RECORD
    STRING50 rmsid;
    STRING50 tmsid;
    STRING50 filingTypeDesc;
    STRING11 filingAmount;
    UNSIGNED4 filingDate;
    STRING20 filingNumber;
    STRING20 filingJurisdiction;
    UNSIGNED4 releaseDate;
    STRING1 eviction;
    STRING75 agency;
    STRING2 agencyState;
    STRING25 agencyCounty;
    DATASET(DIDNameAddrTaxID) debtors;
    DATASET(DIDNameAddrTaxID) creditors;
  END;

  EXPORT BusReportDetails := RECORD
    SlimBusiness bestBusInfo;
    DATASET(BusPropertyDataLayout) busProperties {MAXCOUNT(DueDiligence.Constants.MAX_PROPERTIES)};
    DATASET(WatercraftDataLayout) busWatercraft {MAXCOUNT(DueDiligence.Constants.MAX_WATERCRAFT)};
    DATASET(AircraftDataLayout) busAircraft {MAXCOUNT(DueDiligence.Constants.MAX_AIRCRAFT)};
    DATASET(VehicleDataLayout) busVehicle {MAXCOUNT(DueDiligence.Constants.MAX_VEHICLE)}; 
    DATASET(CommonGeographicLayout) operatingLocations {MAXCOUNT(DueDiligence.Constants.MAX_OPERATING_LOCATIONS)};
    BOOLEAN FEINSourceContainsE5;
    STRING9 FEIN_Masked_For_Report;
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
    DATASET(DIDAndName) namesAssocWithFein {MAXCOUNT(DueDiligence.Constants.MAX_ASSOCIATED_FEIN_NAMES)};
    DATASET(DD_CompanyNames) companyDBA {MAXCOUNT(DueDiligence.Constants.MAX_DBA_NAMES)};
    STRING parentCompanyName;
    UNSIGNED2 DIDlessBEOCount; 
    DATASET(RelatedParty) DIDlessExecs {MAXCOUNT(DueDiligence.Constants.MAX_EXECS)};
    DATASET(LiensJudgementsEvictionDetails) busLJEDetails {MAXCOUNT(DueDiligence.Constants.MAX_LIENS_JUDGEMENTS_EVICTIONS)};
  END;

  EXPORT IndReportDetails := RECORD
    STRING9 bestSSN;
    STRING10 bestPhone;
    UNSIGNED4 bestDOB;
    UNSIGNED4 dateLastReported;
    Name bestName;
    Address bestAddress;
    DATASET(IndPropertyDataLayout) perProperties {MAXCOUNT(DueDiligence.Constants.MAX_PROPERTIES)};
    DATASET(WatercraftDataLayout) perWatercraft {MAXCOUNT(DueDiligence.Constants.MAX_WATERCRAFT)};
    DATASET(VehicleDataLayout) perVehicle {MAXCOUNT(DueDiligence.Constants.MAX_VEHICLE)};  
    DATASET(AircraftDataLayout) perAircraft {MAXCOUNT(DueDiligence.Constants.MAX_AIRCRAFT)};
    DATASET(BusAsscoiations) perBusinessAssociations;// {MAXCOUNT(DueDiligence.Constants.MAX_BUS_ASSOCIATIONS)}; 
    ssnDetails inputSSNDetails;
    ssnDetails bestSSNDetails;
    DATASET({STRING9 ssn}) ssnOnFile;
    DATASET({STRING8 dob}) dobOnFile;
    DATASET(Name) akas;
    DATASET(addressDetails) residences {MAXCOUNT(DueDiligence.Constants.MAX_RESIDENCES)};
    DATASET(LiensJudgementsEvictionDetails) ljeDetails {MAXCOUNT(DueDiligence.Constants.MAX_LIENS_JUDGEMENTS_EVICTIONS)};
  END;




  EXPORT Indv_Internal := Record
    UNSIGNED6 seq := 0;
    UNSIGNED4 historyDate;													//If all 9s will be todays date, otherwise cleaned input date (actual date value)
    UNSIGNED4 historyDateRaw;										    //cleaned date used to calc history date
    BOOLEAN inputAddressProvided;
    BOOLEAN fullInputAddressProvided;
    Indv_Input indvRawInput;
    UNSIGNED6 inquiredDID;
    RelatedParty individual;											  //populated in DueDiligence.getIndAttributes, DueDiligence.getIndInformation
    GeographicRiskLayout; 
    UNSIGNED4 numberOfSpouses;																							
    DATASET(SlimRelation) spouses;																												//populated in DueDiligence.getIndRelationships
    UNSIGNED4 numberOfParents;
    DATASET(SlimRelation) parents {MAXCOUNT(DueDiligence.Constants.MAX_PARENTS)}; 			  //populated in DueDiligence.getIndRelationships
    UNSIGNED4 numberOfAssociates;
    DATASET(SlimRelation) associates;
    STRING2 indvType;                         		  //II = Inquired Individual, IS = Inquired Individual Spouse,  IP = Inquired Individual Parent, 
    
    INTEGER2 cit_inputSSNInvalid;
    INTEGER2 cit_inputSSNIssuePriorToDOB;
    INTEGER2 cit_inputSSNRandomIssuedInvalid;
    INTEGER2 cit_inputSSNReportedDeceased;
    INTEGER2 cit_lexIDBestSSNInvalid;
    INTEGER2 cit_lexIDMultipleSSNs;
    INTEGER2 cit_lexIDReportedDeceased;
    UNSIGNED4 cit_lastReportedByAnySource;
    INTEGER2 cit_inputSSNITIN;
    INTEGER7 cit_lexID;
    STRING1 bs_iidSocsValFlag;
    STRING1 bs_iidPwSocsValFlag;
    STRING1 bs_inputSocsCharFlag;
    UNSIGNED2 bs_adlPerBestSSN;
    UNSIGNED1 bs_adlsPerSSN;
    STRING1 bs_bestSSNDecsFlag;
    STRING1 bs_bestSSNSSNDOBFlag;
    BOOLEAN bs_lexIDDeceased;
    STRING9 bs_bestSSN;
    STRING1 bs_bestSSNValid;
    STRING1 dd_bestSSNReportedDeceased;
    BOOLEAN dd_bestSSNInvalid;
    BOOLEAN dd_bestSSNIssuedPriorDOB;
    BOOLEAN dd_bestSSNRandomIssuedInvalid;
    
    

    DueDiligence.LayoutsAttributes.PersonAttributeValues;         //used in calc'ing attribute values in getIndKRI

    IndReportDetails;                               //Used to hold report data when we have access instead of multiple key calls
    PerAttributes;
    iesp.duediligencepersonreport.t_DDRPersonReport personReport;
  END;


  EXPORT Busn_Internal := Record
    UNSIGNED6	  seq := 0;
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

    UNSIGNED4		filingDate;	
    BOOLEAN			sosFilingExists;												            //populated in DueDiligence.getBusSOSDetail
    STRING2			residentialAddr;												            //populated in DueDiligence.getBusAsInd
    UNSIGNED1		personNameSSN;													            //populated in DueDiligence.getBusAsInd
    UNSIGNED1		personAddrSSN;													            //populated in DueDiligence.getBusAsInd
    //BusIndustryRisk
    UNSIGNED3		numOfSicNaic;
    DATASET(LayoutSICNAIC) sicNaicSources {MAXCOUNT(DueDiligence.Constants.MAX_SIC_NAIC)};		//populated in DueDiligence.getBusSicNaic, DueDiligence.getBusHeader, DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail

    UNSIGNED3		numOfRegAgents;
    DATASET(LayoutAgent) registeredAgents {MAXCOUNT(DueDiligence.Constants.MAX_REGISTERED_AGENTS)};		//populated in DueDiligence.getBusRegistration, DueDiligence.getBusSOSDetail
                      
    UNSIGNED4	  BusnHdrDtLastSeen;										        	    //populated in DueDiligence.getBusHeader		
    STRING5     FIPsCode;

    //BusGeographicRisk
    GeographicRiskLayout;   

    BusAttributes;
    BusReportDetails;
    iesp.duediligencebusinessreport.t_DDRBusinessReport BusinessReport;
  END;


END;