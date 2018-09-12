IMPORT DueDiligence;

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

//------                                      ------
//------                                      ------
//------  Populated with data for the report  ------
//------                                      ------
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
  
  //TO BE REMOVED AFTER DUEDIL-424
  InternalSeqAndIdentifiersLayout  VehicleReportData;
  string2			Source_Code;
  string1     Orig_name_type;
  string5			Orig_Make_Code;                 
  string3			Orig_Series_Code;
  string25		Orig_Series_Desc;               
  string3			Orig_Model_Code;                
  UNSIGNED4   historyDateYYYYMMDD;
  unsigned4   sl_vehicleCount  := 0;
  
 END;		
 
 EXPORT SharedVehicleSlim := RECORD
    InternalSeqAndIdentifiersLayout;
    UNSIGNED4 totalvehicleCount;  //TO BE REMOVED AFTER DUEDIL-424 
    UNSIGNED6 maxBasePrice;
    DATASET(DueDiligence.Layouts.VehicleDataLayout) allVehicles;
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
	
	
//------                                     ------
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
    STRING sort_key;
    STRING sort_eventTypeCodeFull;
    UNSIGNED1 temp_chargeLevelCalcWeight;
    DueDiligence.Layouts.CriminalOffenses
  END;

  EXPORT IndCrimLayoutFlat := RECORD
    InternalSeqAndIdentifiersLayout;
    UNSIGNED4 historyDate;
    
    //misc additional fields
    STRING offenderKey;
    STRING sort_key;
    STRING sort_eventTypeCodeFull;
    STRING8 temp_date;
    UNSIGNED temp_category;
    UNSIGNED4 temp_calcdFirstSeenDate;
    STRING8 temp_firstReportedActivity; 
    BOOLEAN temp_previouslyIncarcerated;
    STRING1 temp_offenseScore;
    STRING5 temp_courtOffLevel;
    
    //event type category hits
    BOOLEAN attr_legalEventCat9;
    BOOLEAN attr_legalEventCat8;
    BOOLEAN attr_legalEventCat7;
    BOOLEAN attr_legalEventCat6;
    BOOLEAN attr_legalEventCat5;
    BOOLEAN attr_legalEventCat4;
    BOOLEAN attr_legalEventCat3;
    BOOLEAN attr_legalEventCat2;
    
    //Top Level Data
    STRING50 state;
    STRING25 source; //also used in source info
    STRING caseNumber;
    STRING offenseStatute;
    STRING8 offenseDDFirstReportedActivity;
    UNSIGNED4 offenseDDLastReportedActivity;
    UNSIGNED4 offenseDDLastCourtDispDate;
    UNSIGNED offenseDDLegalEventTypeCode;
    STRING offenseDDLegalEventTypeMapped;
    STRING offenseCharge; //also used in source info
    STRING1 offenseDDChargeLevelCalculated;
    STRING offenseChargeLevelReported; //also used in source info
    STRING7 offenseConviction; //also used in source info
    STRING15 offenseIncarcerationProbationParole;
    STRING7 offenseTrafficRelated;
    
    //Additional details
    STRING30 county;
    STRING40 countyCourt;
    STRING40 city;
    STRING50 agency;
    STRING30 race;
    STRING7 sex;
    STRING15 hairColor;
    STRING15 eyeColor;
    STRING3 height;
    STRING3 weight;
    
    //Source info
    STRING1 offenseChargeLevelCalculated;
    STRING courtDisposition1;
    STRING courtDisposition2;
    UNSIGNED4 offenseReportedDate;
    UNSIGNED4 offenseArrestDate;
    UNSIGNED4 offenseCourtDispDate;
    UNSIGNED4 offenseAppealDate;
    UNSIGNED4 offenseSentenceDate;
    UNSIGNED4 offenseSentenceStartDate;
    UNSIGNED4 DOCConvictionOverrideDate;
    UNSIGNED4 DOCScheduledReleaseDate;
    UNSIGNED4 DOCActualReleaseDate;
    STRING DOCInmateStatus;
    STRING DOCParoleStatus;
    STRING offenseMaxTerm;
    
    //Party Names
    STRING120 partyName;
  END;


END;