IMPORT DueDiligence, Risk_Indicators;

EXPORT LayoutsInternal := MODULE

  EXPORT InternalSeqAndIdentifiersLayout := RECORD
    UNSIGNED6 seq;
    UNSIGNED6 ultID;
    UNSIGNED6 orgID;
    UNSIGNED6 seleID;
    UNSIGNED6 proxID;
    UNSIGNED6 powID;
    UNSIGNED6 did;
  END;


  EXPORT BestData := RECORD
    InternalSeqAndIdentifiersLayout;
    BOOLEAN lexIDInput;
    BOOLEAN lexIDValid;
    BOOLEAN piiInput;
    BOOLEAN piiValid;
    BOOLEAN lexIDChanged;
    BOOLEAN bestAddressUsed;
    BOOLEAN inputAddressUsed;
    STRING120 companyName;
    STRING120 altCompanyName;
    STRING11 fein;
    DueDiligence.Layouts.Name name;
    DueDiligence.Layouts.Address address;
    DueDiligence.Layouts.Address bestAddress;
    STRING9 ssn;
    STRING8 dob;
    STRING10 phone;
    UNSIGNED1 lexIDScore;
  END;


  EXPORT SharedInput := RECORD
    BestData dataToUse;
    DueDiligence.Layouts.CleanedData;
    DueDiligence.Citizenship.Layouts.IndicatorLayout riskIndicators;
    Risk_Indicators.Layout_Boca_Shell bs;
  END;


  EXPORT BEOLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    STRING title;
    UNSIGNED4 partyFirstSeen;
    UNSIGNED4 partyLastSeen;
    BOOLEAN isExec;
    BOOLEAN isOwnershipProng;
    BOOLEAN isControlProng;
    DueDiligence.Layouts.RelatedParty relatedParty;
  END;

  EXPORT IndBusAssociations := RECORD
    UNSIGNED6 inputSeq;
    InternalSeqAndIdentifiersLayout;
    DueDiligence.Layouts.BusAsscoiations busAssociation;
    STRING2 busAssocScore;
    STRING10 busAssocFlags;
  END;


  //*** This is my simple/flat dataset - use this layout to call the getGeographic Risk ***
  EXPORT GeographicLayout   := RECORD
    InternalSeqAndIdentifiersLayout;
    DueDiligence.Layouts.CommonGeographicLayout;
  END;


  //*** Use this layout to build a nested dataset (GeographicLayout) 
  EXPORT OperatingLocationLayout := RECORD
    InternalSeqAndIdentifiersLayout;                                 
    UNSIGNED3 addrCount;
    DATASET(DueDiligence.Layouts.CommonGeographicLayout) locAddrs;
  END;


  EXPORT SicNaicLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    DATASET(DueDiligence.Layouts.LayoutSICNAIC) sources {MAXCOUNT(DueDiligence.Constants.MAX_SIC_NAIC)};
  END;

  EXPORT SicNaicUniqueIndustryLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    DueDiligence.Layouts.LayoutSICNAIC;
    DueDiligence.Layouts.SicNaicRiskLayout;
  END;

  EXPORT SlimSicNaicLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    DueDiligence.Layouts.LayoutSICNAIC;
    STRING codeDescription;
    STRING8 formattedSicCode;
  END;

  EXPORT AgentLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    DATASET(DueDiligence.Layouts.LayoutAgent) agents {MAXCOUNT(DueDiligence.Constants.MAX_REGISTERED_AGENTS)};
  END;

  EXPORT Agent := RECORD
    InternalSeqAndIdentifiersLayout;
    UNSIGNED4	  historydate;
    DueDiligence.Layouts.LayoutAgent agent;
  END;

  EXPORT LinkedBusLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    DATASET(DueDiligence.Layouts.Busn_Input) linkedBus {MAXCOUNT(DueDiligence.Constants.MAX_LINKED_BUSINESSES)};
  END;

  EXPORT RelatedPartyLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    DATASET(DueDiligence.Layouts.RelatedParty) executives {MAXCOUNT(DueDiligence.Constants.MAX_EXECS)};
  END;

  EXPORT RelatedParty := RECORD
    InternalSeqAndIdentifiersLayout;
    UNSIGNED4	  historydate;
    DueDiligence.Layouts.RelatedParty party;
  END;

  EXPORT PartyLicenses := RECORD
    InternalSeqAndIdentifiersLayout;
    UNSIGNED4	  historydate;
    DueDiligence.Layouts.Licenses license;
  END;


  EXPORT MultipleNames := RECORD
    InternalSeqAndIdentifiersLayout;
    DATASET(DueDiligence.Layouts.LayoutAgent) nameAndDate {MAXCOUNT(DueDiligence.Constants.MAX_ASSOCIATED_FEIN_NAMES)};
  END;

  EXPORT MultipleCompanyNames := RECORD
    InternalSeqAndIdentifiersLayout;
    DATASET(DueDiligence.Layouts.DD_CompanyNames) companyNameAndLastSeen {MAXCOUNT(DueDiligence.Constants.MAX_DBA_NAMES)};
  END;

  EXPORT SourceLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    DATASET(DueDiligence.Layouts.BusSourceLayout) sources;
  END;



  EXPORT PropertySlimLayout := RECORD
    InternalSeqAndIdentifiersLayout; 
    STRING12  LNFaresId;
    STRING2   sourceCode;

    //person related
    BOOLEAN inquiredOwned;
    BOOLEAN spouseOwned;
    DATASET(DueDiligence.Layouts.DIDAndName) ownerNames;
    STRING1 vacancyIndicator;

    //business related
    UNSIGNED4 dateFirstSeen;
    UNSIGNED4 dateLastSeen;
    STRING120 ownerName;

    //used for report by both person/business
    UNSIGNED4 historyDate;
    STRING50  addressType;
    STRING1   ownerOccupied;

    STRING8   recordingDate;
    STRING8   purchaseDate; 
    INTEGER8  purchasePrice;
    INTEGER2  lengthOfOwnership;

    STRING4 assessedYear;
    INTEGER8 assessedTotalValue;

    DueDiligence.Layouts.AddressSlimDetail;
  END;					



  EXPORT WatercraftSlimLayout := RECORD
    InternalSeqAndIdentifiersLayout; 
    STRING30 watercraftKey;		//used to get watercraft details
    STRING30 sequenceKey;			//used to get watercraft details
    STRING2 stateOrigin;			//used to get watercraft details

    UNSIGNED4 historyDate;
    DueDiligence.Layouts.WatercraftDataLayout;
  END;	

  EXPORT SharedWatercraftSlim := RECORD
    InternalSeqAndIdentifiersLayout;
    UNSIGNED4 totalWatercraft;
    UNSIGNED2 maxWatercraftLength;
    DATASET(DueDiligence.Layouts.WatercraftDataLayout) allWatercraft;
  END;

  EXPORT AircraftSlimLayout := RECORD
    InternalSeqAndIdentifiersLayout;

    UNSIGNED4 historyDate;
    UNSIGNED6 id;
    UNSIGNED4 dateFirstSeen;
    UNSIGNED4 dateLastSeen;
    STRING1 statusFlag;

    DueDiligence.Layouts.AircraftDataLayout;
  END;


  EXPORT VehicleSlimLayout := RECORD
    InternalSeqAndIdentifiersLayout;
    STRING30 Vehicle_Key;
    STRING15 Iteration_Key;
    STRING15 Sequence_Key;
    UNSIGNED4 historyDate, 
    UNSIGNED4 dateFirstSeen;
    STRING1 historyFlag;
    STRING1 nameType;
    DueDiligence.Layouts.VehicleDataLayout;
    //DPPA verification fields
    STRING2 stateOrigin;
    STRING2 sourceCode;
  END;		

  EXPORT SharedVehicleSlim := RECORD
    InternalSeqAndIdentifiersLayout; 
    UNSIGNED6 maxBasePrice;
    DATASET(DueDiligence.Layouts.VehicleDataLayout) allVehicles {MAXCOUNT(DueDiligence.Constants.MAX_VEHICLE)};
  END;


  //------                                      ------
  //------      COMMON SECTION                  ------
  //------  Populated with Liens and Judgements ------
  //------                                      ------

  EXPORT common_layout_liens_judgments := RECORD
    STRING50 tmsid;
    UNSIGNED4	HistoryDate;
    UNSIGNED4 DateToUse; 
    UNSIGNED3 NumOfDaysAgo; 
    STRING20 filing_number;                      //***all these fields are from:  liensV2.key_liens_main_ID
    STRING20 filing_jurisdiction;             
    STRING8  date_first_seen;
    STRING8  date_last_seen;
    STRING1  eviction;
    STRING8  orig_filing_date;
    STRING50 filing_type_desc;
    STRING11 amount;
    STRING8  release_date;
    STRING8  lapse_date;
    STRING30 filing_status;
    STRING75 agency;
    STRING2  agency_state;
    STRING25 agency_county; 
  END;


  EXPORT plus_category_liens_judgments := RECORD
    STRING  lien_type_category;
    STRING  judgment_type_category;
    STRING  filing_status_category;
  END;

  //------                                      ------
  //------      For Businesses                  ------
  //------  Populated with Liens and Judgements ------
  //------                                      ------

  EXPORT layout_liens_judgments := RECORD
    InternalSeqAndIdentifiersLayout;
    common_layout_liens_judgments;   
  END;

  //------                                      ------
  //------  Populated with Liens and Judgements ------
  //------                                      ------
  EXPORT 	layout_liens_judgments_categorized := RECORD
    layout_liens_judgments;
    plus_category_liens_judgments;
  END;

  //------                                      ------
  //------      For Individual                  ------
  //------  Populated with Liens and Judgements ------
  //------                                      ------

  EXPORT LiensLayout_by_DID:= RECORD
    unsigned4		seq := 0;
    unsigned6 	did;
    STRING50 		rmsid; // liens extras
    common_layout_liens_judgments;  
  END;

  EXPORT 	ByDID_liens_judgments_categorized := RECORD
    LiensLayout_by_DID;
    plus_category_liens_judgments; 
  END;



  EXPORT CriminalOffenses := RECORD
    InternalSeqAndIdentifiersLayout;
    DueDiligence.Layouts.CriminalOffenses offense;
  END;



  EXPORT IndSlimHeader := RECORD
    UNSIGNED4 seq;
    UNSIGNED6 inquiredDID;
    UNSIGNED6 did;
    STRING2 indvType;
    UNSIGNED4 historydate;
    DueDiligence.Layouts.Name;
    STRING ssn;
    DueDiligence.Layouts.Address;
    UNSIGNED4 dateFirstSeen;
    STRING50 src;
  END;


  EXPORT FeinSources := RECORD
    InternalSeqAndIdentifiersLayout;
    STRING9 companyFEIN;
    STRING9 maskedFEIN;  
    STRING6 mask;  
    BOOLEAN FEINSourceContainsE5;  
    DATASET(DueDiligence.Layouts.FEINLayoutSources) Sources;    
  END;



  EXPORT IndCrimLayoutFinal := RECORD
    InternalSeqAndIdentifiersLayout;
    UNSIGNED4 historyDate;
    STRING sort_key;
    UNSIGNED category;
    BOOLEAN currIncar;
    BOOLEAN currParole;
    BOOLEAN currProbation;
    BOOLEAN prevIncar;
    DueDiligence.Layouts.CriminalOffenses
  END;

  EXPORT IndCrimLayoutFlat := RECORD
    InternalSeqAndIdentifiersLayout;
    UNSIGNED4 historyDate;


    //misc additional fields
    STRING offenderKey;
    STRING sort_key;
    STRING8 temp_offenseDate;
    UNSIGNED temp_category;
    UNSIGNED4 temp_calcdFirstSeenDate; 
    BOOLEAN temp_previouslyIncarcerated;
    STRING1 temp_offenseScore;
    STRING5 temp_courtOffLevel;
    UNSIGNED4 sentenceEndDate;
    UNSIGNED4 incarAdmitDate;
    STRING parole;
    STRING probation;

    //Top Level Data
    //Remove duplicate fields that are in the source detail - will be rolled up
    DueDiligence.Layouts.CriminalTopLevel AND NOT [source, offenseCharge, offenseChargeLevelReported, offenseConviction];
        
    //Source/Detail info
    DueDiligence.Layouts.CriminalSources AND NOT [partyNames];

    //Party Names
    STRING120 partyName;
    DATASET({STRING120 name}) uniquePartyNames;
  END;
  
  EXPORT addressDetails := RECORD
    UNSIGNED6 addressSeq;
    DueDiligence.Layouts.AddressSlimDetail;
    UNSIGNED4 dateFirstSeen;
    UNSIGNED4 dateLastSeen;
  END;
  
  EXPORT chronoAddressesLayout := RECORD
    UNSIGNED6 seq;
    UNSIGNED6 did;
    UNSIGNED4 historyDate;
    BOOLEAN moveWithin3Yrs;
    UNSIGNED1 addrs_last36;
    STRING10 chronoprim_range := '';
    STRING2  chronopredir:= '';
    STRING28 chronoprim_name:= '';
    STRING4  chronosuffix:= '';
    STRING2  chronopostdir:= '';
    STRING10 chronounit_desig:= '';
    STRING8  chronosec_range:= '';
    STRING30 chronocity := '';
    STRING2 chronostate := '';
    STRING5 chronozip := '';
    STRING4 chronozip4 := '';
    STRING3 chronocounty := '';
    STRING7 chronogeo_blk := '';
    UNSIGNED3 chronodate_first := 0;
    UNSIGNED3 chronodate_last := 0;
    UNSIGNED3 address_history_seq;
    STRING2 src := '';
    DATASET(addressDetails) chronoAddresses;
  END;
  
  EXPORT DistanceZipLayout := RECORD
    UNSIGNED6 did;
    UNSIGNED6 seq;
    UNSIGNED3 addressHistorySeq;
    UNSIGNED4 dateFirstSeen;
    STRING5 chronoZip;
    
    STRING5  addr1_zip;
    UNSIGNED4 addr1_firstSeenDate;
    STRING5  addr2_zip;
    UNSIGNED4 addr2_firstSeenDate;
    STRING5  addr3_zip;
    UNSIGNED4 addr3_firstSeenDate;
    STRING5  addr4_zip;
    UNSIGNED4 addr4_firstSeenDate;
    
    STRING5  Move1_dist;
    STRING5  Move2_dist;
    STRING5  Move3_dist;
  END;


END;