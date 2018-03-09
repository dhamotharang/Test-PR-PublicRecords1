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
    DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		YearMakeModel;
		STRING1   detailType; 
		UNSIGNED1	numberOfEngines;
		STRING10		tailNumber;
		VinTitleAndRegistration;
		STRING12	manufactureModelCode;		//used to get number of engines
  END;								

  EXPORT BusWatercraftSlimLayout := RECORD
    DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		STRING30 watercraftKey;		//used to get watercraft details
	  STRING30 sequenceKey;			//used to get watercraft details
		STRING2 stateOrigin;			//used to get watercraft details
		YearMakeModel;
		STRING		vesselType;
		UNSIGNED2 vesselLengthFeet;
		UNSIGNED2 vesselLengthInches;
		UNSIGNED2 vesselTotalLength;
		STRING		propulsion;
		VinTitleAndRegistration;
		UNSIGNED2 watercraftCount;
  END;
	
 EXPORT BusSourceLayout := RECORD
		STRING sourceName;
		STRING source;
		STRING sourceType;
		UNSIGNED4 firstReported;
		UNSIGNED4 lastReported;
	END;
	
	
	EXPORT ListOfBusSourceLayout := RECORD
	 DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		BusSourceLayout;   
	END;



 EXPORT BEOPositionLayout := RECORD
  DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
  unsigned6 did;   
  DueDiligence.Layouts.Positions;
  DueDiligence.Layouts.SlimIndividual;
  DATASET(DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense) BEOOffenses;  
  END;

 
// ------                                                                             ------
// ------    define an intermediate layout to hold information about these executives ------ 
// ------    that have criminal activity                                              ------
// ------    this list has executives and all of it's child datasets including party  ------
// ------    offenses
// ------    ********************************************************************     ------
 EXPORT BEOCriminalReportingOFOffenses := RECORD
  DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
  integer2 numberOfCriminalEvents;
  string20 mostRecentTitle;
  DueDiligence.Layouts.RelatedParty;     //***there is a DATASET of party offenses, positions and titles
  END;
  
  // ------                                                                            ------
  // ------ define a simple list of BEO's with Criminal Events                         ------
  // ------ ********************************************************                   ------ 
  EXPORT FlatListOfBEOWithCriminalLayout := RECORD
    DueDiligence.LayoutsInternal.InternalBIPIDsLayout; 
    DueDiligence.Layouts.SlimIndividual;
    string20 mostRecentTitle;
    DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense;   
  END;
  
  // ------                                                                            ------
  // ------ define the internal GrandChildDataset for the Legal Events section  report ------
	// ------   these list just the offenses and nothing about the person charged        ------
  // ------   *********************************************************************    ------
	EXPORT ReportingofBEOCriminalChildDatasetLayout    := RECORD
	 DueDiligence.LayoutsInternal.InternalBIPIDsLayout;      //*  This is the LINKID number of the parent  
	 iesp.duediligenceshared.t_DDRLegalEventIndividual;
	 string ExecTitle;
   unsigned6 did;   
   DATASET(iesp.duediligenceshared.t_DDRLegalEventCriminal)  BusExecCriminalChild;
	END;
  // ------                                                                       ------
  // ------ define the internal ChildDataset for the Legal Events section report  ------
	// ------                                                                       ------
	EXPORT ReportingofBEOWithCrimChildDatasetLayout    := RECORD
	 DueDiligence.LayoutsInternal.InternalBIPIDsLayout;     //*  This is the LINKID number of the parent 
   unsigned6 did; 
	 DATASET(iesp.duediligencebusinessreport.t_DDRBusinessExecutiveCriminalEvents)  BusExecWithCriminalEventsChild;
	END;
	
	EXPORT BusAircraftReportChildren := RECORD
		DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		DATASET(iesp.duediligenceshared.t_DDRAircraft) air {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxAircraft)};
	END;
	
	EXPORT BusWatercraftReportChildren := RECORD
		DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		DATASET(iesp.duediligenceshared.t_DDRWatercraft) water {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxWatercraft)};
	END;
	
	EXPORT BusIndustryRiskChildren := RECORD
		DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		DATASET(iesp.duediligencebusinessreport.t_DDRSICNAIC) industryRisk {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxSICNAICs)};
	END;
	
	
	EXPORT ReportingOfOperatingLocations  := RECORD
	 DueDiligence.LayoutsInternal.InternalBIPIDsLayout; 
	 DueDiligence.Layouts.BusOperLocationLayout ReportOfOperatingLocs;
	END;
	
	
	EXPORT BusCorpFilingsSlimLayout := RECORD
    DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		  STRING150 BusinessName;                                 //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp legal name
	   STRING20  FilingType;                                   //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing desc.   
	   STRING20  FilingStatus;                                 //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp status desc (example is ACTIVE)
	   UNSIGNED4 FilingDate;                                   //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing date 
	   UNSIGNED4 IncorporationDate;                            //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp inc date 
		  UNSIGNED4 LastSeenDate;                                 //***from Corp2.Key_LinkIDs.Corp.kfetch2 - 
	   STRING30  FilingNumber;                                 //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp filing reference nbr
	   STRING2   IncorporationState;                           //***from Corp2.Key_LinkIDs.Corp.kfetch2 - corp inc state
	END;
	
	
	EXPORT ReportingOfSOSFilingsChildLayout     :=  RECORD 
	  DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
	  DATASET(iesp.duediligencebusinessreport.t_DDRSOSFiling) BusSOSFilingsChild;   
 END;	
 
  // ------                                                                      ------
  // ------ define the ChildDataset  For Debtors                                 ------
	// ------                                                                      ------
 EXPORT	BusLiensDebtorsCreditorsChildDatasetLayout    := RECORD
	  DueDiligence.LayoutsInternal.InternalBIPIDsLayout; 
	  DATASET(iesp.duediligenceshared.t_DDRCreditorDebtor) BusLiensDebtorCreditorChild;
	END; 
 
  // ------                                                                      ------
  // ------ define the ChildDataset  For Business Liens                          ------
	// ------                                                                      ------
 EXPORT	BusLiensChildDatasetLayout    := RECORD
	  DueDiligence.LayoutsInternal.InternalBIPIDsLayout; 
	  DATASET(iesp.duediligenceshared.t_DDRLiensJudgmentsEvictions) BusLiensChild;
	END;
	
END;