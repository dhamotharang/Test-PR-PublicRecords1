IMPORT DueDiligence, iesp;

EXPORT LayoutsInternalReport := MODULE

  EXPORT OwnershipType := RECORD
    BOOLEAN inquiredOwned;
    BOOLEAN spouseOwned;
    DATASET(DueDiligence.Layouts.DIDAndName) owners;
  END;
								

  
  EXPORT SharedPropertyLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    DueDiligence.LayoutsInternal.PropertySlimLayout;
    DueDiligence.Layouts.GeographicRiskLayout;
  END;

  
  EXPORT SharedWatercraftLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    OwnershipType;
    iesp.duediligenceshared.t_DDRWatercraft;
  END;
 
  EXPORT SharedVehicleLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    OwnershipType;
    iesp.duediligenceshared.t_DDRMotorVehicle;
  END;
  
  EXPORT SharedAircraftLayout := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    STRING12 manufactureModelCode;
		OwnershipType;
		iesp.duediligenceshared.t_DDRAircraft;
  END;
	
	
	EXPORT ListOfBusSourceLayout := RECORD
	 DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
   DATASET(iesp.duediligencebusinessreport.t_DDRReportingSources) sources;
	END;


	EXPORT IndivBusAssociationLayout := RECORD
	 DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
	 UNSIGNED6 inputSeq;
	 UNSIGNED6 inquiredDID;
   iesp.duediligencepersonreport.t_DDRBusinessAssocationDetails association;
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
		STRING150 BusinessName;                                 //from Corp2.Key_LinkIDs.Corp.kfetch2 - corp legal name
	  STRING20  FilingType;                                   //from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing desc.   
    BOOLEAN   isActive;
	  STRING20  FilingStatus;                                 //from Corp2.Key_LinkIDs.Corp.kfetch2 - corp status desc (example is ACTIVE)
	  UNSIGNED4 FilingDate;                                   //from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing date 
	  UNSIGNED4 IncorporationDate;                            //from Corp2.Key_LinkIDs.Corp.kfetch2 - corp inc date 
		UNSIGNED4 LastSeenDate;                                 //from Corp2.Key_LinkIDs.Corp.kfetch2 - 
	  STRING30  FilingNumber;                                 //from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing reference nbr
	  STRING2   IncorporationState;                           //from Corp2.Key_LinkIDs.Corp.kfetch2 - corp inc state
    STRING    OrgStructure;
	END;
	
	
	EXPORT ReportingOfSOSFilingsChildLayout     :=  RECORD 
	  DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    STRING corpKey;
	  DATASET(iesp.duediligencebusinessreport.t_DDRSOSFiling) BusSOSFilingsChild;   
 END;	
 

  //define the ChildDataset  For Debtors 
 EXPORT	BusLiensDebtorsCreditorsChildDatasetLayout    := RECORD
	  DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout; 
	  DATASET(iesp.duediligenceshared.t_DDRCreditorDebtor) BusLiensDebtorCreditorChild;
	END; 
 

  //define the ChildDataset  For Business Liens 
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

  
  EXPORT Associated_Businesses := RECORD
    //this will be the Link id's of the Inquired Business
		DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout InquiredBus;
    //this will be the link id's of the Associated Businesses of the BEO
    DueDiligence.Layouts.Busn_Input Busn_Info;  
    unsigned4 HistoryDate;
    string50 AssociatedBusinessName;
    string50 AssociatedLEXID;    
  END;  
  
  EXPORT ReportingOfBEOAssociatedBus := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout  AssociatedBusLINKID;
    DATASET(iesp.duediligencebusinessreport.t_DDRBusinessNameWithLexID) RptAssocBusNames;
  END;
  
  EXPORT ReportIdentity := RECORD
    UNSIGNED6 seq;
    UNSIGNED6 inquiredDID;
    UNSIGNED estimatedAge;
    iesp.duediligencepersonreport.t_DDRPersonSSNDetails inputSSNDetails;
    iesp.duediligencepersonreport.t_DDRPersonSSNDetails bestSSNDetails; 
    iesp.duediligencepersonreport.t_DDRPersonLexIDInformation identityDetails;
    DATASET(iesp.duediligencepersonreport.t_DDRPersonLexIDSourcesReporting) allSourcesReporting;
    UNSIGNED2 allSourcesCounts;
  END;
  
  EXPORT PersonSSNDeviation := RECORD
    UNSIGNED6 seq;
    UNSIGNED6 inquiredDID; 
    UNSIGNED didTiedToSSN; 
    UNSIGNED4 historyDate; 
    STRING9 inputSSN; 
    STRING9 ssnOnFile; 
    STRING9 bestSSN; 
    STRING9 inquiredBestSSN;
    DueDiligence.Layouts.Name bestName; 
    DueDiligence.Layouts.Address bestAddress;
    UNSIGNED bestDOB;
    UNSIGNED2 relation;  
    STRING relationText;
    UNSIGNED differentSSNs;
    UNSIGNED differentBestSSNs;
    STRING9 maskedInputSSN; 
    STRING9 maskedSSNOnFile; 
    STRING9 maskedBestSSN; 
    DATASET(iesp.duediligencepersonreport.t_DDRPersonSSNDeviations) inputPersonDeviations;
    DATASET(iesp.duediligencepersonreport.t_DDRPersonSSNDeviations) bestPersonDeviations;
    DATASET(iesp.duediligencepersonreport.t_DDRPersonSSNLexID) reportedSSNs;
  END;
  
  EXPORT IdentitySources := RECORD
    UNSIGNED6 seq;
    UNSIGNED6 inquiredDID; 
    STRING source;
    UNSIGNED4 sourceCount;
    UNSIGNED4 sourceFirstSeen;
    UNSIGNED4 sourceLastSeen;
    UNSIGNED2 sourceID;
    STRING sourceCategory;
    UNSIGNED4 sourceCategoryCount;
    DATASET(iesp.duediligencepersonreport.t_DDRPersonSources) espInputSourceDetails;
    DATASET(iesp.duediligencepersonreport.t_DDRPersonSources) espBestSourceDetails;
    DATASET(iesp.duediligencepersonreport.t_DDRPersonLexIDSourcesReporting) espSourceDetailsWithDates;
  END;
  
  EXPORT IdentityNestedData := RECORD
    UNSIGNED6 seq;
    UNSIGNED6 inquiredDID;
    DueDiligence.Layouts.Name aka;
    DATASET(iesp.share.t_Name) espAKAs;
    UNSIGNED4 dob;
    DATASET(iesp.duediligencepersonreport.t_DDRPersonDOBAge) espDOBAge;
  END;
  
  EXPORT SlimResidentTenant := RECORD
    UNSIGNED6 residentDID;
    DueDiligence.Layouts.Name;
    BOOLEAN relative;
    BOOLEAN busAssocs;
    BOOLEAN highRiskProfServOfStudy;
    BOOLEAN potentialCrimArrest;
    BOOLEAN potentialSOs;
  END;
  
  EXPORT CurrentResidentTenantInfo := RECORD
    UNSIGNED6 inquiredSeq;
    UNSIGNED6 inquiredDID;
    UNSIGNED6 inquiredAddressSeq;
    SlimResidentTenant;
    DueDiligence.Layouts.AddressSlimDetail;
    UNSIGNED4 residentLastSeenDate;
    UNSIGNED4 residentFirstSeenDate;
    UNSIGNED4 historyDate;
  END;
  
  
  EXPORT MobilityData := RECORD
    UNSIGNED6 seq;
    UNSIGNED6 inquiredDID;
    UNSIGNED4 historyDate;
    DueDiligence.Layouts.AddressDetails addrs;
    STRING countyName;
    STRING movingDistances;
    STRING50 addressType;
    STRING10 currentPreviousIndicator;
    STRING residencyType;
    STRING25 areaRisk;
    UNSIGNED6 numberCurrentResidentTenants;
    UNSIGNED6 numberOfRelatives;
    UNSIGNED6 numberOfBusAssocs;
    UNSIGNED6 numberHighRiskProfServOfStudy;
    UNSIGNED6 numberPotentialCrimArrest;
    UNSIGNED6 numberOfPotentialSOs;
    DATASET(SlimResidentTenant) resTenInfo;
  END;
  
  
  EXPORT SharedCivilEvents := RECORD
    DueDiligence.LayoutsInternal.InternalSeqAndIdentifiersLayout;
    DueDiligence.Layouts.LiensJudgementsEvictionDetails;
  END;
  
END;