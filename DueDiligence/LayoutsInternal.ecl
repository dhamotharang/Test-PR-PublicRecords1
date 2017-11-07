IMPORT DueDiligence;

EXPORT LayoutsInternal := MODULE

 EXPORT  InternalBIPIDsLayout := RECORD
	  UNSIGNED4 seq;
		UNSIGNED6 ultID;
		UNSIGNED6 orgID;
		UNSIGNED6 seleID;
		UNSIGNED6 proxID;
		UNSIGNED6 powID;
	END;   
	
	
	EXPORT SicNaicLayout := RECORD
		InternalBIPIDsLayout;
		DATASET(DueDiligence.Layouts.LayoutSICNAIC) sources;
	END;
	
	EXPORT SicNaicUniqueIndustryLayout := RECORD
		InternalBIPIDsLayout;
		DueDiligence.Layouts.LayoutSICNAIC;
		DueDiligence.Layouts.SicNaicRiskLayout;
	END;
	
	EXPORT AgentLayout := RECORD
		InternalBIPIDsLayout;
		DATASET(DueDiligence.Layouts.LayoutAgent) agents;
	END;
	
	EXPORT RelatedParty := RECORD
		InternalBIPIDsLayout;
		DueDiligence.Layouts.RelatedParty party;
	END;



//------                                      ------
//------  BusPropertyOwnedWithDetails         ------
//------  Populated with data for the report  ------
//------                                      ------
  EXPORT PropertySlimLayout := RECORD
     InternalBIPIDsLayout  PropertyReportData;
		 STRING12  LNFaresId;
		 STRING80  AssesseeName;
		 STRING45  BusinessType;
		 STRING8   SaleDate; 
		 INTEGER2  LengthOfOwnership;
		 INTEGER8  PurchasePrice;
		 STRING1   OwnerOccupied;
	   INTEGER8  TaxAssdValue;   
     INTEGER8  TaxAmount;
	   STRING4   TaxYear;
	   UNSIGNED4 HistoryDate;
		 string80  cname;
		 string10  prim_range;
     string2   predir;
     string28  prim_name;
     string4   suffix;
     string2   postdir;
     string10  unit_desig;
     string8   sec_range;
     string25 p_city_name;
     string25 v_city_name;
     string2   st;
     string5   zip;
     string4   zip4;
		 STRING20  countyName;  
  END;					
	
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

  EXPORT AircraftSlimLayout := RECORD
    InternalBIPIDsLayout;
		YearMakeModel;
		STRING1   detailType; 
		UNSIGNED1	numberOfEngines;
		STRING		tailNumber;
		VinTitleAndRegistration;
		STRING12	manufactureModelCode;		//used to get number of engines
  END;								

  EXPORT WatercraftSlimLayout := RECORD
    InternalBIPIDsLayout;
		STRING30 watercraftKey;		//used to get watercraft details
	  STRING30 sequenceKey;			//used to get watercraft details
		STRING2 stateOrigin;				//used to get watercraft details
		YearMakeModel;
		STRING		vesselType;
		UNSIGNED2 vesselLengthInches;
		STRING		propulsion;
		VinTitleAndRegistration;
		UNSIGNED2 watercraftCount;
  END;


END;