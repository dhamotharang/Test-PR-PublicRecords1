IMPORT DueDiligence, iesp;

EXPORT LayoutsInternalReport := MODULE

	EXPORT VinTitleAndRegistration := RECORD
		STRING30		vin;
		STRING2   	titleState;
		STRING8   	titleDate;
		STRING2   	registrationState;
    STRING8   	registrationDate;
	END;
	
	EXPORT YearMakeModel := RECORD
		STRING4   	year;
		STRING30  	make;
		STRING30  	model;
	END;

  EXPORT BusAircraftSlimLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
		YearMakeModel;
		STRING1   detailType; 
		UNSIGNED1	numberOfEngines;
		STRING10		tailNumber;
		VinTitleAndRegistration;
		STRING12	manufactureModelCode;		//used to get number of engines
  END;								

  
  EXPORT SharedPropertyLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    DueDiligence.LayoutsInternal.PropertySlimLayout;
    DueDiligence.Layouts.GeographicRiskLayout;
  END;

  
  EXPORT SharedWatercraftLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    BOOLEAN inquiredOwned;
    BOOLEAN spouseOwned;
    DATASET(DueDiligence.Layouts.DIDAndName) owners;
    iesp.duediligenceshared.t_DDRWatercraft;
  END;
 
 EXPORT SharedVehicleLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    BOOLEAN inquiredOwned;
    BOOLEAN spouseOwned;
    DATASET(DueDiligence.Layouts.DIDAndName) owners;
    iesp.duediligenceshared.t_DDRMotorVehicle;
  END;
	
	
	EXPORT ListOfBusSourceLayout := RECORD
	 DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
   DATASET(iesp.duediligencebusinessreport.t_DDRReportingSources) sources;
	END;




 
