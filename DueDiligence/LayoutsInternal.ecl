﻿IMPORT DueDiligence;

EXPORT LayoutsInternal := MODULE

 EXPORT InternalSeqAndIdentifiersLayout := RECORD
		UNSIGNED4 seq;
		UNSIGNED6 ultID;
		UNSIGNED6 orgID;
		UNSIGNED6 seleID;
		UNSIGNED6 proxID;
		UNSIGNED6 powID;
    UNSIGNED6 did;
	END; 
	
	EXPORT CommonGeographicLayout   := RECORD
		DueDiligence.Layouts.BusOperLocationLayout;
	END;
	
	
//*** This is my simple/flat dataset - use this layout to call the getGeographic Risk ***
	EXPORT GeographicLayout   := RECORD
	 InternalSeqAndIdentifiersLayout;
	 CommonGeographicLayout;
	END;
 
 
 //*** Use this layout to build a nested dataset (GeographicLayout) 
	EXPORT OperatingLocationLayout := RECORD
		InternalSeqAndIdentifiersLayout;                                 
		UNSIGNED3 addrCount;
		DATASET(CommonGeographicLayout) locAddrs;
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


//------                                      ------
//------  BusPropertyOwnedWithDetails         ------
//------  Populated with data for the report  ------
//------                                      ------
  EXPORT PropertySlimLayout := RECORD
   InternalSeqAndIdentifiersLayout; 
   STRING12  LNFaresId;
   STRING2   sourceCode;

   //person related
   BOOLEAN inquiredOwned;
   BOOLEAN spouseOwned;

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

   STRING10  prim_range;
   STRING2   predir;
   STRING28  prim_name;
   STRING4   suffix;
   STRING2   postdir;
   STRING10  unit_desig;
   STRING8   sec_range;
   STRING25  p_city_name;
   STRING25  v_city_name;
   STRING2   st;
   STRING5   zip;
   STRING4   zip4;
   STRING5   county;
   STRING7   geo_blk;
  END;					
	
	

//------                                      ------
//------                                      ------
//------  Populated with data for the report  ------
//------                                      ------
 EXPORT VehicleSlimLayout := RECORD
  InternalSeqAndIdentifiersLayout  VehicleReportData;
  string30		Vehicle_Key;
		string15		Iteration_Key;
		string2			Source_Code;
		string1     Orig_name_type;
		string25		Orig_VIN;                       //*** VIN
		string4			Orig_Year;                      //*** Year
		string5			Orig_Make_Code;                 //???
		string36		Orig_Make_Desc;                 //*** Make
		string3			Orig_Series_Code;
		string25		Orig_Series_Desc;               //*** class type?
		string3			Orig_Model_Code;                //???
		string30		Orig_Model_Desc;                //*** Model
		unsigned6   Vina_Price;                     //*** base price
		UNSIGNED4   historyDateYYYYMMDD;
		unsigned4   sl_vehicleCount  := 0;
		string30    license_Plate_Type;            //*** reg license plate type desc
		string50    Class_Type;
		/*  Registration */
		string2     Registered_State;                     //*** Title State
	 integer2    Registered_Year;                      //*** Title Year
		integer2    Registered_Month;                     //*** Title Month
		integer2    Registered_Day; 
		/*  Title        */  
		string2     Title_State;                     //*** Title State
	 integer2    Title_Year;                      //*** Title Year
		integer2    Title_Month;                     //*** Title Month
		integer2    Title_Day;                       //*** Title Day  
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
//------   Criminal Offense details          ------
//------                                     ------
//------                                     ------
	EXPORT CriminalDATASETLayout := RECORD
  unsigned4		seq := 0;
		unsigned6 	did;
		string60 	offender_key; 
		DATASET(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense) DIDOffenses;
	END;
	
	EXPORT CriminalOffenses := RECORD
		InternalSeqAndIdentifiersLayout;
		DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense offense;
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
  




END;