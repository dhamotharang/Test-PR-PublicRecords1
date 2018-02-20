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
		STRING2 stateOrigin;				//used to get watercraft details
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







 EXPORT BEOCriminalReportingOFOffenses := RECORD
  DueDiligence.LayoutsInternal.InternalBIPIDsLayout; 
  DueDiligence.Layouts.CriminalOffenseLayout_by_DIDOffense ReportOfOffenses;  
  END;


	
	EXPORT BusAircraftReportChildren := RECORD
		DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		DATASET(iesp.duediligencereport.t_DDRAircraft) air {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxAircraft)};
	END;
	
	EXPORT BusWatercraftReportChildren := RECORD
		DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		DATASET(iesp.duediligencereport.t_DDRWatercraft) water {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxWatercraft)};
	END;
	
	EXPORT BusIndustryRiskChildren := RECORD
		DueDiligence.LayoutsInternal.InternalBIPIDsLayout;
		DATASET(iesp.duediligencereport.t_DDRSICNAIC) industryRisk {MAXCOUNT(iesp.Constants.DDRAttributesConst.MaxSICNAICs)};
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
	  DATASET(iesp.duediligencereport.t_DDRSOSFiling) BusSOSFilingsChild;   
 END;	
	
END;