// ------                                                                             ------
// ------    define an intermediate layout to hold information about these executives ------ 
// ------    that have criminal activity                                              ------
// ------    this list has executives and all of it's child datasets including party  ------
  EXPORT FlatListOfIndividualsWithCriminalLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout; 
    DueDiligence.Layouts.SlimIndividual;
    string20 mostRecentTitle;
    DueDiligence.Layouts.CriminalOffenses crimData;   
  END;
  
  // ------                                                                            ------
  // ------ define the internal GrandChildDataset for the Legal Events section  report ------
	// ------   these list just the offenses and nothing about the person charged        ------
  // ------   *********************************************************************    ------
	EXPORT ReportingOfIndvCriminalChildDatasetLayout    := RECORD
	 DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;      //*  This is the LINKID number of the parent  
	 iesp.duediligenceshared.t_DDRLegalEventIndividual;
	 string ExecTitle;
   DATASET(iesp.duediligenceshared.t_DDRLegalStateCriminal)  criminalChildDS;
	END;
  // ------                                                                       ------
  // ------ define the internal ChildDataset for the Legal Events section report  ------
	// ------                                                                       ------
	EXPORT BusAircraftReportChildren := RECORD
		DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
		DATASET(iesp.duediligenceshared.t_DDRAircraft) air {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxAircraft)};
	END;
	
	EXPORT BusWatercraftReportChildren := RECORD
		DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
		DATASET(iesp.duediligenceshared.t_DDRWatercraft) water {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxWatercraft)};
	END;
	
	EXPORT BusIndustryRiskChildren := RECORD
		DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
		DATASET(iesp.duediligencebusinessreport.t_DDRSICNAIC) industryRisk {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxSICNAICs)};
	END;
	
	
	EXPORT ReportingOfOperatingLocations  := RECORD
	 DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout; 
	 DueDiligence.Layouts.CommonGeographicLayout ReportOfOperatingLocs;
	END;
	
	
	EXPORT BusCorpFilingsSlimLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    UNSIGNED4	  historydate;
    STRING    CorpKey;
		STRING150 BusinessName;                                 //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp legal name
	  STRING20  FilingType;                                   //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing desc.   
    BOOLEAN   isActive;
	  STRING20  FilingStatus;                                 //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp status desc (example is ACTIVE)
	  UNSIGNED4 FilingDate;                                   //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing date 
	  UNSIGNED4 IncorporationDate;                            //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp inc date 
		UNSIGNED4 LastSeenDate;                                 //***from Corp2.Key_LinkIDs.Corp.kfetch2 - 
	  STRING30  FilingNumber;                                 //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing reference nbr
	  STRING2   IncorporationState;                           //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp inc state
    STRING    OrgStructure;
	END;
	
	
	EXPORT ReportingOfSOSFilingsChildLayout     :=  RECORD 
	  DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    STRING corpKey;
	  DATASET(iesp.duediligencebusinessreport.t_DDRSOSFiling) BusSOSFilingsChild;   
 END;	
 
  // ------                                                                      ------
  // ------ define the ChildDataset  For Debtors                                 ------
	// ------                                                                      ------
 EXPORT	BusLiensDebtorsCreditorsChildDatasetLayout    := RECORD
	  DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout; 
	  DATASET(iesp.duediligenceshared.t_DDRCreditorDebtor) BusLiensDebtorCreditorChild;
	END; 
 
  // ------                                                                      ------
  // ------ define the ChildDataset  For Business Liens                          ------
	// ------                                                                      ------
 EXPORT	BusLiensChildDatasetLayout    := RECORD
	  DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout; 
	  DATASET(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions) BusLiensChild;
	END;
  
  EXPORT BusOpInfoAssociatedNamesByFein := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout; 
	  DATASET(iesp.share.t_Name) name;
  END;
  
  EXPORT BusOpInfoDBANames := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    DATASET(iesp.duediligencebusinessreport.t_DDRComponentsOfBusiness) businessNames {MAXCOUNT(iesp.constants.DDRAttributesConst.MaxBusinesses)};
  END;
  
  EXPORT BusRegisteredAgents := RECORD
		DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
		DATASET(iesp.duediligencebusinessreport.t_DDRRegisteredAgents) regAgents {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxRegisteredAgents)};
	END;
  
  EXPORT BusExecs := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    iesp.duediligencebusinessreport.t_DDRBusinessExecutives;
  END;
  
  EXPORT InquiredBusExecs := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutives) execs {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxBusinessExecs)};
  END;
	
  // ------                                                                      ------
  // ------ define the Flat      Dataset  For Debtors                            ------
	// ------                                                                      ------
 EXPORT	BusLiensDebtorsCreditorsFlatLayout    := RECORD
	  DueDiligence.LayoutsInternal.layout_liens_judgments_categorized;
		//unsigned6 did;
    STRING50  rmsid;
    STRING1   NameType;                   // D = Debtor   C = Creditor
    STRING20  TaxID;
    STRING8   party_date_first_seen;
		STRING8   party_date_last_seen;
	  iesp.duediligenceshared.t_DDRCreditorDebtor;  
	END; 
  
  // ------                                                                     ------
  // ------ define the internal Dataset for the Liens section  report           ------
  // ------                                                                     ------
	EXPORT ReportingofLiensDebtorChildDatasetLayout    := RECORD
	 DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;      //*  This is the LINKID number of the parent 
   // unsigned6 did;  
   STRING50 tmsid;
   UNSIGNED4	HistoryDate;
   STRING1    NameType;                   // D = Debtor   C = Creditor
	 iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions;  
	END; 
  
  EXPORT Associated_Businesses := RECORD
    /* this will be the Link id's of the Inquired Business      */
		DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout InquiredBus;
    /* this will be the link id's of the Associated Businesses of the BEO  */   
    DueDiligence.Layouts.Busn_Input Busn_Info;  
    unsigned4 HistoryDate;
    string50 AssociatedBusinessName;
    string50 AssociatedLEXID;    
  END;  
  
  EXPORT ReportingOfBEOAssociatedBus := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout  AssociatedBusLINKID;
    DATASET (iesp.duediligencebusinessreport.t_DDRBusinessNameWithLexID) RptAssocBusNames;
  END;
  
END;