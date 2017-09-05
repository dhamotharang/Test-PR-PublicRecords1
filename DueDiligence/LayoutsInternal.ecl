IMPORT DueDiligence; 

EXPORT LayoutsInternal := MODULE

 EXPORT  InternalBIPIDsLayout := RECORD
	  UNSIGNED4 seq;
		UNSIGNED4 ultID;
		UNSIGNED4 orgID;
		UNSIGNED4 seleID;
	END;   
	


	EXPORT SicNaicLayout := RECORD
		UNSIGNED4 seq;
		UNSIGNED4 ultID;
		UNSIGNED4 orgID;
		UNSIGNED4 seleID;
		DATASET(DueDiligence.Layouts.LayoutSICNAIC) sources;
	END;
	
	EXPORT SicNaicUniqueIndustryLayout := RECORD
		UNSIGNED4 Seq;
		UNSIGNED4 ultID;
		UNSIGNED4 orgID;
		UNSIGNED4 seleID;
		DueDiligence.Layouts.LayoutSICNAIC;
		DueDiligence.Layouts.SicNaicRiskLayout;
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

//------                                      ------
//------                                     ------
//------  Populated with data for the report  ------
//------                                      ------
  EXPORT AircrafttSlimLayout := RECORD
     InternalBIPIDsLayout  AircraftReportData;
		 STRING4   Year;
		 STRING30  Make;
		 STRING30  Model;
		 STRING4   DetailType; 
		 STRING30  VIN;            // Aircraft Identification Number
		 STRING2   TitleState;
		 STRING8   TitleDate;
		 string80  cname;
		 string2   RegistrationState;
     string2   RegistrationDate;
  END;								




END;