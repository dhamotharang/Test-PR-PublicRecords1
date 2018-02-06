﻿IMPORT DueDiligence, iesp;

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
	
END;